Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB6DC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 09:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C9D52465A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 09:39:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgCJJjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 05:39:05 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:38395 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgCJJjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 05:39:04 -0400
Received: by mail-il1-f197.google.com with SMTP id i67so9415793ilf.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 02:39:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Ft1PhnFnc8bw/kovbcGkfh5uu6sAnhp379YzovTXzb4=;
        b=gr6O7S5cOafU+B3ObjLiHdFY9MtZMwyFNGjC8kq1vNPShTPBpd3CuvqoUZ3lWMnbOs
         oeNe+4VdZq3wPDd8wIiuX2GUIUFTItyMy08Mb24Y3SHYavTjo9r9wnmN9fS7JHpz8zAp
         hd+XGsi3V3tBIUDLSGBt2hf/UHgDPuipk9oF19Oz0t79sMM2u4CY0fsMGlrDVay3vMQT
         wSzMuHN4HTB/hlz81cwteQ1jR5nBqzkjS1iZu38iXwAntS1iwap8PS7fH4a1XTdMMiu8
         QhG51xk8vq9hgftOZTUPsmb3iYCbsA52Xk3C6vwE7hmaCPDpuz/iGP95rnLqV5EQ33Vt
         v5bQ==
X-Gm-Message-State: ANhLgQ2J4GBUumS7Sh/kiApfefcKK4q9Ay+6aPl4em+DwBnfckGO1r8y
        zwKkp7C6ZhQ7fFKdk85U4vIH1KHS+A5VZ3PffZBEUn5jufSd
X-Google-Smtp-Source: ADFU+vv409M5ysztY4mJK7k8RhSc53CkX02mkjFwyJLPk9ilHB8ccfdDU+ZKw2MzKDgbagEXleetGkGhQoVnTDE4XxZFi+izxggG
MIME-Version: 1.0
X-Received: by 2002:a92:9955:: with SMTP id p82mr6731873ili.178.1583833141776;
 Tue, 10 Mar 2020 02:39:01 -0700 (PDT)
Date:   Tue, 10 Mar 2020 02:39:01 -0700
In-Reply-To: <00000000000088452f05a07621d2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cc985b05a07ce36f@google.com>
Subject: Re: WARNING: refcount bug in sctp_wfree
From:   syzbot <syzbot+cea71eec5d6de256d54d@syzkaller.appspotmail.com>
To:     ardb@kernel.org, davem@davemloft.net, guohanjun@huawei.com,
        keescook@chromium.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-sctp@vger.kernel.org,
        marcelo.leitner@gmail.com, mingo@kernel.org,
        netdev@vger.kernel.org, nhorman@tuxdriver.com,
        syzkaller-bugs@googlegroups.com, vyasevich@gmail.com,
        will@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit fb041bb7c0a918b95c6889fc965cdc4a75b4c0ca
Author: Will Deacon <will@kernel.org>
Date:   Thu Nov 21 11:59:00 2019 +0000

    locking/refcount: Consolidate implementations of refcount_t

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=117e9e91e00000
start commit:   2c523b34 Linux 5.6-rc5
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=137e9e91e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=157e9e91e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a5295e161cd85b82
dashboard link: https://syzkaller.appspot.com/bug?extid=cea71eec5d6de256d54d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=164b5181e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=166dd70de00000

Reported-by: syzbot+cea71eec5d6de256d54d@syzkaller.appspotmail.com
Fixes: fb041bb7c0a9 ("locking/refcount: Consolidate implementations of refcount_t")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
