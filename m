Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE9CC32771
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 04:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42E262067C
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 04:01:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbgA0EBE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jan 2020 23:01:04 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:34541 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbgA0EBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 23:01:03 -0500
Received: by mail-il1-f199.google.com with SMTP id l13so6757199ils.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jan 2020 20:01:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=VgaYY37/arJ//cWZJnlZvZwtZBPazlQXq/CIao1WfmQ=;
        b=pDHHajVqEpttQF6+rmjn81yxsETeY7HTa7/PGSFGIB0dJcbv1ZGAKyirSO1duOmC1K
         wOR99gXwX44R+Vu4/49RC7nn2Aaw+fs7v23h6isiHJHedk9kXGEqfIYLK7FuIWEtvyEF
         7Ck5MkN0/nHcUdr7BWd1Gc1aGmxdXyC1C0IN21lJFjcBQPjmE5+zuqNn0q1ieAw8WGcl
         A2faxlpdsNzUKtH+vt61hFXYOMMWsKCPjJphnRSuGinrGRxrzGBG9PhLw0q75JKyj9S6
         8sOsEoiqIQ8y9bUSlu3HYEhwDHX9R0qI4De921MV1BEo/TDtx/Rmx4NY4RQwyyeAOeke
         Hcww==
X-Gm-Message-State: APjAAAXuEDZbqOWhoAHjQ3eMpX0wl3G5Fl4w6rYAuxSLLhOS5yU8TTRL
        0Rz4X6S7OlhmqPbOZYMdFlHQGqjlVD0w9Jye5g9eryq4RFKq
X-Google-Smtp-Source: APXvYqysxyvWoFV1hsXw8Jkg2vzZtt8Wscf4J2wj8nn/VWMlh9MEbn8dzfvU/rqOy4eKy13jsOByr26t5WOoeFH66a7eL6jBTpI/
MIME-Version: 1.0
X-Received: by 2002:a02:864b:: with SMTP id e69mr11540998jai.83.1580097663218;
 Sun, 26 Jan 2020 20:01:03 -0800 (PST)
Date:   Sun, 26 Jan 2020 20:01:03 -0800
In-Reply-To: <000000000000dd68d0059c74a1db@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ed3a48059d17277e@google.com>
Subject: Re: KASAN: slab-out-of-bounds Read in bitmap_ip_add
From:   syzbot <syzbot+f3e96783d74ee8ea9aa3@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, allison@lohutok.net,
        aryabinin@virtuozzo.com, coreteam@netfilter.org,
        davem@davemloft.net, elver@google.com, fw@strlen.de,
        gregkh@linuxfoundation.org, info@metux.net, jeremy@azazel.net,
        kadlec@netfilter.org, kstewart@linuxfoundation.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        pablo@netfilter.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this bug to:

commit 751ad98d5f881df91ba47e013b82422912381e8e
Author: Marco Elver <elver@google.com>
Date:   Fri Jul 12 03:54:00 2019 +0000

    asm-generic, x86: add bitops instrumentation for KASAN

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1287db66e00000
start commit:   244dc268 Merge tag 'drm-fixes-2020-01-19' of git://anongit..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1187db66e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1687db66e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d9290aeb7e6cf1c4
dashboard link: https://syzkaller.appspot.com/bug?extid=f3e96783d74ee8ea9aa3
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1104c495e00000

Reported-by: syzbot+f3e96783d74ee8ea9aa3@syzkaller.appspotmail.com
Fixes: 751ad98d5f88 ("asm-generic, x86: add bitops instrumentation for KASAN")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
