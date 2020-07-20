Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 314AEC433E8
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04DDE207DD
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595261669;
	bh=UckB6aorP9uBAZnlnr9liyRAEo9To/eHwIwBb1ucEnA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SIT7z2ylnH9Rh3GuxLkaIk9auY8Hep29j+qedCYeuX1T1Fy6w5dVYNuGhv3pw8vG/
	 LJ545ldSNFTVqc+MB8qbRv7EMFcxpbfLwyYg7Wf15B+l3gfWCYVj0YFNFrIztH4+jV
	 1BrwNAjhWxG7gqqVNyHcKLo8Zx4YSV06H4iSFKBE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388266AbgGTQO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:14:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:54828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387834AbgGTQOY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:14:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 585F92065E;
        Mon, 20 Jul 2020 16:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595261663;
        bh=UckB6aorP9uBAZnlnr9liyRAEo9To/eHwIwBb1ucEnA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vRhbkwBjMKG6Eq1wxCMnOgxkgjlu8Tn5TmWnXiXbS6GoHgZ8/l2ByKDxUmzrhbJpn
         9whI2AqoMwhFEQL55SE4sQAieQKRFBAHJPSt3iXuriVBT6SEsnrSwHaZylN5NMs5gb
         hAMOYGz9yv3uHtwDHm3MOq4eFnIKxB45B+42745Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vishwas M <vishwas.reddy.vr@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 5.7 197/244] hwmon: (emc2103) fix unable to change fan pwm1_enable attribute
Date:   Mon, 20 Jul 2020 17:37:48 +0200
Message-Id: <20200720152835.217335940@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152825.863040590@linuxfoundation.org>
References: <20200720152825.863040590@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vishwas M <vishwas.reddy.vr@gmail.com>

commit 14b0e83dc4f1e52b94acaeb85a18fd7fdd46d2dc upstream.

This patch fixes a bug which does not let FAN mode to be changed from
sysfs(pwm1_enable). i.e pwm1_enable can not be set to 3, it will always
remain at 0.

This is caused because the device driver handles the result of
"read_u8_from_i2c(client, REG_FAN_CONF1, &conf_reg)" incorrectly. The
driver thinks an error has occurred if the (result != 0). This has been
fixed by changing the condition to (result < 0).

Signed-off-by: Vishwas M <vishwas.reddy.vr@gmail.com>
Link: https://lore.kernel.org/r/20200707142747.118414-1-vishwas.reddy.vr@gmail.com
Fixes: 9df7305b5a86 ("hwmon: Add driver for SMSC EMC2103 temperature monitor and fan controller")
Cc: stable@vger.kernel.org
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hwmon/emc2103.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/hwmon/emc2103.c
+++ b/drivers/hwmon/emc2103.c
@@ -443,7 +443,7 @@ static ssize_t pwm1_enable_store(struct
 	}
 
 	result = read_u8_from_i2c(client, REG_FAN_CONF1, &conf_reg);
-	if (result) {
+	if (result < 0) {
 		count = result;
 		goto err;
 	}


