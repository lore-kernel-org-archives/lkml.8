Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 045A8C55186
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 13:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4DD52076C
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 13:05:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbgDWNFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 09:05:10 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:47525 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728512AbgDWNFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 09:05:08 -0400
Received: by mail-io1-f72.google.com with SMTP id v23so5567004ioj.14
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 06:05:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=mDeCiJymVJtdQweAH4ZMSfwDQZ44U0uHTCRHrn44daU=;
        b=jE7+HcapxRuM7zuAVgOqfaeS2OVETv7Ac3PIXrv5UeZZJF1uaYTGQhT+nja+gvZB1v
         MQx2crNRXjuqubfqRwnh7fUFrHiQ22hG6STsD8EAPvdvQBDK0yUSWfTJQjwfbmR8+XWw
         DxfjrNFUhJxDR9DSZCFILOCSqqZ8w/fTpf8I8eH7sxo5xMd50BmrlO9A3cg8sRoDFvIq
         XHbBaOLOXI2Piiee/010i3pY2wcp9DDdr6XRWB6B9IdumBqI8KnM+FN9XkRTx+SDSBGf
         9yz5ZcR8PwcCdFNrNyXC9SN+X7kgOtEAEVybj7ScC+yxtpg9ykmDVWMXOUgtnT3E/2SI
         MfLg==
X-Gm-Message-State: AGi0PubkIK0RNQiJNA8iS+M112mL5QN18WYMeY4Kw7xLaj6+xt1c3y5R
        eUZXfwTKiQ/C975fp9pq+B3/39JvgZiZhAeRMP2GSMcNj17+
X-Google-Smtp-Source: APiQypKXyqz/JlzpTAggRql5Ts4MQd1Yv7aMiN6XtgTUti0YG9yIBcvxI2iQdzYPdf5loOr0vwEuoAe/wokm4kEL4FbCdg+q2dxO
MIME-Version: 1.0
X-Received: by 2002:a5d:9354:: with SMTP id i20mr3491302ioo.207.1587647105465;
 Thu, 23 Apr 2020 06:05:05 -0700 (PDT)
Date:   Thu, 23 Apr 2020 06:05:05 -0700
In-Reply-To: <1587645997.23108.9.camel@suse.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c0064305a3f4e57b@google.com>
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
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1396d5bfe00000

Note: testing is done by a robot and is best-effort only.
