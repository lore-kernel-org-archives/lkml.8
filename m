Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C6BC4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 01:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 423DE208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 01:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="HMQOcY+c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbgB0Bu5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 20:50:57 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40701 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728091AbgB0Bu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 20:50:57 -0500
Received: by mail-ed1-f65.google.com with SMTP id p3so1260525edx.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 17:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=HEgw/5vVD4QFTc9jVVzJqQpf9a5Q3H97p6+91MGqCtQ=;
        b=HMQOcY+cn3+cR4t4V1rC6eCBXOjutUinDSIZcfV15h5Sgh+hRsixyRaCIJGjO3wohO
         p4KxR0escf+XYdyW/Ycy4IC8qgIIuHaIVZgSYI4byvdoPW0maa0ot75qOG900lbnl2PQ
         Opa7VPnRO4oFpdct25EANibVF7q0Fbaaz8Bp8gSCiF6Zl2pdnc/9D02cvPeHe2zM3uN8
         mpL9lqgVNbgOG3YX/rbv96M5/Rwgod3BRIYXCr053mWGYotVZHEzd297eFgfKbToJi2N
         E96nnqGwR8n8DoYf3HRWmGHrxoz8AkjQo1hZLZZTX1i9paPbvL1hmdEp3+amXm5TQCFd
         JPQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=HEgw/5vVD4QFTc9jVVzJqQpf9a5Q3H97p6+91MGqCtQ=;
        b=SCJwwCOO7eU2FBkelwpBt0eRb+/bRAPM+hfk/0sWXEebk8wd4WnIU1wW+oP5/6twug
         nD+8XDu8/fO4Td6bs29v5b8aqmtnV6/MSwsi71PnVmWyrZgGvL+sI2UB5+1XzqYBO2zY
         B6xVrB77y7yiB2kO5J6Wlu2Lr1xWqCkL93NIDOlB4Faz5MzpQHTOWGCtiCs14YeR2FRO
         Y8jblVAtNRiI2i86IeFjtTlL/ud4T80jM04AyJkLm7bop2q6q9DqP8UaYx+SJyMmaZXH
         xGKvq1YP2mLr2E+vln1Vp+rfC+qb0HEM5+Y66NIbkwZtfEvFBewCB7oEkSFtHjgCITS2
         QiOg==
X-Gm-Message-State: APjAAAWX9T7uam5nNg1vTpJ6hrB/9ffHPXyjc5RBpMo0/nLNGfiocEky
        CRiW+ZrBqsHgbYzkzz3cNLbrzKgk9QFdlQfzxbZ2
X-Google-Smtp-Source: APXvYqwsOqd6MVvm4O57PDlHa7osBKxW/22vVgKnbA1WKNc/rUwTveBb39RZyI73bFjbZ5zhBFK2I/5+qPzbao7EqV4=
X-Received: by 2002:a17:906:198b:: with SMTP id g11mr1410549ejd.271.1582768254942;
 Wed, 26 Feb 2020 17:50:54 -0800 (PST)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 26 Feb 2020 20:50:44 -0500
Message-ID: <CAHC9VhSL2M4QBP-_z9U-MMNUAT9G_pnJxrPcNtQs03yi7epYxQ@mail.gmail.com>
Subject: [GIT PULL] Audit fixes for v5.6 (#1)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-audit@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Two audit patches to fix problems found by syzbot, please merge for
the next v5.6-rcX release.

* Moving audit filter structure fields into a union caused some
problems in the code which populates that filter structure.  We keep
the union (that idea is a good one), but we are fixing the code so
that it doesn't needlessly set fields in the union and mess up the
error handling.

* The audit_receive_msg() function wasn't validating user input as
well as it should in all cases, we add the necessary checks.

Thanks,
-Paul

--
The following changes since commit cb5172d96d16df72db8b55146b0ec00bfd97f079:

 audit: Add __rcu annotation to RCU pointer (2019-12-09 15:19:03 -0500)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
   tags/audit-pr-20200226

for you to fetch changes up to 756125289285f6e55a03861bf4b6257aa3d19a93:

 audit: always check the netlink payload length in audit_receive_msg()
   (2020-02-24 16:38:57 -0500)

----------------------------------------------------------------
audit/stable-5.6 PR 20200226

----------------------------------------------------------------
Paul Moore (2):
     audit: fix error handling in audit_data_to_entry()
     audit: always check the netlink payload length in audit_receive_msg()

kernel/audit.c       | 40 +++++++++++++++--------------
kernel/auditfilter.c | 71 +++++++++++++++++++++++++++---------------------
2 files changed, 60 insertions(+), 51 deletions(-)

-- 
paul moore
www.paul-moore.com
