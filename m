Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A74C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 21:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C05C620733
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 21:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="iyLmAhYA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729076AbgC3Vx4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 17:53:56 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38717 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728944AbgC3Vx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 17:53:56 -0400
Received: by mail-ed1-f68.google.com with SMTP id e5so22713930edq.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 14:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=WEI8RlkfGwY1LJxNbmmI1m9WKvjRJF1kJKU3ZaY/CKw=;
        b=iyLmAhYAq3QvCHPOPTjRdg+bQPDaGRV5IkQc/8efr02myTRk/IvnyVH1SY2kTvCWpe
         oCZm4VndRt4SUsragb7pWRLISvsuw8BqhFWm+8Wi/7b8fmJGs4k74Mzzh90DnOhEh8aM
         hcCw08YjzCO9cjz5qDj7CRYrsE+GRl6yAeuKevBF0XeUP+GuDNyhUrg8M1OS/06nVJ1f
         c1zCFJYjI45iOKm0yf1YMopU5VGqVSZp/K6+jyiJAYGnES4wxAUsBuyby8pD50A5S/iD
         +iV1RUVs1XlDYeWuR1nSBCEIs2B78/8zmh+aqYfx3kbCUDF0CHOkVadRPZqPL0Dxpc4E
         coSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=WEI8RlkfGwY1LJxNbmmI1m9WKvjRJF1kJKU3ZaY/CKw=;
        b=Xo7h2ie4BKBLWCesMFkOhxMw+iY2+x0jLQPxX8biKdnnMVkDjb3tRRH7lVTEovH3am
         rxjaXpBp7gY3TDLiy8hGpemnZgXN262Y6CSeWtMk10dpD92qLdd9tJhjSHFTwhY89jk4
         /eeYnm7oY6dmuUDghogJC9W9IttPp1mEhXJI8q+W6DEB6EMTJhqiFSiVQbN6yHfROBtd
         y2onbQXp88KNhK/F0KxBmRs639YMyKtoeudOFQx7BTtMvcMgCavnRrRHiWKFBGdasG4J
         H8RorP8f+cs1Rk1Oovo6/BljboSM4bXWCvJJGBKS1I3RsZsVl4zvu8RMb4tAnkEQ4KmS
         dO8w==
X-Gm-Message-State: ANhLgQ1XdReizF7D0wft72txez3swYiRcAyRoX/ThKJNZ2bY74RZj0jo
        X3Q58g+rh6ENFX6X0kmG8+M6G1iB5e9fyghudYwo
X-Google-Smtp-Source: ADFU+vuKCcJSz05nRjKsDjE9wMbSUW8sIG/OSH8YlP7X3Hauzg7MzTGgYqlywxuE/mDL+sqDG7FyKSD5u5qjWMNeQ0w=
X-Received: by 2002:a17:906:7b8d:: with SMTP id s13mr12489406ejo.77.1585605234401;
 Mon, 30 Mar 2020 14:53:54 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 30 Mar 2020 17:53:45 -0400
Message-ID: <CAHC9VhS2y33mA4jnLUx_39H59JS+7wdOHPw41ffiFJFM7zgAGA@mail.gmail.com>
Subject: [GIT PULL] Audit patches for v5.7
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-audit@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

We've got two audit patches for the v5.7 merge window with a stellar
14 lines changed between the two patches.  The patch descriptions are
far more lengthy than the patches themselves, which is a very good
thing for patches this size IMHO.  The patches pass our test suites
and a quick summary is below, please merge for v5.7.

- Stop logging inode information when updating an audit file watch.
Since we are not changing the inode, or the fact that we are watching
the associated file, the inode information is just noise that we can
do without.

- Fix a problem where mandatory audit records were missing their
accompanying audit records (e.g. SYSCALL records were missing).  The
missing records often meant that we didn't have the necessary context
to understand what was going on when the event occurred.

Thanks,
-Paul

--
The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:

 Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
   tags/audit-pr-20200330

for you to fetch changes up to 1320a4052ea11eb2879eb7361da15a106a780972:

 audit: trigger accompanying records when no rules present
   (2020-03-12 10:42:51-0400)

----------------------------------------------------------------
audit/stable-5.7 PR 20200330

----------------------------------------------------------------
Richard Guy Briggs (1):
     audit: trigger accompanying records when no rules present

Steve Grubb (1):
     audit: CONFIG_CHANGE don't log internal bookkeeping as an event

kernel/audit.c       | 1 +
kernel/audit.h       | 8 ++++++++
kernel/audit_watch.c | 2 --
kernel/auditsc.c     | 3 ---
4 files changed, 9 insertions(+), 5 deletions(-)

-- 
paul moore
www.paul-moore.com
