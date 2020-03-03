Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26358C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 19:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFB7B208C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 19:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uDa5LM3T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730808AbgCCTXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 14:23:30 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:39228 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgCCTXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 14:23:30 -0500
Received: by mail-io1-f67.google.com with SMTP id h3so4917904ioj.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 11:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LLgQsCek9Kb1m4nAwNnmEBwVioWI00Iv+0FWhumo+dE=;
        b=uDa5LM3TNki7/Wt/1Evy+4ZqW3++lqzqUvHiCP0G35KGppB8eFCf5pVdqMAX3Iy1+m
         XH/iBV3BYIVye8uH4kelWQbCvb4vejH65iHoK1IEwU39B71e9YsDwp4Cfb0H22FbqGvw
         v3KJE1BjTz2Fml0kzHMObjV5yhGCli6713TjXpfY3bCzWpBdli55vD/fGrILXjvnRWIa
         yxh1RyXO/HYzlrE38oQnfs+nlGviCMMCpgMXMs+sHSOomRk73GKZltkpUNmozcnXUAJI
         8zyM20HCik3wUHLKu0mlbShT8+hvAZmZCuXxmioAStIXxRro4rDAcLLVD6+znTbeb6zA
         mZ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LLgQsCek9Kb1m4nAwNnmEBwVioWI00Iv+0FWhumo+dE=;
        b=kG8T4ATnDaWwxShdE+zktdeBSF/DoO+2HyvYhdnHeB/mOLHlY+pAOY71qNXvdPw6OO
         wHm7EdieYKR06QjJkpQz+bjSqpabFHzcy+UyTh2TU+vpxLOzepzpFO98LJZkjo5T48Nh
         EcysZpqny8G1IG/5b4H1AfyYH/v8032qmatGzZQY9oU0XSHkzE6tI0tMVV12e8PCuqxW
         VfESp/S4inWNIrIb/XD8o6oh8ga7j1dmeAX+8QmhaMNA3arOLFInFYqXv70u8PIGNffy
         ipgijg+PEjiKO11dqzgsTJqyyOM1zUxxQGxMTzvGYEDoUksUhkxr/HqdEAcIHKSsIXA+
         v+qw==
X-Gm-Message-State: ANhLgQ0RjDdzSfsU52TSWsDOD2Crxy5RVRze38gmQKZd7r80mszGP60T
        94tPnh368/UQCtHiW1QBykcbdR8GkvDgYwE9E3Ftjw==
X-Google-Smtp-Source: ADFU+vvmFLfIa2HV/KNG6a6ZxH2awdyggqi1JUEECvxNbW+fPZiqZ/xZDxS36aAy14JiPgakxzIp85/ViOWnCFG7404=
X-Received: by 2002:a6b:c986:: with SMTP id z128mr5313314iof.296.1583263409592;
 Tue, 03 Mar 2020 11:23:29 -0800 (PST)
MIME-Version: 1.0
References: <20200302235709.27467-1-sean.j.christopherson@intel.com> <20200302235709.27467-49-sean.j.christopherson@intel.com>
In-Reply-To: <20200302235709.27467-49-sean.j.christopherson@intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Tue, 3 Mar 2020 11:23:18 -0800
Message-ID: <CALMp9eRoY6XkwaVd3NmB7xyVTgruRjRyo9ynixCf-szp7hBS+A@mail.gmail.com>
Subject: Re: [PATCH v2 48/66] KVM: x86: Remove stateful CPUID handling
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xiaoyao Li <xiaoyao.li@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 2, 2020 at 3:57 PM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:

> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index b5dce17c070f..49527dbcc90c 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -495,25 +495,16 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
>                  * time, with the least-significant byte in EAX enumerating the
>                  * number of times software should do CPUID(2, 0).
>                  *
> -                * Modern CPUs (quite likely every CPU KVM has *ever* run on)
> -                * are less idiotic.  Intel's SDM states that EAX & 0xff "will
> -                * always return 01H. Software should ignore this value and not
> +                * Modern CPUs, i.e. every CPU KVM has *ever* run on are less

Nit: missing comma after "run on."

Reviewed-by: Jim Mattson <jmattson@google.com>
