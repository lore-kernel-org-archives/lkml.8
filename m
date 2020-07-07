Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38FD3C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 07:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19159206E2
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 07:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DAsb8bSZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbgGGHny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 03:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgGGHnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 03:43:53 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EBA5C061755;
        Tue,  7 Jul 2020 00:43:53 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id o13so16651271pgf.0;
        Tue, 07 Jul 2020 00:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Oqg0waFV1lp8h1+Iq31KyC6DKlnZLj0Pwy1UxBj6Ho8=;
        b=DAsb8bSZtj79L46P+civ1l7WY7x77+BCU4mrZLoBfLIpXtNgH1HY/lGwcKX2o3IbLD
         5YRotXnwFtE0/TLB7mK53OSZivzhuVYrhazRzq+ZZ6HVXVsn2BmZBf8z8/XZ+m2Uh8ev
         bBcfzjmSV01aIEj+gdxVZvQ48Qx50LPHGWxHhGlnK2wC7rrJAiUw3wfAAm1GYV1VrnTs
         RTPqS5j1+9Cxw44HyDO6ExYYCPzmdqCqvIj+0AZGi/cL34fB+11+/LIPWONa2K4EA4/q
         19V0Al4aVIL718Dqf1AvU/RGpCkCwOrFh29Egcac8Nn27l613DujT9givcMQe+j6yewv
         dCaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Oqg0waFV1lp8h1+Iq31KyC6DKlnZLj0Pwy1UxBj6Ho8=;
        b=nKPlFdosCkykiq48AAwmA1V4p+cWiapFvAodt1v2595pxbC9S4DLWDeFPQx98aWKCK
         W9QSrAQeopJmojHDXOj/X1TS4YxqkNBnviDgtXAUvWSgNIlEGKQZgHZkDx+DOcVck5Pk
         r45EwR2cXQziTro1QW3a3NpUD6hn/fXtYXrlYaS4TsMoK0dDG/w4TEcq9bFowAX3f6FP
         /A+wBnp7FK2L6bZ5tWNWlKdxooZh+JVSQUlHQzQ9eeTUemwlmjfgv0bZWfnBl37T2cXZ
         mEK51aNCdx5A4LUiqvlYcGv3IzCkRQKWK+0ukXZukOIKSKbj80E4lj7Opblxw/Nk9Ucx
         MPnw==
X-Gm-Message-State: AOAM533n923SLP9MD/ycY5zp+2psE1L4KyfUrc7C4op32Z4pwaHHbkR0
        84tRQ4l3PhEGzS30tirC2vU=
X-Google-Smtp-Source: ABdhPJyZxivWa3Zwd3TiXVj2C5Co1Tk0OgrJzdk8Va7YqEXPvY+3BH4n2OB5Ix08Z3T1moPGNugPhA==
X-Received: by 2002:a62:fb06:: with SMTP id x6mr48186275pfm.28.1594107832958;
        Tue, 07 Jul 2020 00:43:52 -0700 (PDT)
Received: from varodek.iballbatonwifi.com ([103.105.153.67])
        by smtp.gmail.com with ESMTPSA id s30sm21439248pgn.34.2020.07.07.00.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 00:43:52 -0700 (PDT)
From:   Vaibhav Gupta <vaibhavgupta40@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, bjorn@helgaas.com,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Vaibhav Gupta <vaibhavgupta40@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org
Subject: [PATCH net-next] sun/niu: add __maybe_unused attribute to PM functions
Date:   Tue,  7 Jul 2020 13:11:22 +0530
Message-Id: <20200707074121.230686-1-vaibhavgupta40@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The upgraded .suspend() and .resume() throw
"defined but not used [-Wunused-function]" warning for certain
configurations.

Mark them with "__maybe_unused" attribute.

Compile-tested only.

Fixes: b0db0cc2f695 ("sun/niu: use generic power management")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
---
 drivers/net/ethernet/sun/niu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/sun/niu.c b/drivers/net/ethernet/sun/niu.c
index 68541c823245..b4e20d15d138 100644
--- a/drivers/net/ethernet/sun/niu.c
+++ b/drivers/net/ethernet/sun/niu.c
@@ -9873,7 +9873,7 @@ static void niu_pci_remove_one(struct pci_dev *pdev)
 	}
 }
 
-static int niu_suspend(struct device *dev_d)
+static int __maybe_unused niu_suspend(struct device *dev_d)
 {
 	struct net_device *dev = dev_get_drvdata(dev_d);
 	struct niu *np = netdev_priv(dev);
@@ -9900,7 +9900,7 @@ static int niu_suspend(struct device *dev_d)
 	return 0;
 }
 
-static int niu_resume(struct device *dev_d)
+static int __maybe_unused niu_resume(struct device *dev_d)
 {
 	struct net_device *dev = dev_get_drvdata(dev_d);
 	struct niu *np = netdev_priv(dev);
-- 
2.27.0

