Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B91C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 16:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47BEE246A0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 16:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nvT8eRQ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgB1Qxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 11:53:50 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:45280 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgB1Qxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 11:53:49 -0500
Received: by mail-yw1-f67.google.com with SMTP id d206so3863384ywa.12
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 08:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A8XUuBOQura/ZCwNZQnaa/VEU6kz9OvZiH74oq25eLU=;
        b=nvT8eRQ4TtQCw53KS+O0wKm7YnRHVwXBhsOj6SAkPIfRKvYAbcWogYyCDmU8ZAEf2W
         ZrTdczQLszPOmbFy8FsJ+449vz+kCBIVLwpdjD7Cf5OSBagIAhkzO7KRIrWz+abuJ6ae
         NT1WQReuFw0jmjiuii73K1aawOEbNEKumOVp8SmGU24yWBk/PyfHUlnqcIjRcy63eu+9
         LPnLFIqUTL0cHVe1Qo3hENoglpneECEFhkiAn8IlaRXS0JYxpFB27LZ6r2hRjN6Wd8Q+
         IU6aszoSOWJxsuDukqGRyu6bUi5MWiCTWBCMHF0Jxvhp9VC0/Bo+FWGw/Z83JR9zIqCS
         wbUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A8XUuBOQura/ZCwNZQnaa/VEU6kz9OvZiH74oq25eLU=;
        b=Ae5VZ5EkmBlIx1iUShqJoaoyylbbS5ELM1F1NKcL0yHcU8zK1+AkGbuKQQGYa30utu
         cCv8rwL7cCZZuWQOFmSCnwf6vla4ew/rF5NfEYdd+jsawMzd2P53653pyVLiqTtKz04P
         ASmFvINqcykCg2GyHZDJBTkxBb2AOIsyUMR9kFw0rRn8EO6dQFWRxEKnaSeF7Rxkn8+c
         jsvI4kqqaNnmN67FOVVNNbhnbT+cewdU02BafV/PEegBdNq0Lj+LXxyOE+rA1JW4galH
         2tZ9JF5DDOT69g4d+VMkys2fx1jEwRRd+35bWcEqtilIKUR9oWzFlNQm7tE4MH15uWZg
         ax6A==
X-Gm-Message-State: APjAAAXfDVhkOLJAY0oUS9Neq4Qs9BrDlp4HJ+1BgQUD6v7cLC18EeAG
        0HAtxODm6Cz5BAHFKjiY5BbGtA==
X-Google-Smtp-Source: APXvYqxJYcyNpoqbZq2WbbBQuAkBEtZa/17wGPxXeSAT77rICixk1QYTG5g+QJLNgZiwe1BR+1jZmg==
X-Received: by 2002:a25:1ec6:: with SMTP id e189mr4460419ybe.506.1582908827070;
        Fri, 28 Feb 2020 08:53:47 -0800 (PST)
Received: from localhost.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id g190sm4070820ywf.41.2020.02.28.08.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 08:53:46 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     Jakub Kicinski <kuba@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] bitfield.h: add FIELD_MAX() and field_max()
Date:   Fri, 28 Feb 2020 10:53:43 -0600
Message-Id: <20200228165343.8272-1-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define FIELD_MAX(), which supplies the maximum value that can be
represented by a field value.  Define field_max() as well, to go
along with the lower-case forms of the field mask functions.

Signed-off-by: Alex Elder <elder@linaro.org>
---

 NOTE:	I'm not entirely sure who owns/maintains this file so
	I'm sending it to those who have committed things to it.
	I hope someone will just take it in after review; I use
	field_max() in some code I'm about to send out.

				-Alex

 include/linux/bitfield.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
index 4bbb5f1c8b5b..48ea093ff04c 100644
--- a/include/linux/bitfield.h
+++ b/include/linux/bitfield.h
@@ -55,6 +55,19 @@
 					      (1ULL << __bf_shf(_mask))); \
 	})
 
+/**
+ * FIELD_MAX() - produce the maximum value representable by a field
+ * @_mask: shifted mask defining the field's length and position
+ *
+ * FIELD_MAX() returns the maximum value that can be held in the field
+ * specified by @_mask.
+ */
+#define FIELD_MAX(_mask)						\
+	({								\
+		__BF_FIELD_CHECK(_mask, 0ULL, 0ULL, "FIELD_MAX: ");	\
+		(typeof(_mask))((_mask) >> __bf_shf(_mask));		\
+	})
+
 /**
  * FIELD_FIT() - check if value fits in the field
  * @_mask: shifted mask defining the field's length and position
@@ -110,6 +123,7 @@ static __always_inline u64 field_mask(u64 field)
 {
 	return field / field_multiplier(field);
 }
+#define field_max(field)	((typeof(field))field_mask(field))
 #define ____MAKE_OP(type,base,to,from)					\
 static __always_inline __##type type##_encode_bits(base v, base field)	\
 {									\
-- 
2.20.1

