Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D6D1C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49D4D204FD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:54:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YnsyDcw7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729289AbgHOVy1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729116AbgHOVwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:52:36 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CB1C0612F0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 20:42:34 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id x6so5433632pgx.12
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 20:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lBylaFnUUXRauocku9vHfLkvX5ndvsgjr11eHR0amV4=;
        b=YnsyDcw7owXVN9vY4jxT4N5Xy1n4EOPhdmwXGEgESx8vEbQLRcu9/tIN8jRaP3vlAF
         vQCfaBxWJfFFatQMGj5q8QJvtrnY6iSicxCJnl1bZdrE1AgIP6tGm3x5a4REkqvaBkZD
         6rrNhmwzrFOKi2Rjq2vWTBi7ti9E+CwPnybWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lBylaFnUUXRauocku9vHfLkvX5ndvsgjr11eHR0amV4=;
        b=iK8mgZI/J35VHcz6NHcSs9XUpdkTSB2nrHcq0qSw4AfyOIXKlQNaHBdh19Zi1ihnTl
         XEZ9zsXWG42ed4N1uLJJEgncTd5TfJUo5JbPvq43V61Lym5bu4sYhPY1hfur3t4y8Xu3
         Pbs7unZjyRu/aKpZ1H3DYRNOfsxarTQ+MG+p6B3xdmx7rwp+npW65IVZwTuLoBivR53m
         1tnyz/WD2TfPYV6lnhFkzy+PiKICULFI5cx5pYAJ76IpihAJeQBh+JY/vO4D/Raqv05L
         U1aBL9iGP2kAYOfLFMK1MfTOkNeVw90mrizXZiWWQDp5jSYoNRKc6PyOohgSgH1RbIrF
         xSaw==
X-Gm-Message-State: AOAM533wbwVHXkXCPornV+7to0HUU7HI362v/FG9q0McJWt4b8uupvCk
        fRDJ/kf7+oxp0texw9Wk3l+TAw==
X-Google-Smtp-Source: ABdhPJw/yPAd1dXWFRYZHGweFuXBD+oPrr7ZdPCJkkkb5FOQJeTUDnLQpcl/nMAuNhNP9hlXyh9eUA==
X-Received: by 2002:a62:8c89:: with SMTP id m131mr3920519pfd.288.1597462953567;
        Fri, 14 Aug 2020 20:42:33 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:7220:84ff:fe09:94fe])
        by smtp.gmail.com with ESMTPSA id u15sm9567361pgm.10.2020.08.14.20.42.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2020 20:42:33 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     ejcaruso@chromium.org, drinkcat@chromium.org,
        enric.balletbo@collabora.com, groeck@chromium.org
Cc:     linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH] platform: cros_ec: Reduce ligthbar get version command
Date:   Fri, 14 Aug 2020 20:42:29 -0700
Message-Id: <20200815034229.3109182-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default, the lightbar commands are set to the
biggest lightbar command and response. That length is greater than 128
bytes and may not work on all machines.
But all EC are probed for lightbar by sending a get version request.
Set that request size precisely.

BUG=chromium:160662061
TEST=Before the command would be:
cros_ec_cmd: version: 0, command: EC_CMD_LIGHTBAR_CMD, outsize: 194, insize: 128, result: 0
Afer:
cros_ec_cmd: version: 0, command: EC_CMD_LIGHTBAR_CMD, outsize: 1, insize: 8, result: 0

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/platform/chrome/cros_ec_lightbar.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_lightbar.c b/drivers/platform/chrome/cros_ec_lightbar.c
index b59180bff5a3e..ef61298c30bdd 100644
--- a/drivers/platform/chrome/cros_ec_lightbar.c
+++ b/drivers/platform/chrome/cros_ec_lightbar.c
@@ -116,6 +116,8 @@ static int get_lightbar_version(struct cros_ec_dev *ec,
 
 	param = (struct ec_params_lightbar *)msg->data;
 	param->cmd = LIGHTBAR_CMD_VERSION;
+	msg->outsize = sizeof(param->cmd);
+	msg->result = sizeof(resp->version);
 	ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
 	if (ret < 0) {
 		ret = 0;
-- 
2.28.0.220.ged08abb693-goog

