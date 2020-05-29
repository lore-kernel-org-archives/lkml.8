Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B41C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 13:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 995932100A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 13:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgE2N1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 09:27:03 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:63047 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbgE2N06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 09:26:58 -0400
Received: from fsav402.sakura.ne.jp (fsav402.sakura.ne.jp [133.242.250.101])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 04TDQuDh004920;
        Fri, 29 May 2020 22:26:56 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav402.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav402.sakura.ne.jp);
 Fri, 29 May 2020 22:26:56 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav402.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 04TDQoUw004862
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Fri, 29 May 2020 22:26:55 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v2] twist: allow converting pr_devel()/pr_debug() into
 snprintf()
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Dmitry Vyukov <dvyukov@google.com>,
        syzkaller <syzkaller@googlegroups.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
References: <e3b30905-4497-29b4-4636-a313283dbc56@i-love.sakura.ne.jp>
 <20200528065603.3596-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20200528110646.GC11286@linux-b0ei>
 <e0d6c04f-7601-51e7-c969-300e938dedc0@i-love.sakura.ne.jp>
 <CAHk-=wgz=7MGxxX-tmMmdCsKyYJkuyxNc-4uLP=e_eEV=OzUaw@mail.gmail.com>
 <CAHk-=wjW+_pjJzVRMuCbLhbWLkvEQVYJoXVBYGNW2PUgtX1fDw@mail.gmail.com>
 <13b0a475-e70e-c490-d34d-0c7a34facf7c@i-love.sakura.ne.jp>
 <CAHk-=wjj9ooYACNvO2P_Gr_=aN0g=iEqtg0TwBJo18wbn4gthg@mail.gmail.com>
 <6116ed2e-cee1-d82f-6b68-ddb1bbb6abe2@i-love.sakura.ne.jp>
 <CAHk-=wiVQUo_RJAaivHU5MFdznNOX4GKgJH1xrFc83e9oLnuvQ@mail.gmail.com>
 <19d377d3-8037-8090-0f99-447f72cc1d8c@i-love.sakura.ne.jp>
Message-ID: <38df9737-3c04-dca2-0df4-115a9c1634e5@i-love.sakura.ne.jp>
Date:   Fri, 29 May 2020 22:26:48 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <19d377d3-8037-8090-0f99-447f72cc1d8c@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Dmitry.

Linus is asking me to avoid build-time switching based on kernel config options,
and is suggesting me to use boot-time switching based on boot-config file feature
(which is available since 5.6). I have several concerns about use of boot-config file
feature in syzkaller.

(1) To use boot-config file, syzkaller will need to add "bootconfig" option
    to the kernel command line. This will be doable by patching
    https://github.com/google/syzkaller/tree/master/dashboard/config/ *.cmdline
    files.

(2) The boot-config file is embedded into initramfs file. Since syzkaller builds
    kernels with almost-allyesconfig, booting syzkaller kernels do not require
    initramfs for loading kernel modules needed for mounting the root partition.
    In fact, according to "unexpected kernel reboot" report which contains boot messages,
    I can't find "Unpacking initramfs..." message. It seems that syzkaller kernels do not
    use initramfs file.

    Is it possible for syzkaller to enforce performing steps for creating an initramfs,
    embedding the boot-config file
    ( https://www.kernel.org/doc/html/latest/admin-guide/bootconfig.html#boot-kernel-with-a-boot-config),
    and loading that initramfs whenever booting the syzkaller kernels?
    By the way, I do worry that people forget to perform these steps when they do
    their tests without asking syzbot...

(3) Since syzkaller keeps track of "kernel tree", "commit of the kernel tree", and
    "commit of the syzkaller tree" in order to guarantee reproducibility, it would be
    possible to identify the "your-config" file used for tools/bootconfig/bootconfig
    command. But since "#syz test" command currently accepts only "kernel tree" and
    "commit of the kernel tree" arguments, we might fail to use intended "your-config"
    file when doing reproducibility test. Can syzbot solve this concern?

(4) Of course, "your-config" file would not change so frequently, but "#syz test" command
    relies on external file in "syzkaller tree" makes it impossible to try different
    configuration when I have to ask syzbot to test. (Since I don't have hardware which
    syzbot is reporting problems, I have to ask syzbot when I can't reproduce the problem
    in my environment.)

    https://syzkaller.appspot.com/text?tag=Patch&x=135f254a100000 is an example of
    need to enforce CONFIG_DEBUG_INFO_BTF=n in order to workaround build failure during
    "#syz test" command. If we bring "which twist options should be enabled" to an external
    boot-config file, I can't ask syzbot to try different twist options (except directly
    patching the kernel source which handles "which twist options should be enabled").
    Can syzbot solve this concern?

(5) Anything else?

