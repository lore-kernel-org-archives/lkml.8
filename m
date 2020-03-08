Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE33C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 17:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9464220828
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 17:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RO5mJqse"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgCHRVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 13:21:09 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45694 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbgCHRVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 13:21:09 -0400
Received: by mail-ot1-f67.google.com with SMTP id f21so7273600otp.12
        for <linux-kernel@vger.kernel.org>; Sun, 08 Mar 2020 10:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PtEA2mm9l96k+awFlKZr4TJ6AG/v1NHyD+CFP5x3VFo=;
        b=RO5mJqseeWny+mX27K2lObhmY6I9DyzMDNKtt5MNZhWmD7Zb2rB6mqSS0zdoWAY+/H
         0mMp5KoxajOn1PqQxzaKCRpYT3JM/bgzhvyGg2PbYEqPFfBYIBWmBzTrTwj5rjoMVCnY
         /5rgQVAYTyE5zFpliUAACSusk4VqRQ3qW521OgyD8QtUvVUUdPBkcngTAHCNQmUxHEtG
         UT8OYUmsaBcZdufjl0ASi5XOCy9PtAS4gQ7IdJn3T7enLeJFA26vpwVOk0q7uPtxrL/Z
         ESPszquBVoN5feDMYDraRkd5DdhasbUp35lz4gJb4t203Hn/GHjax8/2GUcCghLtwntQ
         LSoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PtEA2mm9l96k+awFlKZr4TJ6AG/v1NHyD+CFP5x3VFo=;
        b=WwhI9jflhGJ9e52cxUe0m3kUIV6K0ZW3eUKptFsWYDgHlV7mFceqUhPLJXGD+lxFWU
         I2vWlvYf3vZWgm7bbTcEa+CwbPwchhcSOT+/upGgUgoKhsisBnaPRXt5pYMJ2CBFfUJf
         4hMnJgX/t79YzAhU2/oF7wl1qdpo2s2CiBS7xDAxuj/z1pjy/71O2M0UyXfqmdN5/SVZ
         ae25CZUDOG4tLsN01eMnfcqmCYS5k5bLBuIsG6vYP1qf+fD/QvBP5DteqWYmgj5pwXEH
         rLRypc6W/UAaE2EYS+kdPk00nDxBJOoHhpgZeaLgfvHYu9Iwt1vaTkOOjcAbqshXDQoI
         MeRA==
X-Gm-Message-State: ANhLgQ0kf1Q+Slf1Lddxt128ze0BjWeMYjSFfsuX0gcdu0WJlatIay28
        oteBcnyhG0z8xVulEqzPko6hL7Xyp/xKfEdNjvaLmg==
X-Google-Smtp-Source: ADFU+vtF5TJlIqrVcenBMU6JyY5M1kfMbKiy8HlmWV4Ir0C0GIPoIDpylFMIwcKl0vlvlXiADHlQtx1402OgMdb55cE=
X-Received: by 2002:a05:6830:1d6e:: with SMTP id l14mr10073990oti.32.1583688067980;
 Sun, 08 Mar 2020 10:21:07 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000ff323f05a053100c@google.com>
In-Reply-To: <000000000000ff323f05a053100c@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Sun, 8 Mar 2020 18:20:41 +0100
Message-ID: <CAG48ez2TnPppWonr8K3POyg3hGosgNXU2-ZMjyaYN4tLYRiJiQ@mail.gmail.com>
Subject: Re: general protection fault in syscall_return_slowpath
To:     syzbot <syzbot+cd66e43794b178bb5cd6@syzkaller.appspotmail.com>
Cc:     Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: multipart/mixed; boundary="000000000000ba975805a05b1c90"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000ba975805a05b1c90
Content-Type: text/plain; charset="UTF-8"

On Sun, Mar 8, 2020 at 5:40 PM syzbot
<syzbot+cd66e43794b178bb5cd6@syzkaller.appspotmail.com> wrote:
> syzbot found the following crash on:
>
> HEAD commit:    63623fd4 Merge tag 'for-linus' of git://git.kernel.org/pub..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=16cfeac3e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5d2e033af114153f
> dashboard link: https://syzkaller.appspot.com/bug?extid=cd66e43794b178bb5cd6
> compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12a42329e00000
[...]
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

