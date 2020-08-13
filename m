Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC666C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 06:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94C0A22B49
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 06:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QKKKrIiw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgHMGV2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 02:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbgHMGVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 02:21:22 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C79AC061757
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 23:21:22 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id t23so4928143ljc.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 23:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IH75Bnms5DPUZxVd4scsKK5yOA6U4dgdsyqfLFTRRs0=;
        b=QKKKrIiwcWdX5YYhi+IBDzFnMzjp6BoSprArgCKJGaFTAFllL2t0ucD3tGKgBwpFvN
         in6kuJpiVUtaHTQ3TW4R/yzg0P2l0ntv2OQXzVQGcjgkUhOYlrGRAGy8n/Iyk8q8BFeu
         0S/pdYd7UYA/6paTgZms7xIXYMQgqQ9+8vtFqsuCQljaX/b4OSlc1s21jKsJqgd6jG+K
         StlWFVqsso5qkm3ZKbZfI/OYTvxWcpOjGenmx423rC41g52XKhksvmFWK7vYLG9BZ0oN
         hbwz5PzY8SVWx8BqvGgFNteRAgZmgIGQ7p1Pkkaxh+eqmGutPo5m7+oEyxVuY+ptdRtO
         4biQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IH75Bnms5DPUZxVd4scsKK5yOA6U4dgdsyqfLFTRRs0=;
        b=lU78wiZpkQw5FeerVYmaUCWud4dJQqVvL1p7oxpPlKT4ZD5GCb6zSypSLIdM3hWb/s
         RflChhgsaQebSfy5pcEw31lDjPTsO8nLUB1pYzi6GJns+t4BuTrDCeIoJ/VQ7SymOCLQ
         EF8ZCCXrk7cgN7JfZm1qGx2vvx+54/zlaT/egitsoCDWH9Q3+6aViH/PT2oXnL4FOyum
         kz85N0ND5xd8p8NlzT4C32n4Exbi88yY+7SBAPfswgATMLWR1wPOpKqV2K2SPWJ6XYT5
         CG16xOvq8HBtKPIHROcmAp6y9tmjU0DK3oopYtapYc9ar4y8ZI1gIqVndru9hQf7IzXl
         9jfA==
X-Gm-Message-State: AOAM532Ezu1J1ybAOq61+i0nWdfHIuURN0v60xLnQFSh63+ewIuKW2fH
        Q0RxBLos7fOk8kI6f4zdiOs=
X-Google-Smtp-Source: ABdhPJzZ/6L5Z/fBwUE4Dex+np7ONiwAFJpUyzfR48jKW7Q6gk4iOCDuNNlT3JqaSw4e0sXtMyhQ8w==
X-Received: by 2002:a2e:804b:: with SMTP id p11mr1352175ljg.221.1597299680641;
        Wed, 12 Aug 2020 23:21:20 -0700 (PDT)
Received: from a2klaptop.localdomain ([185.199.97.5])
        by smtp.gmail.com with ESMTPSA id f14sm964060lfd.2.2020.08.12.23.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 23:21:20 -0700 (PDT)
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
To:     xen-devel@lists.xenproject.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, boris.ostrovsky@oracle.com,
        jgross@suse.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     sstabellini@kernel.org, dan.carpenter@oracle.com,
        intel-gfx@lists.freedesktop.org,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: [PATCH v2 4/5] xen: Sync up with the canonical protocol definition in Xen
Date:   Thu, 13 Aug 2020 09:21:12 +0300
Message-Id: <20200813062113.11030-5-andr2000@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200813062113.11030-1-andr2000@gmail.com>
References: <20200813062113.11030-1-andr2000@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

This is the sync up with the canonical definition of the
display protocol in Xen.

1. Add protocol version as an integer

Version string, which is in fact an integer, is hard to handle in the
code that supports different protocol versions. To simplify that
also add the version as an integer.

2. Pass buffer offset with XENDISPL_OP_DBUF_CREATE

