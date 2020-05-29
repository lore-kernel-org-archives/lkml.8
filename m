Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D274DC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 23:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABAA42072D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 23:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590796401;
	bh=1rlqXvCzW44o8+ZjKb23JQRgLBLUHkGcCipJVMrMWys=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=do+WX3MQoIK4IzOWq5/0cKKJ+4cciKa5e+QdXxeprLy/mhM9HRVbS4ILTnbDZTU2S
	 41NVzn7MAo2wDBFA9cLIR3ub30hqn7yGFdkTZ2qtc7KXGNt+dbW3JGLmWjvYu/WAsV
	 +27gTiBZ05D5MUpWr5pLxTkwr7pOGyvrjXdCeAjA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728604AbgE2XxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 19:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728293AbgE2XxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 19:53:20 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1C9C08C5C9
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 16:53:19 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id z206so698442lfc.6
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 16:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ICQtGJtrHJozomkdHTEOkutnUdLdZAowcRpo4XmM9/g=;
        b=BKeekuZS2zieYlq8mdCl6fz+pBpw9xzAhVyL+t5zKZaRWVqur00axzXw7v4sCNC5hv
         /1qWi5dvtrM55OwtMCQDzQrBrRFVZyYWsemIazEDWdf1hT4pNTGgP4ShCOvtAVfGGELX
         29aIJ+f8wXXFr8dj738yQ8rtoM6Aj7PLxA5II=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ICQtGJtrHJozomkdHTEOkutnUdLdZAowcRpo4XmM9/g=;
        b=Q7pNGMIeSD5ULgFJjaepTxvZLRNmbj9V8oj36Tld7OevHerOXGOTGRPctuzH0GQevg
         5iJXxl3pbr2i5VaDhka4nZv0TDJ0IlrgqaGO9C8MTLsDV8MIADgS82OP+nD9gOZ6YWS8
         sBMbIRADFQ5YvbjZtvQH/UKkETLBYm8il9EDIvelHIquqS7ZVlRyLNez0AMqx+QxhpyW
         BHjvRtGTOCXn5tgQbl6g9KbiJWnX0LaJrkI+xWkLIofDL0uw92QSMYuUz12Ysq4PcRhO
         yJN/LV5DlEekjqyLWwlVcwoyxT327S/qk5ugka1Tlb7oKYUhYqKePHHcygrUA9E9Qxr0
         VGQA==
X-Gm-Message-State: AOAM530HSW5n3l+9SgW9zCB+/f1CITwYAj6qOVBltudMPjn7PiXRQHJ4
        lGqjgOdWH+ctOwcYtAPT12ueLUjcdbo=
X-Google-Smtp-Source: ABdhPJwSJujL5isgZUnIhXxT8gmCF+//GZFaVNM3nH31rq8kWD0wPiluMRSKDVVrhIwcQ0xyASBxUg==
X-Received: by 2002:a19:987:: with SMTP id 129mr5674951lfj.8.1590796396874;
        Fri, 29 May 2020 16:53:16 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id f18sm2584075lfh.49.2020.05.29.16.53.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2020 16:53:16 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id k5so1285150lji.11
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 16:53:15 -0700 (PDT)
X-Received: by 2002:a2e:8090:: with SMTP id i16mr4658232ljg.421.1590796395104;
 Fri, 29 May 2020 16:53:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200528234025.GT23230@ZenIV.linux.org.uk> <20200529232723.44942-1-viro@ZenIV.linux.org.uk>
 <20200529232723.44942-8-viro@ZenIV.linux.org.uk>
In-Reply-To: <20200529232723.44942-8-viro@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 29 May 2020 16:52:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgq2dzOdN4_=eY-XwxmcgyBM_esnPtXCvz1zStZKjiHKA@mail.gmail.com>
Message-ID: <CAHk-=wgq2dzOdN4_=eY-XwxmcgyBM_esnPtXCvz1zStZKjiHKA@mail.gmail.com>
Subject: Re: [PATCH 8/9] x86: kvm_hv_set_msr(): use __put_user() instead of
 32bit __clear_user()
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 4:27 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> a/arch/x86/kvm/hyperv.c
> -               if (__clear_user((void __user *)addr, sizeof(u32)))
> +               if (__put_user(0, (u32 __user *)addr))

I'm not doubting that this is a correct transformation and an
improvement, but why is it using that double-underscore version in the
first place?

There's a __copy_to_user() in kvm_hv_set_msr_pw() in addition to this
one in kvm_hv_set_msr(). Both go back to 2011 and commit 8b0cedff040b
("KVM: use __copy_to_user/__clear_user to write guest page") and both
look purely like "pointlessly avoid the access_ok".

All these KVM "optimizations" seem entirely pointless, since
access_ok() isn't the problem. And the address _claims_ to be
verified, but I'm not seeing it. There is not a single 'access_ok()'
anywhere in arch/x86/kvm/ that I can see.

It looks like the argument for the address being validated is that it
comes from "gfn_to_hva()", which should only return
host-virtual-addresses. That may be true.

But "should" is not "does", and honestly, the cost of gfn_to_hva() is
high enough that then using that as an argument for removing
"access_ok()" smells.

So I would suggest just removing all these completely bogus
double-underscore versions. It's pointless, it's wrong, and it's
unsafe.

This isn't even some critical path, but even if it was, that user
address check isn't where the problems are.

             Linus
