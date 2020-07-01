Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A867DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D9CA20722
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WrK11Ec3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbgGAIdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 04:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728863AbgGAIbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 04:31:43 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB0EC03E979
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 01:31:42 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id l2so20794016wmf.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 01:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oA8RTovB0rd6yTwQFM7j/fT5zajZLuFIh0xLtIq5guU=;
        b=WrK11Ec31w4tuU8HCCO4VXLIfnciHgOfevpUGBzfQ3xbF5bV2C/YHIzlaNHOWFD5iK
         ypklMlwIAEMTPaSzC336jN8UTGOtmlySQkuawDxjI7JeY0sqec11PiiQQ6jIuJeHZ+rU
         hFaVwdzb3ezTguIerZcbG6vu346i7c3zLmPsXIL8OsJRvkets2jsNHVoYLygQO2nOlOS
         PkVkjHzYKkRIH02uc7ghIVVjfzFw/+IY9+eewtJT5TGx8qhuGW0UpS9ufdKrha63L8sg
         4dU9xCetvmuKpO4H4uDcIFoKOeHHa0MRQWBxYsUE6xNVAD3Iu9CR/SaNLPlr/ldNowgj
         IZ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oA8RTovB0rd6yTwQFM7j/fT5zajZLuFIh0xLtIq5guU=;
        b=Q3cjGUkAw+ZGUejFVV/n17iq1WnM63ZpHqH4gGvDWsf9ocFF2ZevvJ3hJLSZs6Xn7H
         Lkv5lj0SWTx62aBlHXJ67AO7pQ8G9cx3ILIVfgEcl425EXTZu47d2XMRuUme8F7fBtXv
         hHl1FBhk5Vt2/HUx8Mpkd36/H8s9cVJX+Z35sWM/ElMVCwg79t8Rx4Wf/NczQUadatsr
         eUjK7X1yug52cFjQYXh6KgK1H4qhtRurtSPMgoEow8yU3NQj0DhwbbPAzE9TCNgucjXP
         5MThYUm87kRIilssAZspRy+LiQjr6Ak+fv3rkRJcEbKq26RjmpyvnPlFoxAKqakrewJf
         BW7Q==
X-Gm-Message-State: AOAM533so86WC8I9z/cn18RvkcifJJLg+wS8H8CF4PeJiqVQfwVshmeg
        lOPor8zNU475HOzDsXTkGANB+8PY29M=
X-Google-Smtp-Source: ABdhPJyR3mT3l+HU/A8tyDCKJz3R8IPmnK5C/miGyhGwUsBMnHQe5vBBWBpSeQirIrzxrutuyPxrBA==
X-Received: by 2002:a05:600c:2154:: with SMTP id v20mr27637161wml.185.1593592301382;
        Wed, 01 Jul 2020 01:31:41 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id 59sm6717816wrj.37.2020.07.01.01.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 01:31:40 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v2 15/30] misc: mic: cosm: cosm_main: Document 'force' function argument
Date:   Wed,  1 Jul 2020 09:31:03 +0100
Message-Id: <20200701083118.45744-16-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200701083118.45744-1-lee.jones@linaro.org>
References: <20200701083118.45744-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning:

 drivers/misc/mic/cosm/cosm_main.c:31: warning: Function parameter or member 'force' not described in 'cosm_hw_reset'

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/misc/mic/cosm/cosm_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/mic/cosm/cosm_main.c b/drivers/misc/mic/cosm/cosm_main.c
index f9133c4f61050..ebb0eac43754a 100644
--- a/drivers/misc/mic/cosm/cosm_main.c
+++ b/drivers/misc/mic/cosm/cosm_main.c
@@ -26,6 +26,7 @@ static atomic_t g_num_dev;
 /**
  * cosm_hw_reset - Issue a HW reset for the MIC device
  * @cdev: pointer to cosm_device instance
+ * @force: force a MIC to reset even if it is already reset and ready
  */
 static void cosm_hw_reset(struct cosm_device *cdev, bool force)
 {
-- 
2.25.1

