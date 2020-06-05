Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF00C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 06:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6864F207F7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 06:09:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbgFEGJG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 02:09:06 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:52685 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbgFEGJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 02:09:06 -0400
Received: by mail-il1-f199.google.com with SMTP id m7so5671618ill.19
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 23:09:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=zfMfzlBlpd3qWkpJFKroTeMQT3G8z4wtkn9pQpVcdFM=;
        b=J/RIiYhKAmM8SIATN3tYffXP+MYRorN72rvgV4GWxM+NL9dA85zdwDP6S5sq8iR/CA
         vTYxawwpkosOuM6veX95EDLua6ELnwrkyibOZazNWahJ8Ce6kE4vVQmD8egIAIwIWf3O
         NFSQydEPSy3reXMrgsthaeGcz+u0RHykwicdfj3nFdS8zqz1TzGzmq5i4iNsg1ddeYCb
         4jkuag/lgkesTwdAf2b0CgqWo9GsiUV3zQWtwgWpBVaIVzagryK+/bCF3lSu4x6vVAiW
         asz3E7pfsIpoZtMODqfYL6HjbzzktGQKCxcHLmGVVExiaSY7Z1EgC0w6k/JhhuHllAa4
         iMjg==
X-Gm-Message-State: AOAM532Z/Lg1RmKnJ3mAnjwjD5gjpvClvLwEg6b8hpYcs3ew9n3e2VhH
        zJ8FoPh1L17aZZyyXjonfgXh+jioHGaIqHYx9y/4uCCGCkjr
X-Google-Smtp-Source: ABdhPJwAkYKDZuKJ3kL67cziO2fZITVmB5aBx55QUMPXRpbP4Pme2q99pelZ8TGD+wxZ2eem8686PfvQe7n18DFSv54D+fOIMPXJ
MIME-Version: 1.0
X-Received: by 2002:a92:c9ce:: with SMTP id k14mr7131158ilq.250.1591337343956;
 Thu, 04 Jun 2020 23:09:03 -0700 (PDT)
Date:   Thu, 04 Jun 2020 23:09:03 -0700
In-Reply-To: <000000000000a363b205a74ca6a2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001ac18b05a75019ab@google.com>
Subject: Re: BUG: using smp_processor_id() in preemptible code in radix_tree_node_alloc
From:   syzbot <syzbot+3eec59e770685e3dc879@syzkaller.appspotmail.com>
To:     bjorn.andersson@linaro.org, davem@davemloft.net,
        ebiggers@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
        manivannan.sadhasivam@linaro.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, willy@infradead.org
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17e22212100000
start commit:   acf25aa6 Merge tag 'Smack-for-5.8' of git://github.com/csc..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=14122212100000
console output: https://syzkaller.appspot.com/x/log.txt?x=10122212100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5263d9b5bce03c67
dashboard link: https://syzkaller.appspot.com/bug?extid=3eec59e770685e3dc879
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15bd4c1e100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1520c9de100000

Reported-by: syzbot+3eec59e770685e3dc879@syzkaller.appspotmail.com
Fixes: e42671084361 ("net: qrtr: Do not depend on ARCH_QCOM")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
