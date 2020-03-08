Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACDB8C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 18:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 823CD20674
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 18:35:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SYptd35N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgCHSf4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 14:35:56 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40873 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbgCHSfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 14:35:55 -0400
Received: by mail-ot1-f66.google.com with SMTP id x19so7431467otp.7
        for <linux-kernel@vger.kernel.org>; Sun, 08 Mar 2020 11:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cJflWBrLx7na3SB0sRLa6FQD1A/CiH/RljhwX0BHmww=;
        b=SYptd35NMAVG2pCRDcSBUXjNsnO4l4sjlgyCl6qL+xa6+Ud1/UJW0X7+I0V3VHkBVk
         ucvxXNmu4PWuK37QGwgRBBPOG1vkfivGOHCXd1Kh83FuL/bkAG2PnLCuDbK20oLS6da5
         eoxxMnC1DR58CdTUXqnx74sxYCOkW9JJ4vu7r6C6hkUr17XgunNKBPqlSDs0E3qWZcsM
         NeXD/2Eta2k16e4Lwqg0h1cX/vLuy6oi3/5qSrp2RrdoITIgMCUjafU0xMkCsXX72PDQ
         +8EKI+YfrdXEDoijH8W62+bk0vktZrwy/8eiPS6xnKEodU6/fcGS3BJlesbQZtO79CpP
         yC+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cJflWBrLx7na3SB0sRLa6FQD1A/CiH/RljhwX0BHmww=;
        b=JOSds9Bv2EDgJ+PPaay0jYu00t1VMjieC7RcZxhLXKTyMePYehaWFXpPDK2X+pzezc
         B0UHIR8dl5wMesmRJUZ4HR1N66nRqeKb915KWQAKpYrzkoKVYsL7Hp+ddKNOApg/YQXd
         +CHyoOdMM902yEcunqpueM7769GnOvVCwkfpNxsaZC9oWMpDvsabu5PFdcHMrNg7kAAt
         E8QmG+TybZVyOpKuAIyr8sJzJw60Nqp1cs4pjhPggDS9tpV5Z1/l4S+1DkvgjqGt29rX
         0orOyZCBsdx3/rsvyUz9SaOMnTswgwURkj1ZTT6TmzsHUw1nfU+04qoaTGrti3H3MTiD
         vjQw==
X-Gm-Message-State: ANhLgQ0hU9HLzp99erhci7kgsFzywsSdU5Zx7iVkhz5c4OcSynHpHpUN
        TnC4DvHMCeR27M65U7EWIPEzh+u5oBJKmfmkKSD7Ax0C2i8=
X-Google-Smtp-Source: ADFU+vsVxyqNOhCVsKe4pEp0X5iz5sQ84jBS28Y0e4PZL7wjBYIywDItJNL93dJDzq8NAw+tVDK7hV118JgOsLIwL8I=
X-Received: by 2002:a05:6830:1d6e:: with SMTP id l14mr10225806oti.32.1583692554087;
 Sun, 08 Mar 2020 11:35:54 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000ff323f05a053100c@google.com>
In-Reply-To: <000000000000ff323f05a053100c@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Sun, 8 Mar 2020 19:35:27 +0100
Message-ID: <CAG48ez02bt7V4+n68MNK3bmHpXxDnNmLZn8LpZ8r2w63ZhrkiQ@mail.gmail.com>
Subject: Re: general protection fault in syscall_return_slowpath
To:     syzbot <syzbot+cd66e43794b178bb5cd6@syzkaller.appspotmail.com>
Cc:     Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: multipart/mixed; boundary="0000000000001f316f05a05c2893"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000001f316f05a05c2893
Content-Type: text/plain; charset="UTF-8"

