Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B603BC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 07:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F3A02068E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 07:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="nwxC12eG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbgFOHXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 03:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728368AbgFOHXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 03:23:20 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07552C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 00:23:19 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id g10so13492682wmh.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 00:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XY/kg57wcJSHswDW9ogS03xzi4RY+NmHRKldYaxeSpE=;
        b=nwxC12eGq8ElOmgtjCizwM5OoCzDRHda5UlhQdaK2MbsMe1oI6VwRxrMP9JQljhAmS
         Y5O1KH5K90BvGRwE7TGHQfFiRJrRGSDPSzPIGBI+a4e12dHicqKTmXXcAzF1LpcgtLjE
         hyK68heyn4yAaS+s09PUop9kE80jPeyGIJHeF6dUdGqdmf+rtLg55ANIp8hCPIXehGie
         em78vufhN2elFUDCRUeG5tLloCMOXEqHuR32u+1t8l21EnFl56kq+GuRKAWR7x6kkDN9
         0lCMUrOsHYuY6Pb1KJHHYM6cVv//r1gZFC/0Qdds8Ps4CjPLr2G9nfXfvdiodv1jp52A
         r9EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XY/kg57wcJSHswDW9ogS03xzi4RY+NmHRKldYaxeSpE=;
        b=Z3eCt44+cggeHaRFbLr07HqcdQHxxFIrVgQH+YLK/t4OQR5cxPego+P34NT2WrTE9f
         zadhWWHuDdWL0Ht400Q3/vsvu4d+dcADfF77j7RoSGWrBe18suZd6cQgp3jHe5FV0Y34
         POVGW21dPuht/0owCoAYeBaGfZ83DTQtAM8El0xgzmuETYj3E03VTr/HUjQYU2+PdbqF
         qEt0CRC6NNTnOWq1ysn2ZNfx+r0+W2adU+ckf16MS8eNSK7ZrLGNHMYpgnJRTyRgXPvj
         Y2TBBi6FuxCDUuEW1JRPNk7Lreg3xduyY/XF103LS7BvtBW4UDhpEivBANYZBvgo7vfx
         hXMQ==
X-Gm-Message-State: AOAM532ICHKOzsH+2hD6U5NSwp2O2p8yFg5iPwdn+Tkllmen9b504MeD
        CyY92VC+4n2Ld3LxGeluQBScjw==
X-Google-Smtp-Source: ABdhPJwEzOlDtcsNcAW8Dx9lP/OPqsWQb5BWh1JCCMrRzq6fRztahSj/dMhOR5JM9obggeHqdf5xgQ==
X-Received: by 2002:a1c:c3d7:: with SMTP id t206mr11734242wmf.69.1592205796745;
        Mon, 15 Jun 2020 00:23:16 -0700 (PDT)
Received: from localhost.localdomain (lfbn-nic-1-65-232.w2-15.abo.wanadoo.fr. [2.15.156.232])
        by smtp.gmail.com with ESMTPSA id o20sm24241261wra.29.2020.06.15.00.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 00:23:16 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH] regmap: convert all regmap_update_bits() and co. macros to static inlines
Date:   Mon, 15 Jun 2020 09:23:13 +0200
Message-Id: <20200615072313.11106-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

There's no reason to have these as macros. Let's convert them all to
static inlines for better readability and stronger typing.

Suggested-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 include/linux/regmap.h | 222 +++++++++++++++++++++++++++++++++++------
 1 file changed, 192 insertions(+), 30 deletions(-)

diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index cb666b9c6b6a..f4917efed5c3 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -80,36 +80,6 @@ struct reg_sequence {
 				}
 #define REG_SEQ0(_reg, _def)	REG_SEQ(_reg, _def, 0)
 
