Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD89C11D30
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 11:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3599120838
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 11:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbgBXLqD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 06:46:03 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:54577 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727429AbgBXLqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 06:46:02 -0500
Received: by mail-il1-f198.google.com with SMTP id t4so17805994ili.21
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 03:46:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=TPDa8vA3dA5ocPrn3u12l+xTYIvr8/gY5caMU69qWlU=;
        b=ClHxSw/PS8pLWGkr7/fVhHSAqF9s1JBQbG2jE1UYyOJMzhuw+pxJx3jKV5ZkX9EP5/
         NL0BnZ0/r3kSp1SRRaKbV+52c6V6NtTkXRJkS6Z0eJejy00jTEVBPcXXcduRyEhsN4J9
         vCfJj+XmtiRGUuBaBKkHC41x1ntKM2jeJuRGibppRwaE1WhWJAvGSSL2yqO5DcCl77VS
         xHmHRrhQs0dPJ/ftXozCDmeAtL+PoWucYGfo0W6j0mH/cwXbKp/V3CNKXp3S5ld/Q1nT
         1FvYvl2pDbGPHs1QREvxFhIT4sv2QrBtVk+Gcw9zLICIjQK1jKHtWmQoLp3Nwtx+9xsQ
         kp/g==
X-Gm-Message-State: APjAAAXYxyFp0oHN41ZHNerdrad9SEx0loJFLflgDP9zicgHPSl1Zq4/
        B8bRZIoz5AXErwMyLcpdwhpXzieLWZcqhejvtPt9zzb+TedU
X-Google-Smtp-Source: APXvYqw8hJLLKQWy7t1wn0gt4p/CBTAWcz0u7a08HT32PVYseKb6Zst8oSvvhVBG6HkcXdOrZxccOixjo3lFs6l0GucGK/G5V7q9
MIME-Version: 1.0
X-Received: by 2002:a6b:730c:: with SMTP id e12mr48673976ioh.4.1582544761598;
 Mon, 24 Feb 2020 03:46:01 -0800 (PST)
Date:   Mon, 24 Feb 2020 03:46:01 -0800
In-Reply-To: <00000000000005efef059f4e27e1@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005b46ba059f50ea17@google.com>
Subject: Re: KASAN: use-after-free Read in ethnl_update_bitset32
From:   syzbot <syzbot+709b7a64d57978247e44@syzkaller.appspotmail.com>
To:     davem@davemloft.net, f.fainelli@gmail.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, mkubecek@suse.cz,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit bfbcfe2032e70bd8598d680d39ac177d507e39ac
Author: Michal Kubecek <mkubecek@suse.cz>
Date:   Fri Dec 27 14:56:13 2019 +0000

    ethtool: set link modes related data with LINKMODES_SET request

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16d59109e00000
start commit:   0c0ddd6a Merge tag 'linux-watchdog-5.6-rc3' of git://www.l..
git tree:       net
final crash:    https://syzkaller.appspot.com/x/report.txt?x=15d59109e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=11d59109e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3b8906eb6a7d6028
dashboard link: https://syzkaller.appspot.com/bug?extid=709b7a64d57978247e44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13885de9e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1518127ee00000

Reported-by: syzbot+709b7a64d57978247e44@syzkaller.appspotmail.com
Fixes: bfbcfe2032e7 ("ethtool: set link modes related data with LINKMODES_SET request")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
