Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DATE_IN_PAST_06_12,
	FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C476C1975A
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 02:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E12A420637
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 02:15:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgCOCPi convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Mar 2020 22:15:38 -0400
Received: from mail-pj1-f70.google.com ([209.85.216.70]:56332 "EHLO
        mail-pj1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbgCOCPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Mar 2020 22:15:38 -0400
Received: by mail-pj1-f70.google.com with SMTP id f94so6707528pjg.6
        for <linux-kernel@vger.kernel.org>; Sat, 14 Mar 2020 19:15:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:content-transfer-encoding;
        bh=+QdPalM1/7ayitV9XmteLgnXaS2hu+LX/EwtXkNn8sI=;
        b=WroxuWoa6rDunFq6qFviGZ3hPmKIh1N+mykuUUgbZp2JzgC3p9shFnFtVECXReSbZI
         awto5MyPgf6gidE/c5hCypvT2n+nnCi8sMuO5pFLOnHbO5ls+jW/1YdoZp7+B4R8l5dR
         TrwiV4W9oI5xen+RzgM3I0iLWpRCOOQuiTbO9DluTRDJiIbUC9hOKqRLdytBprMx/tAo
         9az12fcRwk7ZLEV0WWSjiLmeRSdUja8vWBlXOlXvP0iYXHSSf9tcIxXTzGICEC4s1ePe
         +D3AtEvu7uiiT4YYtp4aRAYyOh06SA+r9Yr/k67OhEjHKYIAxB45EJ3RHXm/INtGK51N
         TuIg==
X-Gm-Message-State: ANhLgQ0riZWkvU9vzZ1JGtLZN82Z4VCGCyGfNKUfbyyq07cpF/mxjA58
        bsRR7fvz2tie3YtTSke3yGGqItIHCIanxy/8hu41dDBBTFP3
X-Google-Smtp-Source: ADFU+vsvmmvzF0I4nMIQXyBWKmywCRss6IV6wvF4RwqOdkw0XwU5mtrUilZd8jdSs9quwxi/+KGtd7aYDnIYchTEyVeGinshxzTm
MIME-Version: 1.0
X-Received: by 2002:a92:aa87:: with SMTP id p7mr18089913ill.63.1584206402340;
 Sat, 14 Mar 2020 10:20:02 -0700 (PDT)
Date:   Sat, 14 Mar 2020 10:20:02 -0700
In-Reply-To: <000000000000cdbe79059ce82948@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dccd2405a0d3cb04@google.com>
Subject: Re: KASAN: slab-out-of-bounds Read in bitmap_ipmac_destroy
From:   syzbot <syzbot+a85062dec5d65617cc1c@syzkaller.appspotmail.com>
To:     a@unstable.cc, arvid.brodin@alten.se,
        b.a.t.m.a.n@lists.open-mesh.org, coreteam@netfilter.org,
        davem@davemloft.net, florent.fourcot@wifirst.fr, fw@strlen.de,
        jeremy@azazel.net, johannes.berg@intel.com,
        kadlec@blackhole.kfki.hu, kadlec@netfilter.org,
        linux-kernel@vger.kernel.org, mareklindner@neomailbox.ch,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        pablo@netfilter.org, sw@simonwunderlich.de,
        syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit 32c72165dbd0e246e69d16a3ad348a4851afd415
Author: Kadlecsik József <kadlec@blackhole.kfki.hu>
Date:   Sun Jan 19 21:06:49 2020 +0000

    netfilter: ipset: use bitmap infrastructure completely

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10aef753e00000
start commit:   4703d911 Merge tag 'xarray-5.5' of git://git.infradead.org..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=83c00afca9cf5153
dashboard link: https://syzkaller.appspot.com/bug?extid=a85062dec5d65617cc1c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1301ed85e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14b7b79ee00000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: netfilter: ipset: use bitmap infrastructure completely

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
