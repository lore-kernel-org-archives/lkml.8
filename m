Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB5BC433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 10:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98CCD206F5
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 10:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbgGVK7I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 06:59:08 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:45278 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbgGVK7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 06:59:08 -0400
Received: by mail-il1-f198.google.com with SMTP id c1so779336ilk.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 03:59:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=+MTYhbpSCITOUxjmPnhjda3q0hd+gL2rgezFk7qJWaU=;
        b=fM05A2EGkYQC548sKNU9ZPhN3AQx0CChu1Vk1u343bF+e4c/4pfJ5K9P6E/3i7eP7H
         zotUvykZWEfldYzZHPhmYipabAy0i3eBq2KiROKMmv1+Y5VJlIY1L9SztW6snmkFA2nH
         CM8IsL/VjQRxH+a+OxO8SmitfzE5c+Ulx9SCwsQ8EQdrTgf3Xj0jDg41NLWS6gn+cfNN
         3hktStJZjRUkaMj9UZLgeuQ8y554rdXnnHwqZL5TWM8mWLuCUGtvsiXOa2OmD46XCV8T
         14qyJvYdxZClUwilPL87QCBN/NeWDEri9Umi12ddRgwpID3Kx5mK0EAi/t/C1JkvUqje
         Xt/g==
X-Gm-Message-State: AOAM533s36wu3H0ViTSIgVbfnJWHu9HVukgdw1Kz9WYKE7VH6bq00+v8
        G2TlaKIUYKIWa56UYuH6wVHFWF8NG+0UuFISo2zASBRJH/04
X-Google-Smtp-Source: ABdhPJyKtjS5xuKw6MuALvst1m+b7QzvnWngYNvV6LqBHReEEtIkwFNADfCr8JbKjNbF2Bke/lig7Wv1Cfl+GLPkBzoFx6WWGl4H
MIME-Version: 1.0
X-Received: by 2002:a92:d652:: with SMTP id x18mr31350270ilp.248.1595415547083;
 Wed, 22 Jul 2020 03:59:07 -0700 (PDT)
Date:   Wed, 22 Jul 2020 03:59:07 -0700
In-Reply-To: <000000000000cbef4a05a8ffc4ef@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f4040e05ab05a0dc@google.com>
Subject: Re: BUG: using smp_processor_id() in preemptible code in tipc_crypto_xmit
From:   syzbot <syzbot+263f8c0d007dc09b2dda@syzkaller.appspotmail.com>
To:     davem@davemloft.net, jmaloy@redhat.com, jon.maloy@ericsson.com,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tipc-discussion@lists.sourceforge.net, tuong.t.lien@dektech.com.au,
        ying.xue@windreiver.com, ying.xue@windriver.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit e1f32190cf7ddd55778b460e7d44af3f76529698
Author: Tuong Lien <tuong.t.lien@dektech.com.au>
Date:   Fri Nov 8 05:05:12 2019 +0000

    tipc: add support for AEAD key setting via netlink

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11b738a0900000
start commit:   11ba4688 Linux 5.8-rc5
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=13b738a0900000
console output: https://syzkaller.appspot.com/x/log.txt?x=15b738a0900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e944500a36bc4d55
dashboard link: https://syzkaller.appspot.com/bug?extid=263f8c0d007dc09b2dda
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14000957100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12d30d67100000

Reported-by: syzbot+263f8c0d007dc09b2dda@syzkaller.appspotmail.com
Fixes: e1f32190cf7d ("tipc: add support for AEAD key setting via netlink")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
