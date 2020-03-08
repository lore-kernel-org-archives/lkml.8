Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A56C10F28
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 07:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B77D2072A
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 07:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgCHHeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 03:34:05 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:35638 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbgCHHeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 03:34:04 -0400
Received: by mail-il1-f198.google.com with SMTP id h18so5131462ilc.2
        for <linux-kernel@vger.kernel.org>; Sat, 07 Mar 2020 23:34:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Nrw2cp0bbSpLGRZ4GUAh0C3PbsjeyFM4BB9cqeU1ILc=;
        b=CcZJgQYPrnMH4AVTw1AMTkbCc8Q/Z0kwUDulPbKL/aVkKaGRaxTTqfCXYgAdW086cl
         HsgDh5wPGt8jwcyzFDExsk7sGSwbnHIoENVotbJ3qTSIrUCsvCBvDcv76wXiiAsfO4l5
         FeDiunm8IsDo7h8cUreA1UFIZLPy5M2+SzXTOfDpjzkLw44TolvD+aEcAMyXgxh7X8zK
         Zq9Kif9Ep0TwuQDpWTMOLkDJ3GN4Mek2xghKrJr8gCQc1mzgaS1VvySECOZL93xPkDna
         msNpMg/OO/Nm75uCAcDSClkUAXtL0EonZ2ax2oDs3hosdcgFSnTHogKlElZeuZx0P/aw
         jbAQ==
X-Gm-Message-State: ANhLgQ3LT/D0/jNdFWhvSPeL1Xhx/52jEpgZo+GP26V1gC4jetd0oAUB
        RBedF1eSADUg0D/HMV4BhIY0N4sdeU6VVENk9CgeSp0B/QZ2
X-Google-Smtp-Source: ADFU+vti+qKcPR/q+EH0OJg+DCaWyVsiPWSqvPGeLcShP48CU2z8PGEImsHyNDvy0tIir0jwu8FqLHXIPVcaj2uJUaolzgshL6fp
MIME-Version: 1.0
X-Received: by 2002:a5d:9c93:: with SMTP id p19mr8956311iop.81.1583652842882;
 Sat, 07 Mar 2020 23:34:02 -0800 (PST)
Date:   Sat, 07 Mar 2020 23:34:02 -0800
In-Reply-To: <000000000000b25ea005a02bcf21@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000025d0e305a052e97f@google.com>
Subject: Re: KASAN: slab-out-of-bounds Read in resample_shrink
From:   syzbot <syzbot+e1fe9f44fb8ecf4fb5dd@syzkaller.appspotmail.com>
To:     alsa-devel-owner@alsa-project.org, alsa-devel@alsa-project.org,
        gustavo@embeddedor.com, linux-kernel@vger.kernel.org,
        perex@perex.cz, syzkaller-bugs@googlegroups.com, tiwai@suse.com,
        tiwai@suse.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit ca0214ee2802dd47239a4e39fb21c5b00ef61b22
Author: Takashi Iwai <tiwai@suse.de>
Date:   Fri Mar 22 15:00:54 2019 +0000

    ALSA: pcm: Fix possible OOB access in PCM oss plugins

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=101931fde00000
start commit:   63623fd4 Merge tag 'for-linus' of git://git.kernel.org/pub..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=121931fde00000
console output: https://syzkaller.appspot.com/x/log.txt?x=141931fde00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5d2e033af114153f
dashboard link: https://syzkaller.appspot.com/bug?extid=e1fe9f44fb8ecf4fb5dd
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=160e2e91e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=125f09fde00000

Reported-by: syzbot+e1fe9f44fb8ecf4fb5dd@syzkaller.appspotmail.com
Fixes: ca0214ee2802 ("ALSA: pcm: Fix possible OOB access in PCM oss plugins")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