Let's see if we can get syzkaller to tell us which fbcon
implementation it's hitting...

#syz test: https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux.git
63623fd44972d1ed2bfb6e0fb631dfcf547fd1e7

--000000000000ba975805a05b1c90
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-FOR-TESTING-ONLY-tell-us-which-fbcon-implementation-.patch"
Content-Disposition: attachment; 
	filename="0001-FOR-TESTING-ONLY-tell-us-which-fbcon-implementation-.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_k7jayolu0>
X-Attachment-Id: f_k7jayolu0

RnJvbSA4NDQyMTQ0ZmU1ODJhYjM4OTg1Mzc4Y2YyMWNhODhkZTE1OTRiNWRmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKYW5uIEhvcm4gPGphbm5oQGdvb2dsZS5jb20+CkRhdGU6IFN1
biwgOCBNYXIgMjAyMCAxODoxNToxMSArMDEwMApTdWJqZWN0OiBbUEFUQ0hdIEZPUiBURVNUSU5H
IE9OTFk6IHRlbGwgdXMgd2hpY2ggZmJjb24gaW1wbGVtZW50YXRpb24gaXMgdXNlZAoKLS0tCiBk
cml2ZXJzL3R0eS92dC92dC5jIHwgMTAgKysrKysrKystLQogMSBmaWxlIGNoYW5nZWQsIDggaW5z
ZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3R0eS92dC92
dC5jIGIvZHJpdmVycy90dHkvdnQvdnQuYwppbmRleCAwY2ZiYjcxODJiNWEuLmIzZGQ0NDgwMjIw
OCAxMDA2NDQKLS0tIGEvZHJpdmVycy90dHkvdnQvdnQuYworKysgYi9kcml2ZXJzL3R0eS92dC92
dC5jCkBAIC00NTkwLDcgKzQ1OTAsNyBAQCBzdGF0aWMgaW50IGNvbl9mb250X2NvcHkoc3RydWN0
IHZjX2RhdGEgKnZjLCBzdHJ1Y3QgY29uc29sZV9mb250X29wICpvcCkKIHsKIAlpbnQgY29uID0g
b3AtPmhlaWdodDsKIAlpbnQgcmM7Ci0KKwlzdGF0aWMgdm9pZCAqTEFTVDsKIAogCWNvbnNvbGVf
bG9jaygpOwogCWlmICh2Yy0+dmNfbW9kZSAhPSBLRF9URVhUKQpAQCAtNDYwMSw4ICs0NjAxLDE0
IEBAIHN0YXRpYyBpbnQgY29uX2ZvbnRfY29weShzdHJ1Y3QgdmNfZGF0YSAqdmMsIHN0cnVjdCBj
b25zb2xlX2ZvbnRfb3AgKm9wKQogCQlyYyA9IC1FTk9UVFk7CiAJZWxzZSBpZiAoY29uID09IHZj
LT52Y19udW0pCS8qIG5vdGhpbmcgdG8gZG8gKi8KIAkJcmMgPSAwOwotCWVsc2UKKwllbHNlIHsK
KwkJaWYgKExBU1QgIT0gdmMtPnZjX3N3KSB7CisJCQlwcl93YXJuKCJjb25fZm9udF9jb3B5KCk6
IHZjX3N3PSVwUywgdmNfc3ctPmNvbl9mb250X2NvcHk9JXBTXG4iLAorCQkJCXZjLT52Y19zdywg
dmMtPnZjX3N3LT5jb25fZm9udF9jb3B5KTsKKwkJCUxBU1QgPSB2Yy0+dmNfc3c7CisJCX0KIAkJ
cmMgPSB2Yy0+dmNfc3ctPmNvbl9mb250X2NvcHkodmMsIGNvbik7CisJfQogCWNvbnNvbGVfdW5s
b2NrKCk7CiAJcmV0dXJuIHJjOwogfQoKYmFzZS1jb21taXQ6IDYzNjIzZmQ0NDk3MmQxZWQyYmZi
NmUwZmI2MzFkZmNmNTQ3ZmQxZTcKLS0gCjIuMjUuMS40ODEuZ2ZiY2UwZWI4MDEtZ29vZwoK
--000000000000ba975805a05b1c90--
