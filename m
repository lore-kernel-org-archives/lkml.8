Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C30C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 17:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3987A217F4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 17:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vRxxEZHP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbgCBRBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 12:01:40 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:33771 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbgCBRBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 12:01:39 -0500
Received: by mail-il1-f194.google.com with SMTP id r4so153782iln.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 09:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qxBd2/UPs5vf4LaxUj5TjDTWVmNZ1aU9EeZ4ieRPNr0=;
        b=vRxxEZHP+PcGuqWY+XHCm6VavLlu2hAfuoiI+iQedKrK7r1wdvYqIJljxbhdgYvyY9
         DCqy+lZCJdDxI9h+Uk+JYi1Nlceqz94RVdcbdcrvbKfCuN9ZrEGzXZ9JxZ4JB4Iwh63L
         3vsaWFiF7k+8i0nJCGrU6w+TjAqwKSOE60vDaNM1FJdZDgWX+jWkiNunAjwRzh8F7g0q
         oFFt27a4qbZbUoHpkCZBwMDjVdKzUcVl37nOju2Ou6/OzSskvFPHie07cLsvxlcEDuBt
         0q1WftFL6RFvB6SDj5Cg1cQsMkm9eLUlTKCOqbUWGy12kVGwD0E1/CqNwQzEg9ic1Xr7
         /yYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qxBd2/UPs5vf4LaxUj5TjDTWVmNZ1aU9EeZ4ieRPNr0=;
        b=bfFp0wgur7WDfNulAKEjopJNfoozU5jW3D4qIfLbgCIwwb7/T+Rgsx3mAKiklVwXqE
         ABmXiVoKYi2MXUSAS2yv8e0iOUbkgEhsVsoL/h8wGeAvicnPpzPGbf5AbVMwkkT5ZPie
         FPkILTPKxLD9KEFCBpYcrWTU8OyLG8sPrPPEU/uOPs+/WME8XQn+DbQV1yIkfhFCRCBo
         ///PqLNII1vM+Cu196mPdPmWtCu0kAgnbeBaShzZ0nHQ5WKhBz8yZJYVIkPrJWPLC/pu
         KjvJY2krgswzl8S49jguqif/jVlKDU1uIbi6f2ccJRb9SN73tpdpQAPgRlh2idSA2O2r
         NsRQ==
X-Gm-Message-State: ANhLgQ3iXaQPc2dCu1kWWBsPvrV6IHtpdsQvNEydbW1fkfbuEmJ/x5fy
        +H9y7hs+BZyEXya1qlWCx0U5XJ7BuEp94lJ+eur1Yw==
X-Google-Smtp-Source: ADFU+vseY6BhGkCHYlyct7BltEijotjEZ5gYChfY0KqvAR4ZvWW7s81Gs54Im4NcVW30zcggWbg7iXYFPhswML/2lP4=
X-Received: by 2002:a92:8547:: with SMTP id f68mr616024ilh.26.1583168498999;
 Mon, 02 Mar 2020 09:01:38 -0800 (PST)
MIME-Version: 1.0
References: <1582773688-4956-1-git-send-email-linmiaohe@huawei.com>
In-Reply-To: <1582773688-4956-1-git-send-email-linmiaohe@huawei.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Mon, 2 Mar 2020 09:01:27 -0800
Message-ID: <CALMp9eSaZ557-GaQUVXW6-ZrMkz8jxOC1S6QPk-EVNJ-f2pT5w@mail.gmail.com>
Subject: Re: [PATCH v2] KVM: X86: deprecate obsolete KVM_GET_CPUID2 ioctl
To:     linmiaohe <linmiaohe@huawei.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 7:20 PM linmiaohe <linmiaohe@huawei.com> wrote:
>
> From: Miaohe Lin <linmiaohe@huawei.com>
>
> When kvm_vcpu_ioctl_get_cpuid2() fails, we set cpuid->nent to the value of
> vcpu->arch.cpuid_nent. But this is in vain as cpuid->nent is not copied to
> userspace by copy_to_user() from call site. Also cpuid->nent is not updated
> to indicate how many entries were retrieved on success case. So this ioctl
> is straight up broken. And in fact, it's not used anywhere. So it should be
> deprecated.

I don't know how you can make the assertion that this ioctl is not
used anywhere. For instance, I see a use of it in Google's code base.