-#define	regmap_update_bits(map, reg, mask, val) \
-	regmap_update_bits_base(map, reg, mask, val, NULL, false, false)
-#define	regmap_update_bits_async(map, reg, mask, val)\
-	regmap_update_bits_base(map, reg, mask, val, NULL, true, false)
-#define	regmap_update_bits_check(map, reg, mask, val, change)\
-	regmap_update_bits_base(map, reg, mask, val, change, false, false)
-#define	regmap_update_bits_check_async(map, reg, mask, val, change)\
-	regmap_update_bits_base(map, reg, mask, val, change, true, false)
-
-#define	regmap_write_bits(map, reg, mask, val) \
-	regmap_update_bits_base(map, reg, mask, val, NULL, false, true)
-
-#define	regmap_field_write(field, val) \
-	regmap_field_update_bits_base(field, ~0, val, NULL, false, false)
-#define	regmap_field_force_write(field, val) \
-	regmap_field_update_bits_base(field, ~0, val, NULL, false, true)
-#define	regmap_field_update_bits(field, mask, val)\
-	regmap_field_update_bits_base(field, mask, val, NULL, false, false)
-#define	regmap_field_force_update_bits(field, mask, val) \
-	regmap_field_update_bits_base(field, mask, val, NULL, false, true)
-
-#define	regmap_fields_write(field, id, val) \
-	regmap_fields_update_bits_base(field, id, ~0, val, NULL, false, false)
-#define	regmap_fields_force_write(field, id, val) \
-	regmap_fields_update_bits_base(field, id, ~0, val, NULL, false, true)
-#define	regmap_fields_update_bits(field, id, mask, val)\
-	regmap_fields_update_bits_base(field, id, mask, val, NULL, false, false)
-#define	regmap_fields_force_update_bits(field, id, mask, val) \
-	regmap_fields_update_bits_base(field, id, mask, val, NULL, false, true)
-
 /**
  * regmap_read_poll_timeout - Poll until a condition is met or a timeout occurs
  *
@@ -1054,6 +1024,42 @@ int regmap_bulk_read(struct regmap *map, unsigned int reg, void *val,
 int regmap_update_bits_base(struct regmap *map, unsigned int reg,
 			    unsigned int mask, unsigned int val,
 			    bool *change, bool async, bool force);
+
+static inline int regmap_update_bits(struct regmap *map, unsigned int reg,
+				     unsigned int mask, unsigned int val)
+{
+	return regmap_update_bits_base(map, reg, mask, val, NULL, false, false);
+}
+
+static inline int regmap_update_bits_async(struct regmap *map, unsigned int reg,
+					   unsigned int mask, unsigned int val)
+{
+	return regmap_update_bits_base(map, reg, mask, val, NULL, true, false);
+}
+
+static inline int regmap_update_bits_check(struct regmap *map, unsigned int reg,
+					   unsigned int mask, unsigned int val,
+					   bool *change)
+{
+	return regmap_update_bits_base(map, reg, mask, val,
+				       change, false, false);
+}
+
+static inline int
+regmap_update_bits_check_async(struct regmap *map, unsigned int reg,
+			       unsigned int mask, unsigned int val,
+			       bool *change)
+{
+	return regmap_update_bits_base(map, reg, mask, val,
+				       change, true, false);
+}
+
+static inline int regmap_write_bits(struct regmap *map, unsigned int reg,
+				    unsigned int mask, unsigned int val)
+{
+	return regmap_update_bits_base(map, reg, mask, val, NULL, false, true);
+}
+
 int regmap_get_val_bytes(struct regmap *map);
 int regmap_get_max_register(struct regmap *map);
 int regmap_get_reg_stride(struct regmap *map);
@@ -1152,6 +1158,65 @@ int regmap_fields_read(struct regmap_field *field, unsigned int id,
 int regmap_fields_update_bits_base(struct regmap_field *field,  unsigned int id,
 				   unsigned int mask, unsigned int val,
 				   bool *change, bool async, bool force);
+
+static inline int regmap_field_write(struct regmap_field *field,
+				     unsigned int val)
+{
+	return regmap_field_update_bits_base(field, ~0, val,
+					     NULL, false, false);
+}
+
+static inline int regmap_field_force_write(struct regmap_field *field,
+					   unsigned int val)
+{
+	return regmap_field_update_bits_base(field, ~0, val, NULL, false, true);
+}
+
+static inline int regmap_field_update_bits(struct regmap_field *field,
+					   unsigned int mask, unsigned int val)
+{
+	return regmap_field_update_bits_base(field, mask, val,
+					     NULL, false, false);
+}
+
+static inline int
+regmap_field_force_update_bits(struct regmap_field *field,
+			       unsigned int mask, unsigned int val)
+{
+	return regmap_field_update_bits_base(field, mask, val,
+					     NULL, false, true);
+}
+
+static inline int regmap_fields_write(struct regmap_field *field,
+				      unsigned int id, unsigned int val)
+{
+	return regmap_fields_update_bits_base(field, id, ~0, val,
+					      NULL, false, false);
+}
+
+static inline int regmap_fields_force_write(struct regmap_field *field,
+					    unsigned int id, unsigned int val)
+{
+	return regmap_fields_update_bits_base(field, id, ~0, val,
+					      NULL, false, true);
+}
+
+static inline int
+regmap_fields_update_bits(struct regmap_field *field, unsigned int id,
+			  unsigned int mask, unsigned int val)
+{
+	return regmap_fields_update_bits_base(field, id, mask, val,
+					      NULL, false, false);
+}
+
+static inline int
+regmap_fields_force_update_bits(struct regmap_field *field, unsigned int id,
+				unsigned int mask, unsigned int val)
+{
+	return regmap_fields_update_bits_base(field, id, mask, val,
+					      NULL, false, true);
+}
+
 /**
  * struct regmap_irq_type - IRQ type definitions.
  *
@@ -1458,6 +1523,103 @@ static inline int regmap_fields_update_bits_base(struct regmap_field *field,
 	return -EINVAL;
 }
 
+static inline int regmap_update_bits(struct regmap *map, unsigned int reg,
+				     unsigned int mask, unsigned int val)
+{
+	WARN_ONCE(1, "regmap API is disabled");
+	return -EINVAL;
+}
+
+static inline int regmap_update_bits_async(struct regmap *map, unsigned int reg,
+					   unsigned int mask, unsigned int val)
+{
+	WARN_ONCE(1, "regmap API is disabled");
+	return -EINVAL;
+}
+
+static inline int regmap_update_bits_check(struct regmap *map, unsigned int reg,
+					   unsigned int mask, unsigned int val,
+					   bool *change)
+{
+	WARN_ONCE(1, "regmap API is disabled");
+	return -EINVAL;
+}
+
+static inline int
+regmap_update_bits_check_async(struct regmap *map, unsigned int reg,
+			       unsigned int mask, unsigned int val,
+			       bool *change)
+{
+	WARN_ONCE(1, "regmap API is disabled");
+	return -EINVAL;
+}
+
+static inline int regmap_write_bits(struct regmap *map, unsigned int reg,
+				    unsigned int mask, unsigned int val)
+{
+	WARN_ONCE(1, "regmap API is disabled");
+	return -EINVAL;
+}
+
+static inline int regmap_field_write(struct regmap_field *field,
+				     unsigned int val)
+{
+	WARN_ONCE(1, "regmap API is disabled");
+	return -EINVAL;
+}
+
+static inline int regmap_field_force_write(struct regmap_field *field,
+					   unsigned int val)
+{
+	WARN_ONCE(1, "regmap API is disabled");
+	return -EINVAL;
+}
+
+static inline int regmap_field_update_bits(struct regmap_field *field,
+					   unsigned int mask, unsigned int val)
+{
+	WARN_ONCE(1, "regmap API is disabled");
+	return -EINVAL;
+}
+
+static inline int
+regmap_field_force_update_bits(struct regmap_field *field,
+			       unsigned int mask, unsigned int val)
+{
+	WARN_ONCE(1, "regmap API is disabled");
+	return -EINVAL;
+}
+
+static inline int regmap_fields_write(struct regmap_field *field,
+				      unsigned int id, unsigned int val)
+{
+	WARN_ONCE(1, "regmap API is disabled");
+	return -EINVAL;
+}
+
+static inline int regmap_fields_force_write(struct regmap_field *field,
+					    unsigned int id, unsigned int val)
+{
+	WARN_ONCE(1, "regmap API is disabled");
+	return -EINVAL;
+}
+
+static inline int
+regmap_fields_update_bits(struct regmap_field *field, unsigned int id,
+			  unsigned int mask, unsigned int val)
+{
+	WARN_ONCE(1, "regmap API is disabled");
+	return -EINVAL;
+}
+
+static inline int
+regmap_fields_force_update_bits(struct regmap_field *field, unsigned int id,
+				unsigned int mask, unsigned int val)
+{
+	WARN_ONCE(1, "regmap API is disabled");
+	return -EINVAL;
+}
+
 static inline int regmap_get_val_bytes(struct regmap *map)
 {
 	WARN_ONCE(1, "regmap API is disabled");
-- 
2.26.1

