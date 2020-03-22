Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97431C4332E
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 12:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 662582070A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 12:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="njft/1iG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgCVMHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 08:07:00 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:37340 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbgCVMG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 08:06:59 -0400
Received: by mail-vs1-f67.google.com with SMTP id o3so6917889vsd.4
        for <linux-kernel@vger.kernel.org>; Sun, 22 Mar 2020 05:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xxHKTiERPbup5hi0dDw0DZIeiYjugCccEuTfRUaZjmw=;
        b=njft/1iG8QNDBiXvXoNbGBFYpZP9uTwyhg4UrHic/QsjBUNMi7pPZ0cVVmb7HJaND/
         auRZA0qjITv6fY3F6gCTMOvWQUKDJA7iHDntCZigeSPLikLBzn1JtAuhtlA0T6KCzokO
         j0xSIC/RrNepZNr2lT53pYHtetjuNwUOOOyAVW9bhBaN5t+W9C4ywmLHZaZxiLdEyrui
         qfLUfV6CkZMSVlqe9n7htejqHk7wXkf+Kp2je6q9dlQL51y87jbyU2RPeyqD1PP/NdZp
         be5n+T0WznY9d7BsMEeziQkWdgViFPUqOeiiocicEGy91CNgS1qqTauDesVqeddlnS9r
         WNAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xxHKTiERPbup5hi0dDw0DZIeiYjugCccEuTfRUaZjmw=;
        b=m6LXVgIm0C5jSgzSgiYiM5H2MvNS0IHTazlzmVwot3chjrfYcisRKWhwcLcwXW4qxE
         9iqEFtyyLbi2uXBDvJNBlVbNUbRpYyrFPxjsLbsTlkPa9ZLgEIAFi6cbHDCzbwkI0sqD
         RDK8tI2psX1F0wFwbMEsVYGxLWR5TJvrBisGsVynqM313EHLGR0wmOBb1oQZcDHcCP35
         rgxcTEr2pA36OnGV9H+A/sv5YaYFNQ8iwKY2e/qJ+D5+Fw4jkHFTypN884j0gwdc+Qav
         J8FpjKSBAZihbtF1SaqKSIeaF7w7A8kstJmBbEBfDXjUZHEGj2JI9+XDHCzAQf1wfp3R
         E3VA==
X-Gm-Message-State: ANhLgQ0v5ELGVCVqINjQZYkYAWMFk7fQCDxww7RdbFIxraZCT57C12na
        iyjGv5L5HFRaa6MoCnS9qi5ZmJNsB0on5XwUllE=
X-Google-Smtp-Source: ADFU+vt/19Ggl5u4NLQpRHQIgo0eoLUvRbZJaKOGUIcnHhGT0tXBZwp9jWhuue0RtYYXLSoKq9K+kpxBr1TzchX13eY=
X-Received: by 2002:a67:3201:: with SMTP id y1mr12503121vsy.54.1584878818908;
 Sun, 22 Mar 2020 05:06:58 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000cbeaf705a15a9b30@google.com>
In-Reply-To: <000000000000cbeaf705a15a9b30@google.com>
From:   Qiujun Huang <anenbupt@gmail.com>
Date:   Sun, 22 Mar 2020 20:06:48 +0800
Message-ID: <CADG63jAEOBvWZ2G-9tyvHbbuKnHxNTPpqqjfWmhP7YVvsHVioQ@mail.gmail.com>
Subject: Re: KASAN: null-ptr-deref Write in get_block
To:     syzbot <syzbot+4a88b2b9dc280f47baf4@syzkaller.appspotmail.com>
Cc:     aeb@cwi.nl, danarag@gmail.com, kstewart@linuxfoundation.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Need to check the return value of sb_getblk.

Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
---
 fs/minix/itree_common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/minix/itree_common.c b/fs/minix/itree_common.c
index 043c3fd..eedd79f 100644
--- a/fs/minix/itree_common.c
+++ b/fs/minix/itree_common.c
@@ -85,6 +85,8 @@ static int alloc_branch(struct inode *inode,
  break;
  branch[n].key = cpu_to_block(nr);
  bh = sb_getblk(inode->i_sb, parent);
+ if (!bh)
+ break;
  lock_buffer(bh);
  memset(bh->b_data, 0, bh->b_size);
  branch[n].bh = bh;
--
