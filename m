Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F5B5C433E4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 15:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5967B20663
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 15:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eAkwWsC4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbgGOPnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 11:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726402AbgGOPnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 11:43:13 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED038C061755;
        Wed, 15 Jul 2020 08:43:12 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id b25so3110319ljp.6;
        Wed, 15 Jul 2020 08:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4Uquz2cUXAsNkebI07cUnJTpD7lMymggdeIx4TLm5Zs=;
        b=eAkwWsC4SvtuONlDmsXgzlEuVDoQKmQdtfQxKrKRCCgcvU2UW55qZ2P9GQoKQLccrM
         AlJVR0MiOzGB7kSsPS1z5OrkEkpkPYglQxi+0HxLgJH615zHjfrXeEDSceS0zvN0TA7o
         bAcX7wzyA9oNj2UpN3MrtjBwK6YkwTjhe57eFxFv3KfrbIv2/1E4/UflcczzdVZRf0y2
         sKxOK1T6KLv2UQBf2ZacHqeHcIQZNxlM9JV0XUGXEMc2BT2C/K3XiVVvlikyZoVSKDw1
         TzcakFppiacvwmS+pPR3XMDPLU9GLg7f8zJlTvIdJtXX2gGU5GfHE07zSHp+ibHOrCBs
         N1ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4Uquz2cUXAsNkebI07cUnJTpD7lMymggdeIx4TLm5Zs=;
        b=mzCbf7D/jIF6dvZXrGqH9FKsT1m9xY0g+AcAKgwyuF1zFhiEQW0CHshZeo8jEYvS20
         eWJDVF75mPHROzqPZBDZJt2ZxhkGAeYQohC9Pp+Lpb/mEiaJXxW92q9gwKTOs4f/FJrX
         CEx6DOibNixCSZU2ep8I3wptQ/Blmu55e8P6o8uUOucJQ9dBHn8ltBH6eS3b5Xr52UTY
         SNcs9EEBnQPhesd5p0U5s8GiWc+PtTZLLYLb8xeWD1VUPPI7SHDlCzloZ9ShBemgBKhA
         GcxNjM96iJYRR3kovHl2fm8/dd7c8OKkFUfi53LBS6+IRQMk3XDdKZpxj4G4HJc1QmFp
         upiA==
X-Gm-Message-State: AOAM531iCM8oXMvTg+8qR1ura68Qv34yM76DLiqZbgGLwDhDhwLj/J5J
        kThAd5F5n2oDWLIr/cps9ply6eJr
X-Google-Smtp-Source: ABdhPJy9n946MWIITS2PG4rpk28bH1oXW/JL416AzmkGtAiqAOCgDNrkrCxc0idvXr9zLr0B1G5EAQ==
X-Received: by 2002:a05:651c:511:: with SMTP id o17mr4820999ljp.433.1594827791169;
        Wed, 15 Jul 2020 08:43:11 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id c6sm563955lff.77.2020.07.15.08.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 08:43:10 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Fugang Duan <fugang.duan@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH net-next v2 4/4] net: fec: replace snprintf() with strlcpy() in fec_ptp_init()
Date:   Wed, 15 Jul 2020 18:43:00 +0300
Message-Id: <20200715154300.13933-5-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200715154300.13933-1-sorganov@gmail.com>
References: <20200706142616.25192-1-sorganov@gmail.com>
 <20200715154300.13933-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need to use snprintf() on a constant string, nor using magic
constant in the fixed code was a good idea.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 drivers/net/ethernet/freescale/fec_ptp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fec_ptp.c b/drivers/net/ethernet/freescale/fec_ptp.c
index 0c8c56bdd7ac..93a86553147c 100644
--- a/drivers/net/ethernet/freescale/fec_ptp.c
+++ b/drivers/net/ethernet/freescale/fec_ptp.c
@@ -570,7 +570,7 @@ void fec_ptp_init(struct platform_device *pdev, int irq_idx)
 	int ret;
 
 	fep->ptp_caps.owner = THIS_MODULE;
-	snprintf(fep->ptp_caps.name, 16, "fec ptp");
+	strlcpy(fep->ptp_caps.name, "fec ptp", sizeof(fep->ptp_caps.name));
 
 	fep->ptp_caps.max_adj = 250000000;
 	fep->ptp_caps.n_alarm = 0;
-- 
2.10.0.1.g57b01a3

