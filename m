Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B99DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 18:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4561B2067D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 18:54:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5+s2fv2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbgF3SyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 14:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727964AbgF3SyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 14:54:05 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21A2C061755;
        Tue, 30 Jun 2020 11:54:05 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 67so5738865pfg.5;
        Tue, 30 Jun 2020 11:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=jaSCX2cHIXDe/3NIJE8l/vJ0BfgRacUWWr7lL1FWFC0=;
        b=i5+s2fv2j8daMmNq+Qo21BVRmE/ZYrfLv3IJYXC4Z8I6uZJHSMzfOWMKQZYSitkBnz
         2AbCwlnjJ5kgJdkvn772l7AsjjUsv0iWTCpXm4F1uwuQqyOydYZwy+zY1oFldl3DeZFw
         agVdUd3z5u7u+LTPgWx85TaLT9cNMuCUFiPxWLMf6rxJCTQklAOuC2qpRO4v+U+kApF8
         j282mbSwxNLBt8TCaBGdpcSyxGxtBOLbWiPCxK6a7eT8pFkSRnx5ehfmQYEKq+bUkV4q
         1+bCSKY3k5s87ZD+a7/E1NkOsY0A9SdoWmTSEC/wljrdtZ7ncRDTKGjQVG3+JIFlWc2y
         OXkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jaSCX2cHIXDe/3NIJE8l/vJ0BfgRacUWWr7lL1FWFC0=;
        b=N5FuexCnjEAAh+k5/VVM8YdqoPLrwTBLz3qzWh3NpgaWR1OZNQBoyft51BfFn6JYkX
         Jl9QsaTPljIlEi7rEDrwbXBcjTDsvSmlkmAEIBVquC4K9zOrbdsIC4IuGQ21wOpW86DS
         RoBCwmCitPfh5v+hc3BuS5XDvO8Q6XM1sKJ9pNjC6Klm4M2GqT+Yl07aS992Q+pS3MYL
         7gypJj3ZR5jrTSKKBGq6EBpwLRgk89nPuOZMpljfUiASGI+0sdbbyBs2vFsaaFDkQh1I
         8zwShkfBGW6ztnPeoS5hHeXJMWu9HUwipRQ2cHixFYhPDxG79kPVKU4wrkBCpYNWz9nS
         dIkQ==
X-Gm-Message-State: AOAM5326uT3fcbRCacxC8ObMIZhbDL2r3WNJTIno04VPz1YSvLZLe7iW
        Ob08HrbK+PTKHjbqiZmikdw=
X-Google-Smtp-Source: ABdhPJyelGFUvPwAg7nmV1K7tug8dp9jh5zbeSjhfl6w4plbwTUGNccG6cF3nQv9ypnfAyilSzcnPQ==
X-Received: by 2002:a63:b30f:: with SMTP id i15mr16476143pgf.42.1593543245547;
        Tue, 30 Jun 2020 11:54:05 -0700 (PDT)
Received: from ubuntu.localdomain (61-216-143-21.HINET-IP.hinet.net. [61.216.143.21])
        by smtp.googlemail.com with ESMTPSA id y27sm3492438pgc.56.2020.06.30.11.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 11:54:05 -0700 (PDT)
From:   Manbing <manbing3@gmail.com>
Cc:     manbing3@gmail.com, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] trace doc: fix typo of trace/ftrace.rst
Date:   Tue, 30 Jun 2020 11:53:55 -0700
Message-Id: <20200630185356.3467-1-manbing3@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some documents was converted from the plain text documentation
to reStructuredText format.

Signed-off-by: Manbing <manbing3@gmail.com>
---
 Documentation/trace/ftrace.rst | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index 430a16283103..0b479243b903 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -34,7 +34,7 @@ Throughout the kernel is hundreds of static event points that
 can be enabled via the tracefs file system to see what is
 going on in certain parts of the kernel.
 
-See events.txt for more information.
+See events.rst for more information.
 
 
 Implementation Details
@@ -376,11 +376,11 @@ of ftrace. Here is a list of some of the key files:
 
   kprobe_events:
 
-	Enable dynamic trace points. See kprobetrace.txt.
+	Enable dynamic trace points. See kprobetrace.rst.
 
   kprobe_profile:
 
-	Dynamic trace points stats. See kprobetrace.txt.
+	Dynamic trace points stats. See kprobetrace.rst.
 
   max_graph_depth:
 
@@ -568,7 +568,7 @@ of ftrace. Here is a list of some of the key files:
   uprobe_events:
 
 	Add dynamic tracepoints in programs.
-	See uprobetracer.txt
+	See uprobetracer.rst
 
   uprobe_profile:
 
@@ -589,19 +589,19 @@ of ftrace. Here is a list of some of the key files:
 	files at various levels that can enable the tracepoints
 	when a "1" is written to them.
 
-	See events.txt for more information.
+	See events.rst for more information.
 
   set_event:
 
 	By echoing in the event into this file, will enable that event.
 
-	See events.txt for more information.
+	See events.rst for more information.
 
   available_events:
 
 	A list of events that can be enabled in tracing.
 
-	See events.txt for more information.
+	See events.rst for more information.
 
   timestamp_mode:
 
-- 
2.17.1

