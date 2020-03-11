Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 429D1C10F25
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 05:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BA0E208C4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 05:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbgCKFOK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 01:14:10 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:51906 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbgCKFOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 01:14:02 -0400
Received: by mail-io1-f71.google.com with SMTP id h2so650102iow.18
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 22:14:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=y2hVpEQqKWh3yJxXsOzl5nrGR83I9+fKU1M1RVWvyPs=;
        b=uaEdVLiztmpuOClQBRDB0Tq+3ZRmIcBrgJO66nKmACHFb3DSBqKjiLTHZ/j4gHArHe
         5Z3wRTVHxyME6Id9B32LnlDMI71W67U6qjZ2UKyRLVIHFVfONl2iZImOLCqt07TX413R
         1wQeXWdjLpHiwQCKAI26R19+EScoMd1e9ulj6s9s3hTeTH5mDXPZLRaM3rhF+o9191LB
         5QFiZtVBvSatIaFoGn62XE8AHGqk2RoCrA9JO8JNm+Ec9H//+3DDKhe8RqGWxc8PNFnb
         Cgd67X776Hc+xIhfVSBbAgDNgOAF5nmcLHM6y7SNPEPxMBQ1f0YIbqGCCU/CVfzsdiiq
         CtuQ==
X-Gm-Message-State: ANhLgQ2z5DeUhnvb7T2FFQISrezMw+Ho4I9leY51AWEqPS1zwM3h3zVI
        lz7WB95ZNdND6cdpAitA6aQUG1EMr0ytCC7wdKSHZCuLWEJD
X-Google-Smtp-Source: ADFU+vt5z22CinsEa4J20FC0o79+4pntXOyIVUtMDbKuRwnpcjat0DQwZbtCeu25P6gsSLudopbiXfK1NVr6hZMf3ewRKmzDM21x
MIME-Version: 1.0
X-Received: by 2002:a5e:c70c:: with SMTP id f12mr1381398iop.130.1583903641662;
 Tue, 10 Mar 2020 22:14:01 -0700 (PDT)
Date:   Tue, 10 Mar 2020 22:14:01 -0700
In-Reply-To: <CAM_iQpXLZ1PaG757i1NiQH9q+xuZAzhued0DYEGNH2XtAWZq2A@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000eb7a5405a08d4d7e@google.com>
Subject: Re: KASAN: invalid-free in tcf_exts_destroy
From:   syzbot <syzbot+dcc34d54d68ef7d2d53d@syzkaller.appspotmail.com>
To:     davem@davemloft.net, jhs@mojatatu.com, jiri@resnulli.us,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger crash:

Reported-and-tested-by: syzbot+dcc34d54d68ef7d2d53d@syzkaller.appspotmail.com

Tested on:

commit:         2c19e526 net_sched: hold rtnl lock for tcindex_partial_des..
git tree:       https://github.com/congwang/linux.git tcindex
kernel config:  https://syzkaller.appspot.com/x/.config?x=bcbe864577669742
dashboard link: https://syzkaller.appspot.com/bug?extid=dcc34d54d68ef7d2d53d
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
userspace arch: i386

Note: testing is done by a robot and is best-effort only.
