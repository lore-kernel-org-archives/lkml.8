Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C47C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 18:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 052A9206EB
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 18:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SLZeJhgv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbgIBSMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 14:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgIBSMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 14:12:45 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE50C061245;
        Wed,  2 Sep 2020 11:12:44 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id mw10so188358pjb.2;
        Wed, 02 Sep 2020 11:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YlP++aNo5WyMtGJ0CAnpVmn1PYqVs1MEomEwiDLDlvE=;
        b=SLZeJhgvzy1SwbnBEyEm39X14VGdB+s6VaQ/yLOmSqZ40TLeICXfNEyos2uBSsp415
         ef7Qi8KYVMZY/7DYizQBs+BrO6KJVwM3a8pOF+26udAKw8VaUT91w5sJiIq79+2LP1x7
         wE1onhmhnhYrsJFRGGXFHOG77WhzSopANFDW8QeKk1S30fE2iCLJ5hwvi9tI+iuKR9Hv
         DQkWZOcYDhW5izPLwcyqFth7mIWLdTpwBXKtOZzrh9U6VoKY7FS8KvTfH0lGIL9bsmR3
         9tsS0SC+hZ/xCGlGTzqnOjHPHYg/D01LWoZFWcRvv4vrgO1IzTR9DK0QtDLv04/rUcx7
         v4bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YlP++aNo5WyMtGJ0CAnpVmn1PYqVs1MEomEwiDLDlvE=;
        b=WQg1tDOAHB+KesluGWabmPeNN9IkR7jczMeYhZvplAwjQxETX7yopuc3HmyzbT5mUU
         NgoCzUtCFTCRNykTAYYpdlY5QdCSnHnMAtiMapTdNBBC2OOS3MLWr6c+d59AFapcNTdI
         L0xWzGvZSExIC5E8HtCnaITZA2GlNDPalIUHmMWR7sTyOMknyQ3NsWQBTb5M3koVxvaj
         eKe+s94T6nKFquXDfmqHINwSuFfHMd6Ds7qJ7TVqHhrWkITFdFb1UAOLX4xHe57OmlqU
         ynoo0UrJS77Oo6JlVV4xuytIn4TV8sPqQGDVctDqPbjkKhnQl/7ryktue8jh5Mo4vsUh
         zOtw==
X-Gm-Message-State: AOAM533+yTOz8hyefjkKp5LRuh9jqAlUhanEfci8JHX0Hm30lb4/2JtQ
        JnajUp+CnPIK5YU0UxYEfsPyWjPZJmo=
X-Google-Smtp-Source: ABdhPJxyAoeqcuz+tnhtvw279R9EQntj/xjvELk+nr6rkRC6rcP4eI7+rxiJxihTY3+IvWDlXHTkiA==
X-Received: by 2002:a17:90a:a005:: with SMTP id q5mr3026666pjp.152.1599070364055;
        Wed, 02 Sep 2020 11:12:44 -0700 (PDT)
Received: from localhost.localdomain (cpe-172-112-234-200.socal.res.rr.com. [172.112.234.200])
        by smtp.gmail.com with ESMTPSA id u123sm148993pfb.209.2020.09.02.11.12.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Sep 2020 11:12:43 -0700 (PDT)
From:   lindsey.stanpoor@gmail.com
To:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org, heiko@sntech.de,
        balbi@kernel.org, cnemo@tutanota.com
Subject: [PATCH v4 2/4] usb: dwc3: of-simple: Add compatible for rk3328
Date:   Wed,  2 Sep 2020 11:12:32 -0700
Message-Id: <20200902181234.13955-2-lindsey.stanpoor@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200902181234.13955-1-lindsey.stanpoor@gmail.com>
References: <20200902181234.13955-1-lindsey.stanpoor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cameron Nemo <cnemo@tutanota.com>

Add a compatible to be hooked into by the Rockchip rk3328 device tree.

The rk3399 compatible cannot be reused because the rk3328 SoCs may
require a specialized driver in the future, and old device trees must
remain compatible with newer kernels.

Signed-off-by: Cameron Nemo <cnemo@tutanota.com>
---
 drivers/usb/dwc3/dwc3-of-simple.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/dwc3/dwc3-of-simple.c b/drivers/usb/dwc3/dwc3-of-simple.c
index 7df115012935..0727bf2304b1 100644
--- a/drivers/usb/dwc3/dwc3-of-simple.c
+++ b/drivers/usb/dwc3/dwc3-of-simple.c
@@ -171,6 +171,7 @@ static const struct dev_pm_ops dwc3_of_simple_dev_pm_ops = {
 };
 
 static const struct of_device_id of_dwc3_simple_match[] = {
+	{ .compatible = "rockchip,rk3328-dwc3" },
 	{ .compatible = "rockchip,rk3399-dwc3" },
 	{ .compatible = "xlnx,zynqmp-dwc3" },
 	{ .compatible = "cavium,octeon-7130-usb-uctl" },
-- 
2.28.0

