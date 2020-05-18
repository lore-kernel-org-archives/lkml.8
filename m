Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948BEC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 07:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 710D620829
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 07:27:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbgERH1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 03:27:19 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:43669 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbgERH1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 03:27:17 -0400
Received: by mail-il1-f199.google.com with SMTP id v14so9004343ilm.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 00:27:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=8O1WSI1r0iFN1FUDucpHKtaN3aHgzSWF0fLfdlKudj0=;
        b=AVOY11IhB04gl552dpQXbffGOkfDD7uYC9yljdiZR+R3yVWOiAwshONDR5EmGU6owp
         4ArRguVgw8nXbDUMBOQwwAUrPzhGEtFAcUahCE1f/geWMhWKOKn6C9QziZi0Z+f4UnRC
         EYmgc2FnBY0u3jgJx/O3b163RWusAC1vHn+aviKTECofHw5mLzZjW4HRtA262In+VNbL
         K3YH+DlwKJAkkV+/6tqICI3xKUPXmHhFBGrV+47H1Dw+3gbhSmvRxVw0Y5amxve0qtQy
         6iih6AfeK+lr7cQLNy8jWg8xWbDlOkaabdhHobfFDa55sZsvfG/UP3XO4ahY+y0oCTME
         yw1w==
X-Gm-Message-State: AOAM530tE668NQVya7zizmjOAAj2JfxNSAxoU0WrA/6G+ii2APUN8Val
        JsizBYD9glXvyhINk2DREgz1JLevmdz5Ad0wIOUSIPwzGKyC
X-Google-Smtp-Source: ABdhPJwnX8ub7mN+hj4i2ePVVwNft8yq+Vw8gmIX9EHO11cvymZiA5pwoLLGWQp63IMXkh+NkJZ6nkNa3FhPS6USEWc1zPLW4hUP
MIME-Version: 1.0
X-Received: by 2002:a92:8c8a:: with SMTP id s10mr14448328ill.220.1589786836835;
 Mon, 18 May 2020 00:27:16 -0700 (PDT)
Date:   Mon, 18 May 2020 00:27:16 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ada39605a5e71711@google.com>
Subject: BUG: Bad rss-counter state (4)
From:   syzbot <syzbot+347e2331d03d06ab0224@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    ac935d22 Add linux-next specific files for 20200415
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14b66e6e100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bc498783097e9019
dashboard link: https://syzkaller.appspot.com/bug?extid=347e2331d03d06ab0224
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12d18e6e100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=104170d6100000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+347e2331d03d06ab0224@syzkaller.appspotmail.com

BUG: Bad rss-counter state mm:00000000a67744c9 type:MM_ANONPAGES val:1
BUG: Bad rss-counter state mm:00000000f49d6d70 type:MM_ANONPAGES val:1
BUG: Bad rss-counter state mm:0000000006212dd2 type:MM_ANONPAGES val:1
BUG: Bad rss-counter state mm:00000000b6ae35d3 type:MM_ANONPAGES val:1
BUG: Bad rss-counter state mm:00000000d44d5c2e type:MM_ANONPAGES val:1
BUG: Bad rss-counter state mm:0000000023502204 type:MM_ANONPAGES val:1
BUG: Bad rss-counter state mm:000000001a912a5c type:MM_ANONPAGES val:1
BUG: Bad rss-counter state mm:0000000072bd9e23 type:MM_ANONPAGES val:1
BUG: Bad rss-counter state mm:0000000053ee80f7 type:MM_ANONPAGES val:1
BUG: Bad rss-counter state mm:000000003cc0aff9 type:MM_ANONPAGES val:1
BUG: Bad rss-counter state mm:000000005a4ef043 type:MM_ANONPAGES val:1
BUG: Bad rss-counter state mm:00000000fe0ab895 type:MM_ANONPAGES val:1
BUG: Bad rss-counter state mm:00000000863004ed type:MM_ANONPAGES val:1
BUG: Bad rss-counter state mm:0000000064449491 type:MM_ANONPAGES val:1
BUG: Bad rss-counter state mm:00000000f6a209ff type:MM_ANONPAGES val:1
BUG: Bad rss-counter state mm:000000008100dc4b type:MM_ANONPAGES val:1
BUG: Bad rss-counter state mm:00000000f80eb0e8 type:MM_ANONPAGES val:1
BUG: Bad rss-counter state mm:00000000475e50a5 type:MM_ANONPAGES val:1
BUG: Bad rss-counter state mm:00000000f2f5edcf type:MM_ANONPAGES val:1
BUG: Bad rss-counter state mm:00000000bf721456 type:MM_ANONPAGES val:1
BUG: Bad rss-counter state mm:00000000d8d29ec3 type:MM_ANONPAGES val:1
BUG: Bad rss-counter state mm:00000000b5dff60e type:MM_ANONPAGES val:1
BUG: Bad rss-counter state mm:000000001f0fe928 type:MM_ANONPAGES val:1
BUG: Bad rss-counter state mm:000000006fc01973 type:MM_ANONPAGES val:1


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
