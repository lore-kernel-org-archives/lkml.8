Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 533A3C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 13:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BCBE206E6
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 13:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nys7f5HH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbgFENiX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 09:38:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58270 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726937AbgFENiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 09:38:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591364301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OobYjPmqA3TvfL8yzZlPpuk13tFAX+IiJnvRNhzycbA=;
        b=Nys7f5HH/LfEzd8k87LVylYUVN7CbPbiKL/1msY0HcpkTBN8n2ukyCRrhpySkrBaRDd6uh
        Cf8w2C4UjT+qEePwCb02hjdmGE2a1SBniaR6WI7oFK55vd/EtQiSMS/bZpd+8G7kx3x7o6
        +e+Zpm7pLYkgTZuU7adMW5/Wm6i+NnM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-Qv-a6_wePmqbFMhaQlq0SQ-1; Fri, 05 Jun 2020 09:38:14 -0400
X-MC-Unique: Qv-a6_wePmqbFMhaQlq0SQ-1
Received: by mail-ed1-f70.google.com with SMTP id w23so3921731edt.18
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 06:38:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=OobYjPmqA3TvfL8yzZlPpuk13tFAX+IiJnvRNhzycbA=;
        b=VeEu2P7Ce8CLsPzJbStGA9ReVHrrcpPJCqE23DWscGB6PvCtya1pp96lyI0LIxU+Ak
         kmLmhW+bXHNO0CHYpBHgMT21vDn0f4RA1m7JktPeqMAtm1Y7gFKck/HHOi7s+8WF5RgQ
         9ofKF1QjDuz1NMOk9rBhkt7pUd6m2U6shxFNQzWacQFh8327m7urVZ6o6pmYcLJioAVk
         MvcB/pJT2T2EjUNLYBMqcRct17gBDmXnFBGPLVDi2BY2okt35yACA9YY5papSW2vdv/U
         VbkNrY0dW85m7x4dkYsYGdq44G2/7AR30qMBDeyPOuiwrXiW7nDBQRHLskrnLelk6lLJ
         Eorg==
X-Gm-Message-State: AOAM530IJbSruAd40ENPUuV7gOEfF3a3kznVn+t+8vzH5+3s7S1PPpWD
        sRKOx5dQ7GUS4N0cl2BAzITe6pKztMy779lxuSFjpfQesfewG1faBH8ctTcPFomJboxJ65otQeQ
        iOPwdjgvkWeyFj3eIQ4F7N6aU
X-Received: by 2002:aa7:c758:: with SMTP id c24mr9093431eds.290.1591364293714;
        Fri, 05 Jun 2020 06:38:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzh9IIkCQxa/oZvYAov5t8bQcI0de8A/5/uZrivnjRK6RheWxHSiiqpq77n0Nb1m3g1NiysEQ==
X-Received: by 2002:aa7:c758:: with SMTP id c24mr9093419eds.290.1591364293475;
        Fri, 05 Jun 2020 06:38:13 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id n35sm4996087edc.11.2020.06.05.06.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 06:38:10 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org, pbonzini@redhat.com
Cc:     syzbot <syzbot+705f4401d5a93a59b87d@syzkaller.appspotmail.com>,
        eesposit@redhat.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: general protection fault in start_creating
In-Reply-To: <0000000000001803d305a7414b66@google.com>
References: <0000000000001803d305a7414b66@google.com>
Date:   Fri, 05 Jun 2020 15:38:08 +0200
Message-ID: <87sgf9d45b.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot <syzbot+705f4401d5a93a59b87d@syzkaller.appspotmail.com> writes:

> syzbot has found a reproducer for the following crash on:
>
> HEAD commit:    cb8e59cc Merge git://git.kernel.org/pub/scm/linux/kernel/g..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=170f49de100000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a16ddbc78955e3a9
> dashboard link: https://syzkaller.appspot.com/bug?extid=705f4401d5a93a59b87d
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1367410e100000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10e07e0e100000
>
> The bug was bisected to:
>
> commit 63d04348371b7ea4a134bcf47c79763d969e9168
> Author: Paolo Bonzini <pbonzini@redhat.com>
> Date:   Tue Mar 31 22:42:22 2020 +0000
>
>     KVM: x86: move kvm_create_vcpu_debugfs after last failure point
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1366069a100000
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=10e6069a100000
> console output: https://syzkaller.appspot.com/x/log.txt?x=1766069a100000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+705f4401d5a93a59b87d@syzkaller.appspotmail.com
> Fixes: 63d04348371b ("KVM: x86: move kvm_create_vcpu_debugfs after last failure point")
>
> general protection fault, probably for non-canonical address 0xdffffc000000002a: 0000 [#1] PREEMPT SMP KASAN
> KASAN: null-ptr-deref in range [0x0000000000000150-0x0000000000000157]
> CPU: 0 PID: 19367 Comm: syz-executor088 Not tainted 5.7.0-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:__lock_acquire+0xe1b/0x4a70 kernel/locking/lockdep.c:4250
> Code: 91 0a 41 be 01 00 00 00 0f 86 ce 0b 00 00 89 05 4b 9a 91 0a e9 c3 0b 00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 d2 48 c1 ea 03 <80> 3c 02 00 0f 85 57 2e 00 00 49 81 3a c0 74 c0 8b 0f 84 b0 f2 ff
> RSP: 0018:ffffc90004b477b8 EFLAGS: 00010002
> RAX: dffffc0000000000 RBX: 0000000000000001 RCX: 0000000000000000
> RDX: 000000000000002a RSI: 0000000000000000 RDI: 0000000000000150
> RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
> R10: 0000000000000150 R11: 0000000000000001 R12: 0000000000000000
> R13: ffff8880a77c2200 R14: 0000000000000000 R15: 0000000000000000
> FS:  00007f9f3c6e5700(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000004d5bb0 CR3: 00000000821f9000 CR4: 00000000001426f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  lock_acquire+0x1f2/0x8f0 kernel/locking/lockdep.c:4959
>  down_write+0x8d/0x150 kernel/locking/rwsem.c:1531
>  inode_lock include/linux/fs.h:799 [inline]
>  start_creating+0xa8/0x250 fs/debugfs/inode.c:334
>  __debugfs_create_file+0x62/0x400 fs/debugfs/inode.c:383
>  kvm_arch_create_vcpu_debugfs+0x9f/0x200 arch/x86/kvm/debugfs.c:52
>  kvm_create_vcpu_debugfs arch/x86/kvm/../../../virt/kvm/kvm_main.c:3012 [inline]

...

I think what happens here is one thread does kvm_vm_ioctl_create_vcpu()
and another tries to delete the VM. The problem was probably present
even before the commit as both kvm_create_vcpu_debugfs() and
kvm_destroy_vm_debugfs() happen outside of kvm_lock but maybe it was
harder to trigger. Is there a reason to not put all this under kvm_lock?
I.e. the following:

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 7fa1e38e1659..d53784cb920f 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -793,9 +793,9 @@ static void kvm_destroy_vm(struct kvm *kvm)
        struct mm_struct *mm = kvm->mm;
 
        kvm_uevent_notify_change(KVM_EVENT_DESTROY_VM, kvm);
-       kvm_destroy_vm_debugfs(kvm);
        kvm_arch_sync_events(kvm);
        mutex_lock(&kvm_lock);
+       kvm_destroy_vm_debugfs(kvm);
        list_del(&kvm->vm_list);
        mutex_unlock(&kvm_lock);
        kvm_arch_pre_destroy_vm(kvm);
@@ -3084,9 +3084,9 @@ static int kvm_vm_ioctl_create_vcpu(struct kvm *kvm, u32 id)
        smp_wmb();
        atomic_inc(&kvm->online_vcpus);
 
+       kvm_create_vcpu_debugfs(vcpu);
        mutex_unlock(&kvm->lock);
        kvm_arch_vcpu_postcreate(vcpu);
-       kvm_create_vcpu_debugfs(vcpu);
        return r;
 
 unlock_vcpu_destroy:

should probably do. The reproducer doesn't work for me (or just takes
too long so I gave up), unfortunately. Or I may have misunderstood
everything :-)

-- 
Vitaly