There are cases when display data buffer is created with non-zero
offset to the data start. Handle such cases and provide that offset
while creating a display buffer.

3. Add XENDISPL_OP_GET_EDID command

Add an optional request for reading Extended Display Identification
Data (EDID) structure which allows better configuration of the
display connectors over the configuration set in XenStore.
With this change connectors may have multiple resolutions defined
with respect to detailed timing definitions and additional properties
normally provided by displays.

If this request is not supported by the backend then visible area
is defined by the relevant XenStore's "resolution" property.

If backend provides extended display identification data (EDID) with
XENDISPL_OP_GET_EDID request then EDID values must take precedence
over the resolutions defined in XenStore.

4. Bump protocol version to 2.

Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
---
 include/xen/interface/io/displif.h | 91 +++++++++++++++++++++++++++++-
 1 file changed, 88 insertions(+), 3 deletions(-)

diff --git a/include/xen/interface/io/displif.h b/include/xen/interface/io/displif.h
index fdc279dc4a88..d43ca0361f86 100644
--- a/include/xen/interface/io/displif.h
+++ b/include/xen/interface/io/displif.h
@@ -38,7 +38,8 @@
  *                           Protocol version
  ******************************************************************************
  */
-#define XENDISPL_PROTOCOL_VERSION	"1"
+#define XENDISPL_PROTOCOL_VERSION	"2"
+#define XENDISPL_PROTOCOL_VERSION_INT	 2
 
 /*
  ******************************************************************************
@@ -202,6 +203,9 @@
  *      Width and height of the connector in pixels separated by
  *      XENDISPL_RESOLUTION_SEPARATOR. This defines visible area of the
  *      display.
+ *      If backend provides extended display identification data (EDID) with
+ *      XENDISPL_OP_GET_EDID request then EDID values must take precedence
+ *      over the resolutions defined here.
  *
  *------------------ Connector Request Transport Parameters -------------------
  *
@@ -349,6 +353,8 @@
 #define XENDISPL_OP_FB_DETACH		0x13
 #define XENDISPL_OP_SET_CONFIG		0x14
 #define XENDISPL_OP_PG_FLIP		0x15
+/* The below command is available in protocol version 2 and above. */
+#define XENDISPL_OP_GET_EDID		0x16
 
 /*
  ******************************************************************************
@@ -377,6 +383,10 @@
 #define XENDISPL_FIELD_BE_ALLOC		"be-alloc"
 #define XENDISPL_FIELD_UNIQUE_ID	"unique-id"
 
+#define XENDISPL_EDID_BLOCK_SIZE	128
+#define XENDISPL_EDID_BLOCK_COUNT	256
+#define XENDISPL_EDID_MAX_SIZE		(XENDISPL_EDID_BLOCK_SIZE * XENDISPL_EDID_BLOCK_COUNT)
+
 /*
  ******************************************************************************
  *                          STATUS RETURN CODES
@@ -451,7 +461,9 @@
  * +----------------+----------------+----------------+----------------+
  * |                           gref_directory                          | 40
  * +----------------+----------------+----------------+----------------+
- * |                             reserved                              | 44
+ * |                             data_ofs                              | 44
+ * +----------------+----------------+----------------+----------------+
+ * |                             reserved                              | 48
  * +----------------+----------------+----------------+----------------+
  * |/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/|
  * +----------------+----------------+----------------+----------------+
@@ -494,6 +506,7 @@
  *   buffer size (buffer_sz) exceeds what can be addressed by this single page,
  *   then reference to the next page must be supplied (see gref_dir_next_page
  *   below)
+ * data_ofs - uint32_t, offset of the data in the buffer, octets
  */
 
 #define XENDISPL_DBUF_FLG_REQ_ALLOC	(1 << 0)
