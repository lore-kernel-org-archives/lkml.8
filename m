Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C588EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 22:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A7EB2074B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 22:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TjbvbuP8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgFJWra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 18:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbgFJWr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 18:47:27 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29BF1C03E96F
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 15:47:27 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id z9so4546756ljh.13
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 15:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yga3hm+EDiOZlI7uI4fAJaNWzJv8ZipojjERf4LmzU0=;
        b=TjbvbuP8W/z/RS6vyQaYZNL2eSdge045W71vWPtAJRyPz4V15WiJKjnCLBuUx0rGQb
         EP7hKPN6fV+lVWDsoJqOGVPelzCajyND4KJ4hk7zG7SiEzKbTYpNArtKLJh0wrE5plVr
         fAGt7DHjkZqDGPjK+uYVhiI1w4BH8OZ8jJaBKGBx5vXYkZqV3KQXtO9KnlnzjYxMNhcG
         hMDmQUtGC6Y5qszBPPXeG5PrKXJKPa/YRiyOSqRKgSc9+U6CCHDdOoCbTMfaUU/34lmB
         jFyejwmYbQTEdxignq/UWvp7zkNnfrZ6qcCbAwnxy07jJc47UMlFLJ4qopIk+6oiulP9
         zLcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yga3hm+EDiOZlI7uI4fAJaNWzJv8ZipojjERf4LmzU0=;
        b=Cu28UjWOoEwwWHYxvslnG3pz/yiHT+g1hsTmfV8T2N75fIgikZXDmc0hV1X0dJjnyE
         l+98fmP1sYXSeYu9cpQYUYx3He0o2aXPjcLrfrAL92pSH2qrA9TWNqwJPSXReFoak/Sg
         TMYeB1oGtpztOMTzd+spJ2QdKd9ljowXGQTnN1a6g1LB+7SSLOwdvKNaFzwgXL+kMDq7
         35tHMFB13sjteq0Sfm4o2iBkcP8yJ0b6acCaJAXfoIZgXwE65BfQb+n6vAxXMRgVbh8c
         g7lNI+xfwfdNHTTS19/0aoz5vMcvok74WjMD1S8L1ETHAzed1PojfRahHx4BxwhLpLB8
         c9RQ==
X-Gm-Message-State: AOAM530+ZtmjKQDSppf4/4SJnirkQQ4k8C3z4w5dFVD7a0ixTC/YWsCv
        E8aqze/oFC34f69ZjciEe7SBb4SoT1Q=
X-Google-Smtp-Source: ABdhPJy37r8BEf6BcZzghuty0+ZX2GMEwJolyf9F9N3YbXTCt5n0Y6qLBunMAuTNWtdkefMD4TDBDw==
X-Received: by 2002:a05:651c:544:: with SMTP id q4mr3001701ljp.310.1591829245444;
        Wed, 10 Jun 2020 15:47:25 -0700 (PDT)
Received: from localhost.localdomain (h-82-196-111-136.NA.cust.bahnhof.se. [82.196.111.136])
        by smtp.gmail.com with ESMTPSA id s17sm262506ljd.51.2020.06.10.15.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 15:47:24 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Sudeep Dutt <sudeep.dutt@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>
Subject: [PATCH 4/4] mic: vop: Constify static structs
Date:   Thu, 11 Jun 2020 00:47:04 +0200
Message-Id: <20200610224704.27082-5-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200610224704.27082-1-rikard.falkeborn@gmail.com>
References: <20200610224704.27082-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vop_vq_config_ops and id_table[] are never modified so make them const
to allow the compiler to put them in read-only memory.

Before:
   text    data     bss     dec     hex filename
  14889    4065     192   19146    4aca drivers/misc/mic/vop/vop_main.o

After:
   text    data     bss     dec     hex filename
  15113    3841     192   19146    4aca drivers/misc/mic/vop/vop_main.o

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/misc/mic/vop/vop_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/mic/vop/vop_main.c b/drivers/misc/mic/vop/vop_main.c
index 85942f6717c5..51a1ab83a630 100644
--- a/drivers/misc/mic/vop/vop_main.c
+++ b/drivers/misc/mic/vop/vop_main.c
@@ -438,7 +438,7 @@ static int vop_find_vqs(struct virtio_device *dev, unsigned nvqs,
 /*
  * The config ops structure as defined by virtio config
  */
-static struct virtio_config_ops vop_vq_config_ops = {
+static const struct virtio_config_ops vop_vq_config_ops = {
 	.get_features = vop_get_features,
 	.finalize_features = vop_finalize_features,
 	.get = vop_get,
@@ -763,7 +763,7 @@ static void vop_driver_remove(struct vop_device *vpdev)
 	kfree(vi);
 }
 
-static struct vop_device_id id_table[] = {
+static const struct vop_device_id id_table[] = {
 	{ VOP_DEV_TRNSP, VOP_DEV_ANY_ID },
 	{ 0 },
 };
-- 
2.27.0

