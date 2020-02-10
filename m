Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49718C3B187
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18E40208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581338472;
	bh=GfY0bmBiqh0NqfU7FYMqZtKu8Wg4/HCjFIo9gPncUJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jjlk6zSLJepSYojc08nexM63spFoCkrH5i3Zo2HxIyx3WO7NR8IcM/r5U3FE6Q8t7
	 J4x5OVh9lqTwrRFTuq6WJSNBeErkyepeujdXt2d2MTk/riIwax4POPQu1zgV7pkRLN
	 UUdYZZm3ylCUvth8YDXjz4f437UVns7gtcm6C4mw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729919AbgBJMlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:41:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:34490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728593AbgBJMih (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:38:37 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1050B20838;
        Mon, 10 Feb 2020 12:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338316;
        bh=GfY0bmBiqh0NqfU7FYMqZtKu8Wg4/HCjFIo9gPncUJA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MQkDwvlOheMaRq8jp/xVbEXBvbXD2nfx4+PfKrED8azWMqDt94V++kT5mCAWeh+mQ
         gVcn9Zcoo3L1euTWKTzyVresssBvhO0WmlJR5yzTBLKF69X/OdYcIgQk+o6VKGqFY0
         6U2TVcdVuZDOKdoSKCdZxpWHIwFP4jw6RpitCH0I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 5.4 243/309] phy: qualcomm: Adjust indentation in read_poll_timeout
Date:   Mon, 10 Feb 2020 04:33:19 -0800
Message-Id: <20200210122429.853110610@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122406.106356946@linuxfoundation.org>
References: <20200210122406.106356946@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

commit a89806c998ee123bb9c0f18526e55afd12c0c0ab upstream.

Clang warns:

../drivers/phy/qualcomm/phy-qcom-apq8064-sata.c:83:4: warning:
misleading indentation; statement is not part of the previous 'if'
[-Wmisleading-indentation]
                 usleep_range(DELAY_INTERVAL_US, DELAY_INTERVAL_US + 50);
                 ^
../drivers/phy/qualcomm/phy-qcom-apq8064-sata.c:80:3: note: previous
statement is here
                if (readl_relaxed(addr) & mask)
                ^
1 warning generated.

This warning occurs because there is a space after the tab on this line.
Remove it so that the indentation is consistent with the Linux kernel
coding style and clang no longer warns.

Fixes: 1de990d8a169 ("phy: qcom: Add driver for QCOM APQ8064 SATA PHY")
Link: https://github.com/ClangBuiltLinux/linux/issues/816
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/phy/qualcomm/phy-qcom-apq8064-sata.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/phy/qualcomm/phy-qcom-apq8064-sata.c
+++ b/drivers/phy/qualcomm/phy-qcom-apq8064-sata.c
@@ -80,7 +80,7 @@ static int read_poll_timeout(void __iome
 		if (readl_relaxed(addr) & mask)
 			return 0;
 
-		 usleep_range(DELAY_INTERVAL_US, DELAY_INTERVAL_US + 50);
+		usleep_range(DELAY_INTERVAL_US, DELAY_INTERVAL_US + 50);
 	} while (!time_after(jiffies, timeout));
 
 	return (readl_relaxed(addr) & mask) ? 0 : -ETIMEDOUT;


