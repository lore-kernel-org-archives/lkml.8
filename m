Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C0BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 08:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB79A2073A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 08:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gTfPmHHc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbgHJIGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 04:06:42 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:59006 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725857AbgHJIGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 04:06:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597046798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OcahFa/ozGtHspvNjlza3UxikXMeL5PGYiQh3U0aBls=;
        b=gTfPmHHcNbmbpAtXENcBobVeODU1dc3gLbQZjAbu6xfmOvLUFQFPqaS7ggnsjE5fE4RbPm
        FWsDkDQYlMEj7gZ0nonkEDGNNsuIP2A9IsBv3Z3IRAbAKLZ/co6OJYK8JjE13MfOZQZH3B
        z95++h8HpWzL1QDs5LU0hPKydNcJ1AA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-QCQcVcQTOUuMuiFs4wDEQw-1; Mon, 10 Aug 2020 04:06:31 -0400
X-MC-Unique: QCQcVcQTOUuMuiFs4wDEQw-1
Received: by mail-ej1-f69.google.com with SMTP id g18so3578613ejm.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 01:06:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=OcahFa/ozGtHspvNjlza3UxikXMeL5PGYiQh3U0aBls=;
        b=JKs92NtIo+8L0fMqBs6kETT2+MPJzdBJw/NtqT0/Fy7m/rW3c6okgmDlgDHQW1r9WQ
         Vy1k6Lut7wxogcP+bZ0nKOSLq1DEtjb+gtxptO1Yd+2X3IClh7DM/QqAHL2d3GJvdV2A
         S/XjWFO9A5+7qs7DQoh/2ldKXZJAs7AJU74XmLNLhaEcah0NgVA80YThOqr6KoygrdG3
         jBZVwqu5wMfOIBegRfM9wYGgy72352YZH6UUJBQagN9NnxZeOQcHrNfT+CmEtcUtg8X4
         ASyyrNJ3nvqiqcxESi3+xgkZeYpSP5tWhS/QiIe9SgLRKzHOiI8ujjRQSw4SOSSvaSTm
         Ovtw==
X-Gm-Message-State: AOAM530QnF84+U2Sqbqsy6CWdMc3eFvZiJg2tJCDOZuvl12a+d/jM2NX
        /Zo8H+WGJMJQV854yC/N976Z2fc6wwEfIYFL6KfYFVrj+VnUM8FhQ2crIWpK43O37Dp5yEDfhHG
        q/08Ck/MHLobH2TYA1XaFml/v
X-Received: by 2002:a17:906:9385:: with SMTP id l5mr20142318ejx.144.1597046789999;
        Mon, 10 Aug 2020 01:06:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwvamq9BuWqnIdnErIwJVAWKSj/F3XVmYf1XapjDCPpElibWU2Ao+jAty5c/AbzI3WAjBnQTQ==
X-Received: by 2002:a17:906:9385:: with SMTP id l5mr20142296ejx.144.1597046789737;
        Mon, 10 Aug 2020 01:06:29 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id u4sm11888104edy.18.2020.08.10.01.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 01:06:29 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org,
        syzbot <syzbot+c116bcba868f8148cd3e@syzkaller.appspotmail.com>
Cc:     bp@alien8.de, hpa@zytor.com, jmattson@google.com, joro@8bytes.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        pbonzini@redhat.com, sean.j.christopherson@intel.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        wanpengli@tencent.com, x86@kernel.org,
        Nitesh Narayan Lal <nitesh@redhat.com>
Subject: Re: WARNING in rcu_irq_exit
In-Reply-To: <000000000000843c1005ac7a990c@google.com>
References: <000000000000843c1005ac7a990c@google.com>
Date:   Mon, 10 Aug 2020 10:06:28 +0200
Message-ID: <875z9qorgb.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot <syzbot+c116bcba868f8148cd3e@syzkaller.appspotmail.com> writes:

> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    47ec5303 Merge git://git.kernel.org/pub/scm/linux/kernel/g..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=17228c62900000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e0c783f658542f35
> dashboard link: https://syzkaller.appspot.com/bug?extid=c116bcba868f8148cd3e
> compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+c116bcba868f8148cd3e@syzkaller.appspotmail.com
>
> device lo entered promiscuous mode
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 29030 at kernel/rcu/tree.c:772 rcu_irq_exit+0x19/0x20 kernel/rcu/tree.c:773
> Kernel panic - not syncing: panic_on_warn set ...
> CPU: 1 PID: 29030 Comm: syz-executor.2 Not tainted 5.8.0-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1f0/0x31e lib/dump_stack.c:118
>  panic+0x264/0x7a0 kernel/panic.c:231
>  __warn+0x227/0x250 kernel/panic.c:600
>  report_bug+0x1b1/0x2e0 lib/bug.c:198
>  handle_bug+0x42/0x80 arch/x86/kernel/traps.c:235
>  exc_invalid_op+0x16/0x40 arch/x86/kernel/traps.c:255
>  asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:536
> RIP: 0010:rcu_irq_exit+0x19/0x20 kernel/rcu/tree.c:773
> Code: 0b c3 0f 1f 44 00 00 66 2e 0f 1f 84 00 00 00 00 00 83 3d fd fb 68 01 00 74 0b 65 8b 05 50 00 dc 77 85 c0 75 05 e9 07 ff ff ff <0f> 0b e9 00 ff ff ff 41 56 53 83 3d da fb 68 01 00 74 0f 65 8b 05
> RSP: 0018:ffffc90001806e70 EFLAGS: 00010002
> RAX: 0000000000000001 RBX: 0000000000000082 RCX: 0000000000040000
> RDX: ffffc9000da6b000 RSI: 0000000000003173 RDI: 0000000000003174
> RBP: ffff8880a2ce9fa8 R08: ffffffff817a9064 R09: ffffed1015d26cf5
> R10: ffffed1015d26cf5 R11: 0000000000000000 R12: dffffc0000000000
> R13: 000000000000003c R14: dffffc0000000000 R15: 000000000000003c
>  rcu_irq_exit_irqson+0x80/0x110 kernel/rcu/tree.c:827
...

Chances are this is fixed by Tglx' 

commit 87fa7f3e98a1310ef1ac1900e7ee7f9610a038bc
Author: Thomas Gleixner <tglx@linutronix.de>
Date:   Wed Jul 8 21:51:54 2020 +0200

    x86/kvm: Move context tracking where it belongs

(in kvm/next currently).

See also: https://lore.kernel.org/kvm/ece36eb1-253a-8ec6-c183-309c10bb35d5@redhat.com/
which was confirmed to be fixed by the above mentioned commit.

-- 
Vitaly

