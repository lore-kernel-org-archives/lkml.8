Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C24C2D0EA
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 08:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0611C20692
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 08:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ub+cvW4q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgDIIJn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 04:09:43 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44533 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgDIIJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 04:09:42 -0400
Received: by mail-wr1-f65.google.com with SMTP id c15so10776475wro.11
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 01:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8sy4G5azWTKdTXq+AdUl0zD/LRk0rxdNkxqKpvpQpIY=;
        b=Ub+cvW4qPcoyju7stMqHNCY9mG4W16VmOP7o7wsid4KfyBJ7tVQAaip7m2mce5JNQO
         ZrwGiw/DAe1iLK4MjTlUkU/Ipmgyle2egAlE1fpaqWT2ezJ/dG8aAgA1y0+daQ5XLlp1
         8BmECLDJ6+QOgEn8Vjc5/iwsQmfLo0jgKyMgJUEedtTmKx+RK8J5Cs/puhxSzjzmRd/z
         za+JZ+7oYtbTZocIiokPVzcKbyLHdY5vSn9Vn/YZSj9dHUp0bo1qSHBejrdmfcL+vX9G
         o99r2crd17VMswUCfQ/rJJBTvuQcBBetCV3WXnkg7gRBTtUMn9qjD5XaWlivtFtYfoc9
         jgJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8sy4G5azWTKdTXq+AdUl0zD/LRk0rxdNkxqKpvpQpIY=;
        b=WUqTTrgUteBeKfDyerQNNLr6Zpok/Yu8g/00ca20zuV2zodCUreqJ7WIjd6wOGOgXZ
         +B5x9jf6p+rKWnx2hzP9Kyq2ujB231O11zvHvdKO/NlJw+Bfkn4xP5phTuzxO7cIPqf7
         GZrTH6CtfQBaFbbRA1EgrWAWiYh+tXYrXSOtSh3jZjEg8aO6j12AhV3gvGVkLUx5uk46
         tKIY4ZHn75XTN9DCgE7ZEIizQjzTk7zeDk9h66znxxangQ/aYFcPIz8kQBrXU/IGTRmS
         InEczNr4ZodJjsk923LgMekDoQVP7vQiijTRjctzw4ieCWxIAfpPHJDfb9w1DWg9ZM6z
         1nWQ==
X-Gm-Message-State: AGi0PuY3nJsRZcpXCcyL4VfgupYjm3KbyFOW9iZvyhXHPwBqB/NkZX3M
        Sp2bThHzPNMbr4zvgk69L3o=
X-Google-Smtp-Source: APiQypKOBXf1impEVnCXiydzFXK12RgSkh6b1k6ncuRlmPQvU/JwtvGTu4paHsopdxtGdAYzF8Nizg==
X-Received: by 2002:a5d:43c6:: with SMTP id v6mr4059110wrr.395.1586419782074;
        Thu, 09 Apr 2020 01:09:42 -0700 (PDT)
Received: from localhost.localdomain (dslb-092-073-054-213.092.073.pools.vodafone-ip.de. [92.73.54.213])
        by smtp.gmail.com with ESMTPSA id m15sm2648283wmc.35.2020.04.09.01.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 01:09:41 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: rtl8188eu: remove 5 GHz if test
Date:   Thu,  9 Apr 2020 10:08:02 +0200
Message-Id: <20200409080802.16645-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup a line over 80 characters by removing an if test that is valid
only for 5 GHz. According to the TODO 5 GHz code should be removed.

- find and remove remaining code valid only for 5 GHz. Most of the obvious
  ones have been removed, but things like channel > 14 still exist.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_mlme_ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
index bce777e4bf6c..8d035f67ef61 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
@@ -1781,7 +1781,7 @@ static void issue_action_BSSCoexistPacket(struct adapter *padapter)
 
 			p = rtw_get_ie(pbss_network->ies + _FIXED_IE_LENGTH_, _HT_CAPABILITY_IE_, &len, pbss_network->ie_length - _FIXED_IE_LENGTH_);
 			if (!p || len == 0) { /* non-HT */
-				if ((pbss_network->Configuration.DSConfig <= 0) || (pbss_network->Configuration.DSConfig > 14))
+				if (pbss_network->Configuration.DSConfig <= 0)
 					continue;
 
 				ICS[0][pbss_network->Configuration.DSConfig] = 1;
-- 
2.26.0

