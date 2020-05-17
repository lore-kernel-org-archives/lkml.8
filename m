Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D1A5C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 10:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC2FC206D8
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 10:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X+RPZRro"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbgEQK3h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 06:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727838AbgEQK3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 06:29:36 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E347C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 03:29:36 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f134so6387226wmf.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 03:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=dR0m9BqGN7TZcV3xDXtWZa93fIAGMoZPMNXvSvQx1dg=;
        b=X+RPZRro/L1FMaazUvMf3KNn9JIIcuU481FwjUL7wLvwzF/lqrf3y1zNhMWZSQPWLJ
         77WuVZ65/cpJoIwYkf1QOywcZWbfU0FnPDUspR+wu9VeUKBYdbFSFyIXp8Z0lKEWVOML
         pxRiSxtkqzbMNhicayusNucZaswjTZhETQazsv2jv9/LbiIH3rY47Rn0wwgPTNX1TSv7
         sKucDcmJinKi6U5t5O316m44t1O5ofLEJpfGOTEmBzYDrf84tt7MRkZzZbjMBnwGZMV7
         XKDrTB0Y09+YgUhEd0BC3s0cQ0XOLuADQFidrb/lT4kyoRcmlX6b/vRWDSjl7uJV6fo0
         udRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dR0m9BqGN7TZcV3xDXtWZa93fIAGMoZPMNXvSvQx1dg=;
        b=uaDN9TJ3LDnvwqKiqna5kVSHIvI0v2TRFktrJ9kY8Dstu2XRCo8w2crv6ptEzt+aNY
         KTSuAOhinEpIA+QTlfq1JjR9CM6rRQpbf7RTVrMq3msm8dj8yVYj2aOqdCJhO/urqQRm
         0ITjWMinPgy5FUKggYZ635kfTSFfmKnAEJG5fUI48zpSxi2GyksXaxy/6RJzVxYgGiLP
         s9/rfHV8xH0ChcyAPwQkaS4c90yy28DFoDpmhnted3C3aoRllNn+oH8tAZURAOHmJxPq
         SnFUsjgrwI3dTJJ7d/mTpNl2CRsPfbehzzWYtws0cGRK0s4AEhJuSefmHifbNyEe5BAh
         J6MQ==
X-Gm-Message-State: AOAM530eINoofqZunzzhhpBmR54Wooj/QqgGGSJF/rizyZI/HEpMVm3W
        7QjX3xHoN77FTaaPgtoKYwZRraVH
X-Google-Smtp-Source: ABdhPJybWhrt+FTlKClHARU4+zReK1SV43l0pYRM1DyfF468LXZfH1LsOz6Zaa76hVt4tjDznXcTeA==
X-Received: by 2002:a1c:2843:: with SMTP id o64mr1116707wmo.158.1589711374378;
        Sun, 17 May 2020 03:29:34 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id i4sm6845096wrv.23.2020.05.17.03.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2020 03:29:33 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai
Cc:     gregkh@linuxfoundation.org, Rachel Stahl <rstahl@habana.ai>
Subject: [PATCH] habanalabs: update patched_cb_size for Wreg32
Date:   Sun, 17 May 2020 13:29:30 +0300
Message-Id: <20200517102930.24006-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rachel Stahl <rstahl@habana.ai>

The patch_cb_size is not updated for Wreg32 in its validate function, so
updated in goya_validate_cb.

Signed-off-by: Rachel Stahl <rstahl@habana.ai>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/goya/goya.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 56f415f9120a..15b6c3228e37 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -3394,6 +3394,7 @@ static int goya_validate_cb(struct hl_device *hdev,
 			 */
 			rc = goya_validate_wreg32(hdev,
 				parser, (struct packet_wreg32 *) user_pkt);
+			parser->patched_cb_size += pkt_size;
 			break;
 
 		case PACKET_WREG_BULK:
-- 
2.17.1

