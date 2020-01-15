Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3796EC33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 14:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 091982467C
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 14:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kIWJKZcs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbgAOOTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 09:19:38 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38139 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgAOOTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 09:19:37 -0500
Received: by mail-pf1-f194.google.com with SMTP id x185so8602134pfc.5;
        Wed, 15 Jan 2020 06:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rv/DqUwBL0cLyteq+cLEvFpPEt4GgePPdmAX2ItXChM=;
        b=kIWJKZcsvkuUZvwRivtFvgIWWDo/Tti9TY17prXqhn8ou+0J4BFvJ8oIYES3K08qiV
         R2Vd/rvzIe6i8Dil+hZ1hPy5ShyssowGgZBxu6/JRIa6PsjSIBRLZaXZ8XByGPpMGHXb
         HMEh9ZxA9USfjlI/OVFGBEnv4FMtGnmgrp8YW8Bne7Sob31aw40Lz7ldLM/hNyY+ouRL
         nO67kdJRx5Qqwd6mEg1nF2oLI06lV89EutTw90xedrb8KftavppvbuE85RQRPFz+aWLB
         jofInZLvvseBm3dWeaCgohHSctkr/z6cg19t3fVZFRNbnLUnK+IO6HNECzCuhrooY2aC
         7PAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rv/DqUwBL0cLyteq+cLEvFpPEt4GgePPdmAX2ItXChM=;
        b=CavODgW43/U5eCvFO6KXXtU/lkl+g4CVa6s46dQvKvCZGCHS/G0EIg4tYW0XDFBK3x
         ZVbWDjldpFX36VfnlFcUg4BOuIFjy32+mCwT9nvvqbMnOw0c0dpyQrvR3GCITEzhlygN
         MG+/XXC6mP/9aToGwZCYTdO8xrRY7+GV3Jn9Bs4qRafs9oj2jfDv4sPdzx+Nu2Oxq3lx
         qoyGDW609xzGDorCaDohM7Q7kcpSyI98Hrq8XkmHdKkbIwauUxWMPYJNWBWPm0tqJZgl
         GaHkVCCWaNpENJ8aht0DRxRdCUJwtPLD0dcRlbZ9XEH2nFr8oddYmWDc1wUE2GXVsPLy
         hvVA==
X-Gm-Message-State: APjAAAXQ0gC/NpIPnpKzLBITq2Jm7iNCWg5Mh5PboJmCJnifUik+kG5R
        O0U5Brnd9zmOjarCMO5KOIU=
X-Google-Smtp-Source: APXvYqw/Ek4M3Mu/gGAWjG9C64Bz9YXgOVv1wSXGZqMVwUNkMRrlLduGljYrzFwonam0LSkXgoxpww==
X-Received: by 2002:a63:534d:: with SMTP id t13mr31890500pgl.89.1579097977017;
        Wed, 15 Jan 2020 06:19:37 -0800 (PST)
Received: from madhuparna-HP-Notebook.nitk.ac.in ([2402:3a80:1ee8:ed72:75ba:e01f:bdbc:c547])
        by smtp.gmail.com with ESMTPSA id p35sm21208425pgl.47.2020.01.15.06.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 06:19:36 -0800 (PST)
From:   madhuparnabhowmik04@gmail.com
To:     wei.liu@kernel.org, paul@xen.org
Cc:     xen-devel@lists.xenproject.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, paulmck@kernel.org,
        joel@joelfernandes.org, frextrite@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
Subject: [PATCH] net: xen-netback: hash.c: Use built-in RCU list checking
Date:   Wed, 15 Jan 2020 19:48:40 +0530
Message-Id: <20200115141840.10553-1-madhuparnabhowmik04@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>

list_for_each_entry_rcu has built-in RCU and lock checking.
Pass cond argument to list_for_each_entry_rcu.

Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
---
 drivers/net/xen-netback/hash.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/xen-netback/hash.c b/drivers/net/xen-netback/hash.c
index 10d580c3dea3..3f9783f70a75 100644
--- a/drivers/net/xen-netback/hash.c
+++ b/drivers/net/xen-netback/hash.c
@@ -51,7 +51,8 @@ static void xenvif_add_hash(struct xenvif *vif, const u8 *tag,
 
 	found = false;
 	oldest = NULL;
-	list_for_each_entry_rcu(entry, &vif->hash.cache.list, link) {
+	list_for_each_entry_rcu(entry, &vif->hash.cache.list, link,
+				lockdep_is_held(&vif->hash.cache.lock)) {
 		/* Make sure we don't add duplicate entries */
 		if (entry->len == len &&
 		    memcmp(entry->tag, tag, len) == 0)
-- 
2.17.1

