Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D0DFC54EEB
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 02:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEEEA20836
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 02:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbgCXCrE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 22:47:04 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:34488 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbgCXCrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 22:47:04 -0400
Received: by mail-io1-f70.google.com with SMTP id n26so13762004iop.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 19:47:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=LOv2WyxOQNJMMiel1AjLpQJL3nLG4+bZfZZebAkOi9k=;
        b=M2T59pDtmOc5UydVdnoAMTgaXYW9Q358cNleNGWqJ8PNSG2etBJpaq6b8t9s/cT7I7
         GwNnuVdhmxAGeSyDAvpQ+Qx41tCD4WFG3olG5x2Wl0ly0dPpjgAw+vap1BUipkg0hVNv
         I7V9udGhUWwQa6qXYDffos/kO3Me7clAld3GnNdr3Jb59yCRM5fu7x7IChmUDUkqqi/5
         ZxAvHuCi8cezGjCJQ4cRMwepb8oizMbQE/7IP04ccpROKzpMScSdBpseDX6brG4j+8Tf
         5qwNWfokgajGHhI038GyOD4m2VDrkncBsWMcFreLhob51xo6roiuwjwgBO/ddhgXTkKI
         LPWQ==
X-Gm-Message-State: ANhLgQ3SynH1D5CjuashEzFcG2m19+pqeVdg54M7MBbq30d6IHDm3z6X
        UUjNiWDk2FyLgYdjn5ELC66LCry/eI2qgSBWtWyJQNZ3fy9G
X-Google-Smtp-Source: ADFU+vstiI7NkY8P0sLiaAwA1tlgY+DAUVfkvxxrtQc1GUcIriiMD4ZAGZsTUHBhY7pwHk2p3ulODfmE2r7ZpymGWtd3GqW4WeUB
MIME-Version: 1.0
X-Received: by 2002:a02:6cd5:: with SMTP id w204mr22866930jab.43.1585018023533;
 Mon, 23 Mar 2020 19:47:03 -0700 (PDT)
Date:   Mon, 23 Mar 2020 19:47:03 -0700
In-Reply-To: <000000000000a6f2030598bbe38c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004162e805a190c456@google.com>
Subject: Re: WARNING in wp_page_copy
From:   syzbot <syzbot+9301f2f33873407d5b33@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, andriin@fb.com, ast@kernel.org,
        bjorn.topel@intel.com, bpf@vger.kernel.org,
        catalin.marinas@arm.com, daniel@iogearbox.net, davem@davemloft.net,
        hawk@kernel.org, jakub.kicinski@netronome.com, jmoyer@redhat.com,
        john.fastabend@gmail.com, jonathan.lemon@gmail.com,
        justin.he@arm.com, kafai@fb.com, kirill.shutemov@linux.intel.com,
        kirill@shutemov.name, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, magnus.karlsson@gmail.com,
        magnus.karlsson@intel.com, netdev@vger.kernel.org,
        songliubraving@fb.com, syzkaller-bugs@googlegroups.com,
        torvalds@linux-foundation.org, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit c3e5ea6ee574ae5e845a40ac8198de1fb63bb3ab
Author: Kirill A. Shutemov <kirill@shutemov.name>
Date:   Fri Mar 6 06:28:32 2020 +0000

    mm: avoid data corruption on CoW fault into PFN-mapped VMA

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1170c813e00000
start commit:   e31736d9 Merge tag 'nios2-v5.5-rc2' of git://git.kernel.or..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=79f79de2a27d3e3d
dashboard link: https://syzkaller.appspot.com/bug?extid=9301f2f33873407d5b33
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10fd9fb1e00000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: mm: avoid data corruption on CoW fault into PFN-mapped VMA

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
