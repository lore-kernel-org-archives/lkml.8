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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A2B1C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3592220738
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u6FAoOdh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729645AbgHCMsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 08:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728102AbgHCMYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 08:24:54 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06E8C061756;
        Mon,  3 Aug 2020 05:24:53 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id q76so14024466wme.4;
        Mon, 03 Aug 2020 05:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FTgfPSmSTzWTADmwe07r4VxKyWCszF67jRChwFwa6d0=;
        b=u6FAoOdhpkSh973rLBFaTKeH8n4xklGOCi0nZUg6UHhhx+n1Nu0+sQslo8i9Kpwwda
         Qsu1zdEupt8I17pfviRffxQXa5QCySBf74/Ryqthdl20Hjev0jV/QGV0B+QaTn+b83xy
         TKKk8VBFKZGmRIil01Ph6eO404uiUQVgDi35qrXi7YhPVChWTW1vFQOnbLAU7FjV3w81
         vSSYOJDdoIqcm0+9r/YQvC1t4NIHMsu76dx7tGcLc6q0P1bTFjSTMPnRX6R4AFjPuf0D
         zo0u0/eBeYGHppcsrNAH3F3o3FobCOFmuELI+gjj4JkpZo1ayQI/WAEl6WOlaKLUeH+M
         4TNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FTgfPSmSTzWTADmwe07r4VxKyWCszF67jRChwFwa6d0=;
        b=R/jA8Npp/e+AafIV+YXAi/O1LpTGF/uDGZCOOTJFHj2pSR5zr6IlJoXQwcST7Y630t
         PEORYHKt+9Glg5bXLzn7skgwPvaATRRXNFbjpWeX7/uL3ag+zjvwwmRLnA16bCGqb6wW
         RAFx8Kb/jEtrOJIAEBwrqltn6JdJYNnKZr3oeKld449pIiQW6+Jc94JjaGZP/rY9NXdZ
         4Iw4ZyFnlhWOEPbSrMZ4GRKw+nC3Ayg1PQhy/qpuprY/0s48gpKJrSqt2Wn3o0DGM1vl
         v5wJkczUu2GnFzc2UjT4eaqcATlKpz7yYoe2Tblhac3INxYvksMoYdMSDUys7lEjwhyc
         wD2g==
X-Gm-Message-State: AOAM533cOi2pgpQDz21ayiquZAwE0rSRsLekVWLtNaMNQWjuR4ym1x8+
        O31Ob5i1UkB3Atn1H3+zxlA9AX4YAA==
X-Google-Smtp-Source: ABdhPJzAEMNcSysSnj7Cg5pHOtKwl+m02esoSnz41MtlOdS3tmdgi1rw2q8LAZo2gFiazyGUkdO0Jg==
X-Received: by 2002:a1c:984d:: with SMTP id a74mr16567619wme.140.1596457492292;
        Mon, 03 Aug 2020 05:24:52 -0700 (PDT)
Received: from localhost.lan (host-92-25-238-49.as13285.net. [92.25.238.49])
        by smtp.gmail.com with ESMTPSA id m1sm6559050wmc.28.2020.08.03.05.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 05:24:51 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     inux-kernel@vger.kernel.org
Cc:     Jules Irenge <jbi.octave@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>,
        linux-audit@redhat.com (moderated list:AUDIT SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] audit: uninitialize variable audit_sig_sid
Date:   Mon,  3 Aug 2020 13:24:30 +0100
Message-Id: <20200803122430.82364-3-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200803122430.82364-1-jbi.octave@gmail.com>
References: <0/2>
 <20200803122430.82364-1-jbi.octave@gmail.com>
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

