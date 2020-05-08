Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A53ABC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AFDA24959
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588942367;
	bh=12G08OjkcLRNptzhaSvIbZJBb4wxK+MHHopIQJcsoTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PZUWP2TK5Bz4IxJwSLroobdExKYD8wDqirpZd8/4T6o8q0VJbPDbcjaYx/ghfYt5K
	 7r76+hhkV+FFHHWX+b2lv6C333GkvBQ5blCzu/NbEZzNpVU/2csEZA2msknbdSgijK
	 rTWnGMEG3PGx0HyjbKkTLbJpr1oLkM6Dqqe+GCrw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729991AbgEHMwq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:52:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:33996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729622AbgEHMwm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:52:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5407524953;
        Fri,  8 May 2020 12:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588942361;
        bh=12G08OjkcLRNptzhaSvIbZJBb4wxK+MHHopIQJcsoTE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sNbF0ExIsnTrL662qWd5Z672PCeTmJjkXHncXaB3NlHunLLDwBRlbrL40daGZ+Sk3
         oqPhJoc+zNmz0h2JP9fhSYKwdShgZWxYgxlYYPng21wuRatKoaDllqLWWySNqUxVEF
         CZR0DZ/C0/fcnW21fIG7Tdof0OoW1PDA7jWIsau8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alex Elder <elder@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 15/50] remoteproc: qcom_q6v5_mss: fix a bug in q6v5_probe()
Date:   Fri,  8 May 2020 14:35:21 +0200
Message-Id: <20200508123045.542370898@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508123043.085296641@linuxfoundation.org>
References: <20200508123043.085296641@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Elder <elder@linaro.org>

[ Upstream commit 13c060b50a341dd60303e5264d12108b5747f200 ]

If looking up the DT "firmware-name" property fails in q6v6_probe(),
the function returns without freeing the remoteproc structure
that has been allocated.  Fix this by jumping to the free_rproc
label, which takes care of this.

Signed-off-by: Alex Elder <elder@linaro.org>
Link: https://lore.kernel.org/r/20200403175005.17130-3-elder@linaro.org
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/remoteproc/qcom_q6v5_mss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
index 783d00131a2a9..6ba065d5c4d95 100644
--- a/drivers/remoteproc/qcom_q6v5_mss.c
+++ b/drivers/remoteproc/qcom_q6v5_mss.c
@@ -1440,7 +1440,7 @@ static int q6v5_probe(struct platform_device *pdev)
 	ret = of_property_read_string_index(pdev->dev.of_node, "firmware-name",
 					    1, &qproc->hexagon_mdt_image);
 	if (ret < 0 && ret != -EINVAL)
-		return ret;
+		goto free_rproc;
 
 	platform_set_drvdata(pdev, qproc);
 
-- 
2.20.1



