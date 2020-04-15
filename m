Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E74C2BA2B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 04:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89A4F20784
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 04:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393154AbgDOEzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 00:55:10 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:35754 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393136AbgDOEzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 00:55:05 -0400
Received: by mail-io1-f69.google.com with SMTP id s26so7664701ioj.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 21:55:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Y2W+RK5QX6ymnzvXaAg6rFGFyTW39IKvpdZtQG2d1eM=;
        b=Xm+IXLY/zYONSbFXdY9EOBBSz/W0NYDIK5c9qh3AUPl/crpxEEFu6edhUubKeAtGFZ
         3khz0d7d6lCt5FWLdSbxr4O9x5R5DxHweToqqoxLYvrOU9HjnOPecWP0GVAPIkK/wF7w
         f61zzlOALiKayXDkihmE/T+c6u+dK7atArWX0k3Y0WJeA4outB2KeXo15lxOF12GeyGu
         pE4X7uqahPyQPMuXUEl0xthAfcu/puuAAMwZqBJc2uWXCO4fIlSS5qoareakST6G+WJ1
         g6QmaWePdV2f4uIzwfHyFCs5yWKm7LYA2yY4sgqutLrb6KMMS5qFwk6p+cSLnaFjqJWV
         Au9A==
X-Gm-Message-State: AGi0PuZxGz1wtBCMX0IdQ5MIii5yOAFlb2bImLMUcCdINhsGUjh1Ymeq
        4UMV6p8Fo6Drg85cGYH6YcDO3uFgY9Nwitg7vgIp3y9ilsvu
X-Google-Smtp-Source: APiQypLoHsOzgEfyXKGl1uv7QMFA3G0iEexcJWQkFz/EJ2Og/YlYLQkyynZxJlWrP+PyBVAXtw3KwYrchO1YR8DpHflA85WQ9cBY
MIME-Version: 1.0
X-Received: by 2002:a05:6602:154a:: with SMTP id h10mr24660899iow.137.1586926504681;
 Tue, 14 Apr 2020 21:55:04 -0700 (PDT)
Date:   Tue, 14 Apr 2020 21:55:04 -0700
In-Reply-To: <20200415043553.GH90651@mit.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000098a5d505a34d1e48@google.com>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in
 generic_perform_write (2)
From:   syzbot <syzbot+bca9799bf129256190da@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, akpm@linux-foundation.org,
        dan.j.williams@intel.com, jack@suse.cz, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger crash:

Reported-and-tested-by: syzbot+bca9799bf129256190da@syzkaller.appspotmail.com

Tested on:

commit:         5b8b9d0c Merge branch 'akpm' (patches from Andrew)
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=23c5a352e32a1944
dashboard link: https://syzkaller.appspot.com/bug?extid=bca9799bf129256190da
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15524a00100000

Note: testing is done by a robot and is best-effort only.
