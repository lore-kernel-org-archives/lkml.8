Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94001C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 06:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69906208FE
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 06:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kKUS7IMN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbgGCGo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 02:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbgGCGoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 02:44:25 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2F4C08C5DD
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 23:44:25 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id o5so31373035iow.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 23:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=odGB8TNyWCdqWFOvUPdduy/mDuwvatkITzLXwOy1S7Q=;
        b=kKUS7IMNGJY2+SzWhECJRvZNNLG61zPX5yQWSTMsnOPMQh1wEqANmYx1X5IwvVjZDo
         LlF1J+5FtWC1ePNf1VvN8on1sudpcFECX9oPYqa9OdYuMACu26oR+JKAkC+IuIB5XyQm
         FC5/vvVnssevvXfbTwP6cEKK0n6Vi5kUl2Nms2ozUsiK3CT6mcYmkmD4hxcm6/N5SP5s
         wYYAaepu5Lo97ReO3dMVJJOa63tQMh/da8qLLsj77aRqN49f5IHWl6kgysAuRVOPU40Z
         CgbK1UV4X2sEjNbxzoFETpcyMT6Ey3pRY29i1VePvCaMRyr/evpln+3V1+AsxqlXZZTC
         MVow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=odGB8TNyWCdqWFOvUPdduy/mDuwvatkITzLXwOy1S7Q=;
        b=RS8vTmUp5GTfr006b5p4DRtqUvzZpV0L6STt8ClaKzZO6IOhEll+r4P9vmHGAXewce
         9xvl5hlnY8xXu0C7jvnbnh6mxEQ/4RYfGgPoOAWARakSAE7bs8vSEHmIsexqxNefz0qE
         /r0it2BAyUKtWBnOwuYbNJzlXiEKJ2w5deC5MFWio9j4PwBdvq1WYYBcPnMdYgl8SLqb
         +lVURwkD62Q0Jcy59JggqvK5vKy5SjcTkmXfbi4v1v9oRpN7QeMz/zLvnxiJnFvtazob
         mURT4VBYHe6UVoB3iv+Skq1w9/t0gcuvH4E6Jt+PS7d22dj8xDJqA1oXWC2ZKqTRUcFR
         9icw==
X-Gm-Message-State: AOAM530Z91ochj6w78IDArF+VF6ig+9KxQwAsG2HXV5AyzIGIr+XsMTL
        gvqZQwgwwxbuCTzg1a3PJ+GE6vMEgGdCntxUmcD/4A==
X-Google-Smtp-Source: ABdhPJzPjYsVNTjPsHGn5aGpeM2rXoN818Ai/fS/PfHZI4ezHdmCt4f8T4PdyoBQUvwn6ueXUn0EW38be6NrYO+Dk9A=
X-Received: by 2002:a05:6602:2dd4:: with SMTP id l20mr11019260iow.13.1593758664519;
 Thu, 02 Jul 2020 23:44:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200702221237.2517080-1-abhishekbh@google.com>
 <e7bc00fc-fe53-800e-8439-f1fbdca5dd26@redhat.com> <CAN_oZf2t+gUqXe19Yo1mTzAgk2xNhssE-9p58EvH-gw5jpuvzA@mail.gmail.com>
In-Reply-To: <CAN_oZf2t+gUqXe19Yo1mTzAgk2xNhssE-9p58EvH-gw5jpuvzA@mail.gmail.com>
From:   Abhishek Bhardwaj <abhishekbh@google.com>
Date:   Thu, 2 Jul 2020 23:43:47 -0700
Message-ID: <CA+noqoj6u9n_KKohZw+QCpD-Qj0EgoCXaPEsryD7ABZ7QpqQfg@mail.gmail.com>
Subject: Re: [PATCH v3] x86/speculation/l1tf: Add KConfig for setting the L1D
 cache flush mode
To:     Anthony Steinhauser <asteinhauser@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Waiman Long <longman@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>, kvm@vger.kernel.org,
        x86 <x86@kernel.org>, Doug Anderson <dianders@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have tried to steer away from kernel command line args for a few reasons.

I am paraphrasing my colleague Doug's argument here (CC'ed him as well) -

- The command line args are getting unwieldy. Kernel command line
parameters are not a scalable way to set kernel config. It's intended
as a super limited way for the bootloader to pass info to the kernel
and also as a way for end users who are not compiling the kernel
themselves to tweak kernel behavior.

- Also, we know we want this setting from the start. This is a
definite smell that it deserves to be a compile time thing rather than
adding extra code + whatever miniscule time at runtime to pass an
extra arg.

I think this was what CONFIGS were intended for. I'm happy to add all
this to the commit message once it's approved in spirit by the
maintainers.

On Thu, Jul 2, 2020 at 8:18 PM Anthony Steinhauser
<asteinhauser@google.com> wrote:
>
> Yes, this probably requires an explanation why the change is necessary
> or useful. Without that it is difficult to give some meaningful
> feedback.



-- 
Abhishek
