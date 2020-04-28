Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75CE4C83001
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 01:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42F7C206E2
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 01:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CHcQb9jd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbgD1BDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 21:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726263AbgD1BDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 21:03:03 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A81C03C1A8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 18:03:03 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id a7so381587pju.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 18:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1KP0Ez7hKSnKb+povEU3BzAbH8Pt0yNwSNaVttztrRk=;
        b=CHcQb9jdYyP6gCgFKoXSog75I+fwwXi8tHwq3opxqfLD6dG55Dk+bqbxAE6/DC0LAL
         h7jn1mQIl6kqwVpYNyXzUYgmpWsue1PASrSuim/H5yEzov1PrhYU3ZaWEWKGUA2Lrvsp
         Os2oC73xaWQfiRX49BC2SQKEUbSVbIG6AdZIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1KP0Ez7hKSnKb+povEU3BzAbH8Pt0yNwSNaVttztrRk=;
        b=Ot3kGVUHQrscm4YvQDenXE762YwCd15ap/P5oyc/Y5LXNFDEAA8qRDSvMkfEwJQwWj
         QT3ghl+tUOT7nTEF9OJYa7hlc+5tDz0hGLsISggMRoGD2LGaLyU/VFD/c5Qw88UImLJM
         Cqi8YqiEVF29/aqLdDzOYjD2UwsGAH+d0AFDOivs/elAQBzuNkZoNZIZ/wEjF2hEqujk
         M5XO08jQO4jirRJeBbwLs2wVAc7MWKjbfPacOSrCp8VZexmOtGB4MEcJpaYphONXscQd
         X1HcucyKOc0rlImAWV3FDuOUhn7DRSnYkaT2jRvWHWkGGSif9g6EyJqfjyNP1vjwSRzA
         Ntxg==
X-Gm-Message-State: AGi0PuaQ60vqgzYmuiYIdusMfc93cBzMUc2FLkkhS5em/VTzhKJK2fsX
        NdlgfszaU4ELzy5CHdftIfsWyecz3Vc=
X-Google-Smtp-Source: APiQypLW7LTz7ruoIMuR0LUUdSjDAZvB0lrl+jFCby4+jUoewb6428yRiCp9YX/6VyhmwAHvc7MXlg==
X-Received: by 2002:a17:90b:2388:: with SMTP id mr8mr1765611pjb.107.1588035783213;
        Mon, 27 Apr 2020 18:03:03 -0700 (PDT)
Received: from dlunevwfh.Home (n1-43-86-194.mas2.nsw.optusnet.com.au. [1.43.86.194])
        by smtp.gmail.com with ESMTPSA id q6sm9392922pfh.193.2020.04.27.18.03.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Apr 2020 18:03:02 -0700 (PDT)
From:   Daniil Lunev <dlunev@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Prashant Malani <pmalani@chromium.org>,
        Daniil Lunev <dlunev@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH] platform/chrome: cros_ec_typec: Handle NULL EC pointer during probe.
Date:   Tue, 28 Apr 2020 11:02:56 +1000
Message-Id: <20200428110253.1.I926f6741079cafb04ecb592130aef75b24ad31ae@changeid>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Missing EC in device hierarchy causes NULL pointer to be returned to the
probe function which leads to NULL pointer dereference when trying to
send a command to the EC. This can be the case if the device is missing
or incorrectly configured in the firmware blob. Even if the situation
occures, the driver shall not cause a kernel panic as the condition is
not critical for the system functions.

Signed-off-by: Daniil Lunev <dlunev@chromium.org>
---

 drivers/platform/chrome/cros_ec_typec.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 874269c07073..30d99c930445 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -301,6 +301,11 @@ static int cros_typec_probe(struct platform_device *pdev)
 
 	typec->dev = dev;
 	typec->ec = dev_get_drvdata(pdev->dev.parent);
+	if (!typec->ec) {
+		dev_err(dev, "Failed to get Cros EC data\n");
+		return -EINVAL;
+	}
+
 	platform_set_drvdata(pdev, typec);
 
 	ret = cros_typec_get_cmd_version(typec);
-- 
2.24.1

