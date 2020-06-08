Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B7BDC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 745A220823
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591658340;
	bh=5xfvrXfgGzAoI+QrpARM+doyiSzu3Hq1ghxRMgHX12I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IG5fZaGslgx5jls4p2FwdY+huzUM0DM0jRl+F5tn7IpVpP7xIpHIhd4HVQvAfrPFL
	 UAlPw9tAMug2YUG3IMxzHAv9UWppZsxIPiwp78pUPM9gu0erlss31VPYVvW8Bav7gV
	 ePLjaDYh6nsVfeaUuoAjT366xfNnCBuleLL2YNNg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730734AbgFHXS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:18:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:36238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728561AbgFHXPV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:15:21 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 756BD20774;
        Mon,  8 Jun 2020 23:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658121;
        bh=5xfvrXfgGzAoI+QrpARM+doyiSzu3Hq1ghxRMgHX12I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FPL2qmpcq13FQwScbyJCY6LXUpPfKKjJU3/ZQN/oOHBPl2/pjjkZ8rAAKF1UtXWKG
         2gI1SuJigWmptD6FWyh1MKbwytOGWiU4A+h/kcssdyWTDUe9Lds7pwJ2LIOUEREA99
         Ot9dJqbsmjrYeiLrFXLNz5e39/gyFiXiF5uJE6Iw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vladimir Murzin <vladimir.murzin@arm.com>,
        Dijil Mohan <Dijil.Mohan@arm.com>,
        Vinod Koul <vkoul@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dmaengine@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 158/606] dmaengine: dmatest: Restore default for channel
Date:   Mon,  8 Jun 2020 19:04:43 -0400
Message-Id: <20200608231211.3363633-158-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608231211.3363633-1-sashal@kernel.org>
References: <20200608231211.3363633-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladimir Murzin <vladimir.murzin@arm.com>

commit 6b41030fdc79086db5d673c5ed7169f3ee8c13b9 upstream.

In case of dmatest is built-in and no channel was configured test
doesn't run with:

dmatest: Could not start test, no channels configured

Even though description to "channel" parameter claims that default is
any.

Add default channel back as it used to be rather than reject test with
no channel configuration.

Fixes: d53513d5dc285d9a95a534fc41c5c08af6b60eac ("dmaengine: dmatest: Add support for multi channel testing)
Reported-by: Dijil Mohan <Dijil.Mohan@arm.com>
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
Link: https://lore.kernel.org/r/20200429071522.58148-1-vladimir.murzin@arm.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/dma/dmatest.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
index 364dd34799d4..0425984db118 100644
--- a/drivers/dma/dmatest.c
+++ b/drivers/dma/dmatest.c
@@ -1166,10 +1166,11 @@ static int dmatest_run_set(const char *val, const struct kernel_param *kp)
 		mutex_unlock(&info->lock);
 		return ret;
 	} else if (dmatest_run) {
-		if (is_threaded_test_pending(info))
-			start_threaded_tests(info);
-		else
-			pr_info("Could not start test, no channels configured\n");
+		if (!is_threaded_test_pending(info)) {
+			pr_info("No channels configured, continue with any\n");
+			add_threaded_test(info);
+		}
+		start_threaded_tests(info);
 	} else {
 		stop_threaded_test(info);
 	}
-- 
2.25.1

