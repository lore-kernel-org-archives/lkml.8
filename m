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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D6CC2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 14:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9859217F4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 14:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ElLgojf+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbgATOFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 09:05:51 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39199 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbgATOFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 09:05:50 -0500
Received: by mail-pl1-f195.google.com with SMTP id g6so13237308plp.6;
        Mon, 20 Jan 2020 06:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/v1IzDSLfJvfKfWBZua8/9zmrUBTaByJf1uzQJas5Wc=;
        b=ElLgojf+YrtHVzJCr9kbn2bG4YjALZxIq7P1KG85hf4xWO8aOu25uJfsu7eqQvJvXx
         Kp9D/3v1TYjMpm6Apkilc24M9Ou7Lohn15ioUO0W3c1kN2B/nBuFr+XliJR7dFlwng1k
         Eav86HDp1P/QXLD/czDXFPgEeFvSRAcNbtkt5d0IwPHOhrqWv9yXdAg6bBlGhWek6l96
         RuiSeh+Lk+t+uX5KwAk3Fdd813JArg446/GB3eI1GVlIAUXLBTAMvLhnl0S50/e1PeE3
         MSOsi2I6Bf1DX94OV4BszhB7maP20RWbsoe4cZxa7dPgOt/UMhEKJnooxZ4TI6bWJC8M
         SQyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/v1IzDSLfJvfKfWBZua8/9zmrUBTaByJf1uzQJas5Wc=;
        b=EvhlJcovAyVc5BM9FqneQPFZhVFqNoYV+/csj/1s0o501nGsfgiGgGWDhCG8Evt5ed
         igQYfgezKi+Qrp36xRdPETpmj+ZKX1EMnBerXYaD5rzYC/E6UgjRJ8qkVoYGvNiC4WmP
         bLtFxYpKZ727uaK1og/tfSumZjHsyj1Ape0Zly40i4++0U6y/0tEdK8ouuI6z3FEHSVY
         RUl9dFPeE2g18XyiCuvtFlvUVKvNl12SAMAx+yUNWtnuGFwfWfGCR1XWCzOeiP1cBmhH
         pf1GthDEhNRR6C5uY+/ZqsJtsfWq9+nPbDkJspji98bn55QHquWCRN7sMwyER7xvwZNm
         /PnQ==
X-Gm-Message-State: APjAAAWGeu+Wzwi4encOxAXHKMDfNQxuwWSQmdICwkg5uI1tBgIgNYEV
        Tt8d5Yl723CvZ2Nf7UyW3VT571MmkHtEzA==
X-Google-Smtp-Source: APXvYqx8oijiciBf5VQCSc1j5Qt/mwD0QWcVLLM8S5xmmTZ1bWDMyHqHKbM5FEDFyLHOWSgJDhfeag==
X-Received: by 2002:a17:902:9a96:: with SMTP id w22mr4839458plp.107.1579529149530;
        Mon, 20 Jan 2020 06:05:49 -0800 (PST)
Received: from glados.lan ([2601:647:4c01:6541:fa16:54ff:fed1:1bd6])
        by smtp.gmail.com with ESMTPSA id b42sm188991pjc.27.2020.01.20.06.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 06:05:49 -0800 (PST)
From:   Thomas Hebb <tommyhebb@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-stable@vger.kernel.org, Thomas Hebb <tommyhebb@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org
Subject: [PATCH v2 1/2] usb: typec: wcove: fix "op-sink-microwatt" default that was in mW
Date:   Mon, 20 Jan 2020 06:05:40 -0800
Message-Id: <0eac53c4878423a9abd49d2142fe4cb1136db4e2.1579529138.git.tommyhebb@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 4c912bff46cc ("usb: typec: wcove: Provide fwnode for the port")
didn't convert this value from mW to uW when migrating to a new
specification format like it should have.

Fixes: 4c912bff46cc ("usb: typec: wcove: Provide fwnode for the port")
Cc: linux-stable@vger.kernel.org
Signed-off-by: Thomas Hebb <tommyhebb@gmail.com>

---

Changes in v2:
- Split fix into two patches
- Added stable cc

 drivers/usb/typec/tcpm/wcove.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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

