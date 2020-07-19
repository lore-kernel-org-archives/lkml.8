Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B79CC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 15:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07CCA22B4E
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 15:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595171594;
	bh=TlXTSAsSOac8Qtiptyjyh5/Vm+YFyJhPk0Qrt97Ikf4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=lwN/AgTcX8lgkNuhXYzr0YMuP8QrMaExJAFOoTqQUg385QIM2n0442zEQzU18qBPq
	 g+tn/8Mey+IQD/PpO3ixGhKKbAx/psJkyKdjX87iJi2FsBuE6Jc58gCaAiA22nPihq
	 Cogb5j6MYKe4TwUKmv591duDx4rQW3brtJOWsptA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbgGSPM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 11:12:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:53136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbgGSPM7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 11:12:59 -0400
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7517E22BEF
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 15:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595171578;
        bh=TlXTSAsSOac8Qtiptyjyh5/Vm+YFyJhPk0Qrt97Ikf4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cYLErWbIB9SWIWZf/b/i10t54A4cXxsR9IPnWDQ9B6koCU//6tH1ygGScYq5UY7m5
         ZrmhpH0dCqT8uEpeQlfXEvwwu6idH9F/Nh8BXxQRiqepDRtCAYwU+WY7zTKPRnX1SQ
         8ww5BjC44E2h6jeKZ/FCUed9HmvBcIKS+6BQk0e8=
Received: by mail-wm1-f48.google.com with SMTP id 22so19968457wmg.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 08:12:58 -0700 (PDT)
X-Gm-Message-State: AOAM532eMW3GWfaa9N2r9lajTcxvsjwu/CT/Tb2hdUYaW/HkEn5SdMz/
        6wI/9DjlCeko0NMjr8h3yQPGyxgRDtMnUZBYFaHbvA==
X-Google-Smtp-Source: ABdhPJy3sP1MKHyJa8dHCmnkj1CZ7ULf6bUubt98uthTUuEgQoBUMN2KuV52xPp/kfGPODxApq1EKeXT3K5gbycS/as=
X-Received: by 2002:a7b:c92e:: with SMTP id h14mr17167909wml.36.1595171576997;
 Sun, 19 Jul 2020 08:12:56 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000bd4f7305aac6870d@google.com>
In-Reply-To: <000000000000bd4f7305aac6870d@google.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 19 Jul 2020 08:12:45 -0700
X-Gmail-Original-Message-ID: <CALCETrXreVrWEsBBYX8KS=-DFW=5RB7SAKcgcdPtzJtML6n7UQ@mail.gmail.com>
Message-ID: <CALCETrXreVrWEsBBYX8KS=-DFW=5RB7SAKcgcdPtzJtML6n7UQ@mail.gmail.com>
Subject: Re: WARNING in do_syscall_64
To:     syzbot <syzbot+29454675f5fe94137999@syzkaller.appspotmail.com>
Cc:     Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        syzkaller-bugs@googlegroups.com,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 19, 2020 at 12:42 AM syzbot
<syzbot+29454675f5fe94137999@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    e9919e11 Merge branch 'for-linus' of git://git.kernel.org/..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=11dca4cf100000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e944500a36bc4d55
> dashboard link: https://syzkaller.appspot.com/bug?extid=29454675f5fe94137999
> compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
>
> Unfortunately, I don't have any reproducer for this issue yet.

On a brief inspection, the only way I can see this happening is if the
syscall flags msr got corrupted.  There's not much code between the
actual hardware entry and this warning.

--Andy
