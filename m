Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72156C433E5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 09:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56EBE2065C
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 09:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgGZJ5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 05:57:07 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:54711 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726909AbgGZJ5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 05:57:06 -0400
Received: by mail-il1-f198.google.com with SMTP id d18so9233661ill.21
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 02:57:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=M+lItSmzANKwPOA/FLnsRuuzLx9O8sKK2O7ztiuewsw=;
        b=jU+2LZKum9tuB+GPpJHbIGrFYt8g002lkZjeF1U7ggrOJi6bd11Hqgt04pZb1TEf3s
         TCH1599ysQjgj//nbSxGEXCd6c0UzIhskUorc5p+r9fzZJaxVCkz/UpBt+ati6rixv4s
         Xad2o95Am7IkCKc/Dzs0cCr5jwBb/Td62eJGDXf+vrkEScRWRZo4cZC10QcOkqgxE2wz
         e00ulbNNR+/x9IEj6SGlCxmGSB+/ejMjZDsCFd9S7qMpiVYIiFTjHjuSFDK9HgF3sm34
         DdBJjzfbyg6PCwRsc001FQMAvVfF5OLcLJ4cSjaJCvJv+39i7l912QOhez+Xt2Z8Kwu2
         XXXQ==
X-Gm-Message-State: AOAM530xOKAWSjWduW+VhWwuaAC7aqf2qwjnDgSRKRF5Qnf/JETM8TsN
        OUeqN03CIrVEtmbZiAFWO8r6xe43OT8BThLorwM6CvpdrwVk
X-Google-Smtp-Source: ABdhPJzTKAuBrLOcNZShjjC5K+KAmmPmtsbgfXbsIB9MoOqOOoq6/meN+p4dsSnL857g+Eev4GfZNXcqIkmPJyR9BymjGF4MALae
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1495:: with SMTP id j21mr20749916jak.136.1595757425808;
 Sun, 26 Jul 2020 02:57:05 -0700 (PDT)
Date:   Sun, 26 Jul 2020 02:57:05 -0700
In-Reply-To: <000000000000a376c105a8313901@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000083581705ab553aab@google.com>
Subject: Re: KASAN: use-after-free Read in __smsc95xx_mdio_read
From:   syzbot <syzbot+a7ebdb01bb2cc165cab6@syzkaller.appspotmail.com>
To:     Markus.Elfring@web.de, UNGLinuxDriver@microchip.com,
        davem@davemloft.net, dingxiang@cmss.chinamobile.com,
        hdanton@sina.com, kuba@kernel.org, linus.walleij@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org, steve.glendinning@shawell.net,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 7e23ab72e73bc601b4cf2983382691d9f165c8d1
Author: Ding Xiang <dingxiang@cmss.chinamobile.com>
Date:   Mon Mar 30 07:56:26 2020 +0000

    pinctrl: nomadik:remove unneeded variable

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13cfe3a0900000
start commit:   7ae77150 Merge tag 'powerpc-5.8-1' of git://git.kernel.org..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=d195fe572fb15312
dashboard link: https://syzkaller.appspot.com/bug?extid=a7ebdb01bb2cc165cab6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17046c66100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=140a8a3e100000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: pinctrl: nomadik:remove unneeded variable

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
