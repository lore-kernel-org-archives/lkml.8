Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74138C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 13:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4ED332081A
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 13:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ve0vODUR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbgFZNGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 09:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728072AbgFZNFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 09:05:40 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169ECC08C5DB
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 06:05:40 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id j4so6982916wrp.10
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 06:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wtZgwN1VEe1uHwSxLOV5iMEAtJq6PXuzc/2gq6Shnxw=;
        b=ve0vODURkQ/NmbAvYy1X78a87W0iIn8AB8y2hOTsOaFy50tuPrl7R+PMgOe9Nt0/v0
         d+GQeXOTlguWywGBl1Tvl59tosAfEK6jX7aAgpjoW+ZjvJtBdkacmlmWE4PEgZTfE9Cp
         +YC1m1VQT9y/kolkuJ/Gzby9rE/xIWfwusc6ScaVSdvqeQl8vtEZp+R3B1HMD6rvzlE+
         4pg68HmeRVY7FY0XZubD01AGP/sBZkqreA3RDmSp9tU2mAOYxXxqIdEiYDyADVcnkeS/
         PIZivkIaJOUFb0954GFHDGYM8+U+jC5xgeR8wFEKI/slBUdpa+si3Rk2x/Tq+4u5GR+J
         vLVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wtZgwN1VEe1uHwSxLOV5iMEAtJq6PXuzc/2gq6Shnxw=;
        b=bvxGp4FO19nuJxKJ/0aXZ6um0F2oklreWk95KlnBS0lLhH0JXYP+jPHwj55iWHPLOF
         dwsNsEQwAHUmAswPypOWR8CI+rKSmYR5rNi5idxV55ZJ0316dvkWsJG4TRLaGg1Y0tB+
         3ZhmDOn0qs2+KmFfhA5337mBMijCRu5sC4AQu2tMlKaGIZU/hMJCo++tucLl5o+CjwCm
         sHFlNIyGIu/glCueuq/x4T5p6LEblCWIuqrys+mE0GczTjs8Xtb8hzksyktPnDOhyptu
         IFgIVxJDCaUskgkMXOEn42z/y2k9mk/Lpr1rzQs4X1KsdnxbGoBD3YrgrWCI7mbvOhY7
         102Q==
X-Gm-Message-State: AOAM532XESDMLvdseISNT5qU+Qv38SeYcGK5u3DslqNwDNkEmu3gEJ/f
        FuENHHIqfy78HHyt0d/Uf+IvIA==
X-Google-Smtp-Source: ABdhPJxcb8/qodOG2VmiAY0Wvi/Gp9r7A1G8FrbCD4mBZKGbAemQCuno75AvB02aZQKkRKnmvGwq+g==
X-Received: by 2002:adf:8b5a:: with SMTP id v26mr3660157wra.165.1593176738701;
        Fri, 26 Jun 2020 06:05:38 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id u20sm16746904wmc.44.2020.06.26.06.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 06:05:38 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 08/10] misc: cb710: sgbuf2: Add missing documentation for cb710_sg_dwiter_write_next_block()'s 'data' arg
Date:   Fri, 26 Jun 2020 14:05:23 +0100
Message-Id: <20200626130525.389469-9-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200626130525.389469-1-lee.jones@linaro.org>
References: <20200626130525.389469-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An attempt was made to provide a proper kerneldoc header for
cb710_sg_dwiter_write_next_block(), but a description for it's 'data'
argument was missed.

Squashes W=1 kernel build warning:

 drivers/misc/cb710/sgbuf2.c:131: warning: Function parameter or member 'data' not described in 'cb710_sg_dwiter_write_next_block'

Cc: "Michał Mirosław" <mirq-linux@rere.qmqm.pl>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/misc/cb710/sgbuf2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/cb710/sgbuf2.c b/drivers/misc/cb710/sgbuf2.c
index dfd2969e36289..e5a4ed3701eb8 100644
--- a/drivers/misc/cb710/sgbuf2.c
+++ b/drivers/misc/cb710/sgbuf2.c
@@ -117,6 +117,7 @@ static void sg_dwiter_write_slow(struct sg_mapping_iter *miter, uint32_t data)
 /**
  * cb710_sg_dwiter_write_next_block() - write next 32-bit word to sg buffer
  * @miter: sg mapping iterator used for writing
+ * @data: data to write to sg buffer
  *
  * Description:
  *   Writes 32-bit word starting at byte pointed to by @miter@
-- 
2.25.1

