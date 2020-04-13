Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E0CBC2BB1D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 19:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8210F20575
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 19:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rQMPxkwS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387918AbgDMTeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 15:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387885AbgDMTeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 15:34:05 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4C9C0A3BDC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 12:34:04 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id v2so3754774plp.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 12:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Uy1IdPuBXp7VgVD7eTNB6uNJOU6qTuzmXsvstPKTvdc=;
        b=rQMPxkwS4+7Mq/Yq3K5p+s0kbh0EQ4YHqy9tnYxTmuVtLvpLCfnb4FDrqOoM7P5+iY
         +l2lfpazPOkQEqQ12MqfPlEfI8L3r2U7vV2YYb6dsJ5YxnGapRwqcGxEjY20jkL3yg48
         u6NuAzGo71MDSwc8XK8OMt1pp+k1mnO0jpP3ZNRyfND2xCU+QTbgo4qC3Uc02iLEkPxE
         8Kdhfoi3fJ1oib/m9cHWPeGF8L6NE9k1r+wT+JX5dENy/keMTELSDH8CfAQMPwRIlXLN
         H4EA47L32xUuo4h+PR6UUMQud0agY+gRSAEZr5TYUjLT8BO5lBRMndK9KjWbofw5/F3r
         ONWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Uy1IdPuBXp7VgVD7eTNB6uNJOU6qTuzmXsvstPKTvdc=;
        b=V51NxYhkYLYrtSM1f4EjXKEi8YFaS8VMBfX8MMSABo/BdfwKLuW7vPY92SAwCkmIig
         gtzIseGW8l412dNoa6kVyajnZq2YupV7A33K6HvN8Ld5vrwrnEYVrbwKQupF0/tdvoiS
         P6lMpxGNJaK3qrADb1Jm164qBoWUKRszNDXQ84OF4opYZDjjlS8NkS5BYDnj7/XCa4e8
         Ks0w2MlLcSEHyclm1PsIAX4SnTBq7tnhR3fXMfgK+l5PECOD9fU7IMogn0cstXnx3iMY
         myCL2SZIwN9PDrWCwXvN7L5/V0hXJ9ZfbCKN0Ar5t20Cg6dZIdJNo5PAPlFg8WtmNEW6
         GAJQ==
X-Gm-Message-State: AGi0PuYa+K4TR693RIo9i9y9x+Iet7MhANpi1b+ZoRDXr7Sk6ndUrdu3
        J2jVxvxUJi1ZiSVoAAVQg2tirA==
X-Google-Smtp-Source: APiQypJDiXvrVscdRWIFzgkmw0vE0eAonIfSGOofEC/ATUFi6ujjyiKxZmJrLM+w6EdsaWDcuEC7PQ==
X-Received: by 2002:a17:90a:dc01:: with SMTP id i1mr6256901pjv.154.1586806443522;
        Mon, 13 Apr 2020 12:34:03 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id ml24sm7032330pjb.48.2020.04.13.12.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 12:34:02 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     bjorn.andersson@linaro.org, ohad@wizery.com
Cc:     s-anna@ti.com, elder@linaro.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] remoteproc: Refactor function rproc_alloc() 
Date:   Mon, 13 Apr 2020 13:33:57 -0600
Message-Id: <20200413193401.27234-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

Function rproc_alloc() had to be reworked as part of my work on MCU
synchronisation[1].  Concurrent to that Suman [2] and Alex [3] also did
some work on the same function.  

In order to provide a clean foundation for everyone to work from and avoid
unpleasant merge conflicts this set gathers the work that both Alex and I
did.  That way Suman and I can move forward with our respective patchsets
without too much headache.   

Applies cleanly on v5.7-rc1.

Thanks,
Mathieu

[1]. https://patchwork.kernel.org/project/linux-remoteproc/list/?series=261069
[2]. https://patchwork.kernel.org/patch/11456385/
[3]. https://patchwork.kernel.org/patch/11473241/ 

Alex Elder (1):
  remoteproc: Fix a bug in rproc_alloc()

Mathieu Poirier (3):
  remoteproc: Split firmware name allocation from rproc_alloc()
  remoteproc: Split rproc_ops allocation from rproc_alloc()
  remoteproc: Get rid of tedious error path

 drivers/remoteproc/remoteproc_core.c | 101 +++++++++++++++------------
 1 file changed, 58 insertions(+), 43 deletions(-)

-- 
2.20.1

