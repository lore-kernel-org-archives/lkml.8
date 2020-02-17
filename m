Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3CE2C3B1BF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 00:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF9F320726
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 00:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKKlq9b5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgBQAIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 19:08:35 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41342 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgBQAIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 19:08:35 -0500
Received: by mail-qt1-f195.google.com with SMTP id l21so10910777qtr.8;
        Sun, 16 Feb 2020 16:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pnWJqbPgIe4l8M7Sn+HBmagN0oFNcHyqYUcxWkGwJ7Y=;
        b=eKKlq9b5Dbymz+22rhK32GcI88cRqIDvWZmHbz7cMNkuHuqV8cKl9E9sNf+7rvSQ46
         ZtHf+UGBPekeyiLdDzJl2mATjrfH0rUNzS4mzuptjamAzmAvr9B2FhpiPwsOvUhUf79z
         +LVMs11VMqb3bldX84ai/rHd8JFCMLcFAPVlMbEya61aH9H8PxKrEphUTPwFQdbvFgfl
         TxNyR2NyeymcpkiWEwxu4aA8p+gvm94KQBeI+0k7WqWrVC/4nnQeGx8KdczahMzxr16D
         FbxXniWDS0YCJzmjHfVmGKEoSrYREuOFhXLul+run4cYeItO2GPASzfL1cDqP00aE6la
         UhnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pnWJqbPgIe4l8M7Sn+HBmagN0oFNcHyqYUcxWkGwJ7Y=;
        b=a+MiWi+CaW17tzBWF8bmYh3QPOM4e0U6vkvOoE6NoM9JYnGxqcMOc9FbjXIb2RI5iF
         he2hqTNdYCYJrfG1J3FVNdZwFimnRF6gmi8TF59zzVPmguf+ZAaqJ2LkuB7m2K3kBVax
         TAPYZqQ2e4VN6PNSrlEygxjuxUb78UXf1oRqMxysKEbl0BOAFd7sD6qptqJmiZsS6WT6
         VjTgVL8lAXjdTUyozs8LQp3YuWvZhHhEHZL8xLPtFJGYn9gOP7iYkbPYPfzAVSQF+j7O
         tFfyfXATMZ/J/vetM63tbdfhVFglsuoGgDkaz2Y39IaugeY4LrwNHFb+s0HhbCRFElWj
         KoJg==
X-Gm-Message-State: APjAAAVp9QRH25LsTo4ZYwb4CcKu2PZrJ3Pow+14991a7DTAY2YnHP3w
        kI+xFy7dAC5W/qah6VKMWScLBBSi
X-Google-Smtp-Source: APXvYqxaifKAIhKN14gs4uqG+TRGPGG2fKd7NiMsl7GKT/nmnNLrNOKSjeh5v3IznNTmO31PIQ6Qtw==
X-Received: by 2002:ac8:4616:: with SMTP id p22mr11406800qtn.368.1581898113390;
        Sun, 16 Feb 2020 16:08:33 -0800 (PST)
Received: from tony-macbook.lan1 ([2604:2000:1303:4c81:3508:12d4:7da8:3e97])
        by smtp.gmail.com with ESMTPSA id j58sm7831838qtk.27.2020.02.16.16.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2020 16:08:32 -0800 (PST)
From:   Tony Fischetti <tony.fischetti@gmail.com>
To:     corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tony Fischetti <tony.fischetti@gmail.com>
Subject: [PATCH] Documentation: bring process docs up to date
Date:   Sun, 16 Feb 2020 19:08:26 -0500
Message-Id: <20200217000826.55767-1-tony.fischetti@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The guide to the kernel dev process documentation, for example, contains
references to older kernels and their timelines. In addition, one of the
"long term support kernels" listed have since reached EOL, and a new one
has been named. This patch brings information/tables up to date.

Additionally, some very trivial grammatical errors, unclear sentences,
and potentially unsavory diction have been edited.

