Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F73CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 21:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C88F920772
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 21:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OAc2dXOY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbgF3VIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 17:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbgF3VIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 17:08:13 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4E5C061755;
        Tue, 30 Jun 2020 14:08:13 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id k5so469525pjg.3;
        Tue, 30 Jun 2020 14:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mOueOrU/MztlC+Mzo/PRCS1EQQCyJoQy2Oc5pG3fIVA=;
        b=OAc2dXOYyTgHX8CbckWVMX+g5e2DIRNsIh3tm9tesxal8k1M2pmB3ehGHr2b0TlLNb
         udnji61Gjyx7Dz5dnC2lmVyBGt5/LTNLtk8Q2lXc4br5QvNGFT+ZP8IglhemBw/i+OQC
         Bu2/DsMDzAgb/pSfxO+wBEhSU49MdgK00/wd9e/z7hOvepqfovUgWZ8t4Xh6bD4PlyN/
         EgAFNYlkI/SOPBDZ6oK09ELznXM/GK7qIxFMANKqKlhSava+gus//XIq7z1SDC5HvlZl
         HJ2ra9VjWALHcWzm6CQcIUc5KSx/z0pEz96UhsNAkkd6HRNnu4X4iGHBXSCi6eMoT1dA
         mbLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mOueOrU/MztlC+Mzo/PRCS1EQQCyJoQy2Oc5pG3fIVA=;
        b=kbZKyLaqvAvCuy4aOAdmcmprqn2fGFzm3psB6B/L4KyTXIBVv+pW2Nt2BrRLKjg/pi
         MN91DJGPaY0a87wuQF7HldDZxkJeQceQr5OB+CApbd1BDd0TMXGEuWjezOMkzeQUVSCt
         DToKh92GC9ksrxOWVzFgtecuvuu5k3DamwOhcBglJZnSRrX/e31m5Vf3LazZAN2o1nZS
         PRkuHgVtzM/8Fi80SIJ69huq1YlnbfBQ+RqHYEHUT7X6L6KaoRvt0CjvBnKZkX1ZzGea
         spZAfZ0LYYo+u1vggrGHxjIbJZQ9UP02n/at5EQCEEwuZzomoGTXd/mIuW2rMKPIt5Nf
         0Ujw==
X-Gm-Message-State: AOAM532P/+IkTMBlloO/+dw+6AfmBVA6mXCR2x5GZE/8O6eqbyYTFCN8
        LtDOlJTIAz2m1H+DGv2tegoMzL6R
X-Google-Smtp-Source: ABdhPJx0zpNbTsl97R86OZuv72rXcejwkzxEuv8JklwnYbg1G+787xwpu7eZxV3mMuOa/SQBU4kxKQ==
X-Received: by 2002:a17:902:aa0c:: with SMTP id be12mr19635013plb.45.1593550868913;
        Tue, 30 Jun 2020 14:01:08 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:1000:7a00::1])
        by smtp.gmail.com with ESMTPSA id c19sm3070079pjs.11.2020.06.30.14.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 14:01:08 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        Don Fry <pcnet32@frontier.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH net-next 1/2] amd8111e: Mark PM functions as __maybe_unused
Date:   Tue, 30 Jun 2020 14:00:33 -0700
Message-Id: <20200630210034.3624587-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In certain configurations without power management support, the
following warnings happen:

../drivers/net/ethernet/amd/amd8111e.c:1623:12: warning:
'amd8111e_resume' defined but not used [-Wunused-function]
 1623 | static int amd8111e_resume(struct device *dev_d)
      |            ^~~~~~~~~~~~~~~
../drivers/net/ethernet/amd/amd8111e.c:1584:12: warning:
'amd8111e_suspend' defined but not used [-Wunused-function]
 1584 | static int amd8111e_suspend(struct device *dev_d)
      |            ^~~~~~~~~~~~~~~~

Mark these functions as __maybe_unused to make it clear to the compiler
that this is going to happen based on the configuration, which is the
standard for these types of functions.

Fixes: 2caf751fe080 ("amd8111e: Convert to generic power management")
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/net/ethernet/amd/amd8111e.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/amd/amd8111e.c b/drivers/net/ethernet/amd/amd8111e.c
index c6591b33abcc..5d389a984394 100644
--- a/drivers/net/ethernet/amd/amd8111e.c
+++ b/drivers/net/ethernet/amd/amd8111e.c
@@ -1581,7 +1581,7 @@ static void amd8111e_tx_timeout(struct net_device *dev, unsigned int txqueue)
 		netif_wake_queue(dev);
 }
 
-static int amd8111e_suspend(struct device *dev_d)
+static int __maybe_unused amd8111e_suspend(struct device *dev_d)
 {
 	struct net_device *dev = dev_get_drvdata(dev_d);
 	struct amd8111e_priv *lp = netdev_priv(dev);
@@ -1620,7 +1620,7 @@ static int amd8111e_suspend(struct device *dev_d)
 	return 0;
 }
 
-static int amd8111e_resume(struct device *dev_d)
+static int __maybe_unused amd8111e_resume(struct device *dev_d)
 {
 	struct net_device *dev = dev_get_drvdata(dev_d);
 	struct amd8111e_priv *lp = netdev_priv(dev);

base-commit: ff91e9292fc5aafd9ee1dc44c03cff69a3b0f39f
-- 
2.27.0

