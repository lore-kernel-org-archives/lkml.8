Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D49C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 21:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DF77205CB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 21:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="es56dcOc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbgIIVtV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 17:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgIIVtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 17:49:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31808C061573
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 14:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HXIdUpByyG4qzsIKApPAxHn9z/7NYiDmd4oaoQuNQ6Y=; b=es56dcOcXXKCGaOzeKAMOjtmhq
        4MSph/lwjOSVoCSqbDhjIiJEd1XMYkQ6YO45X5TPqeUn9aG95K3tvmqYBSQqLKUVEnFz1ls1Mt3QB
        KelVEdkr+tfQYlV8hTpKkHUHtd0HblJA8Bsw9z+kxOEQMIGM0TBzJjUcBYjIneI6e2dgMzbr0n+sR
        lzLFsds9XKOpd2goZR2GyXkC22vSP/Eh1NUZJcyTIpJtpSlcvhYt+q2GbxZqbRw16oME9h4XW9oLC
        s+pmmZiS9XkaipAeWgIXGRMuCiIri0xU1d4mRWdp5HWxnZ3H6cg1Dh4RFiqL5/f5+FVMpVLAOApc5
        zQTsAfZQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kG7xo-0000N8-S5; Wed, 09 Sep 2020 21:49:12 +0000
Date:   Wed, 9 Sep 2020 22:49:12 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     zangchunxin@bytedance.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v2] mm/vmscan: fix infinite loop in drop_slab_node
Message-ID: <20200909214912.GO6583@casper.infradead.org>
References: <20200909152047.27905-1-zangchunxin@bytedance.com>
 <16906d44-9e3c-76a1-f1a9-ced61e865467@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16906d44-9e3c-76a1-f1a9-ced61e865467@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 09, 2020 at 07:59:44PM +0200, Vlastimil Babka wrote:
> - Exit also on other signals such as SIGABRT, SIGTERM? If I write to drop_caches
> and think it's too long, I would prefer to kill it by ctrl-c and not just kill
> -9. Dunno if the canonical way of testing for this is if
> (signal_pending(current)) or differently.

fatal_signal_pending() is the canonical way to do it.  If your task has
installed a signal handler for ABRT or TERM, that's its prerogative,
but it's chosen not to get killed, and it's not allowed to see short
reads/writes, so we can't break out early.
