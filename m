Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D435CC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 11:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF30D2177B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 11:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728973AbgH0L7z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 07:59:55 -0400
Received: from mail-qk1-f197.google.com ([209.85.222.197]:35538 "EHLO
        mail-qk1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728473AbgH0Lnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 07:43:37 -0400
Received: by mail-qk1-f197.google.com with SMTP id n128so4540022qke.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 04:43:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=pwNkg447Nvt9DP6BHMmIFvIl++UIZS1Yr2SQgfIT/uI=;
        b=MPrHf+4oSHZRkIwO/PZXbkxj2Fg9sIpm1k8k6v5/dP/atND7KJfa3EpnYelGrjKs+L
         A32y08Pfpoh3f2hruZi9tcFeX2Nxv6fkKbiLYofWuf/FK2wF5taMKyKywqrXRF3wwEpM
         b5UeWRfGyRR7fOpjyOma8K1W+Jts2aApaK8lkSgWvAA5XhWDZ2FJ2gkXzfRE9xERDIGK
         JH/UEQzJP9GQtus0vetQc4Drp0yGM30D/OteC2A128zwOh3DLk9eZqdp+dLQG7fE8e/y
         PpDZrjf+NPiTKfcjSDA77nZroRyH16uaHUcbZ5RYxyRyWP18+hSiZgxMV796q/E24sdm
         8llA==
X-Gm-Message-State: AOAM533QlZAMuZ7Z5zwRSKTxzxeydkD5ZYB64HQ9ZjIiWogcxINe/sLK
        xyOAc8nk/bDncd5ZLM4d2hkn4Vd+v1tB02+d2TH3GqdExk02
X-Google-Smtp-Source: ABdhPJxDRrpZipHuFzQ757CmsZAIU/5jJofSaXf8x7xPsEtScojRDRY1s41xcjRSEzQrCEIS6tw+8a9moYMqcFRKFDnWyN4YaXIz
MIME-Version: 1.0
X-Received: by 2002:a02:234c:: with SMTP id u73mr19132402jau.141.1598526846052;
 Thu, 27 Aug 2020 04:14:06 -0700 (PDT)
Date:   Thu, 27 Aug 2020 04:14:06 -0700
In-Reply-To: <00000000000068340d05add74c29@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d2adea05adda0870@google.com>
Subject: Re: WARNING: ODEBUG bug in get_signal
From:   syzbot <syzbot+e3cf8f93cf86936710db@syzkaller.appspotmail.com>
To:     alsa-devel@alsa-project.org, arnd@arndb.de, axboe@kernel.dk,
        baolin.wang@linaro.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org, oleg@redhat.com,
        perex@perex.cz, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tiwai@suse.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit a9ed4a6560b8562b7e2e2bed9527e88001f7b682
Author: Marc Zyngier <maz@kernel.org>
Date:   Wed Aug 19 16:12:17 2020 +0000

    epoll: Keep a reference on files added to the check list

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15e57751900000
start commit:   15bc20c6 Merge tag 'tty-5.9-rc3' of git://git.kernel.org/p..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17e57751900000
console output: https://syzkaller.appspot.com/x/log.txt?x=13e57751900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=978db74cb30aa994
dashboard link: https://syzkaller.appspot.com/bug?extid=e3cf8f93cf86936710db
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13236eb6900000

Reported-by: syzbot+e3cf8f93cf86936710db@syzkaller.appspotmail.com
Fixes: a9ed4a6560b8 ("epoll: Keep a reference on files added to the check list")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
