Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB62FC1975A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 22:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A52A206F9
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 22:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbgCVWlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 18:41:06 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:52737 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbgCVWlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 18:41:06 -0400
Received: by mail-il1-f197.google.com with SMTP id d2so11004536ilf.19
        for <linux-kernel@vger.kernel.org>; Sun, 22 Mar 2020 15:41:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=cAEgMtJXVcFR8HXdzN8/OJMaHj1085L78hE0rS+5FzA=;
        b=Kqd8bbrnUzc7bvYZg5iZuaZDctH0/4rAryUkuHKExrRKdG5RVPvOSC8URhT8t9k6kC
         avQRRwU1WVYaLiwwtGezY/sSJmgrxG/HpFTeAWoOryoGcluTwXgnv6qlARkbQmZyw8sw
         l1defQNZx5639msaieTpj/zSZjWQx3Lj8VL9gsH9ohm5uwz5cW6SjYwI1gGl/NTwrO4o
         OtmVHaYWsHFSuOCQ3/B11U03pu0Do75tZ8iMCMhEzTlxqHebDJteMw+NCDGgvbRGpekX
         /O2raSzHNpZGL1Hc+gXrAz7ofm+ujS7U5bl/UAAkScWoacmDkKjLyXu45KFIdW9b1MWR
         4xRw==
X-Gm-Message-State: ANhLgQ2eq8bxBWpzKrEOxIg/xI7Z8Qen0ipWZcwhTNUIn3Fyt8mL+EC3
        BZD3xUVqckA2ZeC2eyEHXX7poSe07ITiWjSsBf662NhIDAy6
X-Google-Smtp-Source: ADFU+vvoY4ZZ8q9RJ93Ljlr95XzUMy5yWapyFQUyd7mKNRVJ+vBb4vGnxI0XRUhkLiLs7jftcPg0X2aGtnmNNmMkJYN6LEr7okak
MIME-Version: 1.0
X-Received: by 2002:a02:90d0:: with SMTP id c16mr18198725jag.22.1584916863921;
 Sun, 22 Mar 2020 15:41:03 -0700 (PDT)
Date:   Sun, 22 Mar 2020 15:41:03 -0700
In-Reply-To: <000000000000f04e43059b1ee697@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ac36ba05a1793693@google.com>
Subject: Re: WARNING in switch_fpu_return
From:   syzbot <syzbot+f2ca20d4aa1408b0385a@syzkaller.appspotmail.com>
To:     alexander.deucher@amd.com, bigeasy@linutronix.de, bp@alien8.de,
        dave.hansen@intel.com, dvyukov@google.com, hpa@zytor.com,
        linmiaohe@huawei.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, nicholas.kazlauskas@amd.com, pbonzini@redhat.com,
        riel@surriel.com, sean.j.christopherson@intel.com,
        sunpeng.li@amd.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, x86@kernel.org, zhan.liu@amd.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit 3009afc6e39e78708d8fb444ae50544b3bcd3a3f
Author: Sean Christopherson <sean.j.christopherson@intel.com>
Date:   Wed Jan 22 04:43:39 2020 +0000

    KVM: x86: Use a typedef for fastop functions

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1667aa4be00000
start commit:   bf8d1cd4 Merge tag 'scsi-fixes' of git://git.kernel.org/pu..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=ed9d672709340e35
dashboard link: https://syzkaller.appspot.com/bug?extid=f2ca20d4aa1408b0385a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=151d549ee00000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: KVM: x86: Use a typedef for fastop functions

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