@@ -506,6 +519,7 @@ struct xendispl_dbuf_create_req {
 	uint32_t buffer_sz;
 	uint32_t flags;
 	grant_ref_t gref_directory;
+	uint32_t data_ofs;
 };
 
 /*
@@ -731,6 +745,44 @@ struct xendispl_page_flip_req {
 	uint64_t fb_cookie;
 };
 
+/*
+ * Request EDID - request EDID describing current connector:
+ *         0                1                 2               3        octet
+ * +----------------+----------------+----------------+----------------+
+ * |               id                | _OP_GET_EDID   |   reserved     | 4
+ * +----------------+----------------+----------------+----------------+
+ * |                             buffer_sz                             | 8
+ * +----------------+----------------+----------------+----------------+
+ * |                          gref_directory                           | 12
+ * +----------------+----------------+----------------+----------------+
+ * |                             reserved                              | 16
+ * +----------------+----------------+----------------+----------------+
+ * |/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/|
+ * +----------------+----------------+----------------+----------------+
+ * |                             reserved                              | 64
+ * +----------------+----------------+----------------+----------------+
+ *
+ * Notes:
+ *   - This command is not available in protocol version 1 and should be
+ *     ignored.
+ *   - This request is optional and if not supported then visible area
+ *     is defined by the relevant XenStore's "resolution" property.
+ *   - Shared buffer, allocated for EDID storage, must not be less then
+ *     XENDISPL_EDID_MAX_SIZE octets.
+ *
+ * buffer_sz - uint32_t, buffer size to be allocated, octets
+ * gref_directory - grant_ref_t, a reference to the first shared page
+ *   describing EDID buffer references. See XENDISPL_OP_DBUF_CREATE for
+ *   grant page directory structure (struct xendispl_page_directory).
+ *
+ * See response format for this request.
+ */
+
+struct xendispl_get_edid_req {
+	uint32_t buffer_sz;
+	grant_ref_t gref_directory;
+};
+
 /*
  *---------------------------------- Responses --------------------------------
  *
@@ -753,6 +805,35 @@ struct xendispl_page_flip_req {
  * id - uint16_t, private guest value, echoed from request
  * status - int32_t, response status, zero on success and -XEN_EXX on failure
  *
+ *
+ * Get EDID response - response for XENDISPL_OP_GET_EDID:
+ *         0                1                 2               3        octet
+ * +----------------+----------------+----------------+----------------+
+ * |               id                |    operation   |    reserved    | 4
+ * +----------------+----------------+----------------+----------------+
+ * |                              status                               | 8
+ * +----------------+----------------+----------------+----------------+
+ * |                             edid_sz                               | 12
+ * +----------------+----------------+----------------+----------------+
+ * |                             reserved                              | 16
+ * +----------------+----------------+----------------+----------------+
+ * |/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/|
+ * +----------------+----------------+----------------+----------------+
+ * |                             reserved                              | 64
+ * +----------------+----------------+----------------+----------------+
+ *
+ * Notes:
+ *   - This response is not available in protocol version 1 and should be
+ *     ignored.
+ *
+ * edid_sz - uint32_t, size of the EDID, octets
+ */
+
+struct xendispl_get_edid_resp {
+	uint32_t edid_sz;
+};
+
+/*
  *----------------------------------- Events ----------------------------------
  *
  * Events are sent via a shared page allocated by the front and propagated by
@@ -804,6 +885,7 @@ struct xendispl_req {
 		struct xendispl_fb_detach_req fb_detach;
 		struct xendispl_set_config_req set_config;
 		struct xendispl_page_flip_req pg_flip;
+		struct xendispl_get_edid_req get_edid;
 		uint8_t reserved[56];
 	} op;
 };
@@ -813,7 +895,10 @@ struct xendispl_resp {
 	uint8_t operation;
 	uint8_t reserved;
 	int32_t status;
-	uint8_t reserved1[56];
+	union {
+		struct xendispl_get_edid_resp get_edid;
+		uint8_t reserved1[56];
+	} op;
 };
 
 struct xendispl_evt {
-- 
2.17.1

