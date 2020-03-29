Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FORGED_MSGID_YAHOO,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F37EEC43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 22:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C391820733
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 22:57:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IhfXMK9h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbgC2W5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 18:57:33 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36388 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728619AbgC2W5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 18:57:33 -0400
Received: by mail-wm1-f66.google.com with SMTP id g62so19579444wme.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Mar 2020 15:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=QsgCSsuB4Lh94wSfvpEuEtMRFjpl1/aOPTILb/nR+i0=;
        b=IhfXMK9hkySJimYQVmic2APBwnthiNPncKeida0LhLJ4Lbse8jveY4CiKmXpDPLvnK
         24xKX4ygUsB4d2eSIWHCzc26N9GFGHVQJIIuASI1rsdCZMArnxTeqazM9P0j5eL87N5n
         YLmqSbvG6mgqlbZesV3gR3f98xotnbc3ETHC92mo58hctgoomXmXNDqqgfXj7oPzXhNu
         jqihRjHNRd6zoda4ZunhCztXHbn38VdqhwYM4Pli0AzpCe2HiTBecII0d5z27PdUaA2c
         RDSoGvs6/Tr+8/MN1aH1spuD4xIJ1HgaCRuaj9SaywoRoOG+7X03wzvTGeJlEixm7mFV
         F6Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QsgCSsuB4Lh94wSfvpEuEtMRFjpl1/aOPTILb/nR+i0=;
        b=jLbTBPn6lBrrkE5+AGTzrsPHLBzEWcM4BQ+/cjvjIo6t48lNO4xn7NQQMrV8GxCcf3
         CH2tClVrdmvg/1bbBNLHId4dkgcISKMhjOiE9fEQt11E/Jqq/U4p50nXEqjnLoO9T+hB
         stPXGh7V37zXstXDGUTqM87/UUVGpG3wAWKHEwsEX6a+7ObAroCDxTDXSviikb0riKix
         JopG7LfqZ8wwhNPlwutMrGgQjVQ6dkEs8rnbiSjBXUHm9QahK/veB8VEpV04/KR5imIR
         Cl0Nk/rK/POiFktVI6DOd/mKJutpKMbIf/2mv0FjtdYdn6xJG2N23AnnjBAA+qORP7Vk
         JNfQ==
X-Gm-Message-State: ANhLgQ3l2aPvhFB0aL9HkDGr6n70bp7SwmlwWVAOyrmC20sXlcQ9VqMR
        4hdk7GFS54olgMuRzB4c6E8=
X-Google-Smtp-Source: ADFU+vuOULPP2BrGsp5l0LDSjRRWlvdzItCSWN19rEWNH1CUZ/FIice4KTMuFOug6hI8n8BDaaG+mA==
X-Received: by 2002:a1c:a553:: with SMTP id o80mr8184848wme.159.1585522651201;
        Sun, 29 Mar 2020 15:57:31 -0700 (PDT)
Received: from localhost.localdomain ([79.118.211.86])
        by smtp.gmail.com with ESMTPSA id d206sm18597712wmf.29.2020.03.29.15.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 15:57:30 -0700 (PDT)
From:   Iulian Olaru <iulianolaru249@gmail.com>
X-Google-Original-From: Iulian Olaru <iulianolaru249@yahoo.com>
To:     daniel.baluta@gmail.com, gregkh@linuxfoundation.org,
        allison@lohutok.net, info@metux.net, alexios.zavras@intel.com,
        tglx@linutronix.de
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Iulian Olaru <iulianolaru249@yahoo.com>
Subject: [PATCH] staging: uwb: Fix missing blank space coding style issue
Date:   Mon, 30 Mar 2020 01:57:27 +0300
Message-Id: <20200329225727.9222-1-iulianolaru249@yahoo.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a blank space before the switch argument parenthesis to
silence checkpatch.pl errors.

Signed-off-by: Iulian Olaru <iulianolaru249@yahoo.com>
---
 drivers/staging/uwb/drp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/uwb/drp.c b/drivers/staging/uwb/drp.c
index 869987bede7b..4449220f618a 100644
--- a/drivers/staging/uwb/drp.c
+++ b/drivers/staging/uwb/drp.c
@@ -249,7 +249,7 @@ static void handle_conflict_normal(struct uwb_ie_drp *drp_ie,
 	action = evaluate_conflict_action(drp_ie, ext_beacon_slot, rsv, uwb_rsv_status(rsv));
 
 	if (uwb_rsv_is_owner(rsv)) {
-		switch(action) {
+		switch (action) {
 		case UWB_DRP_CONFLICT_ACT2:
 			/* try move */
 			uwb_rsv_set_state(rsv, UWB_RSV_STATE_O_TO_BE_MOVED);
@@ -267,7 +267,7 @@ static void handle_conflict_normal(struct uwb_ie_drp *drp_ie,
 			break;
 		}
 	} else {
-		switch(action) {
+		switch (action) {
 		case UWB_DRP_CONFLICT_ACT2:
 		case UWB_DRP_CONFLICT_ACT3:
 			uwb_rsv_set_state(rsv, UWB_RSV_STATE_T_CONFLICT);
@@ -292,7 +292,7 @@ static void handle_conflict_expanding(struct uwb_ie_drp *drp_ie, int ext_beacon_
 		/* status of companion is 0 at this point */
 		action = evaluate_conflict_action(drp_ie, ext_beacon_slot, rsv, 0);
 		if (uwb_rsv_is_owner(rsv)) {
-			switch(action) {
+			switch (action) {
 			case UWB_DRP_CONFLICT_ACT2:
 			case UWB_DRP_CONFLICT_ACT3:
 				uwb_rsv_set_state(rsv,
@@ -304,7 +304,7 @@ static void handle_conflict_expanding(struct uwb_ie_drp *drp_ie, int ext_beacon_
 						&rsv->mv.companion_mas);
 			}
 		} else { /* rsv is target */
-			switch(action) {
+			switch (action) {
 			case UWB_DRP_CONFLICT_ACT2:
 			case UWB_DRP_CONFLICT_ACT3:
 				uwb_rsv_set_state(rsv,
-- 
2.17.1

