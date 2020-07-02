Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66487C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 13:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3538C20890
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 13:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729234AbgGBNjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 09:39:08 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:47675 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729129AbgGBNjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 09:39:07 -0400
Received: by mail-il1-f200.google.com with SMTP id o2so19503045ilg.14
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 06:39:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=WpKkuPCbjM9qHybSEs/eO4ohp9+DmrsOe+ROlXOZsfw=;
        b=B6zlxk24AgFGsECQAPEotw4uZcmkY9zfqaKIW9T+6GBzW8OK+ulrs6S8zPzl0d6DX8
         nNd70itgAnFNBGZB8DIpcf70LRIDhnghgLaesIuW5ylOqat2Co8MvhUJLPTqBo75q9Kt
         Cw3YLanQbzQ5Lal3O955ajrO2cLeDvXUWfMNuMP+RXD2R7JZZ+rDfL8SQ2KwGN4jKeD7
         vjlG6kA+MV5RjPQ9SN65CiJoCshuJlB4hv9Mpenbz1A57CKIB/vdkBtIliX7KpS+tJ+M
         Vk5YusO2FCyQH2oAgOsPcl+8q0j4RH/ldhGu0YnTY/k5nIcHaA/KdqmYe7SBVRU2F2xV
         mbbQ==
X-Gm-Message-State: AOAM531Tv8EIsOYDlJc228r1Mx5rrOrJNOZuR4f7obkYdRpYN/XNIg7l
        yjWzkDB4s9e13jlBozqkhr9kUwYmnfNPl3oX/XZp1eTkqJbb
X-Google-Smtp-Source: ABdhPJzabNnQL2nbQZLXYYBaeQiPct0MWGQOc2ZsbarBu3vWY2R3VqBxT6Ux5jgC1ao6rItmynuh00qwZq7qfK301tZVPk00HE/2
MIME-Version: 1.0
X-Received: by 2002:a05:6638:e93:: with SMTP id p19mr16903757jas.67.1593697147104;
 Thu, 02 Jul 2020 06:39:07 -0700 (PDT)
Date:   Thu, 02 Jul 2020 06:39:07 -0700
In-Reply-To: <000000000000ea237605a8e368a9@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000055323705a9758823@google.com>
Subject: Re: WARNING in idr_alloc
From:   syzbot <syzbot+f31428628ef672716ea8@syzkaller.appspotmail.com>
To:     bjorn.andersson@linaro.org, davem@davemloft.net, kuba@kernel.org,
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17325ad5100000
start commit:   7ae77150 Merge tag 'powerpc-5.8-1' of git://git.kernel.org..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=14b25ad5100000
console output: https://syzkaller.appspot.com/x/log.txt?x=10b25ad5100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d195fe572fb15312
dashboard link: https://syzkaller.appspot.com/bug?extid=f31428628ef672716ea8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15252c4b100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10159291100000

Reported-by: syzbot+f31428628ef672716ea8@syzkaller.appspotmail.com
Fixes: e42671084361 ("net: qrtr: Do not depend on ARCH_QCOM")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
