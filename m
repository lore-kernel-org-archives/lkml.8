Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35D9C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81F6121655
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588615599;
	bh=sJvUXY4jKJ59y85O7d56ajWyoMqv8hzihExsn6RTZ+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PjzekUmRfOoccCTr0+WKimnDbGt0OiIwlF0ernxD9fBBuCh65VET7Ppfo/fmH7pRj
	 vq5mpD1HNNi2bUaAOcPfeyU1jXZE/SXVSmBzM2geDlSFjN4Gi6nMWxmBIRrdciZEBG
	 ut/QT89y739ZZ+0dY5wKzfHh5b0o+pLNs5KjeQfk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731999AbgEDSGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 14:06:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:36916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731983AbgEDSG3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 14:06:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1897A206B8;
        Mon,  4 May 2020 18:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588615589;
        bh=sJvUXY4jKJ59y85O7d56ajWyoMqv8hzihExsn6RTZ+8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2P0kurVk1WDyCT6UTgymcgZ2CMYym92mYCSbAkXFXQvhNBY7duacZPE+NRJMl/vJ1
         1E0uUbuhtInTJ72pMPRIMjdIGi7RANQUgGFkX8UKRRRj/1Tvft0LRp/NhaFtiF4axt
         uyy0nOCAzsMwmMKMPvEktX0SAg9DvLHCK/9JY0+M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vasily Averin <vvs@virtuozzo.com>,
        Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 5.6 09/73] drm/qxl: qxl_release leak in qxl_hw_surface_alloc()
Date:   Mon,  4 May 2020 19:57:12 +0200
Message-Id: <20200504165503.581526098@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200504165501.781878940@linuxfoundation.org>
References: <20200504165501.781878940@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasily Averin <vvs@virtuozzo.com>

commit a65aa9c3676ffccb21361d52fcfedd5b5ff387d7 upstream.

Cc: stable@vger.kernel.org
Fixes: 8002db6336dd ("qxl: convert qxl driver to proper use for reservations")
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
Link: http://patchwork.freedesktop.org/patch/msgid/2e5a13ae-9ab2-5401-aa4d-03d5f5593423@virtuozzo.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/qxl/qxl_cmd.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/qxl/qxl_cmd.c
+++ b/drivers/gpu/drm/qxl/qxl_cmd.c
@@ -480,9 +480,10 @@ int qxl_hw_surface_alloc(struct qxl_devi
 		return ret;
 
 	ret = qxl_release_reserve_list(release, true);
-	if (ret)
+	if (ret) {
+		qxl_release_free(qdev, release);
 		return ret;
-
+	}
 	cmd = (struct qxl_surface_cmd *)qxl_release_map(qdev, release);
 	cmd->type = QXL_SURFACE_CMD_CREATE;
 	cmd->flags = QXL_SURF_FLAG_KEEP_DATA;


