Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09FADC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 07:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD16820786
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 07:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p2YS8erq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbgHSH26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 03:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726854AbgHSHZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 03:25:09 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4542FC06136C
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 00:24:27 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id l2so20443970wrc.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 00:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4rLwtBvMkow5I5GDEjyJuOU5JzSfmTUQSvGDHlfWV2k=;
        b=p2YS8erqOU/gjRtz4iVLLaMMKfXmVFvrRVi+3sc8ekfq/H7rh07Ky8kWW8qm0xOl7H
         gICMIUqThUQIq3Aj/P84e9220rP4seaClfp6TMWzMKTx9I2Ety6ePlpWYYv/utFTZsu1
         f2/fvNKQsuhAz2wlvL7xLEdinCCwVSsBIgKuCbEhIC7LAQAIFGEZi70S8Rdrn96JDPUK
         f9hnU3tzZ923q8b5VmYM+HniJ0SpwLYOmE+L+Fbo/pgx6qnGENDwbVdr+zRlE/ilG9bN
         SuntGeq2+BPuuCZAszBdrXBYL7/mzh8XwphBNHQCuRc9i0ANcXv3Xhp1njCVJTMkztza
         Mieg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4rLwtBvMkow5I5GDEjyJuOU5JzSfmTUQSvGDHlfWV2k=;
        b=N0GKbIuQeWb5hHH5YBDz6YiOhqEEpE3CtGg6JnyJMqXEPUydTOmZ97nMI6TV1OSSMe
         hs0WljkvdZremZjAIseqQYgrz7tpMzuw3+0Z/O/ZOafUYOlwBh7wKu82RidJxoCl2+Ei
         mHS9hd16xMXNNFRItBM+vsylnCxPyjap5OCtT1ZhehIBTCzTL8JhIiqx2mQ4AoWm89eC
         cJgy+sy+5uQ64W52091CTOyiWb6N6KWjN5joA/f3c3SPdEo2oACsqKf7ISzie1wIY6e+
         u4ECH9jVDRNyNzTHN6spU9XdXUQ35dtk1Jq7SdtoQQ58kAIAZhPmHAp9DLmfkhlrEF/0
         FA7A==
X-Gm-Message-State: AOAM533wy2hzZaUmTN4+PWLEOprGWDvk6C3vFL4tne7YpoFQEZ2LQc6C
        WNWucIzhGw8/nLu+U9q3NbQSYQ==
X-Google-Smtp-Source: ABdhPJzXBn1IXHXSUSbWLBLOHC10XUr5FZWPQa6flhRI76F8vknBKoswuQD38N8iOhXv4eE0P0x7Og==
X-Received: by 2002:adf:bc4b:: with SMTP id a11mr22292936wrh.381.1597821865954;
        Wed, 19 Aug 2020 00:24:25 -0700 (PDT)
Received: from dell.default ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id c145sm3795808wmd.7.2020.08.19.00.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 00:24:25 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Siva Rebbagondla <siva8118@gmail.com>
Subject: [PATCH 17/28] wireless: rsi: rsi_91x_main: Fix misnamed function parameter 'rx_pkt'
Date:   Wed, 19 Aug 2020 08:23:51 +0100
Message-Id: <20200819072402.3085022-18-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200819072402.3085022-1-lee.jones@linaro.org>
References: <20200819072402.3085022-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/rsi/rsi_91x_main.c:157: warning: Function parameter or member 'rx_pkt' not described in 'rsi_read_pkt'
 drivers/net/wireless/rsi/rsi_91x_main.c:157: warning: Excess function parameter 'rcv_pkt' description in 'rsi_read_pkt'

Cc: Amitkumar Karwar <amitkarwar@gmail.com>
Cc: Siva Rebbagondla <siva8118@gmail.com>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/wireless/rsi/rsi_91x_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/rsi/rsi_91x_main.c b/drivers/net/wireless/rsi/rsi_91x_main.c
index 576f51f9b4a7e..9a3d2439a8e7a 100644
--- a/drivers/net/wireless/rsi/rsi_91x_main.c
+++ b/drivers/net/wireless/rsi/rsi_91x_main.c
@@ -148,7 +148,7 @@ static struct sk_buff *rsi_prepare_skb(struct rsi_common *common,
 /**
  * rsi_read_pkt() - This function reads frames from the card.
  * @common: Pointer to the driver private structure.
- * @rcv_pkt: Received pkt.
+ * @rx_pkt: Received pkt.
  * @rcv_pkt_len: Received pkt length. In case of USB it is 0.
  *
  * Return: 0 on success, -1 on failure.
-- 
2.25.1

