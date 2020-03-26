Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D11E5C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 01:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A349920714
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 01:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDHKuu2J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbgCZBrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 21:47:16 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43098 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727666AbgCZBrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 21:47:15 -0400
Received: by mail-qt1-f195.google.com with SMTP id a5so4031527qtw.10;
        Wed, 25 Mar 2020 18:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jQGw0+wDMXMHQyn5mWxU49obk4+l4lWYazhtCW7XAW0=;
        b=BDHKuu2J7gseVH6tcFkPiJy/T9pX4UY/j7J/Kzl04VRhmw8t4V4127gNflvrDVF7QW
         P/rMOa7l4cBB/LgaUwJRCNJJeSaQyBZAVZaoGsv1pc0NIUHPiYqo8ayet57dAY1VP7rb
         jrN5aPY6HxPwVtg9a+pN+Hx0wHoeB22sQGSH7oFKup2f/3VErdn4QXso0Wou4/zjGApM
         77/rJSOp8FPjZ0shGuIZMjox+5TArDkj32ofc7d1+I+iusgKR+PpWB8IMEQq5KUElbAD
         UE1vhEhBLjXxMErAp81ELvHjlUlFBTVi2xJ/dVDPD5AfGhHoem1a6l7bU/5LJey4AZC6
         G6iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jQGw0+wDMXMHQyn5mWxU49obk4+l4lWYazhtCW7XAW0=;
        b=mlg6+61NTCAEpCS7MSb960iMrmcZRbzhdyPp42vnxPmUgCH8xDFARNxBkcM2Due76B
         AIo6wJ9KiE0xWNk5PYoOfZfbAgQzJJCc7/4eDfkqw4yr2OWdeICCnx/z7+Rf70vK7CJH
         mm58jf9QZrawZq81NIiN9pk4Nv6bHpVlzwdqQYNay3B2jv2ATpVwZzYqNy+FfxRksc8k
         8s0CZUenJ4CxebimwpL+8gUZFJx+j4SNtJFkgCwdBrFIomNdHQ7pAg3NaKmFLoHsp/FT
         RSlcMpuwurW5DcDg/s88KXjJocvotZomBFVyu9d+yuNTqTrqneW9VsG3SpsZ+/2yC/ev
         Z99w==
X-Gm-Message-State: ANhLgQ0ueNLCDzesqZpzvc+bJTUzRWG05XtfCwSnSXjHeVw94zUSIZx9
        gTL6xYRB7rtKc51i6IFvTH0=
X-Google-Smtp-Source: ADFU+vsnsYEHvnFA+FQgJGsj0JkfKg/uHMLKYKuSHMYm/4fcjbU4Lrxo7XIWXCfRqO1XIPW4vObP5w==
X-Received: by 2002:ac8:3550:: with SMTP id z16mr5882265qtb.217.1585187232801;
        Wed, 25 Mar 2020 18:47:12 -0700 (PDT)
Received: from localhost.localdomain (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id h129sm463552qkf.54.2020.03.25.18.47.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 25 Mar 2020 18:47:12 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>, pantelis.antoniou@konsulko.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Alan Tull <atull@kernel.org>
Subject: [PATCH 1/2] of: gpio unittest kfree() wrong object
Date:   Wed, 25 Mar 2020 20:45:30 -0500
Message-Id: <1585187131-21642-2-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1585187131-21642-1-git-send-email-frowand.list@gmail.com>
References: <1585187131-21642-1-git-send-email-frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

kernel test robot reported "WARNING: held lock freed!" triggered by
unittest_gpio_remove().  unittest_gpio_remove() was unexpectedly
called due to an error in overlay tracking.  The remove had not
been tested because the gpio overlay removal tests have not been
implemented.

kfree() gdev instead of pdev.

Fixes: f4056e705b2e ("of: unittest: add overlay gpio test to catch gpio hog problem")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 drivers/of/unittest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 96ae8a762a9e..25911ad1ce99 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -122,7 +122,7 @@ static int unittest_gpio_remove(struct platform_device *pdev)
 		gpiochip_remove(&gdev->chip);
 
 	platform_set_drvdata(pdev, NULL);
-	kfree(pdev);
+	kfree(gdev);
 
 	return 0;
 }
-- 
Frank Rowand <frank.rowand@sony.com>

