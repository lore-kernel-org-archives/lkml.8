Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47038C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 06:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41C0E20781
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 06:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="YW/5yZ43"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729040AbgHDGpB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 02:45:01 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:22180 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728487AbgHDGo4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 02:44:56 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1596523495; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=Jyd4eEib35Li78ZVNukP/4xQT3vqwtBZMy4V6t0UkIc=; b=YW/5yZ43vCxIhGJz86jPK9oq/UNgb6yw9lh1bb3Oa2jp1YKZx7MB66ILpyK0ebNlmexsn1TL
 UCs+om/KsQx6uMp8xg+EYMpvHebaK88wcYMxf9NQnY4D8QLaZIQ945YH2hkPffsLKXUDoD1g
 JC2XH0o45d67KMC34haKjhuD5zI=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n17.prod.us-west-2.postgun.com with SMTP id
 5f2903e537790be1d0a47b02 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 04 Aug 2020 06:44:53
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 25C0CC4339C; Tue,  4 Aug 2020 06:44:53 +0000 (UTC)
Received: from blr-ubuntu-253.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 90D7BC433C9;
        Tue,  4 Aug 2020 06:44:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 90D7BC433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Sam Ravnborg <sam@ravnborg.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: [PATCH 0/2] Remove unused downstream bus scaling apis
Date:   Tue,  4 Aug 2020 12:14:41 +0530
Message-Id: <cover.1596523009.git.saiprakash.ranjan@codeaurora.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MSM bus scaling has moved on to use interconnect framework
and downstream bus scaling apis are not present anymore.
Remove them as they are nop anyways in the current code,
no functional change.

Sai Prakash Ranjan (2):
  drm/msm/mdp4: Remove unused downstream bus scaling apis
  drm/msm/mdp5: Remove unused downstream bus scaling apis

 .../gpu/drm/msm/disp/mdp4/mdp4_dtv_encoder.c  | 51 --------------
 drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.h      | 13 ----
 .../gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c | 47 -------------
 .../gpu/drm/msm/disp/mdp5/mdp5_cmd_encoder.c  | 24 -------
 drivers/gpu/drm/msm/disp/mdp5/mdp5_encoder.c  | 68 -------------------
 5 files changed, 203 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

