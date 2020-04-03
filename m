Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 977EDC2D0E8
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 12:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E4ED20737
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 12:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="DzUeiEZ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403931AbgDCMTw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 08:19:52 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39741 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728140AbgDCMTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 08:19:52 -0400
Received: by mail-lj1-f193.google.com with SMTP id i20so6700030ljn.6
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 05:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=g/ynuYjJt7Qm1NRNhiAHFZpsxO5RlOPe2UghsFzLBKM=;
        b=DzUeiEZ7cwkwl5tdjKkU98tl91HYziVlmcmErrC1AH3nBpIUo/DPaOAJ605N0VK12S
         l/uxhlKaw5EoY1L/1gdEwRnU/7TMHBUfzlbZL6bSUs4lGftmFqrfk4AWEhV9GFrAYyst
         ejqIngi5DPgXuN6Noa2W/P7OGwx2HYGauYzD0dqpYc/+03ikuHgxxlo5uc3QQ3Nbu4Jg
         411RYmp8GpTrlqHkmvbC1hHp0XlpvhY3EvFEgb5xXG2Laggv9pZA0BcwhZEcFUou17Tg
         +AEGMOq0Rbv4vgnBXrS724vzIf6gCsZdCOF5kBdkQtzuUGGr1TWFyNSOSJ8mu50Ljnuz
         jNPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g/ynuYjJt7Qm1NRNhiAHFZpsxO5RlOPe2UghsFzLBKM=;
        b=EWmVYNBM7TRHjif7xXKaSmRIlAkRsbQCtAO0KtwRPaQT55uVWCLdFu5xZctOqiF0QI
         hd6FsbdjxlVqzat+79of+jNiShKi1O9M1Dp9rEdP81DQ8lNCTKmB2wCHt8pIACQHiAt0
         HbUXstXsVe8xXzlffcuntYB7xT8bnDKIX819Igyu3eJ9oTcliGGh/bDlBTA8qUhqV4Vd
         p/IgrCkoYrBEbVcXLRUE3tlYXwIF+yXWHkV/oyb7IYL7MiLkagtOo4QQgY0Bc9aMuP1R
         CqwdWatBg4rW9avTReJ8I5/q3j6mwCSa/CpNQ912uq+qEGnQUrygq7au+AKjPg/Jcny4
         duYw==
X-Gm-Message-State: AGi0PuZmwL2D2YUmCqm96FFKiUsZDAbGZ2pdlfz5QFepePI8Tys3Z79d
        7Z8PZxVRK6XvvwoiSdrkhrBMlQ==
X-Google-Smtp-Source: APiQypK33qY7ePoFZ2Cih5owCFLqMBrh9ojn/DSWQVBEZFJXNA1avafYNNQjzI3nlOb68pyibjWVnA==
X-Received: by 2002:a2e:3c0a:: with SMTP id j10mr4729637lja.205.1585916388999;
        Fri, 03 Apr 2020 05:19:48 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id l21sm6739854lfh.63.2020.04.03.05.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 05:19:48 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id AF97B10132C; Fri,  3 Apr 2020 15:19:47 +0300 (+03)
Date:   Fri, 3 Apr 2020 15:19:47 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Petr Tesarik <ptesarik@suse.cz>
Subject: Re: [PATCH] mm, dump_page(): do not crash with invalid mapping
 pointer
Message-ID: <20200403121947.sk5oif775op6mubk@box>
References: <20200331165454.12263-1-vbabka@suse.cz>
 <20200401140544.pkhgfmo5pks3dw6v@box>
 <a5ebb5eb-ccda-eb74-422c-cddea792894f@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5ebb5eb-ccda-eb74-422c-cddea792894f@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 02, 2020 at 10:30:35AM +0200, Vlastimil Babka wrote:
> On 4/1/20 4:05 PM, Kirill A. Shutemov wrote:
> > On Tue, Mar 31, 2020 at 06:54:54PM +0200, Vlastimil Babka wrote:
> >> We have seen a following problem on a RPi4 with 1G RAM:
> >> 
> >> Besides the underlying issue with page->mapping containing a bogus value for
> >> some reason, we can see that __dump_page() crashed by trying to read the
> >> pointer at mapping->host, turning a recoverable warning into full Oops.
> >> 
> >> It can be expected that when page is reported as bad state for some reason, the
> >> pointers there should not be trusted blindly. So this patch treats all data in
> >> __dump_page() that depends on page->mapping as lava, using
> >> probe_kernel_read_strict(). Ideally this would include the dentry->d_parent
> >> recursively, but that would mean changing printk handler for %pd. Chances of
> >> reaching the dentry printing part with an initially bogus mapping pointer
> >> should be rather low, though.
> >> 
> >> Also prefix printing mapping->a_ops with a description of what is being
> >> printed.  In case the value is bogus, %ps will print raw value instead of
> >> the symbol name and then it's not obvious at all that it's printing a_ops.
> >> 
> >> Reported-by: Petr Tesarik <ptesarik@suse.cz>
> >> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> >> ---
> >>  mm/debug.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++------
> >>  1 file changed, 50 insertions(+), 6 deletions(-)
> > 
> > I'm not sure it worth the effort. It looks way too complex for what it
> > does.
> 
> Well the human effort is done, and CPU cycles are cheap :P Complex is better
> than to crash, IMHO.
> 
> > I also expect it to slowdown dump_page(), which is hotpath for some debug
> > scenarios :P
> 
> It's still a debug code, better safe than fast :P

Crash fast, crash often :P

> > Maybe just move printing this info to the end, so we would see the rest
> > even if ->mapping is bogus?
> 
> Well the thing is designed to be recoverable. Just today "mm: improve
> dump_page() for compound pages" was merged that AFAICS prevents similar crashes
> when the compound_head() is bogus.

Okay, fair enough.

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
