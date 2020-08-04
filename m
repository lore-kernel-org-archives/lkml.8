Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00611C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 19:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D88FE2086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 19:10:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbgHDTKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 15:10:08 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:47157 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbgHDTKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 15:10:08 -0400
Received: by mail-il1-f198.google.com with SMTP id e12so4402448ile.14
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 12:10:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=8DGWtpZeXz6g3gc4QGhBE15iscZLRy4QscvcEIUaaf0=;
        b=JPZp2hBRL1VrjXHzEvY8Lt2WdQEJ9RcBDQT8RodHNtJ/2FJH79kmUVO+E73bY86ZnI
         XqriFC5LZMfquFdqVpYM+zWMhiCRN+sKyEQd+qBjDNhtLoX7PHh6WAMJltez3lubCrUu
         GNOIJ6kRqFXtNLHcE//eSEQBHBASe8PkQp2m70gToQZadQvMVwfGS8qgGKshMgAvHa1V
         /JkEI6/6XJSet6sJOaRgbkLFoj+nHSZFIyHaK+8lv5lfc2YKo/pxGP2sj+bP4HrOPh8+
         h8uv7Elo0/o5r/psU6cqpHzg0oXNr4xCxwzJw3oooUicK2vZds27yw0ojP7++5rmhwoo
         YI3w==
X-Gm-Message-State: AOAM532jMjbdN71r0FcQHfBP1MzoxN8FltLfRdqB6LPT0MAgKtEovxF7
        Sf/KONnA+7qLXawty4zOeCz/skstPUU321Vp4tGe2nicplx6
X-Google-Smtp-Source: ABdhPJzIGgmU9Wneouek0XdGIUbP14uLYINaBLupAaVxNQzLpFgOJpeyfs/OdYUytzp5So9OVrIgzT55MOsTBG1WFe6X7kkZah6p
MIME-Version: 1.0
X-Received: by 2002:a6b:700d:: with SMTP id l13mr6590268ioc.135.1596568207215;
 Tue, 04 Aug 2020 12:10:07 -0700 (PDT)
Date:   Tue, 04 Aug 2020 12:10:07 -0700
In-Reply-To: <00000000000055881a05ac0f0122@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d9d1aa05ac12001b@google.com>
Subject: Re: WARNING: suspicious RCU usage in ovs_flow_tbl_destroy
From:   syzbot <syzbot+c0eb9e7cdde04e4eb4be@syzkaller.appspotmail.com>
To:     davem@davemloft.net, dev@openvswitch.org, echaudro@redhat.com,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com, pshelar@ovn.org,
        syzkaller-bugs@googlegroups.com, xiangxia.m.yue@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 9bf24f594c6acf676fb8c229f152c21bfb915ddb
Author: Eelco Chaudron <echaudro@redhat.com>
Date:   Fri Jul 31 12:21:34 2020 +0000

    net: openvswitch: make masks cache size configurable

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17461dea900000
start commit:   2f631133 net: Pass NULL to skb_network_protocol() when we ..
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14c61dea900000
console output: https://syzkaller.appspot.com/x/log.txt?x=10c61dea900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=91a13b78c7dc258d
dashboard link: https://syzkaller.appspot.com/bug?extid=c0eb9e7cdde04e4eb4be
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=172cd3d4900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11fbd342900000

Reported-by: syzbot+c0eb9e7cdde04e4eb4be@syzkaller.appspotmail.com
Fixes: 9bf24f594c6a ("net: openvswitch: make masks cache size configurable")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
