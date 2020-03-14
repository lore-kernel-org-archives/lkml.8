Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=DATE_IN_PAST_12_24,
	FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF9DC1975A
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 02:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD6A82071C
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 02:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbgCOCXn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Mar 2020 22:23:43 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:37111 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727222AbgCOCXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Mar 2020 22:23:42 -0400
Received: by mail-il1-f197.google.com with SMTP id c26so1362381ila.4
        for <linux-kernel@vger.kernel.org>; Sat, 14 Mar 2020 19:23:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:content-transfer-encoding;
        bh=j2SmXJOFlNVNX3IBInWb2HEJ3kFsGIlnIYBHVv47Fmg=;
        b=C11TZAkLMycQAitXzDwLWxGWk6EU4iLgrKxJvxBnIVJ9ncITtlq0YfU3q7+WxHXL1E
         28hFC61FkgfmsSdWyR7W1Rw7nuFGJEqW8AAbUJ3ueZpBQZ88o0B5JbxF/oxdnuByzGHp
         Qm5UWOIVJD28300ryAgz9OuH/RZM7ipWrVO4/Vn2UTojJf+MHHTYgmlQO7EUj7891J6J
         W5wK8riaSrggk0QGVdvFDyL/SM/pAMAU+Hq3/2ETgDmhDi710Ke6Baz4jhbXcE0LXsEF
         NCgym0Jpn6uG/Gh6rDiXJA2GXIagTS8+ucIs5y7zqTG79oOsNZLAiEWgyqo5aiAR6Fjx
         XHLg==
X-Gm-Message-State: ANhLgQ1O9TbEHtGxQ2VWIr0cyd9runE6jppRATV3RqvxwuzSjZ+qg9t/
        wvGJK8dJiSsGSIUoJGqc0AexeI9ulCtZYZwK07N/2l/J5v2I
X-Google-Smtp-Source: ADFU+vuJBPZ1PMOOzQo98cA9c5gJcvaAaQ6f/LSVIdRh9X4dB9T+eheUju1sRb7NyyPU97BKERRNFdBNpuxA4sPOAFveN366df7X
MIME-Version: 1.0
X-Received: by 2002:a92:d842:: with SMTP id h2mr17075595ilq.34.1584191402876;
 Sat, 14 Mar 2020 06:10:02 -0700 (PDT)
Date:   Sat, 14 Mar 2020 06:10:02 -0700
In-Reply-To: <000000000000204b4d059cd6d766@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d3278d05a0d04d97@google.com>
Subject: Re: KASAN: slab-out-of-bounds Read in bitmap_port_destroy
From:   syzbot <syzbot+b96275fd6ad891076ced@syzkaller.appspotmail.com>
To:     arvid.brodin@alten.se, coreteam@netfilter.org,
        dan.carpenter@oracle.com, davem@davemloft.net,
        florent.fourcot@wifirst.fr, fw@strlen.de, hdanton@sina.com,
        jeremy@azazel.net, johannes.berg@intel.com,
        kadlec@blackhole.kfki.hu, kadlec@netfilter.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org, pablo@netfilter.org,
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=106f42a9e00000
start commit:   131701c6 Merge tag 'leds-5.5-rc8' of git://git.kernel.org/..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=83c00afca9cf5153
dashboard link: https://syzkaller.appspot.com/bug?extid=b96275fd6ad891076ced
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15fba721e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1339726ee00000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: netfilter: ipset: use bitmap infrastructure completely

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
