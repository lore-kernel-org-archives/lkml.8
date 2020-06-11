Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A512DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 05:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C5E02074B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 05:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cCQPH702"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbgFKFhe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 01:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgFKFhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 01:37:33 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5373DC08C5C1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 22:37:33 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id d128so3781383wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 22:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=tF510AlbcUE6tq4ktArBowJC1gEM9p0c32UAoE8MTdA=;
        b=cCQPH702LQIzMamek2cP15P+xs8XaUgSnbWJuJiP34/yrGctLlcDNvbJIQojKNXaAP
         MtTXsW+/EObHkfcAbqNzUI1Dmekyz4aEQQ4zVTg7tHSSAHndZOXMmlgeJ/u9thA+aOIN
         eK2C5FaHwv3kWtRoM93JGPdhApyKLjw2Sp9qo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tF510AlbcUE6tq4ktArBowJC1gEM9p0c32UAoE8MTdA=;
        b=OIPXqjj4UknmDmL2g162KVcVXMH6gDGuWKEPrU0TLEQMcRHJom3txzK2tvkEafpHhn
         VRF6rBdDgKA+52c4Acejyx8aBb+9LYB23kKqcTAT6mmDhpZwzmQ8mX8grGZ9XWtnAITx
         wETbAeGcTLY6SmJE53fQIaYNa5EvHtxXZP4ici4ED7vtUy3u89HiakHecu+uGLSWu1pj
         C87vbffHoVsPPAVbnuI5zL/97WWFPm30JxTGTTKBd3UkPzN6k7emEeGjFmANQDEGOJS2
         H6ood+0oIh1Edo31p5luzYyBJmPfPhqq1wdlZoiiQx/HVuHaz4ioHgOKzjNwarZP4sVX
         2Z1w==
X-Gm-Message-State: AOAM530ZgLlWTLXdad50BvmuIxl4F3RLvCH+1PLVFc7FQh5HMeO2ggtL
        Bflej+9k7nfCVvreAWorUp5LdA==
X-Google-Smtp-Source: ABdhPJz9IO0DDxEeXYiTYwfzGB4d0fgQflR6zt+2Inh0a5aSkMb++/25aHOApH3vj2MB2eba8T+llQ==
X-Received: by 2002:a1c:6a1a:: with SMTP id f26mr6510830wmc.80.1591853851364;
        Wed, 10 Jun 2020 22:37:31 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id 50sm3328214wra.1.2020.06.10.22.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 22:37:30 -0700 (PDT)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
Cc:     BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-kernel@vger.kernel.org,
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH v2 1/1] checkpatch: add check for NONNETWORKING_BLOCK_COMMENT_STYLE
Date:   Wed, 10 Jun 2020 22:37:19 -0700
Message-Id: <20200611053719.17092-1-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NETWORKING_BLOCK_COMMENT_STYLE is supported by checkpatch but there
doesn't seem to be any check for the standard block comment style.
Add support for NONNETWORKING_BLOCK_COMMENT_STYLE to check for empty /*
on first line of non-networking block comments.

Signed-off-by: Scott Branden <scott.branden@broadcom.com>

---
Changes since v1:
-----------------
Do file/patch test and used CHK on file as suggested by Joe Perches.
---
 scripts/checkpatch.pl | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index d4860972c721..45c71e7543f7 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3408,6 +3408,18 @@ sub process {
 			     "networking block comments don't use an empty /* line, use /* Comment...\n" . $hereprev);
 		}
 
+# Non-Networking with an empty initial /*
+		if ($realfile !~ m@^(drivers/net/|net/)@ &&
+		    $prevrawline =~ /^\+[ \t]*\/\*[ \t]/ &&
+		    $prevrawline !~ /\*\/[ \t]*$/ &&		#no trailing */
+		    $rawline =~ /^\+[ \t]*\*/ &&
+		    $realline > 2) {
+			my $msg_level = \&WARN;
+			$msg_level = \&CHK if ($file);
+			&{$msg_level}("NONNETWORKING_BLOCK_COMMENT_STYLE",
+				      "non-networking block comments use an empty /* on first line\n" . $hereprev);
+		}
+
 # Block comments use * on subsequent lines
 		if ($prevline =~ /$;[ \t]*$/ &&			#ends in comment
 		    $prevrawline =~ /^\+.*?\/\*/ &&		#starting /*
-- 
2.17.1

