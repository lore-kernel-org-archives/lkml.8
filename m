Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A90F4C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 14:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73B21206F5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 14:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jWP4gYUd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbgGPOtG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 10:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbgGPOtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 10:49:05 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E3E6C061755;
        Thu, 16 Jul 2020 07:49:05 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id e8so4968370pgc.5;
        Thu, 16 Jul 2020 07:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=W2OZvJG4DPRannY7wuwhfNk5s3YNrxgm/m4qGt8i4rE=;
        b=jWP4gYUdkJ025RQx0M4uQajcNEnMl/nPvN9dVTi9eoy74Rmb6eP76LIM1wMGpfPPnK
         OvJGg5IjEzBHh3MT6h5Z2CNjs3TO7oP9wfgNgebBmFJPLhSlDqIpeAd7VcfuURuZBT2z
         qC0KDnrTAhkfI86cWWTq+/ZajfMRt0at6PrhR6Si07S/6xkiKjCzm84enuBmPyEuNObK
         wpQwZYviaX6WYIYv+QO3HVDPXOmz7mt29H4gtMwaPEdxecsDX3Pz6PSFrzbiK1FumiIp
         ldL67iaHOzfWRtdxK/T5o4zkyvwbrm9e04TT6IuZHTGN/A9qi+fbS9enIQuvAG0hCwqD
         CXaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=W2OZvJG4DPRannY7wuwhfNk5s3YNrxgm/m4qGt8i4rE=;
        b=n74WpMNU3g8UgASdZphQQCZQlMecXwyuGCJ9lEMlvFn51NZNyTiSF7UpNfN72sEPPk
         NRGymcqjwUlEyW6i35tgc9As7SqMpfitdztwy1E+PzAh2LiyjNmcmdAfKSA2ZtDgbnmC
         vQ2uwB3NLgPq05QVA90SBfBbrjPQYY+u4VwmtI1eELrBt1V7ne5zczH0Qh0LV8lnXY6J
         POYOBJ1oTOD4tNNQFq1UsZuiaKCckD/uMVlm+2ReMI3bW4qZvvFRdVY3r1DK9R1rU8GY
         wJ3iQGUi5Qpus6SD79ESuEDi90fZyCs7pMMv0PmSnGW8A+63zcZj3RKx+7ruwP9fGhzo
         w6HA==
X-Gm-Message-State: AOAM532RAB7+hLumekRFUa2fQyju+BeL/VsUtNMj++mRnJE39bNK5BbZ
        ZaBhWfDylngxsNBZt5hSGtk=
X-Google-Smtp-Source: ABdhPJzq4ajzmPpxhlpGrWRgsSPlBde/g7zwaOm5aM8RqGHr9eXRsQaVRro7Rj1L7Ntn2lsG/CPGQA==
X-Received: by 2002:a62:ae0d:: with SMTP id q13mr4051021pff.89.1594910945098;
        Thu, 16 Jul 2020 07:49:05 -0700 (PDT)
Received: from localhost.localdomain ([139.167.122.148])
        by smtp.gmail.com with ESMTPSA id s68sm347383pjb.38.2020.07.16.07.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 07:49:04 -0700 (PDT)
From:   Dhiraj Sharma <dhiraj.sharma0024@gmail.com>
To:     masahiroy@kernel.org, michal.lkml@markovi.net
Cc:     Dhiraj Sharma <dhiraj.sharma0024@gmail.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] Makefile: Add "-eudyptula" string in EXTRAVERSION
Date:   Thu, 16 Jul 2020 20:18:43 +0530
Message-Id: <20200716144843.7965-1-dhiraj.sharma0024@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am doing eudyptula assigned tasks to get selected as a mentee. I am using LDF103 course knowledge and loving it.
I used git log for Makefile and ran checkpatch.pl on my patch as to follow the same commit process guidelines. I hope you will like it.

Signed-off-by: Dhiraj Sharma <dhiraj.sharma0024@gmail.com>
Suggested-by: Little Penguin <little@eudyptula-challenge.org>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 0b5f8538bde5..d7897ce5ab23 100644
--- a/Makefile
+++ b/Makefile
@@ -2,7 +2,7 @@
 VERSION = 5
 PATCHLEVEL = 8
 SUBLEVEL = 0
-EXTRAVERSION = -rc5
+EXTRAVERSION = -rc5-eudyptula
 NAME = Kleptomaniac Octopus

 # *DOCUMENTATION*
--
2.17.1

