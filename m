Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 975F6C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 10:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6749520674
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 10:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dymNsCod"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgATKxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 05:53:23 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44612 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgATKxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 05:53:23 -0500
Received: by mail-pf1-f195.google.com with SMTP id 62so9029610pfu.11;
        Mon, 20 Jan 2020 02:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U+Rso55JZaMhZNPtPtuSs1XzIHq/8ZFdHLVa6T1ULdA=;
        b=dymNsCodIKf8njlpc/JGslBA7AUPgy2Pt+OnLegz5nBCIWriAOAEVKdvizckZvrRD8
         3ilGsC6FbdrFAnh/HayqJqBY6dRcapE1nTaJRtGT5RSp95GDE8JGpSy8zcwxuvI+tTdF
         /WZ/dzRjkDRSliGqMhIRAB1U+Kd6Dqw7e2TMWhK5XiraRG6qSC8/a+Ga2zCrAYyr/f1s
         I/dnRzde4FE0EDyrlBuy4aLJy20jiUG7lDUlSvAGYY7LPqJ5qlM627JOmeIhQYgKQcyF
         N32Fh44gPXrmGlGxGZ7R5zq6hhD3SANn11rvBcvFt0CFrzIioixQ57l+XFNsu4tn7ONQ
         yFeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U+Rso55JZaMhZNPtPtuSs1XzIHq/8ZFdHLVa6T1ULdA=;
        b=c8wZmiv+BA/YAY2MWhsXOhrzHIAO/sC44qXPBfly3TITHGXTmFIdIAnbU1C4aPmaPF
         aCWz2x84eRK1ovv7V8iafgaXNk0DKl/l4Gp4If8yWnpd+ZkX+4vCIJ+zA37m7AHai2NS
         I0wYkt4qWWDBw8WGU6T+rTXzZ4UF1kk/5o969huq1sUCk+9zXTk7EdzzmZb7Lkx5C7sZ
         ITTLa7haYBsd4cXnr/xaAadsHLImNtrVxicAKg1qjsQPfx/adZ/m3qhSVpoXH5aoGD7o
         Lybcbfanjars//uGzGILLYp+b/zqKDb7K2LVs/+3cf89it6UmpL/flHjHcnADJYWXkLx
         o8mw==
X-Gm-Message-State: APjAAAXLcti7zpCKBbByB1jkl2WXYNCklWEvjgwxN+aegch0CqgcjNf+
        SijKzUA1sDsUGfz2rIqffHHdX1x3R+I=
X-Google-Smtp-Source: APXvYqwPgW/p5ckZhxiXVhN17rSeg3AQiC9RH8kTHNt/pYq2Ykc/CW/i6o8aWBT1lSzwjMl44NUtLw==
X-Received: by 2002:a62:7c49:: with SMTP id x70mr15761306pfc.200.1579517602267;
        Mon, 20 Jan 2020 02:53:22 -0800 (PST)
Received: from glados.lan ([2601:647:4c01:6541:fa16:54ff:fed1:1bd6])
        by smtp.gmail.com with ESMTPSA id e18sm18018502pjt.21.2020.01.20.02.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 02:53:21 -0800 (PST)
From:   Thomas Hebb <tommyhebb@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Hebb <tommyhebb@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org
Subject: [PATCH] usb: typec: fix "op-sink-microwatt" defaults that were in mW
Date:   Mon, 20 Jan 2020 02:53:16 -0800
Message-Id: <bcd87046185bb7cea42873186d706aeb50e27a80.1579517594.git.tommyhebb@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 8f6244055bd3 ("usb: typec: fusb302: Always provide fwnode for the
port") and commit 4c912bff46cc ("usb: typec: wcove: Provide fwnode for
the port") converted a legacy TCPM platdata structure to a more generic
format. However, one field, denoting required sink power, was specified
in mW in the old format but uW in the new format. The migration failed
to account for this, meaning that the values are now 1000x too small.

Correct the issue by converting the values to uW.

Signed-off-by: Thomas Hebb <tommyhebb@gmail.com>

---

 drivers/usb/typec/tcpm/fusb302.c | 2 +-
 drivers/usb/typec/tcpm/wcove.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/fusb302.c
index ed8655c6af8c..b498960ff72b 100644
--- a/drivers/usb/typec/tcpm/fusb302.c
+++ b/drivers/usb/typec/tcpm/fusb302.c
@@ -1666,7 +1666,7 @@ static const struct property_entry port_props[] = {
 	PROPERTY_ENTRY_STRING("try-power-role", "sink"),
 	PROPERTY_ENTRY_U32_ARRAY("source-pdos", src_pdo),
 	PROPERTY_ENTRY_U32_ARRAY("sink-pdos", snk_pdo),
-	PROPERTY_ENTRY_U32("op-sink-microwatt", 2500),
+	PROPERTY_ENTRY_U32("op-sink-microwatt", 2500000),
 	{ }
 };
 
diff --git a/drivers/usb/typec/tcpm/wcove.c b/drivers/usb/typec/tcpm/wcove.c
index edc271da14f4..9b745f432c91 100644
--- a/drivers/usb/typec/tcpm/wcove.c
+++ b/drivers/usb/typec/tcpm/wcove.c
@@ -597,7 +597,7 @@ static const struct property_entry wcove_props[] = {
 	PROPERTY_ENTRY_STRING("try-power-role", "sink"),
 	PROPERTY_ENTRY_U32_ARRAY("source-pdos", src_pdo),
 	PROPERTY_ENTRY_U32_ARRAY("sink-pdos", snk_pdo),
-	PROPERTY_ENTRY_U32("op-sink-microwatt", 15000),
+	PROPERTY_ENTRY_U32("op-sink-microwatt", 15000000),
 	{ }
 };
 
-- 
2.24.1