Signed-off-by: Tony Fischetti <tony.fischetti@gmail.com>
---
 Documentation/process/2.Process.rst    | 108 +++++++++++++------------
 Documentation/process/coding-style.rst |  18 ++---
 Documentation/process/howto.rst        |  17 ++--
 3 files changed, 73 insertions(+), 70 deletions(-)

diff --git a/Documentation/process/2.Process.rst b/Documentation/process/2.Process.rst
index ae020d84d7c46..b21b5b245d138 100644
--- a/Documentation/process/2.Process.rst
+++ b/Documentation/process/2.Process.rst
@@ -18,18 +18,18 @@ major kernel release happening every two or three months.  The recent
 release history looks like this:
 
 	======  =================
-	4.11	April 30, 2017
-	4.12	July 2, 2017
-	4.13	September 3, 2017
-	4.14	November 12, 2017
-	4.15	January 28, 2018
-	4.16	April 1, 2018
+	5.0	March 3, 2019
+	5.1	May 5, 2019
+	5.2	July 7, 2019
+	5.3	September 15, 2019
+	5.4	November 24, 2019
+	5.5	January 6, 2020
 	======  =================
 
-Every 4.x release is a major kernel release with new features, internal
-API changes, and more.  A typical 4.x release contain about 13,000
-changesets with changes to several hundred thousand lines of code.  4.x is
-thus the leading edge of Linux kernel development; the kernel uses a
+Every 5.x release is a major kernel release with new features, internal
+API changes, and more.  A typical release can contain about 13,000
+changesets with changes to several hundred thousand lines of code.  5.x is
+the leading edge of Linux kernel development; the kernel uses a
 rolling development model which is continually integrating major changes.
 
 A relatively straightforward discipline is followed with regard to the
@@ -48,9 +48,9 @@ detail later on).
 
 The merge window lasts for approximately two weeks.  At the end of this
 time, Linus Torvalds will declare that the window is closed and release the
-first of the "rc" kernels.  For the kernel which is destined to be 2.6.40,
+first of the "rc" kernels.  For the kernel which is destined to be 5.6,
 for example, the release which happens at the end of the merge window will
-be called 2.6.40-rc1.  The -rc1 release is the signal that the time to
+be called 5.6-rc1.  The -rc1 release is the signal that the time to
 merge new features has passed, and that the time to stabilize the next
 kernel has begun.
 
@@ -67,22 +67,23 @@ add at any time).
 As fixes make their way into the mainline, the patch rate will slow over
 time.  Linus releases new -rc kernels about once a week; a normal series
 will get up to somewhere between -rc6 and -rc9 before the kernel is
-considered to be sufficiently stable and the final 2.6.x release is made.
+considered to be sufficiently stable and the final release is made.
 At that point the whole process starts over again.
 
-As an example, here is how the 4.16 development cycle went (all dates in
-2018):
+As an example, here is how the 5.4 development cycle went (all dates in
+2019):
 
 	==============  ===============================
-	January 28	4.15 stable release
-	February 11	4.16-rc1, merge window closes
-	February 18	4.16-rc2
-	February 25	4.16-rc3
-	March 4		4.16-rc4
-	March 11	4.16-rc5
-	March 18	4.16-rc6
-	March 25	4.16-rc7
-	April 1		4.16 stable release
+	September 15	5.3 stable release
+	September 30	5.4-rc1, merge window closes
+	October 6	5.4-rc2
+	October 13	5.4-rc3
+	October 20	5.4-rc4
+	October 27	5.4-rc5
+	November 3	5.4-rc6
+	November 10	5.4-rc7
+	November 17	5.4-rc8
+	November 24	5.4 stable release
 	==============  ===============================
 
 How do the developers decide when to close the development cycle and create
@@ -98,43 +99,44 @@ release is made.  In the real world, this kind of perfection is hard to
 achieve; there are just too many variables in a project of this size.
 There comes a point where delaying the final release just makes the problem
 worse; the pile of changes waiting for the next merge window will grow
