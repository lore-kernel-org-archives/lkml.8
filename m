Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C8EC433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 12:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 656922065C
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 12:02:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bV9bLouL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbgGHMCc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 08:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728637AbgGHMCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 08:02:30 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF28C08C5DC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 05:02:29 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id b6so48659410wrs.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 05:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/GI6WmzBD/tXdjRqMOCJ6wEDBpBeiEpQ/v95OUrVAL8=;
        b=bV9bLouLqxa4IS/T3dEi6X062He0tvGD4Qu/lii+sBTB4lF0PJlrBT8iLObnuSUf/d
         htNbTUHwkzbxbY17Ti9OZOI298t98K0MS6hNsoWwMwcsCPUo3nWfTqmkMHnMbxdFDwIi
         7cLhWhiWk7Jt+bIL+nYY7mPML81GkdliiPEbEJqIfUNk1igpLbKw/cz5TYWHDyLRjtgk
         S//PUlCBhoQn2NoheTUiYMruF8YG+aV7399r8pLTeHV4kq8MmiDx5BTyNiAuDzBcVPId
         n1PpGPt9MNZ2uNMMYT+7vRTd6tgVu8bpnr1hH9IbIyuKzf+P6pXBu4mNP+SiwWU1eBPv
         C1fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/GI6WmzBD/tXdjRqMOCJ6wEDBpBeiEpQ/v95OUrVAL8=;
        b=Fi5jXWbqKWJZ9vvvsDjwHOM89isXkmwv13iwhiguvlTGKA7BqCpkSrYQFx4WwJzjSc
         Y0LkRUVLyB1D3vQN1UEVAfMuMqEGPORifc/Y7ZyVtdoGGAYM8Ae9es2/tQG6aCWAOu1O
         odbaDvRsPzU5wuVV2RH4HCJc+dIl66UIFA7qC9Z629Uk+9IUgBxUJHHu/Drc4d2m/WUp
         CUqMaPNWkmL+2X+CW5zfkhMMN1SvYdPWBG5QD1X4s/zxFeukk++fqlQyZb+vYFqCxRK6
         TMpMBKt5pzrYbIW/Wp9wggWlG8p0xM5NITW3Mo/TrSm7N0xQPMmM74Hv1KzwBw13c705
         R5PA==
X-Gm-Message-State: AOAM533zl5DBZ5PZdMNiSNT2S05MrGRiJTbWQEP5AmyNC9rKedEvxFtc
        wGv7Gf5YeSCdZv2SYG2un2CFKQ==
X-Google-Smtp-Source: ABdhPJwVGA5JxCPrvpb0mkdsBMsuK375rqhOSlXQczWVSfrzvBV+h/UTJTX6pj2n5TmhwEwR5NyToQ==
X-Received: by 2002:a05:6000:ca:: with SMTP id q10mr59989471wrx.135.1594209748519;
        Wed, 08 Jul 2020 05:02:28 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id m62sm3964997wmm.42.2020.07.08.05.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 05:02:27 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: [PATCH 03/30] scsi: libfc: fc_disc: trivial: Fix spelling mistake of 'discovery'
Date:   Wed,  8 Jul 2020 13:01:54 +0100
Message-Id: <20200708120221.3386672-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200708120221.3386672-1-lee.jones@linaro.org>
References: <20200708120221.3386672-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is my fault (can't even blame copy/paste).

Cc: Hannes Reinecke <hare@suse.de>
Reported-by: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/scsi/libfc/fc_disc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/libfc/fc_disc.c b/drivers/scsi/libfc/fc_disc.c
index 428f40cfd1c36..19721db232839 100644
--- a/drivers/scsi/libfc/fc_disc.c
+++ b/drivers/scsi/libfc/fc_disc.c
@@ -370,7 +370,7 @@ static void fc_disc_gpn_ft_req(struct fc_disc *disc)
 
 /**
  * fc_disc_gpn_ft_parse() - Parse the body of the dNS GPN_FT response.
- * @disc:  The descovery context
+ * @disc:  The discovery context
  * @buf:   The GPN_FT response buffer
  * @len:   The size of response buffer
  *
-- 
2.25.1

