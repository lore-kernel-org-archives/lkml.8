Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 916DFC43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 18:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53383206B8
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 18:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WtTM9kdk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbgIDSqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 14:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbgIDSqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 14:46:38 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4FFC061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 11:46:37 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id t10so7873413wrv.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 11:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=dQx7qlr5sgzl+EKsELL8mDhBMabAg3tAw/hUjBERGxw=;
        b=WtTM9kdkg/wt6spsrEZ+o1doy3qhPydnTTUFE7DM3+dJvLK2Jkcf1Lrodr9ouegtVv
         Up45nyWxX+kWV4TovqKnjULFESfMDAv1/H78UlBWNO2c5IuiUBPFChWiteHjyx0mClWV
         qiXwVMs7QE/9BlYxbpdlMqH10UYaJTzfSXZZc0OyRas2rGlsuyG7MDsl8ea9LJ8qCIrv
         Y/en3YfbTmJt0ZoHxOEQCgOIlMYZOhLNUfvlvbah9A8BUEoXKZLSACmJ5sgCONHoNS/g
         AvRNLW/dMpmTI0CP5oM9wW3R76NZ+UikqDdq3M0bg/JK4MYI6i9NVE3mM3EOcb54pWBy
         axcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=dQx7qlr5sgzl+EKsELL8mDhBMabAg3tAw/hUjBERGxw=;
        b=XjBn0Re5SWOb5GO/UGY3CixlmMmShGunQp+JtNQM4o9Q3OfILHFnIqqhS5AKcrhmNm
         jNsqNctE0b8OMuHsnTbBXE+K0UOkHLxqSZpjW/cRzEqhSAjIJW/f/JvX0EogWcdTPBTS
         J5SYa4yJGvr5hIC95uxnayxYvhu0LlLOLVIv4ia6el6mSbcJkjdLJDQh+wszBn85p5+I
         Wub1VXXiTrusrCl9fRNUprxPhIRN7a/njqNJEe7qKOnPDuhaZF/bPZc+FxbXle7tbHL2
         XsaUMIt8MIPBv5XCwKmRlAbQhBttQv88qCPc5iYrTjllnaH3BsdqR5nvotdnFEbk0MGv
         d9xQ==
X-Gm-Message-State: AOAM530Nin9ickWkFZ/UHonk/WPC+vzZH3YW1Fy7k6PQABoj/oQ8dgRv
        5H30UGl46SriqaAiArEKFtq9nPrRvrY=
X-Google-Smtp-Source: ABdhPJyRZnf+SlBQ7UbrvpsnTaq4v4xa242elj+FV/LlVyt9CQ5ComoNbu8H0KuPGTxqae/RK5yZTw==
X-Received: by 2002:a5d:6051:: with SMTP id j17mr9690739wrt.81.1599245195826;
        Fri, 04 Sep 2020 11:46:35 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id q186sm14111670wma.45.2020.09.04.11.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 11:46:34 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Subject: [PATCH 5/6] habanalabs: increase PQ COMP_OFFSET by one nibble
Date:   Fri,  4 Sep 2020 21:46:22 +0300
Message-Id: <20200904184623.13478-5-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200904184623.13478-1-oded.gabbay@gmail.com>
References: <20200904184623.13478-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For future ASICs, we increase this field by one nibble. This field was not
used by the current ASICs so this change doesn't break anything.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/include/common/qman_if.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/include/common/qman_if.h b/drivers/misc/habanalabs/include/common/qman_if.h
index 0fdb49188ed7..7ed7739575ee 100644
--- a/drivers/misc/habanalabs/include/common/qman_if.h
+++ b/drivers/misc/habanalabs/include/common/qman_if.h
@@ -40,7 +40,7 @@ struct hl_bd {
  */
 
 #define BD_CTL_COMP_OFFSET_SHIFT	16
-#define BD_CTL_COMP_OFFSET_MASK		0x00FF0000
+#define BD_CTL_COMP_OFFSET_MASK		0x0FFF0000
 
 #define BD_CTL_COMP_DATA_SHIFT		0
 #define BD_CTL_COMP_DATA_MASK		0x0000FFFF
-- 
2.17.1

