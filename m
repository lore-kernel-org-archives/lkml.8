Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7EB3C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 21:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1DED20888
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 21:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="Rdj07d1E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391289AbgEZV40 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 17:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390131AbgEZV4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 17:56:24 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75564C03E96D
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 14:56:24 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id z13so16779692ljn.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 14:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KxA9UmGJJnl7Bb+4Hp5hGEl722cKfUNLx8ou3ZEhvTQ=;
        b=Rdj07d1EbBsd4yaGts4o+yqzcD6soXFmwEnvmWnKKkkMxr4IzXZCRjUTJqQ0b010v3
         QCViqtYyatK+6gpTvUUspFrQ+zruGqU7KH44vMYy2OZ3Zz/zaly4trhle/tcrtMgZMnm
         LnEITkjaw/mB9K1DttC+YgzADHQ/izR/asILurcN7rLch/r/ZUjle2DQa17WJYFuL7H9
         yfWZ+EOFZPbQkSb/D/+GXzEViwlKYd4HKr0NRPce3hroQ0JffQtCKP79tgSShlUSHbm7
         UkQQ0zKl4bK/mvTBH0UJYqgNftgHENuCLJzhnIk6dqfK20eYm7k60qJVlizWE2dv5ebi
         QR6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KxA9UmGJJnl7Bb+4Hp5hGEl722cKfUNLx8ou3ZEhvTQ=;
        b=qz9acLiS1q5pLgIZwUdGzigoYZWMi3FzVkKOK2ZqKvETOffkZAhAczDmex5lrXadW0
         u2rgaJ1c+6Au6I+6OOlWL9nL/p9cQxuW0h3JPtuGR0ORWS5u0XJScyILDY9/LexPUSX+
         sSA6geER44tG5QVhb8k6/NloCnMMUNQhLw4cPSpD7s1ePlzsBGrkcKiqJ/QVW1W/beP0
         wQTAjJ3rIeCltQSeBDbEJ8PshHYOk7QQrndoU9Irs41fE9HLGY29Ga/y814b2mBhfK8r
         ol6tzVNKZ8X2Ki0upGl4d9tv3O1pkudWpVeO+Aa7sh91N+9wPN89tDVY0So7hNn3vv1r
         LZMQ==
X-Gm-Message-State: AOAM533ZUgWhiP/uT5QLeLiOdkwpZXhDQHiP8tr5rqM3BZdbPxS2lVgA
        RBNI95S+UkYSGBS92t3TeNewMw==
X-Google-Smtp-Source: ABdhPJyBJffVuN8Gxouh7odL35w4h73NN8hmaj17eT0JxNv7QR2g36h9/tqS3jaVBhyIz8dNFQkR1g==
X-Received: by 2002:a2e:8091:: with SMTP id i17mr1625888ljg.141.1590530182839;
        Tue, 26 May 2020 14:56:22 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id w24sm218345ljo.136.2020.05.26.14.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 14:56:22 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 850B710230F; Wed, 27 May 2020 00:56:22 +0300 (+03)
Date:   Wed, 27 May 2020 00:56:22 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "Kleen, Andi" <andi.kleen@intel.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [RFC 06/16] KVM: Use GUP instead of copy_from/to_user() to
 access guest memory
Message-ID: <20200526215622.r455gfohtufr45vj@box>
References: <20200522125214.31348-1-kirill.shutemov@linux.intel.com>
 <20200522125214.31348-7-kirill.shutemov@linux.intel.com>
 <20200526061459.GC13247@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526061459.GC13247@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 09:14:59AM +0300, Mike Rapoport wrote:
> On Fri, May 22, 2020 at 03:52:04PM +0300, Kirill A. Shutemov wrote:
> > New helpers copy_from_guest()/copy_to_guest() to be used if KVM memory
> > protection feature is enabled.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > ---
> >  include/linux/kvm_host.h |  4 +++
> >  virt/kvm/kvm_main.c      | 78 ++++++++++++++++++++++++++++++++++------
> >  2 files changed, 72 insertions(+), 10 deletions(-)
> > 
> >  static int __kvm_read_guest_page(struct kvm_memory_slot *slot, gfn_t gfn,
> > -				 void *data, int offset, int len)
> > +				 void *data, int offset, int len,
> > +				 bool protected)
> >  {
> >  	int r;
> >  	unsigned long addr;
> > @@ -2257,7 +2297,10 @@ static int __kvm_read_guest_page(struct kvm_memory_slot *slot, gfn_t gfn,
> >  	addr = gfn_to_hva_memslot_prot(slot, gfn, NULL);
> >  	if (kvm_is_error_hva(addr))
> >  		return -EFAULT;
> > -	r = __copy_from_user(data, (void __user *)addr + offset, len);
> > +	if (protected)
> > +		r = copy_from_guest(data, addr + offset, len);
> > +	else
> > +		r = __copy_from_user(data, (void __user *)addr + offset, len);
> 
> Maybe always use copy_{from,to}_guest() and move the 'if (protected)'
> there?
> If kvm is added to memory slot, it cab be the passed to copy_{to,from}_guest.

Right, Vitaly has pointed me to this already.

-- 
 Kirill A. Shutemov
