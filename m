Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E53C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 05:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5D5C20663
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 05:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbgGBF7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 01:59:07 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:50548 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgGBF7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 01:59:06 -0400
Received: by mail-il1-f199.google.com with SMTP id l17so18813044ilj.17
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 22:59:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=xbytn9M3cxRfOi5zth6kd9KGsR1TEtsxTskqPLpg9gk=;
        b=ddiGSZqMW2y/m58X3hDGiurDVtnxoveQZ0XBQ1mcXdy91ySC3CzzMebafOicOr8LTL
         kGt8j7qWgrFERU/I2vsPCH00/Lcp4/TdR6Omt6tS0CGTHmf2q1UqxJyWZENi9wIKdq1h
         fzHIoD2c1wZanjM3cf0IN3BBt+MtaTcvn01FJvEV3qHlh06TbnKTIeglTnt+dvAG6j+U
         /2mp+aV3r4B3OfPQCPmcElFMVzCackQymw8E941g39YA45qq6j9keQSNYaQ1EB7Qt+/P
         U4dHBJ21av20UF+UpjFpLpIehrId/ADvUk2g9lmS8HcqmUu/XJeIi6OpGJzFpNhd34bD
         jhMQ==
X-Gm-Message-State: AOAM532oYthsvWGnPmy0Vm+s89Tbws4oSEYAoNvgR+MEicuOxLumnjG5
        FpQK4cPVXIECIR0CP6te4Am8c32qaKwLy0Gd3pgwyy6PPo9M
X-Google-Smtp-Source: ABdhPJwYd5RKhOT9Nti7IyaWKnwwbMZeMQ8zrGXQzpwoBuIFp4ja7As0wb5vuWZZ3LxVZPkx2R/wE7IZVvBFXdpbxa54lsJZzdA4
MIME-Version: 1.0
X-Received: by 2002:a92:2ca:: with SMTP id 193mr11456381ilc.299.1593669545736;
 Wed, 01 Jul 2020 22:59:05 -0700 (PDT)
Date:   Wed, 01 Jul 2020 22:59:05 -0700
In-Reply-To: <000000000000b41c6405a8e38c6d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000029c39c05a96f1bb8@google.com>
Subject: Re: WARNING: suspicious RCU usage in qrtr_ns_worker
From:   syzbot <syzbot+0f84f6eed90503da72fc@syzkaller.appspotmail.com>
To:     bjorn.andersson@linaro.org, colin.king@canonical.com,
        dan.carpenter@oracle.com, davem@davemloft.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, manivannan.sadhasivam@linaro.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit e42671084361302141a09284fde9bbc14fdd16bf
Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date:   Thu May 7 12:53:06 2020 +0000

    net: qrtr: Do not depend on ARCH_QCOM

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=105f7755100000
start commit:   7ae77150 Merge tag 'powerpc-5.8-1' of git://git.kernel.org..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=125f7755100000
console output: https://syzkaller.appspot.com/x/log.txt?x=145f7755100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=be4578b3f1083656
dashboard link: https://syzkaller.appspot.com/bug?extid=0f84f6eed90503da72fc
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1521944d100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1298d245100000

Reported-by: syzbot+0f84f6eed90503da72fc@syzkaller.appspotmail.com
Fixes: e42671084361 ("net: qrtr: Do not depend on ARCH_QCOM")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
