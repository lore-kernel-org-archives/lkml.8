Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F27EC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A9752067C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597689059;
	bh=VdDv/tPrzl9Gjvzoe32tHMeY4aINAE3rMv3C+4ryWME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FfUqbJw9syrRsVHF6a5kcuCrBI/s2f1kM0bkcVlaVCrvwRpYaLX/6CDV6TiQmYOKw
	 ZqjoIyUUJyBhqMgUj7+6kFrmx3hTR+eQMI5NuIKU7w1r7CEK2Kf1WEjBZ6y6f+9Amc
	 aamrN+v4FXm56jy8Ngu12J4skB8T/P7DqHAEws+Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391086AbgHQSaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:30:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:48896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388148AbgHQQB3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 12:01:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED247207FB;
        Mon, 17 Aug 2020 16:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597680087;
        bh=VdDv/tPrzl9Gjvzoe32tHMeY4aINAE3rMv3C+4ryWME=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tIru1hqaT/u1Uh5QZC9SuRmu0P3ibIFqMYtAVTs51o3Q46SILJvHaiiN5gX9pVsxH
         jGJ1kmo9hrJI6z5yl+yx8x/KJEGlZ8rcX6/kJt721wwnV30v6G4l/Dt7WOdzoTfkaZ
         wW3RXXUGYXnW2yqhesjBJ1hJ5ZvBGXg1eXozlI1U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 047/270] soc: qcom: rpmh-rsc: Set suppress_bind_attrs flag
Date:   Mon, 17 Aug 2020 17:14:08 +0200
Message-Id: <20200817143758.134261276@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143755.807583758@linuxfoundation.org>
References: <20200817143755.807583758@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maulik Shah <mkshah@codeaurora.org>

[ Upstream commit 1a53ce9ab4faeb841b33d62d23283dc76c0e7c5a ]

rpmh-rsc driver is fairly core to system and should not be removable
once its probed. However it allows to unbind driver from sysfs using
below command which results into a crash on sc7180.

echo 18200000.rsc > /sys/bus/platform/drivers/rpmh/unbind

Lets prevent unbind at runtime by setting suppress_bind_attrs flag.

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
Link: https://lore.kernel.org/r/1592808805-2437-1-git-send-email-mkshah@codeaurora.org
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/qcom/rpmh-rsc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index 0ba1f465db122..8924fcd9f5f59 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -715,6 +715,7 @@ static struct platform_driver rpmh_driver = {
 	.driver = {
 		  .name = "rpmh",
 		  .of_match_table = rpmh_drv_match,
+		  .suppress_bind_attrs = true,
 	},
 };
 
-- 
2.25.1



