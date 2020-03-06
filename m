Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82384C3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 04:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 576B72073D
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 04:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jx1yPVJr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgCFEXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 23:23:09 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:43085 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbgCFEXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 23:23:08 -0500
Received: by mail-yw1-f68.google.com with SMTP id p69so1053312ywh.10
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 20:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sMbKOm76H5mFEqAkSoaE+7Ax6unR881JS91louKjFYc=;
        b=jx1yPVJrJ8OhZLKw9kcHzaFARQHYix4WQLtIVg8KvBHwb5BvxZGrkRVE7oTlr3/hiW
         rvPFGLy0+CUpnSW2v75STX3stcpTItrgyCFk6u+mEM+BHC6SRliDYQ5Viat26gUFT0Xd
         H/ULVzneOWEd7zZ3ifibiT0d+nscbJj7pw/F1yT3ITsVt+u5DsoeNeeym42iPkkU8RwV
         iyqz6ApW5KVrzWfQrqkRKLBanWGPPmyqp1wa2vdtxDsurRXxfqmz1FiR+NFSYLb4AZ6Z
         4CP0qQItr8Y+99Ns1SpwcteVbRILIoOWwnej/CJtAaR+vte64DgEynnUhSoEPzZolvDj
         xq5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sMbKOm76H5mFEqAkSoaE+7Ax6unR881JS91louKjFYc=;
        b=P0xL5PL2ysTrrgGRFDmPr9EsUF0aKvcUN4FbcJnw8TUqySdP0pqrXJ0fPKCgNCtUat
         AWWI1mO2nWWywM6aiH7YEHl166h2V2bWBSh5Nu4sKqbk2QLERGEfhfp56DQL7cnjcvCO
         BYelll1QW+fw/pfTPaGZppKf5MSDZxzLCmqUDeYkE5rf/QUbFPMg2G58Out6UdpvgCaq
         SREMiE8KDK6O9HhJZQya5NJZ9NHw1FYNrZDp8U9CfWh1B/ptvpH+lkkZqOC80scrLRT4
         ijjgReKWnftC5MlKZ96Mp8RpHzpFugbbkSfP9pguBdCWdCQKcm34MghsyeDwh/x9ANa0
         FqFQ==
X-Gm-Message-State: ANhLgQ1dS9YRQiWhGCzjFeQL/vcyPpOcYPY8uV1wbswbYNfVyMUSkP9r
        xKs1RkNZ7Qa4ujh1/D8DsK0G5NRiB1E=
X-Google-Smtp-Source: ADFU+vs+RcJ9Rr2DXgB3GM4Vg5uvj7uEkI72h0JZxT+0/pzRe+8+creExY50wqUf6HuTKeGEv50IvQ==
X-Received: by 2002:a25:c945:: with SMTP id z66mr1913599ybf.206.1583468587657;
        Thu, 05 Mar 2020 20:23:07 -0800 (PST)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id t65sm11159465ywe.62.2020.03.05.20.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 20:23:06 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] bitfield.h: add FIELD_MAX() and field_max()
Date:   Thu,  5 Mar 2020 22:23:02 -0600
Message-Id: <20200306042302.17602-1-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define FIELD_MAX(), which supplies the maximum value that can be
represented by a bitfield.  Define field_max() as well, to go
along with the lower-case forms of the field mask functions.

Signed-off-by: Alex Elder <elder@linaro.org>
Acked-by: Jakub Kicinski <kuba@kernel.org>
---
v2: Added Acked-by from Jakub.

David, I added you to this because it's probably easiest to take
this change in through your tree with the rest of the IPA code
(which uses field_max(), defined here).

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

