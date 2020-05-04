Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D55C6C47258
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 14:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADF3A206D7
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 14:27:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbgEDO1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 10:27:07 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:36023 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726922AbgEDO1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 10:27:06 -0400
Received: by mail-io1-f69.google.com with SMTP id m16so13454376ion.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 07:27:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=tPiCWo5vZt6eRDO7BBRPOa0yuIhUrB+l131rOX9s6CY=;
        b=S6cLDBlWDODFF3fW8nRny/jGpqEFh7PwMFn/DFsGBzWO0IBtD357HByFME8vw2XFN/
         CG+F6/uyuQ9cuh69ib5U9KxxCQPWuoEsjYOXd4Kic6xfmHHPxy2l4RtSuomp/hUC+SF7
         ly+0Ts8qm71Ndd5hCDw6osUv2d5PmZta2J0QwQ7EuF3aiRMdmeBU6HQebkfbqwYcMt/+
         HGTeTe/h0bGgRf9WQsFAi1ObM467DRmRa9ShmpMOFboaMWrUfNIXvmqBJXlnUe4ZhkBk
         1fJBx9hC7j2jClqNfqED9jIxDoweLxti98Z7WMBFsLy8I9n3Z+dx6TetR0UANwuNoaN5
         bJKg==
X-Gm-Message-State: AGi0PuYqQ5mTus5VNl4TmnTFbgrG1WuDPiV2KsylKkMb+g+1IsTRf+2r
        AbtLYEkOPDAEljFJYLDExsJ4t1IIKaqN6cZ0EKtpi9XA8moB
X-Google-Smtp-Source: APiQypJ8harZ8NMOPBBI5viNbcdAe/HO5mOVtP+fh48bD5vjQGEpp9ITY+DyKOTs273WuBIXSFmjQ9qZWsR+xnFn/H5HXBGE1lGL
MIME-Version: 1.0
X-Received: by 2002:a92:5aca:: with SMTP id b71mr16544469ilg.56.1588602424468;
 Mon, 04 May 2020 07:27:04 -0700 (PDT)
Date:   Mon, 04 May 2020 07:27:04 -0700
In-Reply-To: <1588601290.13662.6.camel@suse.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003329dd05a4d353d5@google.com>
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
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17327ea8100000

Note: testing is done by a robot and is best-effort only.
