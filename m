Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1BA4C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 06:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8297224695
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 06:30:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgCBGaK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 01:30:10 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:55991 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgCBGaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 01:30:09 -0500
Received: by mail-io1-f69.google.com with SMTP id k5so7474835ioa.22
        for <linux-kernel@vger.kernel.org>; Sun, 01 Mar 2020 22:30:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=4YYMt/NmjzWA++n+f1JrmgMPppH69EcF6rf66gBwOAQ=;
        b=BlOmh9e86qqWQxKoU8KkpCRzuwrKalavhvr/TbLf4X31V+XN5xhES5az1n4mjomAmY
         tfwDgAxTRfVAPZobgdcEBvswgy5jyWEtkNvndHFvsy8xXhPIsSdv1yNry7MwN4IZktTg
         RDk9IhpBOSWCXep7eVpXOP2SNpEiptw4i8ktJ1d7mHcBCz+v0hvHPMhDtGQRaaEMO3Nd
         l0bJy/A1QAQmFYArODhoMwzweUfif7jGtzM0/lUdpetwcgOAsby4IPUON3gD++nRfaQF
         DlR0DESnZOJcpIs68y4LdT8irHOxqdaUFFpuXBqGlD9fjWCsbzr90avShmPT/cjjJpfx
         TrmA==
X-Gm-Message-State: APjAAAUZb58lxazIhWcY+TAvKr+NTeYf7HCKshiH08jok2nzl8zqni6x
        8jd0L1FvJCMmFCptvsXm6/rbBoHl87Xf3a/FuJqtOB3vOT9O
X-Google-Smtp-Source: APXvYqxO00LLlC0E59VXlspGx5WEkQ2/lGhvq9JtGOFZlbtjoSv4GLYjpozDO1f5VgJgyv2k+3MwmO9OuUPzoUF9IW31DADJl64C
MIME-Version: 1.0
X-Received: by 2002:a5e:a703:: with SMTP id b3mr8643903iod.95.1583130609317;
 Sun, 01 Mar 2020 22:30:09 -0800 (PST)
Date:   Sun, 01 Mar 2020 22:30:09 -0800
In-Reply-To: <0000000000000e4f720598bb95f8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000099fb63059fd95165@google.com>
Subject: Re: KASAN: use-after-free Read in slcan_open
From:   syzbot <syzbot+b5ec6fd05ab552a78532@syzkaller.appspotmail.com>
To:     davem@davemloft.net, dvyukov@google.com, jouni.hogander@unikie.com,
        linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
        mkl@pengutronix.de, netdev@vger.kernel.org, socketcan@hartkopp.net,
        syzkaller-bugs@googlegroups.com, wg@grandegger.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This bug is marked as fixed by commit:
slcan: Fix use-after-free Read in slcan_open
But I can't find it in any tested tree for more than 90 days.
Is it a correct commit? Please update it by replying:
#syz fix: exact-commit-title
Until then the bug is still considered open and
new crashes with the same signature are ignored.
