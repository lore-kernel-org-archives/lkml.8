Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CBA7C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 20:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C5C224679
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 20:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="rjrZyBBq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbgA0UdR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 15:33:17 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40902 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgA0UdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 15:33:17 -0500
Received: by mail-ed1-f66.google.com with SMTP id p3so10434320edx.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 12:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=dEVQQBZ4iTYdQIjstHziIMop+sy3GzjT/sdtf1Lx2G4=;
        b=rjrZyBBqFmeRybNHcQ8nJSLGzHw9Mif1z3KYN+1rVNnaU1Dl7A0VlkGCdKRKADcUN8
         caggBCH0SW6pb3YkZQP75PjhiIEz2qCuEiuwMEvJ6wFyzurGsuSsjBXcyMIEZF3BHS0R
         P2rwwQ+jf2VjwYQp3Mp3Ggg5VQHPy57mxsj7uYQfBbW5/LrtV2LQem+nIJsYD2hfAx3A
         TOrDNqqMUmR2yem15IAr3iPc332THF4u8AKL7n+joXUQEW8zn8eUO10LUsFdTVkE/Wf3
         eGwWq8gIRNgENYrQumdViWgE5kZW0jKJmkmsoiBEZxM1DsXIIWHESOv9kBq71LsCaZMs
         Xdtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=dEVQQBZ4iTYdQIjstHziIMop+sy3GzjT/sdtf1Lx2G4=;
        b=WV9fjAWLyFOFumCaKidbAF/VSVD6Zlb0Lw5BZq6sBzMDrpd5ZOked6ZEXsjnh/P5lz
         xooq5Ksy5vXEM1srMOZwiMcuji0gi6eHbQiuKq9oKpBbNhvRhEvXwQH5fIGFcCPABU3E
         /EvMLsa67G9mFb+V4D8QN2GQDomH4TnLH3JiIn6oWbqBzUKsqJR0zgYMG0M13tfJKVlE
         /ftluBeeTYDFRvmaDBQBj12QbDqgL8S7S14umzDEPGL0VFqUx0TgVhz23xRQTEDFt8HL
         0zs5GFOMEe4GsAOaYZN92JPZWkcbwM/WltfpWalXdioL9LYteYeux7BwzqrZ3g4GGhpP
         MqPw==
X-Gm-Message-State: APjAAAVj+W6uIPFnEsHe6gZ0t+75YD8v9b8Btfx+G0X6iDJXFt9bA5Fe
        FfXY9WouSaDX4q4QuYUOoeXVnZeA3Fb8+z7vSwsk
X-Google-Smtp-Source: APXvYqyjOgNl/c9yixRA7xgRUSiMq5N0amWowrz3+VD4I8riDv2I6jMSb+8HRzixXT8AUuubV/L4e+GVyOqhQfKb4W4=
X-Received: by 2002:a17:906:c299:: with SMTP id r25mr388723ejz.272.1580157195274;
 Mon, 27 Jan 2020 12:33:15 -0800 (PST)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 27 Jan 2020 15:33:04 -0500
Message-ID: <CAHC9VhRm1dAsc+_eH7iKj4C6RVdzYeZLLqShcOjvMMbEaB4VQA@mail.gmail.com>
Subject: [GIT PULL] Audit patch for v5.6
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-audit@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

One small audit patch for the Linux v5.6 merge window, and
unsurprisingly it passes our test suite with flying colors.  Please
merge.

Thanks,
-Paul

--
The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:

 Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
   tags/audit-pr-20200127

for you to fetch changes up to cb5172d96d16df72db8b55146b0ec00bfd97f079:

 audit: Add __rcu annotation to RCU pointer (2019-12-09 15:19:03 -0500)

----------------------------------------------------------------
audit/stable-5.6 PR 20200127

----------------------------------------------------------------
Amol Grover (1):
     audit: Add __rcu annotation to RCU pointer

kernel/audit.c | 5 +++--
1 file changed, 3 insertions(+), 2 deletions(-)

-- 
paul moore
www.paul-moore.com
