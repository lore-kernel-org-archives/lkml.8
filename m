Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C37C54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 11:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E38420728
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 11:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbgDWLUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 07:20:06 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:35995 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728015AbgDWLUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 07:20:06 -0400
Received: by mail-io1-f69.google.com with SMTP id p9so5333100ioh.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 04:20:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=7ws0cdv3Hoh5HeHAP/ghf6fY1WIucwMKaP3c8MnIE78=;
        b=fgj5gxGQOQ6MQDEL/229fos02HdreH46iZxQQP2RLb5p/k6n6YnOPaCfDG86WTu0Nd
         1PPGXCwI9dR78cTLE6XNbl3myck1pcx2i3vyG2m+y+f6hwFi8YnzAOCvJiFAgPIjA4Sp
         Ply33URYRPJRDtQaUYkjclT7JMBHgP4M7xUKOxQl4a6NUV3dkGytBba7L5z72WcZ26P+
         JajvDOnpKqxZ3UY0DJ7mArXjJFCzwVK+1rizI0MybCgUbTYA9n/GybLiBJ+Jpb//TncA
         ZYJiuReQPvMNuG+hMkjDtEzQ3wajGtnYsga3afGJ4ZHkUpThIwbUzh61JZcOBW36RoIO
         RydA==
X-Gm-Message-State: AGi0PuZeZlc8mmkfZLJXSFUv0PhGR0cTqZQrnaNPyNkmJ4E34QkW99jT
        QyASl43xfeyCUQ3QUiTkpaRJwuFborHWwuggZb23ZiGG/ao5
X-Google-Smtp-Source: APiQypI+EsLOsSPy6Sg+P7SRjTLpki9gp5v/Xt5zbhKL9lDbKFt5ewoTipmheSr6K6PolKz5AuPvg7AodJLNWX3+BaXd0t0KhCeX
MIME-Version: 1.0
X-Received: by 2002:a92:3cc4:: with SMTP id j65mr2713330ilf.190.1587640805461;
 Thu, 23 Apr 2020 04:20:05 -0700 (PDT)
Date:   Thu, 23 Apr 2020 04:20:05 -0700
In-Reply-To: <1587639690.23108.2.camel@suse.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003d967305a3f36ee9@google.com>
Subject: Re: general protection fault in go7007_usb_probe
From:   syzbot <syzbot+cabfa4b5b05ff6be4ef0@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, hverkuil-cisco@xs4all.nl,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-usb@vger.kernel.org, mchehab@kernel.org, oneukum@suse.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger crash:

Reported-and-tested-by: syzbot+cabfa4b5b05ff6be4ef0@syzkaller.appspotmail.com

Tested on:

commit:         e9010320 usb: cdns3: gadget: make a bunch of functions sta..
git tree:       https://github.com/google/kasan.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=bd14feb44652cfaf
dashboard link: https://syzkaller.appspot.com/bug?extid=cabfa4b5b05ff6be4ef0
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=108a4ecfe00000

Note: testing is done by a robot and is best-effort only.
