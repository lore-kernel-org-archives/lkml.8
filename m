Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E47FBC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 01:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A981D2073A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 01:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgH0BLK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 21:11:10 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:53430 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbgH0BLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 21:11:09 -0400
Received: by mail-il1-f197.google.com with SMTP id o18so2944882ill.20
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 18:11:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=NYrrGTRexboki2HLW6RsbGRdLIlrj7zalnOfN9qVvpI=;
        b=gaLpRcKqK7CGeIhaVCAmmxvDRIEdfM+hw1HFvQ40z4/Z51vmu9ZkTtwdIkeuaiHoa9
         0hsS/w33PGVi+boOflz/WE2/Aq3x5+Wk3u3CSuLp9f+pH6BhNsQFpJf2M5P7BhBhOkMF
         Gud0SOrgsgC/3k2cJUtpZRwAtm33fM3fjEMD+Id3TA+goxlsUTYAD+VOxz4OlzHxpbkK
         m2h5rCVfbn//eQcHA+XKurbYH+NNeBKG72ukwRkoLrYZRKsLJR3HQFnGBBl/zQzzLJub
         gVdBVM8XXn1pfkGYeGeW6ztLp+Skjo7BYMqov58AVjLHuO37kCdF1knBtJaFeyHJAI8v
         ZluQ==
X-Gm-Message-State: AOAM530loPozI13lTbhNK79yPQlnuu6FHZhP1hcSNCeiGLOWpjtc5X3T
        rv3VuMHWynhzdv5OnokLHfYJVHhKyAu/eo1aUpqUVfGrGRE7
X-Google-Smtp-Source: ABdhPJyWTAOtjNbMelzOqWh45HRoneg/M/Ww24g1T1cgnWVaOCUqZJImsQySP/GAtqRaI/vdPOxfZixG9gO6P73jsp0D/qaAudB7
MIME-Version: 1.0
X-Received: by 2002:a92:a119:: with SMTP id v25mr16044253ili.77.1598490668571;
 Wed, 26 Aug 2020 18:11:08 -0700 (PDT)
Date:   Wed, 26 Aug 2020 18:11:08 -0700
In-Reply-To: <0000000000004740cd05ac444126@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007a21a405add19c0b@google.com>
Subject: Re: KASAN: use-after-free Write in afs_manage_cell
From:   syzbot <syzbot+f59c67285cb61166a0cf@syzkaller.appspotmail.com>
To:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-cachefs@redhat.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit c99c2171fc61476afac0dfb59fb2c447a01fb1e0
Author: David Howells <dhowells@redhat.com>
Date:   Thu Nov 1 23:07:27 2018 +0000

    afs: Use fs_context to pass parameters over automount

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10679fa9900000
start commit:   abb3438d Merge tag 'm68knommu-for-v5.9-rc3' of git://git.k..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12679fa9900000
console output: https://syzkaller.appspot.com/x/log.txt?x=14679fa9900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=891ca5711a9f1650
dashboard link: https://syzkaller.appspot.com/bug?extid=f59c67285cb61166a0cf
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10d97d46900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14eb9fa9900000

Reported-by: syzbot+f59c67285cb61166a0cf@syzkaller.appspotmail.com
Fixes: c99c2171fc61 ("afs: Use fs_context to pass parameters over automount")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
