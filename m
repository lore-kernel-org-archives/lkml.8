Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E28C4332E
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 08:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 627DF20637
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 08:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UoClQMO6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbgCWISa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 04:18:30 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:48421 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727526AbgCWISa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 04:18:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584951508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9+djlOZkkG34kATfFU8ToSkWmnwBYyFJfZBQaAAXqqE=;
        b=UoClQMO61tOXMtbTmaf2gwx9zvXRbdjdecKnP9NVJ4wfOEi8MWOZsvX5jA6OmMBGr8X6Mm
        NBdZ+eBhWVV19giVwbsmZ6VmRAcRiDHyOl1TYa/xZRZ+i9FpVlmjCSaVmfCMQgmXe/IuXi
        ukk9MscQGqe/DsWlBkyGfmBjbWiHSUE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-qsXFI-B7MZCs6vdgKpsJHQ-1; Mon, 23 Mar 2020 04:18:20 -0400
X-MC-Unique: qsXFI-B7MZCs6vdgKpsJHQ-1
Received: by mail-wm1-f71.google.com with SMTP id s14so1049220wmj.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 01:18:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9+djlOZkkG34kATfFU8ToSkWmnwBYyFJfZBQaAAXqqE=;
        b=n5WYJgej/rmYeUfKybroqnp9QvNkIF0GgRvVlEmmv4B2a3m01NmD+aBLea7DrF+Mmn
         0+UqadGRdV4vgp62LIezwendlV+bokEh6+Hw/VM2PV/jhAAEO0CYGHJSiFbCutd/J1BV
         WHUt61vbtl/Aaa1r1zYJReVYhtMeAEe+XeI7mKmNIFJK4DWr8+buhIBnRWhvk/q4E7qc
         oPWoMQQ4L5dij107zS325OM3pjg5uuTf/vjX0TVL81ua4+dZm+6LoASlv24mp0AgL+I4
         qEsrBXJ++9f0hStbAFWZ0fpeW+sajYwA67m/ytmxlnVhOgajUcMYpxqnS1bSFEgJcpWG
         1sww==
X-Gm-Message-State: ANhLgQ3jTq3TDdy/uLP2k5xLdi9qUTlh8sQPBvsJx8211WY2BVkl3pt0
        MZr9c9ltbN2+hi76eltgIlj9IdCUiKBVFqoUXQb2w7F1ZHrbh3LGyZG+1VGz7XWs3dcYP0ZJQ5o
        bqABBnfsgv/S4huSK4h8mXZfj
X-Received: by 2002:adf:fa8a:: with SMTP id h10mr6852180wrr.160.1584951497496;
        Mon, 23 Mar 2020 01:18:17 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuglqGpMjyGAXtjGXC9VUQZ55Okh6SKZ0pRVVSMnctABMUeYyFbQ50ib/snd3MA/dgnb/Bz0A==
X-Received: by 2002:adf:fa8a:: with SMTP id h10mr6852142wrr.160.1584951497210;
        Mon, 23 Mar 2020 01:18:17 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:24d8:ed40:c82a:8a01? ([2001:b07:6468:f312:24d8:ed40:c82a:8a01])
        by smtp.gmail.com with ESMTPSA id t126sm21823703wmb.27.2020.03.23.01.18.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2020 01:18:16 -0700 (PDT)
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in
 handle_external_interrupt_irqoff
To:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+3f29ca2efb056a761e38@syzkaller.appspotmail.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Cc:     Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, KVM list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, wanpengli@tencent.com,
        the arch/x86 maintainers <x86@kernel.org>
References: <000000000000277a0405a16bd5c9@google.com>
 <CACT4Y+b1WFT87pWQaXD3CWjyjoQaP1jcycHdHF+rtxoR5xW1ww@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5058aabe-f32d-b8ef-57ed-f9c0206304c5@redhat.com>
Date:   Mon, 23 Mar 2020 09:18:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+b1WFT87pWQaXD3CWjyjoQaP1jcycHdHF+rtxoR5xW1ww@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/03/20 07:59, Dmitry Vyukov wrote:
> 
> The commit range is presumably
> fb279f4e238617417b132a550f24c1e86d922558..63849c8f410717eb2e6662f3953ff674727303e7
> But I don't see anything that says "it's me". The only commit that
> does non-trivial changes to x86/vmx seems to be "KVM: VMX: check
> descriptor table exits on instruction emulation":

That seems unlikely, it's a completely different file and it would only
affect the outside (non-nested) environment rather than your own kernel.

The only instance of "0x86" in the registers is in the flags:

> RSP: 0018:ffffc90001ac7998 EFLAGS: 00010086
> RAX: ffffc90001ac79c8 RBX: fffffe0000000000 RCX: 0000000000040000
> RDX: ffffc9000e20f000 RSI: 000000000000b452 RDI: 000000000000b453
> RBP: 0000000000000ec0 R08: ffffffff83987523 R09: ffffffff811c7eca
> R10: ffff8880a4e94200 R11: 0000000000000002 R12: dffffc0000000000
> R13: fffffe0000000ec8 R14: ffffffff880016f0 R15: fffffe0000000ecb
> FS:  00007fb50e370700(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000000000005c CR3: 0000000092fc7000 CR4: 00000000001426f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

That would suggest a miscompilation of the inline assembly, which does
push the flags:

#ifdef CONFIG_X86_64
                "mov %%" _ASM_SP ", %[sp]\n\t"
                "and $0xfffffffffffffff0, %%" _ASM_SP "\n\t"
                "push $%c[ss]\n\t"
                "push %[sp]\n\t"
#endif
                "pushf\n\t"
                __ASM_SIZE(push) " $%c[cs]\n\t"
                CALL_NOSPEC


It would not explain why it suddenly started to break, unless the clang
version also changed, but it would be easy to ascertain and fix (in
either KVM or clang).  Dmitry, can you send me the vmx.o and
kvm-intel.ko files?

Thanks,

Paolo