On Sun, Mar 8, 2020 at 5:40 PM syzbot
<syzbot+cd66e43794b178bb5cd6@syzkaller.appspotmail.com> wrote:
> HEAD commit:    63623fd4 Merge tag 'for-linus' of git://git.kernel.org/pub..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=16cfeac3e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5d2e033af114153f
> dashboard link: https://syzkaller.appspot.com/bug?extid=cd66e43794b178bb5cd6
> compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12a42329e00000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+cd66e43794b178bb5cd6@syzkaller.appspotmail.com
>
> general protection fault, probably for non-canonical address 0x1ffffffff1255a6b: 0000 [#1] PREEMPT SMP KASAN
> CPU: 0 PID: 8742 Comm: syz-executor.2 Not tainted 5.6.0-rc3-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:arch_local_irq_disable arch/x86/include/asm/paravirt.h:757 [inline]
> RIP: 0010:syscall_return_slowpath+0xeb/0x4a0 arch/x86/entry/common.c:277
> Code: 00 10 0f 85 de 00 00 00 e8 b2 a3 76 00 48 c7 c0 58 d3 2a 89 48 c1 e8 03 80 3c 18 00 74 0c 48 c7 c7 58 d3 2a 89 e8 05 00 00 00 <00> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> RSP: 0018:ffffc900020a7ed0 EFLAGS: 00010246
> RAX: 1ffffffff1255a6b RBX: dffffc0000000000 RCX: ffff88808c512380
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: ffffc900020a7f10 R08: ffffffff810075bb R09: fffffbfff14d9182
> R10: fffffbfff14d9182 R11: 0000000000000000 R12: 1ffff110118a2470
> R13: 0000000000004000 R14: ffff88808c512380 R15: ffff88808c512380
> FS:  000000000154f940(0000) GS:ffff8880aea00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000000076c000 CR3: 00000000a6b05000 CR4: 00000000001406f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  do_syscall_64+0x11f/0x1c0 arch/x86/entry/common.c:304
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> BUG: kernel NULL pointer dereference, address: 0000000000000000
> #PF: supervisor write access in kernel mode
> #PF: error_code(0x0002) - not-present page
> PGD 8fecc067 P4D 8fecc067 PUD 97953067 PMD 0
> Oops: 0002 [#2] PREEMPT SMP KASAN
> CPU: 0 PID: 8742 Comm: syz-executor.2 Not tainted 5.6.0-rc3-syzkaller #0

Ugh, why does it build with -Werror...

#syz test: https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux.git
63623fd44972d1ed2bfb6e0fb631dfcf547fd1e7

--0000000000001f316f05a05c2893
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="v2-0001-FOR-TESTING-ONLY-tell-us-which-fbcon-implementati.patch"
Content-Disposition: attachment; 
	filename="v2-0001-FOR-TESTING-ONLY-tell-us-which-fbcon-implementati.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_k7jdn0o40>
X-Attachment-Id: f_k7jdn0o40

RnJvbSA4NDQyMTQ0ZmU1ODJhYjM4OTg1Mzc4Y2YyMWNhODhkZTE1OTRiNWRmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKYW5uIEhvcm4gPGphbm5oQGdvb2dsZS5jb20+CkRhdGU6IFN1
biwgOCBNYXIgMjAyMCAxODoxNToxMSArMDEwMApTdWJqZWN0OiBbUEFUQ0ggdjJdIEZPUiBURVNU
SU5HIE9OTFk6IHRlbGwgdXMgd2hpY2ggZmJjb24gaW1wbGVtZW50YXRpb24gaXMKIHVzZWQKCi0t
LQogZHJpdmVycy90dHkvdnQvdnQuYyB8IDEwICsrKysrKysrLS0KIDEgZmlsZSBjaGFuZ2VkLCA4
IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy90dHkv
dnQvdnQuYyBiL2RyaXZlcnMvdHR5L3Z0L3Z0LmMKaW5kZXggMGNmYmI3MTgyYjVhLi5iM2RkNDQ4
MDIyMDggMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdHR5L3Z0L3Z0LmMKKysrIGIvZHJpdmVycy90dHkv
dnQvdnQuYwpAQCAtNDU5MCw3ICs0NTkwLDcgQEAgc3RhdGljIGludCBjb25fZm9udF9jb3B5KHN0
cnVjdCB2Y19kYXRhICp2Yywgc3RydWN0IGNvbnNvbGVfZm9udF9vcCAqb3ApCiB7CiAJaW50IGNv
biA9IG9wLT5oZWlnaHQ7CiAJaW50IHJjOwotCisJc3RhdGljIHZvaWQgKkxBU1Q7CiAKIAljb25z
b2xlX2xvY2soKTsKIAlpZiAodmMtPnZjX21vZGUgIT0gS0RfVEVYVCkKQEAgLTQ2MDEsOCArNDYw
MSwxNCBAQCBzdGF0aWMgaW50IGNvbl9mb250X2NvcHkoc3RydWN0IHZjX2RhdGEgKnZjLCBzdHJ1
Y3QgY29uc29sZV9mb250X29wICpvcCkKIAkJcmMgPSAtRU5PVFRZOwogCWVsc2UgaWYgKGNvbiA9
PSB2Yy0+dmNfbnVtKQkvKiBub3RoaW5nIHRvIGRvICovCiAJCXJjID0gMDsKLQllbHNlCisJZWxz
ZSB7CisJCWlmIChMQVNUICE9IHZjLT52Y19zdykgeworCQkJcHJfd2FybigiY29uX2ZvbnRfY29w
eSgpOiB2Y19zdz0lcFMsIHZjX3N3LT5jb25fZm9udF9jb3B5PSVwU1xuIiwKKwkJCQl2Yy0+dmNf
c3csIHZjLT52Y19zdy0+Y29uX2ZvbnRfY29weSk7CisJCQlMQVNUID0gdmMtPnZjX3N3OworCQl9
CiAJCXJjID0gdmMtPnZjX3N3LT5jb25fZm9udF9jb3B5KHZjLCBjb24pOworCX0KIAljb25zb2xl
X3VubG9jaygpOwogCXJldHVybiByYzsKIH0KCmJhc2UtY29tbWl0OiA2MzYyM2ZkNDQ5NzJkMWVk
MmJmYjZlMGZiNjMxZGZjZjU0N2ZkMWU3Ci0tIAoyLjI1LjEuNDgxLmdmYmNlMGViODAxLWdvb2cK
Cg==
--0000000000001f316f05a05c2893--
