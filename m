Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E50DCC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 11:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFC9B2068E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 11:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iFWqnNSh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgHNLpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 07:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728080AbgHNLjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 07:39:46 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36F4C061385
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 04:39:45 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id a15so8047533wrh.10
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 04:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y77AtHzguUcJCUMjPrpTvjpVQ3AGTioiQPnppwV8VKc=;
        b=iFWqnNShFxm/D8776BXHu/qVGwFhwXQ+8rfUFDSN73HTnVGrhjwoT90p1MDlIfUelr
         4u5AzjJC7607Eg0uQQQH5twyO0MQz0DNNC4vZ/3VLlLRboWX+XlyFs04QvCJ7lv/HAb/
         O71kBtX1paMcjGcapsvpmQJL3lS57YAx1xLl6qEiFielydjRTzc6DLCoP7sU21grqzGO
         fvp3qnjdaBwwnF3Xl9p4MQpF6U4WSieWI4Ta2lJCCqQShezjah9feA0i6wVahmIWiVIV
         1PcdyBRtW88tORF12WPdEw244Xm6tUELNaiz5HfmsnpjpxY0m8jhUFgL1ekx1ZZp5VnC
         BPmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y77AtHzguUcJCUMjPrpTvjpVQ3AGTioiQPnppwV8VKc=;
        b=BaxYaIjvclZoTH3U21L4jsT0Ru9KbfiH6G/nonrFPU1OWwnMiOZb7wC1MIRyA7EltY
         PTnA0B3I54rMsPNzLBKqx3vpwLJFjFdOJhMCNzLFTeD4XnyH0ACxwULVeRjgiyEAIp8W
         y3sFRKxlDilwUdNT595Y1ctbx3wB9FJ2CqIFb48StgB2Y/tMlMd63q9zhtoKUurQnvOI
         HisctWqq8OwDVAyG+g8dOeloODwvlz5i7vIGxpc5MsWT4HyEjOLqf5p5IG+Y0IqnuKT9
         8kRnOSN3XY68nAjlNEgEqUIX8JQPI1tZHDReosphbDYlkQX7bTdheflGwFH7bKYH1oBv
         7iZA==
X-Gm-Message-State: AOAM533Lq8CnJxYxedPAXnL4DB58nTYDm3SWUrnXFvArJD7HCaXuvui2
        LMsoYBGpLduZ9lZkKb9OzGm+PQ==
X-Google-Smtp-Source: ABdhPJzOO5hb0FwyFDV+Y5ePxRrJMQlbWLrBFcALYFBIbUTV5cFeHryeDHp37n3PhcwIn4sRkgmkSQ==
X-Received: by 2002:a05:6000:1149:: with SMTP id d9mr2276259wrx.335.1597405184635;
        Fri, 14 Aug 2020 04:39:44 -0700 (PDT)
Received: from dell.default ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id 32sm16409129wrh.18.2020.08.14.04.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 04:39:44 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>, netdev@vger.kernel.org
Subject: [PATCH 04/30] net: bonding: bond_alb: Describe alb_handle_addr_collision_on_attach()'s 'bond' and 'addr' params
Date:   Fri, 14 Aug 2020 12:39:07 +0100
Message-Id: <20200814113933.1903438-5-lee.jones@linaro.org>
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

 drivers/net/bonding/bond_alb.c:1222: warning: Function parameter or member 'bond' not described in 'alb_set_mac_address'

Cc: Jay Vosburgh <j.vosburgh@gmail.com>
Cc: Veaceslav Falico <vfalico@gmail.com>
Cc: Andy Gospodarek <andy@greyhouse.net>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/bonding/bond_alb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_alb.c
index 095ea51d18539..4e1b7deb724b4 100644
--- a/drivers/net/bonding/bond_alb.c
+++ b/drivers/net/bonding/bond_alb.c
@@ -1206,8 +1206,8 @@ static int alb_handle_addr_collision_on_attach(struct bonding *bond, struct slav
 
 /**
  * alb_set_mac_address
- * @bond:
- * @addr:
+ * @bond: bonding we're working on
+ * @addr: MAC address to set
  *
  * In TLB mode all slaves are configured to the bond's hw address, but set
  * their dev_addr field to different addresses (based on their permanent hw
-- 
2.25.1

