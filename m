Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 005F3C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 18:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCB91207FD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 18:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qHwudCiM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbgCESoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 13:44:04 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:33567 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgCESoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 13:44:04 -0500
Received: by mail-il1-f195.google.com with SMTP id r4so5956608iln.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 10:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jQrU1ycuK56Wco0X09B7AmUEkfvXTDPV4/enUSsAJG4=;
        b=qHwudCiMEDtoduI5abx7Au96djjqA4MICG5WoLKcDqa4HyqqKsWk3xsnY1KfBgAzbV
         FUHboP4KQaYuvYxEWZui1b0dbf14eiq9p7o1Uznhf0EVJfQ+w9ls6C4Us1yJhGtAiZvk
         CbPIuS5ymL4SIYYu+njrQA2xuEu2sGvvQx6uAVm7eEjmwU1JAN8z8m1uU1EQwHdsdkJo
         +N4jR+N883F8TWXXG38iAfzZZZBjQhLsQqDgIKGtIXl03ThPz+q9yaZ8ggxUI/UKibdl
         RCQIDOnKlpeEqTe2uphYjCyptK0+7GwzZXkUGTF2oN0KTAYVNfVhg7chqedDnRHzMEZg
         FLsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jQrU1ycuK56Wco0X09B7AmUEkfvXTDPV4/enUSsAJG4=;
        b=kfPGBTx4JWEH72MgwO8FyIEyLD0Bd3v+ceBX6D+tkY+Bs7yNwJFL+4c+fo7rbmwWrO
         0PANJXengppnIbP5AVnRGjyJAzARTB5PaRU3rchKK+5ItCntrKHqPPqwWd+lOXQoZ0Hq
         5HUJLusQO697jnIGS2ySgzOiMHTmlvlU3iKs4IDgKU/+05kK6r9j8Fa8RS/wxuVq1I7k
         u/rlY7DYb52wqQa4Sb7pvS4iY5MBy0veQSmoPjhB5+8TclGAotoOid++3dW74VQ9G005
         +upgjBxbe72P9n3GgGa3jfGu+x2syvdHOBi8aap5ZuhBaIrL0JxlIJxQR0c26yFODxkI
         gNuw==
X-Gm-Message-State: ANhLgQ0JAV4WpFb6qawUu3UsXqQfLLQkSPw8rNI+gQKor2Gt1AsARAEE
        y8bFJFpLEzw6PHcH8SEDQhRJy9c+I0Nb/4z8EHnEKg==
X-Google-Smtp-Source: ADFU+vt4qvBIGp+yHLrI64YSK1/fHHdooZOdurgvTYU1hu2RTLUDofVfOjMRFYxg87L1Ni2t/O3L+teG2/uSYul8txw=
X-Received: by 2002:a92:914a:: with SMTP id t71mr357972ild.108.1583433842040;
 Thu, 05 Mar 2020 10:44:02 -0800 (PST)
MIME-Version: 1.0
References: <20200305013437.8578-1-sean.j.christopherson@intel.com> <20200305013437.8578-5-sean.j.christopherson@intel.com>
In-Reply-To: <20200305013437.8578-5-sean.j.christopherson@intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 5 Mar 2020 10:43:51 -0800
Message-ID: <CALMp9eRRWZ54kzMXdTqRCy2KmaUAq+HVVVzbxJNVdgktg65XCA@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] KVM: x86: Fix CPUID range checks for Hypervisor
 and Centaur classes
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Pu Wen <puwen@hygon.cn>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 4, 2020 at 5:34 PM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> Rework the masking in the out-of-range CPUID logic to handle the
> Hypervisor sub-classes, as well as the Centaur class if the guest
> virtual CPU vendor is Centaur.
>
> Masking against 0x80000000 only handles basic and extended leafs, which
> results in Hypervisor range checks being performed against the basic
> CPUID class, and Centuar range checks being performed against the
> Extended class.  E.g. if CPUID.0x40000000.EAX returns 0x4000000A and
> there is no entry for CPUID.0x40000006, then function 0x40000006 would
> be incorrectly reported as out of bounds.
>
> While there is no official definition of what constitutes a class, the
> convention established for Hypervisor classes effectively uses bits 31:8
> as the mask by virtue of checking for different bases in increments of
> 0x100, e.g. KVM advertises its CPUID functions starting at 0x40000100
> when HyperV features are advertised at the default base of 0x40000000.
>
> The bad range check doesn't cause functional problems for any known VMM
> because out-of-range semantics only come into play if the exact entry
> isn't found, and VMMs either support a very limited Hypervisor range,
> e.g. the official KVM range is 0x40000000-0x40000001 (effectively no
> room for undefined leafs) or explicitly defines gaps to be zero, e.g.
> Qemu explicitly creates zeroed entries up to the Cenatur and Hypervisor
> limits (the latter comes into play when providing HyperV features).
>
> The bad behavior can be visually confirmed by dumping CPUID output in
> the guest when running Qemu with a stable TSC, as Qemu extends the limit
> of range 0x40000000 to 0x40000010 to advertise VMware's cpuid_freq,
> without defining zeroed entries for 0x40000002 - 0x4000000f.
>
> Note, documentation of Centaur/VIA CPUs is hard to come by.  Designating
> 0xc0000000 - 0xcfffffff as the Centaur class is a best guess as to the
> behavior of a real Centaur/VIA CPU.

Don't forget Transmeta's CPUID range at 0x80860000 through 0x8086FFFF!