-larger, creating even more regressions the next time around.  So most 4.x
+larger, creating even more regressions the next time around.  So most 5.x
 kernels go out with a handful of known regressions though, hopefully, none
 of them are serious.
 
 Once a stable release is made, its ongoing maintenance is passed off to the
-"stable team," currently consisting of Greg Kroah-Hartman.  The stable team
-will release occasional updates to the stable release using the 4.x.y
-numbering scheme.  To be considered for an update release, a patch must (1)
-fix a significant bug, and (2) already be merged into the mainline for the
-next development kernel.  Kernels will typically receive stable updates for
-a little more than one development cycle past their initial release.  So,
-for example, the 4.13 kernel's history looked like:
+"stable team," currently Greg Kroah-Hartman. The stable team will release
+occasional updates to the stable release using the 5.x.y numbering scheme.
+To be considered for an update release, a patch must (1) fix a significant
+bug, and (2) already be merged into the mainline for the next development
+kernel. Kernels will typically receive stable updates for a little more
+than one development cycle past their initial release. So, for example, the
+5.2 kernel's history looked like this (all dates in 2019):
 
 	==============  ===============================
-	September 3 	4.13 stable release
-	September 13	4.13.1
-	September 20	4.13.2
-	September 27	4.13.3
-	October 5	4.13.4
-	October 12  	4.13.5
+	September 15 	5.2 stable release
+	July 14		5.2.1
+	July 21		5.2.2
+	July 26		5.2.3
+	July 28		5.2.4
+	July 31  	5.2.5
 	...		...
-	November 24	4.13.16
+	October 11	5.2.21
 	==============  ===============================
 
-4.13.16 was the final stable update of the 4.13 release.
+5.2.21 was the final stable update of the 5.2 release.
 
 Some kernels are designated "long term" kernels; they will receive support
 for a longer period.  As of this writing, the current long term kernels
 and their maintainers are:
 
-	======  ======================  ==============================
-	3.16	Ben Hutchings		(very long-term stable kernel)
-	4.1	Sasha Levin
-	4.4	Greg Kroah-Hartman	(very long-term stable kernel)
-	4.9	Greg Kroah-Hartman
-	4.14	Greg Kroah-Hartman
-	======  ======================  ==============================
+	======  ================================	=======================
+	3.16	Ben Hutchings				(very long-term kernel)
+	4.4	Greg Kroah-Hartman & Sasha Levin	(very long-term kernel)
+	4.9	Greg Kroah-Hartman & Sasha Levin
+	4.14	Greg Kroah-Hartman & Sasha Levin
+	4.19	Greg Kroah-Hartman & Sasha Levin
+	5.4	Greg Kroah-Hartman & Sasha Levin
+	======  ================================	=======================
 
 The selection of a kernel for long-term support is purely a matter of a
 maintainer having the need and the time to maintain that release.  There
@@ -215,12 +217,12 @@ How patches get into the Kernel
 -------------------------------
 
 There is exactly one person who can merge patches into the mainline kernel
-repository: Linus Torvalds.  But, of the over 9,500 patches which went
-into the 2.6.38 kernel, only 112 (around 1.3%) were directly chosen by Linus
-himself.  The kernel project has long since grown to a size where no single
-developer could possibly inspect and select every patch unassisted.  The
-way the kernel developers have addressed this growth is through the use of
-a lieutenant system built around a chain of trust.
+repository: Linus Torvalds. But, for example, of the over 9,500 patches
+which went into the 2.6.38 kernel, only 112 (around 1.3%) were directly
+chosen by Linus himself. The kernel project has long since grown to a size
+where no single developer could possibly inspect and select every patch
+unassisted. The way the kernel developers have addressed this growth is
+through the use of a lieutenant system built around a chain of trust.
 
 The kernel code base is logically broken down into a set of subsystems:
 networking, specific architecture support, memory management, video
diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
index edb296c52f61e..acb2f1b36350f 100644
--- a/Documentation/process/coding-style.rst
+++ b/Documentation/process/coding-style.rst
@@ -284,9 +284,9 @@ context lines.
 4) Naming
 ---------
 
