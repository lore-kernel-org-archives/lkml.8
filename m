Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05509C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 09:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBEDB20716
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 09:37:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgFVJhN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 05:37:13 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:43414 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbgFVJhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 05:37:12 -0400
Received: by mail-il1-f198.google.com with SMTP id y13so1518370ila.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 02:37:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=NCIhNzemyaHeV1URQe9l6ctBEp+a/h06zCpmFD6sWu8=;
        b=NxY+9OjL8XFAGxsMfLvAAci1bLu7fUjcUToRd9pApCmBi1c9YwAVsPFgJppoO1WNh2
         km4pvsvyzpoUQ+45t/pU7W/GoeJnKetek/H4veWcqAVX75wzlbiUUCt3dA5atRZChUgH
         4txLSimE5qEsNC1iWVbfFDhnKL1ciw6vY9e+8Du99TC18wC1Jj0551eUaCxPSKF+X2Ma
         FhVJ51zioQ0pyg5Qcv53DDuuhZvdmOci7nDrEGVwdjTOg1aqv9k30sV9+VEcB5YTOf7L
         Ns9X0KgPhXcRWuVFrKEK7OcgPG9m+ZvFX/nEo70Qr8rAtXfvOWpyAWGdC7FxJODid87Y
         Vrjg==
X-Gm-Message-State: AOAM532uTpJ9LtjqdJ3xurDErIz7Mf4bb056q4JY5LVt2HsgNFWyaaHO
        RlDMA5P6VzbTTsPuWFBQsl3l8tEuc/ZrhJI/DlWn/bogDcMJ
X-Google-Smtp-Source: ABdhPJya4TlXHk3sbbO0u6TW75Uj7uiXd6K8Q9hxTZjJt3xKDqXjWbWh/cInD1e9U3Z1gyM+ARL1XjZlxcsBVU2ArxN+/EdJ27gE
MIME-Version: 1.0
X-Received: by 2002:a92:d3cd:: with SMTP id c13mr16652193ilh.101.1592818632119;
 Mon, 22 Jun 2020 02:37:12 -0700 (PDT)
Date:   Mon, 22 Jun 2020 02:37:12 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c25ce105a8a8fcd9@google.com>
Subject: linux-next build error (9)
From:   syzbot <syzbot+dbf8cf3717c8ef4a90a0@syzkaller.appspotmail.com>
To:     bp@alien8.de, hpa@zytor.com, jmattson@google.com, joro@8bytes.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org, mingo@redhat.com, pbonzini@redhat.com,
        sean.j.christopherson@intel.com, sfr@canb.auug.org.au,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        vkuznets@redhat.com, wanpengli@tencent.com, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    27f11fea Add linux-next specific files for 20200622
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=138dc743100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=41c659db5cada6f4
dashboard link: https://syzkaller.appspot.com/bug?extid=dbf8cf3717c8ef4a90a0
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+dbf8cf3717c8ef4a90a0@syzkaller.appspotmail.com

./arch/x86/include/asm/kvm_para.h:99:29: error: inlining failed in call to always_inline 'kvm_handle_async_pf': function attribute mismatch
./arch/x86/include/asm/processor.h:824:29: error: inlining failed in call to always_inline 'prefetchw': function attribute mismatch
./arch/x86/include/asm/current.h:13:44: error: inlining failed in call to always_inline 'get_current': function attribute mismatch
arch/x86/mm/fault.c:1353:1: error: inlining failed in call to always_inline 'handle_page_fault': function attribute mismatch
./arch/x86/include/asm/processor.h:576:29: error: inlining failed in call to always_inline 'native_swapgs': function attribute mismatch
./arch/x86/include/asm/fsgsbase.h:33:38: error: inlining failed in call to always_inline 'rdgsbase': function attribute mismatch
./arch/x86/include/asm/irq_stack.h:40:29: error: inlining failed in call to always_inline 'run_on_irqstack_cond': function attribute mismatch
./include/linux/debug_locks.h:15:28: error: inlining failed in call to always_inline '__debug_locks_off': function attribute mismatch
./include/asm-generic/atomic-instrumented.h:70:1: error: inlining failed in call to always_inline 'atomic_add_return': function attribute mismatch
kernel/locking/lockdep.c:396:29: error: inlining failed in call to always_inline 'lockdep_recursion_finish': function attribute mismatch
kernel/locking/lockdep.c:4725:5: error: inlining failed in call to always_inline '__lock_is_held': function attribute mismatch

---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
