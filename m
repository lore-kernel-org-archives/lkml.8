Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92BE4C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 20:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 600E320757
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 20:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588710924;
	bh=FlarCttK714TCgXtLmYHtw4n67Swh0WSbhkChXfoK6Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ZUhSzRxJtCGEANvlFPae8Q+MJlGkm0LGG2n/yZgPP4+VQnbaC10NIsDaa2szhIVqu
	 W67ssjkU4TT1Bt+MZZL/8xxuXK9V7wMdJcd9h+Su3IoRS4i0E0m4ZiXNWsHWCI0xuN
	 PeAc9emc2UH+sS+tnGKQt6APukQYxUXGQxUq65os=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729159AbgEEUfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 16:35:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:37088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726350AbgEEUfW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 16:35:22 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2728020752;
        Tue,  5 May 2020 20:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588710922;
        bh=FlarCttK714TCgXtLmYHtw4n67Swh0WSbhkChXfoK6Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=REiW3W0Ma8o3zstTFwYlU20TscGpSEG9Ai+jA01wL570DTG19447riGJRlCdoUgwy
         whVbWcZYGa0UsxP2sQkC69QmhA/BNYTM7mgR46rxKa87WTynbSZB0ALYZKJqDAiytr
         sBAqhbsUS4k/vPLw2zQ1884irPHC7ElqjGpJt6fo=
Date:   Tue, 5 May 2020 13:35:21 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Waiman Long <longman@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-mm@kvack.org,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Joe Perches <joe@perches.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>
Subject: Re: [PATCH v3] mm: Add kvfree_sensitive() for freeing sensitive
 data objects
Message-Id: <20200505133521.eb8901d0b92e09452191ab49@linux-foundation.org>
In-Reply-To: <694340.1586290917@warthog.procyon.org.uk>
References: <694135.1586290793@warthog.procyon.org.uk>
        <20200407200318.11711-1-longman@redhat.com>
        <694340.1586290917@warthog.procyon.org.uk>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Apr 2020 21:21:57 +0100 David Howells <dhowells@redhat.com> wrote:

> David Howells <dhowells@redhat.com> wrote:
> 
> > >  			if (unlikely(key_data))
> > > -				__kvzfree(key_data, key_data_len);
> > > +				kvfree_sensitive(key_data, key_data_len);
> > 
> > I think the if-statement is redundant.
> 
> Ah - I see that you explicitly wanted to keep it.

Why's that?

> There's a good chance it'll get janitored at some point.

Indeed.  Perhaps add a few little comments to explain the reasoning and
to keep the janitorial fingers away?

