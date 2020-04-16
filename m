Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C5EAC2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 01:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64BA62076D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 01:20:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=juliacomputing-com.20150623.gappssmtp.com header.i=@juliacomputing-com.20150623.gappssmtp.com header.b="FuZadO+K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731040AbgDPBTw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 21:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730899AbgDPBRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 21:17:36 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49B1C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 18:17:32 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id e127so4008889iof.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 18:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=juliacomputing-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b/NNMh3S+UlylnusIMrRyM4zMHQpXid5UmqdCRWxVJQ=;
        b=FuZadO+K7xiMVzw5uhUh0nWYawBf/MBxNjqycqBAO+AUo21JAiu9lozfi8+z0ptpWb
         SrE9fmWXhL5nMgNZG4NKKQ44+issHx+CfvlCa3hRKphUgNySnjBm/bpLOPKdqUZhewSn
         o01cC+h0jj5vXFxk1tSj6Rt6Nz/0GNEJx6X8iCdUy58ouMIDsb1r/w5GUkvrO7I62dR4
         xjnIemsq4Ll2J5IjTalvGT401jRdPke4Pfu01Z1btUXtVNj4BmYfOX2ok7zgeLuL0U10
         Mk/gephvJAWN/OQAd/qMco6ROzvdrVkT6RiMJ0JOPMlqXByN68OtLedQugCQVU6VWIXu
         ZDBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b/NNMh3S+UlylnusIMrRyM4zMHQpXid5UmqdCRWxVJQ=;
        b=IsU6WlQ+GTuZ3EG3wkgdu6HPEZ2EGCk1VYCFvBeX6YFdXhmpDXXXi8FGrlyN/Fv+vl
         07pZw+XWlXca8ibo0mqgo8wiYKeWvxlSSpavEYwXHVm6H7k3TjrtZWJxhz2Sq/MEK4kj
         cTcMsnGGPjh/z657qIdmBTPC4wh4MIfrWWHJUBHzLwAbWmnkw6xV/UziRWgclAvBN+fu
         DgDCDLsGcMUMTQvCi/QY11RzJCJ15Hdk+700Dnb6kkCIg3hAJnl/2PmrZpDMr0HkYHHw
         8i5G9cf6PHWGwD1bnEx2o9k1VJIfA4pOGBfXgEg4KLgHLoE/TO9h8kQaEJCPu2iXsJ4X
         1g2Q==
X-Gm-Message-State: AGi0PuYVBXyjNBz0Bs1Ef2eAhZxUClIJuqFqgH/FnYKTLlKIFONPRt73
        TIazFCtDxjFWWqgJBZHaf5n9AR5NNA29DyTJTUSqtg==
X-Google-Smtp-Source: APiQypIdZIs8g0HEIIkvAARM7OhOKjnbWsyhK2vZ3LovZssJQvOw2yoa9ARU7lknyz/GRnxaLbxcWoeqRiGHDjdP0Eo=
X-Received: by 2002:a05:6602:22c3:: with SMTP id e3mr28961266ioe.75.1586999852049;
 Wed, 15 Apr 2020 18:17:32 -0700 (PDT)
MIME-Version: 1.0
References: <a5b07aa9-96ea-a9b5-13db-e5dcbd7760e6@intel.com>
 <BEA3CCB8-5127-4E6A-9696-E293C00BFA82@amacapital.net> <CABV8kRxqcCmPKtX3DDOf+47Re1hO1gMeUPhCd6HtDP0-SpcSBw@mail.gmail.com>
 <CALCETrVmsWZ+w6C4RV50DWoL0Qaiy+S6BtXr=QKQEg3MYgAc6w@mail.gmail.com>
 <CABV8kRxfMNxzy8r2P4GKj-22i+GMj=VDfPWAZB-VSgfrsQsjCA@mail.gmail.com>
 <CALCETrWTDrcynTwpWZ6u6JXRL1rz6_vakLK7=BqMjCPCkQ+9dg@mail.gmail.com> <CABV8kRzbGgF4Uc9+VyzBUiH-kGfMALd8tDtjE3hjyE2Z5VD3-g@mail.gmail.com>
In-Reply-To: <CABV8kRzbGgF4Uc9+VyzBUiH-kGfMALd8tDtjE3hjyE2Z5VD3-g@mail.gmail.com>
From:   Keno Fischer <keno@juliacomputing.com>
Date:   Wed, 15 Apr 2020 21:16:56 -0400
Message-ID: <CABV8kRz0nxSu=Nr-ViGamKd=vZ5-v6=+CFRC19hB+CdQ28C4yg@mail.gmail.com>
Subject: Re: [RFC PATCH v2] x86/arch_prctl: Add ARCH_SET_XCR0 to set XCR0 per-thread
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andi Kleen <andi@firstfloor.org>,
        Kyle Huey <khuey@kylehuey.com>,
        "Robert O'Callahan" <robert@ocallahan.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 9:14 PM Keno Fischer <keno@juliacomputing.com> wrote:
>
> > Would it make matters easier if tasks with nonstandard XCR0 were not
> > allowed to use ptrace() at all?  And if ARCH_SET_XCR0 were disallowed
> > if the caller is tracing anyone?
>
> That would be fine by me (as long as you're still allowed to ptrace them of
> course).

Sorry, I realized after I had hit send that this wording may not be clear.
What I meant was that it would need to be able to have an external ptracer
(with unmodified XCR0) attach to the task, even if it had modified its XCR0.
I don't think you were suggesting that that wouldn't be possible,
but I just wanted to make sure.
