Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C3BDC83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 16:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E5AA208FE
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 16:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qOfV4LMX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgD2Qy6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 12:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726580AbgD2Qy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 12:54:56 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E881C03C1AE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 09:54:56 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id u22so1031867plq.12
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 09:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QhnNbFgMhb8TBL2bWNur+1czIzeYIF+WjxZSErS6Dcc=;
        b=qOfV4LMX6mF2hlEyT6Ogcm2d3yi4foFoOnhf4ENAMAlj6jYw/geKkSo/9zFDah6dgo
         lN38/MlTvX+q7K6JgPfr3frx3PRHek//4TAKZUCjbBjQWdNjgSP27OjWn89ETA38ZPEU
         KacFwviDxIG0dxQkIRsSkj82umdS2DHFToJyKKDrBM1R5OR4Q3IuzWiOQ1COtbvmu78e
         IffnZ4LDpBYxBKZ0IVXvoefLt+JsWVzHdXXLRDiXuDIEnJEJnZdHm7GMJLB2aZzKQuPg
         nKgStBBd2Ujf/sX2TL3ncD2Os3NfnXLPhdHug+6Bhqa7034rVl5KymN0ymTzTHwFki/N
         pY4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QhnNbFgMhb8TBL2bWNur+1czIzeYIF+WjxZSErS6Dcc=;
        b=PRzTmdxWfHf/0oWV/51zBpou6ROlBZ0Hjct9/qNOQqMAX8xCcjavrCu9lzd1Ve2Q0s
         bGu/ywWGXupC1uKWHVAkJi/78BhcjOcIp+bEPLbYwh4s6KU26REe/F2iLvv6IwMOr7ya
         l09J2ff44vE7ZNJF+Pcy2xglihdLMRj8zGbKz7/FKOprRzx9ajf+L5JnYmyqHF/iiC0s
         ucufxJ6Y/Jaaf0k8ghLBSSkbgcBh4oPNZT6ZBcOJvmdNmprBu8mX9qZ3PIZG0aMGeT6a
         MZQQ+yZkM7h/7LY2a3Uhub+eb5q6SKElonV/l+YHYRi55VGSVKmKjFBvuvB8rP/ibcke
         g/0Q==
X-Gm-Message-State: AGi0PuaYrCEaBFEGyjzav5daIk5f0MLpGlm3DLf//pLTxmVeT8u8saxU
        KClaQjGb/NK/spsWSztJg8s=
X-Google-Smtp-Source: APiQypKFEAoRkT8LAdt+0d5hSTQ3oN+x+oBQoMG8Z2kEdSdlM/AMBT9p/t5tL+IKtDAoeCktjyaHOA==
X-Received: by 2002:a17:90a:d14d:: with SMTP id t13mr4259685pjw.175.1588179295674;
        Wed, 29 Apr 2020 09:54:55 -0700 (PDT)
Received: from minnich.svl.corp.google.com ([2620:15c:2c5:3:65f9:fd8e:a0b8:2917])
        by smtp.googlemail.com with ESMTPSA id w3sm1460190pfn.115.2020.04.29.09.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 09:54:55 -0700 (PDT)
From:   "Ronald G. Minnich" <rminnich@gmail.com>
X-Google-Original-From: "Ronald G. Minnich" <rminnich@google.com>
Cc:     Boris Brezillon <boris.brezillon@collabora.com>,
        Ron Minnich <rminnich@google.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: parser: cmdline: Support MTD names containing one or more colons
Date:   Wed, 29 Apr 2020 09:53:47 -0700
Message-Id: <20200429165347.48909-1-rminnich@google.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Boris Brezillon <boris.brezillon@collabora.com>

Looks like some drivers define MTD names with a colon in it, thus
making mtdpart= parsing impossible. Let's fix the parser to gracefully
handle that case: the last ':' in a partition definition sequence is
considered instead of the first one.

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Ron Minnich <rminnich@google.com>
Tested-by: Ron Minnich <rminnich@google.com>
---
 drivers/mtd/parsers/cmdlinepart.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/parsers/cmdlinepart.c b/drivers/mtd/parsers/cmdlinepart.c
index c86f2db8c882..0625b25620ca 100644
--- a/drivers/mtd/parsers/cmdlinepart.c
+++ b/drivers/mtd/parsers/cmdlinepart.c
@@ -218,12 +218,29 @@ static int mtdpart_setup_real(char *s)
		struct cmdline_mtd_partition *this_mtd;
		struct mtd_partition *parts;
		int mtd_id_len, num_parts;
-		char *p, *mtd_id;
+		char *p, *mtd_id, *semicol;
+
+		/*
+		 * Replace the first ';' by a NULL char so strrchr can work
+		 * properly.
+		 */
+		semicol = strchr(s, ';');
+		if (semicol)
+			*semicol = '\0';

		mtd_id = s;

-		/* fetch <mtd-id> */
-		p = strchr(s, ':');
+		/*
+		 * fetch <mtd-id>. We use strrchr to ignore all ':' that could
+		 * be present in the MTD name, only the last one is interpreted
+		 * as an <mtd-id>/<part-definition> separator.
+		 */
+		p = strrchr(s, ':');
+
+		/* Restore the ';' now. */
+		if (semicol)
+			*semicol = ';';
+
		if (!p) {
			pr_err("no mtd-id\n");
			return -EINVAL;
