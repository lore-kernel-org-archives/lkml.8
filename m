Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C2DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 10:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5813207ED
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 10:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nyuu+neK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgFDKxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 06:53:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45940 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725854AbgFDKxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 06:53:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591267997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NJ5211tqQw+odkztinAtHwvoVxd/s5NOqyp0nCyASHw=;
        b=Nyuu+neKigd844xRBRHBTKd0MJx1gi9OKdl7+YsSkcTa1YQ3BWXEf2j+OPZhCN4C6P/Sxm
        2nBpiyEWvaLC2tp0esxTRO3cQONC1sTHBaVMLpKGOpGIvOmNNIck37XzDTmG2CmmPn/0Eb
        5FgHgxFxkwlnlB5UbTse7CR+JfSkas8=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-BA6gkKbgMyeunzwL7L6bSw-1; Thu, 04 Jun 2020 06:53:14 -0400
X-MC-Unique: BA6gkKbgMyeunzwL7L6bSw-1
Received: by mail-ed1-f71.google.com with SMTP id o12so2473653edj.12
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 03:53:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=NJ5211tqQw+odkztinAtHwvoVxd/s5NOqyp0nCyASHw=;
        b=XwzjDMCP750CKemlD4IB5HpHJAk7Yzr8mpyyWJB7rSk50qsoxQ0Iui4BWDspXJqkDV
         8yK8KLCp3tf4eNyJFbgEaZ2b4Mc9hRTU59STMnZn7sympLuJupm0BRTYq1RanZNWkVA1
         yuKWB4mMD4JLneziDUrhBbc9V49lXbrXGjeaIgHVQqx75BOhXA//xhvj0Z5lO3G+YIB3
         rK9OPGyZcjFVpnLQMSEj+Ufki7FNykOQBD/HUhBb2/TzxiDHNWrHIrPYA8oezAXhpX83
         BmG5a42+Sn6fqqjww/pKMMu60W6+XRetZDcLP8EZKHsUGhiDEZdZqlCDWTci+BC00vre
         fk8g==
X-Gm-Message-State: AOAM533zuw3NDiSVRV4opXiYC3FqFb+0Kg6yOk6U7nuZWjQ9CFe9qYSX
        kW/O7RdGUMN1BNKoBjLLW4vT4K+pMxwhG+IZbxf1lnROaTFuSIzT6J8MTXA/IPUOgFegHmQsGWa
        phdTjDjskwkqgeY/olAPYUb8+
X-Received: by 2002:a17:906:3483:: with SMTP id g3mr3279358ejb.373.1591267992747;
        Thu, 04 Jun 2020 03:53:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwmkk3yovp2SuFFArqDQKJwy/TMc25+fPl8y9LVkYJ3sQoitVh7mzj72xFAZldNwmLjupmTsQ==
X-Received: by 2002:a17:906:3483:: with SMTP id g3mr3279343ejb.373.1591267992516;
        Thu, 04 Jun 2020 03:53:12 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id l27sm1819141eja.118.2020.06.04.03.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 03:53:10 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org, pbonzini@redhat.com,
        sean.j.christopherson@intel.com
Cc:     syzbot <syzbot+2a7156e11dc199bdbd8a@syzkaller.appspotmail.com>,
        bp@alien8.de, hpa@zytor.com, jmattson@google.com, joro@8bytes.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        wanpengli@tencent.com, x86@kernel.org
Subject: Re: WARNING in kvm_inject_emulated_page_fault
In-Reply-To: <000000000000c8a76e05a73e3be3@google.com>
References: <000000000000c8a76e05a73e3be3@google.com>
Date:   Thu, 04 Jun 2020 12:53:09 +0200
Message-ID: <874krrf6ga.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot <syzbot+2a7156e11dc199bdbd8a@syzkaller.appspotmail.com> writes:

> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    cb8e59cc Merge git://git.kernel.org/pub/scm/linux/kernel/g..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=14dedfe2100000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a16ddbc78955e3a9
> dashboard link: https://syzkaller.appspot.com/bug?extid=2a7156e11dc199bdbd8a
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=134ca2de100000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=178272f2100000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+2a7156e11dc199bdbd8a@syzkaller.appspotmail.com
>
> L1TF CPU bug present and SMT on, data leak possible. See CVE-2018-3646 and https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/l1tf.html for details.
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 6819 at arch/x86/kvm/x86.c:618
> kvm_inject_emulated_page_fault+0x210/0x290 arch/x86/kvm/x86.c:618

This is 

WARN_ON_ONCE(fault->vector != PF_VECTOR);

> Kernel panic - not syncing: panic_on_warn set ...
> CPU: 0 PID: 6819 Comm: syz-executor268 Not tainted 5.7.0-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x188/0x20d lib/dump_stack.c:118
>  panic+0x2e3/0x75c kernel/panic.c:221
>  __warn.cold+0x2f/0x35 kernel/panic.c:582
>  report_bug+0x27b/0x2f0 lib/bug.c:195
>  fixup_bug arch/x86/kernel/traps.c:105 [inline]
>  fixup_bug arch/x86/kernel/traps.c:100 [inline]
>  do_error_trap+0x12b/0x220 arch/x86/kernel/traps.c:197
>  do_invalid_op+0x32/0x40 arch/x86/kernel/traps.c:216
>  invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1027
> RIP: 0010:kvm_inject_emulated_page_fault+0x210/0x290 arch/x86/kvm/x86.c:618
> Code: 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 75 79 48 8b 53 08 4c 89 f6 48 89 ef e8 fa 04 0c 00 e9 10 ff ff ff e8 10 ac 68 00 <0f> 0b e9 3a fe ff ff 4c 89 e7 e8 21 74 a7 00 e9 5d fe ff ff 48 89
> RSP: 0018:ffffc90000f87968 EFLAGS: 00010293
> RAX: ffff888095202540 RBX: ffffc90000f879e0 RCX: ffffffff810ae417
> RDX: 0000000000000000 RSI: ffffffff810ae5e0 RDI: 0000000000000001
> RBP: ffff888088ce0040 R08: ffff888095202540 R09: fffff520001f0f58
> R10: ffffc90000f87abf R11: fffff520001f0f57 R12: 0000000000000000
> R13: 0000000000000001 R14: ffffc90000f87ab8 R15: ffff888088ce0380
>  nested_vmx_get_vmptr+0x1f9/0x2a0 arch/x86/kvm/vmx/nested.c:4638
>  handle_vmon arch/x86/kvm/vmx/nested.c:4767 [inline]
>  handle_vmon+0x168/0x3a0 arch/x86/kvm/vmx/nested.c:4728
>  vmx_handle_exit+0x29c/0x1260 arch/x86/kvm/vmx/vmx.c:6067
  
 [...]

Exception we're trying to inject comes from

 nested_vmx_get_vmptr()
  kvm_read_guest_virt()
   kvm_read_guest_virt_helper()
     vcpu->arch.walk_mmu->gva_to_gpa()

but it seems it is only set if GVA to GPA convertion fails. In case it
doesn't, we can still fail kvm_vcpu_read_guest_page() and return
X86EMUL_IO_NEEDED but nested_vmx_get_vmptr() doesn't case what we return
and does kvm_inject_emulated_page_fault(). This can happen when VMXON
parameter is MMIO, for example.

How do fix this? We can either properly exit to userspace for handling
or, if we decide that handling such requests makes little sense, just
inject #GP if exception is not set, e.g. 

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 9c74a732b08d..a21e2f32f59b 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -4635,7 +4635,11 @@ static int nested_vmx_get_vmptr(struct kvm_vcpu *vcpu, gpa_t *vmpointer)
                return 1;
 
        if (kvm_read_guest_virt(vcpu, gva, vmpointer, sizeof(*vmpointer), &e)) {
-               kvm_inject_emulated_page_fault(vcpu, &e);
+               if (e.vector == PF_VECTOR)
+                       kvm_inject_emulated_page_fault(vcpu, &e);
+               else
+                       kvm_inject_gp(vcpu, 0);
+
                return 1;
        }

-- 
Vitaly

