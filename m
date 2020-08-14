Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB810C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 11:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C76520771
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 11:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lNAS2xDi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbgHNLoe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 07:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728108AbgHNLjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 07:39:49 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC38C061388
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 04:39:48 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id c19so8216120wmd.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 04:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Jmvmk4Q+PrpP0fEH57Cf6D9tPKOf5EojpThDuxlUrjQ=;
        b=lNAS2xDiXBRodT3zZ1ho7xTZfJLW0acXN9AiflPjRb4vW9teDq0sMQJkO9MYu2GBxS
         ntbuP4119uVsgffokOm2NXa2u1DErGaUo46E7ArfoMQ45/h9eiNYSBSWs6YHMYf6326v
         szNBfkDOdLfXIXVc56AzHvh9PmIUuK/FtoeyXv60KPRJx/OHem49ax6sF4Zoxw4Jp0HX
         4XTiroXKVnqtDgCbFW9UMti3Ba15Jc+IOLVu21J3f2ParAy4/9fBFYozDa17nU69147n
         5ZRUzrvA4a0SLD39Kuzxe9OrBrx+cY4GT5ggzRWIBxQkAGzwbKGyGe9qTc4DKH1hX0zY
         /cyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jmvmk4Q+PrpP0fEH57Cf6D9tPKOf5EojpThDuxlUrjQ=;
        b=IyZCv37w2GO1W90TEqr+vhqLMKAplNcgy3E8rxLZSOExIo7OT6dHtTd/x0/yRwNlD/
         pVAGFdJRWnmt/4AezXT6t4b3o8X6gCNg+9Ty+8/ra5oU+/Fy1Zz58XRymW+/igVC84dD
         LjO1LH420zcQkVc9w4aybNAJyOedCvZYZU2+DxT1ZLQtwy24DGH2zDIDksICf2KPeHnY
         uZeUWx3Oa8A8kkArk4EZsy391zd4Sub8hJ2WlNk3lvYsoUW3iPZj3Vw3i3FGCxhfN8B9
         bg8kNHIEg7/WEc3W+ir8tNLRfiXSWLKB895S4S9JL6UwHIvQWdK10WcYMn5bzBNfDuNX
         hTRQ==
X-Gm-Message-State: AOAM530k8KokNi1neC7Bz9LpcRvn37aY9+vLkTn0diI7jEXYQBXOyyCd
        CatEVjtjqqABO12/p/i9hyPfKw==
X-Google-Smtp-Source: ABdhPJy95B9JCQ17J8ciJby1aFSQ7We3ewp78KTdZreaF35CI0bjsdZqnLQGEGuzSVEvTUVXKxgxKA==
X-Received: by 2002:a1c:f605:: with SMTP id w5mr2184556wmc.26.1597405187342;
        Fri, 14 Aug 2020 04:39:47 -0700 (PDT)
Received: from dell.default ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id 32sm16409129wrh.18.2020.08.14.04.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 04:39:46 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Martin Habets <mhabets@solarflare.com>,
        Shannon Nelson <snelson@pensando.io>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        William Lee <william@asix.com.tw>,
        "A. Hinds --" <dahinds@users.sourceforge.net>,
        reached at <becker@scyld.com>, netdev@vger.kernel.org
Subject: [PATCH 06/30] net: ethernet: 8390: axnet_cs: Document unused parameter 'txqueue'
Date:   Fri, 14 Aug 2020 12:39:09 +0100
Message-Id: <20200814113933.1903438-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200814113933.1903438-1-lee.jones@linaro.org>
References: <20200814113933.1903438-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/ethernet/8390/axnet_cs.c:907: warning: Function parameter or member 'txqueue' not described in 'axnet_tx_timeout'

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Martin Habets <mhabets@solarflare.com>
Cc: Shannon Nelson <snelson@pensando.io>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: William Lee <william@asix.com.tw>
Cc: "A. Hinds --" <dahinds@users.sourceforge.net>
Cc: reached at <becker@scyld.com>
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/ethernet/8390/axnet_cs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/8390/axnet_cs.c b/drivers/net/ethernet/8390/axnet_cs.c
index aeae7966a082f..08db4c9da2fa8 100644
--- a/drivers/net/ethernet/8390/axnet_cs.c
+++ b/drivers/net/ethernet/8390/axnet_cs.c
@@ -898,6 +898,7 @@ static int ax_close(struct net_device *dev)
 /**
  * axnet_tx_timeout - handle transmit time out condition
  * @dev: network device which has apparently fallen asleep
+ * @txqueue: unused
  *
  * Called by kernel when device never acknowledges a transmit has
  * completed (or failed) - i.e. never posted a Tx related interrupt.
-- 
2.25.1

