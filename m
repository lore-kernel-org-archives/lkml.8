Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F59C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 12:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E63AD20738
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 12:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lIA5MI4J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbgFCMAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 08:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725833AbgFCMAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 08:00:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0C7C08C5C0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 05:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HUsvsrTi4Pk2unP72gitF1ESvPnnwLM16HEeHV57pjY=; b=lIA5MI4JgxNkhfW6ytD7fMf4Ih
        67NTLSoEGZiLJuwwjMj2DvD5Z96Dw06gEVQ5T8tI+ctuCRUOaHDA+tebtqR/uifuMFzGkHHthSrg/
        Ib0Fr0V+TL8ixjjOvOT6fbU4LSSU9++QUxkP5zJrFyzI4vCg3dyl06y00/uPBuTiEeJVslDRIdOe+
        rEJ7/2vYTeaJjJzBwXlBhu3GeNzS+6vWk7szf75Xbh2P2N1GkbDEORgiNtuMB9hcFa4Qo6vCpafh9
        +6iT6p402KLEaXaO1QCDCJCpEFarXR7suuM7P7Cd2m/enyi5XLJ/9bcQJYpjtEXSBa4K6Ij4re/8z
        3blIcrvw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jgS4V-0002iW-8O; Wed, 03 Jun 2020 12:00:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B261430008D;
        Wed,  3 Jun 2020 14:00:37 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9D5EC209C23B0; Wed,  3 Jun 2020 14:00:37 +0200 (CEST)
Date:   Wed, 3 Jun 2020 14:00:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de
Cc:     x86@kernel.org, elver@google.com, paulmck@kernel.org,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        will@kernel.org, dvyukov@google.com, glider@google.com,
        andreyknvl@google.com
Subject: Re: [PATCH 0/9] x86/entry fixes
Message-ID: <20200603120037.GA2570@hirez.programming.kicks-ass.net>
References: <20200603114014.152292216@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200603114014.152292216@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 03, 2020 at 01:40:14PM +0200, Peter Zijlstra wrote:
> The first patch is a fix for x86/entry, I'm quicky runing out of brown paper bags again :/
> 
> The rest goes on top of these:
> 
>   https://lkml.kernel.org/r/20200602173103.931412766@infradead.org
>   https://lkml.kernel.org/r/20200602184409.22142-1-elver@google.com
> 
> patches from myself and Marco that enable *SAN builds. So far GCC-KASAN seen to
> behave quite well, I've yet to try UBSAN.

GCC10 + UBSAN:

vmlinux.o: warning: objtool: match_held_lock()+0x1b2: call to __ubsan_handle_type_mismatch_v1() leaves .noinstr.text section
vmlinux.o: warning: objtool: rcu_nmi_enter()+0x234: call to __ubsan_handle_out_of_bounds() leaves .noinstr.text section
vmlinux.o: warning: objtool: __rcu_is_watching()+0x59: call to __ubsan_handle_out_of_bounds() leaves .noinstr.text section

All of them are marked noinstr. So I suppose UBSAN is just buggered in
GCC :-/
