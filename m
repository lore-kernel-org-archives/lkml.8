Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9165BC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 02:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6938820FC3
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 02:00:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="odDiYisi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731651AbgFTCAv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 22:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731607AbgFTCAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 22:00:50 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101D7C06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 19:00:50 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id b201so5305718pfb.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 19:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J/PImVIlMQhUi5RdPNvX2NF2rCR7tu4NCt0FIFuo1io=;
        b=odDiYisiF1Tysi4CDYwRedQg63AgXLx2FVYxlrTaZmeSG5K2iAq0hJiESb3E9HN8qO
         EksGYj4CHuJdJSY+b1/eJYA0KDtUJAS55vSdd/9eVcxHz5aYsf0G/4GU8IJZqiAyX8Aw
         lfexT8CW2RkzCm3O6CkAmN3iGnZmkr7xVanxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J/PImVIlMQhUi5RdPNvX2NF2rCR7tu4NCt0FIFuo1io=;
        b=h4ItUUs/NlaSll0nHf7pmGV67AwKxbabg4/LWUezP3ZW/9wNdVMK3+DSHL96cW8/Mm
         9oHPTJLhE+++DMk4AITSNHga9KuRAt6VP0ydimpV2MoFarL/Y9fR5gmfaSqM8UgQwRyz
         0g8x8/thp/OU5wQcP+m71d96JoA07tQLuIe54ZqmGD1zKJbBQoQGhbFF5ycmoaQDzzyP
         3/bu0HJsLMG/2OgpLF4I2fQ1LhyRB2AqvSxRgNYu7xi+hyiZimSWncLAYey274N58IvV
         Ten6VkgtbpoUVLoJqac1qR8XKtnQadQm0gZKUrMGtE0kM4qTaBW70yLRep3KgIs0QdRC
         aYsA==
X-Gm-Message-State: AOAM5301c8ysZzm/ULNa283TTq+WVMo/TuYQ2l4ZtvoXuncMqcsW6Fse
        MFQEw9snbrF/Nt7hSJx7NCAl7uxuR8g=
X-Google-Smtp-Source: ABdhPJxrrpzrjBhEBuxgWiNJNiqqvyBmP7CTnNdxkj5PI9pcI3tym1Pg4vQPqESg3aYMbZabU5Kibg==
X-Received: by 2002:a62:191:: with SMTP id 139mr10560589pfb.94.1592618449304;
        Fri, 19 Jun 2020 19:00:49 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:476b:691:abc3:38db])
        by smtp.gmail.com with ESMTPSA id i14sm6180043pju.24.2020.06.19.19.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 19:00:48 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com,
        Prashant Malani <pmalani@chromium.org>,
        kernel test robot <lkp@intel.com>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH] platform/chrome: cros_ec_typec: Make configure_mux static
Date:   Fri, 19 Jun 2020 19:00:37 -0700
Message-Id: <20200620020038.230887-1-pmalani@chromium.org>
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since cros_typec_configure_mux() is only used in cros-ec-typec,
it should be marked static.

Fixes: 7e7def15fa4b ("platform/chrome: cros_ec_typec: Add USB mux control")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/platform/chrome/cros_ec_typec.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 509fc761906b..1df1386f32e4 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -428,9 +428,9 @@ static int cros_typec_enable_dp(struct cros_typec_data *typec,
 	return typec_mux_set(port->mux, &port->state);
 }
 
-int cros_typec_configure_mux(struct cros_typec_data *typec, int port_num,
-			     uint8_t mux_flags,
-			     struct ec_response_usb_pd_control_v2 *pd_ctrl)
+static int cros_typec_configure_mux(struct cros_typec_data *typec, int port_num,
+				uint8_t mux_flags,
+				struct ec_response_usb_pd_control_v2 *pd_ctrl)
 {
 	struct cros_typec_port *port = typec->ports[port_num];
 	enum typec_orientation orientation;
-- 
2.27.0.111.gc72c7da667-goog

