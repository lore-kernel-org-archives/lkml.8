Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D9AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 09:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC1DB2088E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 09:44:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbgGBJoF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 05:44:05 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:51124 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbgGBJoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 05:44:04 -0400
Received: by mail-io1-f71.google.com with SMTP id 14so7218471ioz.17
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 02:44:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=WAGEeWPrSaptqzW7yLUHgWJcljJ0RDXieWtaFOLwK8I=;
        b=BLOwf+2cIT+BznM11BTcN9LqfxVJVHVy3ihULKN3silWekNSoRUpVCbXgCHrtHIie0
         JbJqlDs9pJWrjUTtTfyoLgSLKnALHS7KeIC8xIFkFoo01LQhjsKCHBFoHzvcz4dd5ttx
         /EbzeubXr2QX16kjjTJV2XI1Cz3fbrjyYPk2ajlPI+IFi3B8tg/5Mq0lfEaakd9IrW5t
         6LYyjxWDujAWwU4IxHfcDvQExNka0EM0QO75cRsCSiqTx9DMapjDiGCC1oKEgbU27GQz
         lqUPW3Azx74rhP6DXhzSEN85ORt1UVRDXs34q9SOEldqQy4//tjL7G58NjIYDfQe5fAw
         Ghnw==
X-Gm-Message-State: AOAM533E3TN1tiuEqy/JH+/hvrgstS8nizeMAam35Z9HI03vNbU0uNIN
        88bs8zTKe+OELKFwn958ABJYowzeSeBKtR1sO3QPKSHU0NpO
X-Google-Smtp-Source: ABdhPJwvaUUKgDGCjjnU0hGKeYaZG0U1RMrOv2um1OcV2qBfkIsnEkJXuKSw91FQIuKR1yDl7VlRG1dip2i6bT4m4jmzbSomUx1N
MIME-Version: 1.0
X-Received: by 2002:a02:3c08:: with SMTP id m8mr1134561jaa.107.1593683043766;
 Thu, 02 Jul 2020 02:44:03 -0700 (PDT)
Date:   Thu, 02 Jul 2020 02:44:03 -0700
In-Reply-To: <000000000000add83505a8e38c4c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b559df05a9723fcf@google.com>
Subject: Re: WARNING: suspicious RCU usage in ctrl_cmd_new_lookup
From:   syzbot <syzbot+3025b9294f8cb0ede850@syzkaller.appspotmail.com>
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=131c54a7100000
start commit:   7ae77150 Merge tag 'powerpc-5.8-1' of git://git.kernel.org..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=109c54a7100000
console output: https://syzkaller.appspot.com/x/log.txt?x=171c54a7100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d195fe572fb15312
dashboard link: https://syzkaller.appspot.com/bug?extid=3025b9294f8cb0ede850
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11802cf9100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=144acc03100000

Reported-by: syzbot+3025b9294f8cb0ede850@syzkaller.appspotmail.com
Fixes: e42671084361 ("net: qrtr: Do not depend on ARCH_QCOM")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
