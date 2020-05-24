Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A66C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 06:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5722620812
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 06:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbgEXGDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 02:03:04 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:47068 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbgEXGDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 02:03:04 -0400
Received: by mail-il1-f199.google.com with SMTP id x2so1075556ill.13
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 23:03:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=f8cm7i+6DZaPSRKesHef9xX2E7QNOPynTMGv2aqlP84=;
        b=PtqG8tn/FO+vBeP796Wt/AFV0OEdNh1sfciSSd7hzCBtj1AiQlA4HfKDWI6x+rNnkI
         1KWGBgJtPBCMPgvl8eEss6VIjK0l1/XcOuMkSJWUCf6qWhtRmKgCP4c6SpIOCu2d0ywA
         TCfY+PCRa9rZ6yGypXbNrQnnMl6EgSCS1a8xfcM0OhwDI7a5ZMcZyQ75Wk4+DipFyYLh
         YQHDwhxcCRH6yQGCyrbo+hbq/uynViYJpwPKlQzAovQBjvI118Oejz+iIZzhGtjPb88/
         4upklYXrKJmJH5d0WtdWMNV+ldadnU9y0NAy7SFbPtbptX+2vTQMALWGIjS1QdCHuss0
         qPtw==
X-Gm-Message-State: AOAM5326BobOJuKCjJb2LjWsFflwAqjkf4HFGLvwxpF9omGT8ztLn9in
        kjojXatEchRrNutRtYi3/V0WPTLu0llfHBk73Jkrtdv8eCxe
X-Google-Smtp-Source: ABdhPJwGqcUvFi9kw0HhVexHTCTsxhtssXwOhzWwTlRVW0bo6dxr+flQYWuUIA+M7jdwFMz5UWSgckDGMnoq58SrEydxAK0FWUZP
MIME-Version: 1.0
X-Received: by 2002:a92:914f:: with SMTP id t76mr20627206ild.238.1590300183500;
 Sat, 23 May 2020 23:03:03 -0700 (PDT)
Date:   Sat, 23 May 2020 23:03:03 -0700
In-Reply-To: <000000000000ba47b705a6443a0d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000861e3305a65e9d74@google.com>
Subject: Re: KASAN: use-after-free Read in uif_close
From:   syzbot <syzbot+0ce97ea45b008ba3b8bd@syzkaller.appspotmail.com>
To:     arnd@arndb.de, daniel.baluta@nxp.com, festevam@gmail.com,
        gregkh@linuxfoundation.org, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux@rempel-privat.de, miquel.raynal@bootlin.com, richard@nod.at,
        s.hauer@pengutronix.de, shawnguo@kernel.org,
        syzkaller-bugs@googlegroups.com, vigneshr@ti.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 32ec783ae19d48084b893cc54747fed37b07eb0c
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Wed Apr 8 19:02:57 2020 +0000

    firmware: imx: fix compile-testing

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15b22972100000
start commit:   c11d28ab Add linux-next specific files for 20200522
git tree:       linux-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=17b22972100000
console output: https://syzkaller.appspot.com/x/log.txt?x=13b22972100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3f6dbdea4159fb66
dashboard link: https://syzkaller.appspot.com/bug?extid=0ce97ea45b008ba3b8bd
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14b23f06100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=111b0172100000

Reported-by: syzbot+0ce97ea45b008ba3b8bd@syzkaller.appspotmail.com
Fixes: 32ec783ae19d ("firmware: imx: fix compile-testing")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
