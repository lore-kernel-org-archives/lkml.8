Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 923F6C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69A082054F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FxRbndga"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728975AbgHCMhL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 08:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729233AbgHCMfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 08:35:12 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53383C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 05:35:12 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id c19so3706795wmd.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 05:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FTgfPSmSTzWTADmwe07r4VxKyWCszF67jRChwFwa6d0=;
        b=FxRbndgaP5tj/cm8hMoZC0896qPXVO1mGKUVz0GMLWSoQHMdsg6tl+mEb0MZeWkrqp
         Y+dm5jgawR1Mix+erIqkh+GTIkuWlZwle72ge2xDKOPLyppmdLq6zDplTXnm6HkakMPD
         csad3upaybzdXYjWGzqFbMzDuoYG/fI+8Mfuk+N8XmQeYVA5kIuS8SDilGKHu3TgTjsP
         VwOrEUohK+ELhnukszl0LR+7bHhKofNdkg2vERN1o4hKW466+0Mhp3mueQg/1I+Ebh+B
         O9GsM630KwJu2ynE2VSN2Z+SsC+s+aqW9eGg2EPekOZcvj6/xyWMv+SMJa4MPHICIeRN
         E4hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FTgfPSmSTzWTADmwe07r4VxKyWCszF67jRChwFwa6d0=;
        b=rEHaLE8u5tISGaDuHBPOHrsh2ii7+MLZpbmm3Na4x9facjNPldX9bJqugZ5J3Kd9LA
         URTg+K9Z7N461JaZdjujhyWzXci6dIhfCnPpVX3D+PebNYT7saIxyuktkHB7zHOKZg7N
         YoGlLvJArqBDa/+oIGZtl/PXryRjgQf1dVNGYTinaKLR3gn12+DofwJILmRpRFvHl+Th
         CnnZIR474c+d5rErEdQvl/BO7bpJWHTvU9hFTrKWmokw4IT6cxJ98/X5c3GYCU13qJ4l
         BtF/2/2TpZfPWSWvatuHndXcjy0ch1pAq4yggcQh2he9x2rf1wcMwfxPxHjMBHXiwPB9
         EigA==
X-Gm-Message-State: AOAM531w1hd0tRTvfpwM/KT4olXgFQDd3aFsDGjGLuBNUMwIVXlISIz7
        TqPsWxL77/rjQh03iAiMzsFTZxUz5A==
X-Google-Smtp-Source: ABdhPJzbe6LZdfAL8EIT/Oh6YY9Xm6ZbUZUyEPTt/DKov8B61cmbhjP3GfR5BPcRyxIrZO4nqxoYSw==
X-Received: by 2002:a1c:23c4:: with SMTP id j187mr15931167wmj.58.1596458110852;
        Mon, 03 Aug 2020 05:35:10 -0700 (PDT)
Received: from localhost.lan (host-92-25-238-49.as13285.net. [92.25.238.49])
        by smtp.gmail.com with ESMTPSA id u66sm24201133wmu.37.2020.08.03.05.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 05:35:10 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jules Irenge <jbi.octave@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>,
        linux-audit@redhat.com (moderated list:AUDIT SUBSYSTEM)
Subject: [RESEND PATCH 2/2] audit: uninitialize variable audit_sig_sid
Date:   Mon,  3 Aug 2020 13:34:39 +0100
Message-Id: <20200803123439.83400-3-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200803123439.83400-1-jbi.octave@gmail.com>
References: <0/2>
 <20200803123439.83400-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checkpatch tool reports

"ERROR: do not initialise globals/statics to 0"

To fix this, audit_sig_sid is uninitialized
As this is stored in the .bss section,
the compiler can initialize the variable automatically.

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 kernel/audit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index afd7827cf6e8..1c74d1d788b6 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -125,7 +125,7 @@ static u32	audit_backlog_wait_time = AUDIT_BACKLOG_WAIT_TIME;
 /* The identity of the user shutting down the audit system. */
 static kuid_t		audit_sig_uid = INVALID_UID;
 static pid_t		audit_sig_pid = -1;
-static u32		audit_sig_sid = 0;
+static u32		audit_sig_sid;
 
 /* Records can be lost in several ways:
    0) [suppressed in audit_alloc]
-- 
2.26.2