-C is a Spartan language, and so should your naming be.  Unlike Modula-2
-and Pascal programmers, C programmers do not use cute names like
-ThisVariableIsATemporaryCounter.  A C programmer would call that
+C is a Spartan language, and your naming conventions should follow suit.
+Unlike Modula-2 and Pascal programmers, C programmers do not use cute
+names like ThisVariableIsATemporaryCounter. A C programmer would call that
 variable ``tmp``, which is much easier to write, and not the least more
 difficult to understand.
 
@@ -300,9 +300,9 @@ that counts the number of active users, you should call that
 ``count_active_users()`` or similar, you should **not** call it ``cntusr()``.
 
 Encoding the type of a function into the name (so-called Hungarian
-notation) is brain damaged - the compiler knows the types anyway and can
-check those, and it only confuses the programmer.  No wonder MicroSoft
-makes buggy programs.
+notation) is asinine - the compiler knows the types anyway and can check
+those, and it only confuses the programmer. No wonder Microsoft makes buggy
+programs.
 
 LOCAL variable names should be short, and to the point.  If you have
 some random integer loop counter, it should probably be called ``i``.
@@ -806,9 +806,9 @@ covers RTL which is used frequently with assembly language in the kernel.
 ----------------------------
 
 Kernel developers like to be seen as literate. Do mind the spelling
-of kernel messages to make a good impression. Do not use crippled
-words like ``dont``; use ``do not`` or ``don't`` instead.  Make the messages
-concise, clear, and unambiguous.
+of kernel messages to make a good impression. Do not use incorrect
+contractions like ``dont``; use ``do not`` or ``don't`` instead. Make the
+messages concise, clear, and unambiguous.
 
 Kernel messages do not have to be terminated with a period.
 
diff --git a/Documentation/process/howto.rst b/Documentation/process/howto.rst
index b6f5a379ad6cb..70791e153de1d 100644
--- a/Documentation/process/howto.rst
+++ b/Documentation/process/howto.rst
@@ -243,10 +243,10 @@ branches.  These different branches are:
 Mainline tree
 ~~~~~~~~~~~~~
 
-Mainline tree are maintained by Linus Torvalds, and can be found at
+The mainline tree is maintained by Linus Torvalds, and can be found at
 https://kernel.org or in the repo.  Its development process is as follows:
 
-  - As soon as a new kernel is released a two weeks window is open,
+  - As soon as a new kernel is released a two week window is open,
     during this period of time maintainers can submit big diffs to
     Linus, usually the patches that have already been included in the
     linux-next for a few weeks.  The preferred way to submit big changes
@@ -281,8 +281,9 @@ Various stable trees with multiple major numbers
 
 Kernels with 3-part versions are -stable kernels. They contain
 relatively small and critical fixes for security problems or significant
-regressions discovered in a given major mainline release, with the first
-2-part of version number are the same correspondingly.
+regressions discovered in a given major mainline release. Each release
+in a major stable series increments the third part of the version
+number, keeping the first two parts the same.
 
 This is the recommended branch for users who want the most recent stable
 kernel and are not interested in helping test development/experimental
@@ -359,10 +360,10 @@ Managing bug reports
 
 One of the best ways to put into practice your hacking skills is by fixing
 bugs reported by other people. Not only you will help to make the kernel
-more stable, you'll learn to fix real world problems and you will improve
-your skills, and other developers will be aware of your presence. Fixing
-bugs is one of the best ways to get merits among other developers, because
-not many people like wasting time fixing other people's bugs.
+more stable, but you'll also learn to fix real world problems and you will
+improve your skills, and other developers will be aware of your presence.
+Fixing bugs is one of the best ways to get merits among other developers,
+because not many people like wasting time fixing other people's bugs.
 
 To work in the already reported bug reports, go to https://bugzilla.kernel.org.
 
-- 
2.25.0

