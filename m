Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0214BC433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 18:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFD582072A
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 18:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MSy4t9aB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbgHASqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Aug 2020 14:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbgHASqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 14:46:38 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27334C06174A
        for <linux-kernel@vger.kernel.org>; Sat,  1 Aug 2020 11:46:38 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id q76so10788071wme.4
        for <linux-kernel@vger.kernel.org>; Sat, 01 Aug 2020 11:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PvnrBlZrpRslY4PpmEHw5xhWUfLd5lVP4jPMRcGfwzE=;
        b=MSy4t9aBkRohIC/HXlbwk8C/iETgAgFR2FotTeQqf7LYl9jfCLLcOrupiK7Rpzyh0Y
         n1Bd9wiDkSRMp/Bh5KwgN2sI0AEcNgMDrbuhU78i7Jv019Ma+VA4hrWRfC9JGVOkOqzX
         frHiG3VFvmDFVy3DHijgc7ZR6vwgzemubRaR0gIPh6iS8KbPaGfDgr0SGVFdvMs8hCxY
         mOFtrbzwlNhsUxNsm3NQY6Rj3jfDB0UHCT6x+ifxA8IXj+/MfgiIM0fhXYSNykEBU8an
         jA3oQO6XPLDtLO2JgoJYjvP/CbNFGO1Pxd7vvZGzJZaShWhh3Y1WQ+rz5dg6eTHuVLdl
         PPlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PvnrBlZrpRslY4PpmEHw5xhWUfLd5lVP4jPMRcGfwzE=;
        b=Yb2Y73w7uTdh+IM6U2Tr/EAFr1G19RWlThMDdBT3ue2yND/m7gjFwsoO3RmaC/eux3
         YBit17Jba86m7125fWQ8VGBGbo4WEdJL9lkriTONz6kCQH6KgdG6Zw363iwnpQfdOaZ+
         6+l9rW9KF2E5DvOkDxCzHV2FUUj9q4xanr8erHfaxf3iF/c2qYmAVV80LdrzTv8/fFIz
         3jwOKznsRSugC8CN21o902glbb5GNU9aqgInoWUs/z9flmB6EiXO4x+4e6Fhwp64zirp
         /63HfLUZQaC2i13+v5AvkVda4wYMGzXM9Epu6NstVJo+6lo/n6OXmTiClDezfsrsBoMi
         v4yA==
X-Gm-Message-State: AOAM530VK5nDVpX3GY376oXexIwQyhL5E1cz2W9+wRLR+3l7boz/pSWo
        JBdHZfHrk/2XpCXQtS5Aei4sD9Kf9Aap
X-Google-Smtp-Source: ABdhPJzf9LDaS8QS+PG8yGVerZ9n0pnm84BAInexjKqKIMk2EKvw/ypxB0jO93mXt95a26klGwF1Ig==
X-Received: by 2002:a1c:750a:: with SMTP id o10mr9282009wmc.165.1596307596610;
        Sat, 01 Aug 2020 11:46:36 -0700 (PDT)
Received: from localhost.lan (host-92-25-238-49.as13285.net. [92.25.238.49])
        by smtp.gmail.com with ESMTPSA id g7sm17468447wrv.82.2020.08.01.11.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2020 11:46:36 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jules Irenge <jbi.octave@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>,
        linux-audit@redhat.com (moderated list:AUDIT SUBSYSTEM)
Subject: [PATCH 2/4] audit: uninitialize global variable audit_sig_sid
Date:   Sat,  1 Aug 2020 19:46:01 +0100
Message-Id: <20200801184603.310769-3-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200801184603.310769-1-jbi.octave@gmail.com>
References: <0/4>
 <20200801184603.310769-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checkpatch tool reports an error at variable audit_sig_sid declaration

"ERROR: do not initialise globals to 0"

To fix this, the global variable has been uninitialized.

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 kernel/audit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index 8c201f414226..7b1a38a211a9 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -125,7 +125,7 @@ static u32	audit_backlog_wait_time = AUDIT_BACKLOG_WAIT_TIME;
 /* The identity of the user shutting down the audit system. */
 kuid_t		audit_sig_uid = INVALID_UID;
 pid_t		audit_sig_pid = -1;
-u32		audit_sig_sid = 0;
+u32		audit_sig_sid;
 
 /* Records can be lost in several ways:
    0) [suppressed in audit_alloc]
-- 
2.26.2

