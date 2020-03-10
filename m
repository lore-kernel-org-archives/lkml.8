Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4015C18E5A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB16324649
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="idu54600"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730840AbgCJNYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:24:20 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35015 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730740AbgCJNXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:23:38 -0400
Received: by mail-wr1-f68.google.com with SMTP id r7so15886356wro.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 06:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FOxfUuj0TREDv7iIfCUTWeNt9swvf5CtUpwVkBi3xBU=;
        b=idu546000uhmSKIIeafo9t0VgmC7xLfeQrtZAwJmCyLZZ1C52rdwJUroD8YUv6+O0S
         Tnnmpvtqv9jXzqIk3LOp57F83mP78l7YXXykYDL+lJvnVE1zampVVEPK/zJx6YBOUDjl
         5D7mvqTYEqbMr5x5R4QnLMohHiXxYy4ggh3nciKdUxxecu9wz0kaK20o6w4VXZUqNWuA
         4NGLyXpffctfVPYvROXBnJkX5qEEqmtkQJJDAFMdMpMRIyST4OpyhKv7CYDWRq1BVstO
         eMmLIH9glJqOjFRhNW+aQ5FtiwBJuazcF5xWEv9Qkw0QRDrQOkQqTf6nGXmr1+LZnGQI
         sS2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FOxfUuj0TREDv7iIfCUTWeNt9swvf5CtUpwVkBi3xBU=;
        b=PiuoUU6RBp2SriN5eAj8atZ8aiCZbaiZOe/YzCoSbihPizsaS746ZazW7vfxNNN7og
         sptgOr5VyvX/Y7V90kDI9tZaYMnWB453dAPNDFaYqRsvvzo4LcIAKuWsk4IWIN28VzRF
         ZZzuQB9Mld4xeK5DsjA/LoLdfkItMkuFMlQo7WH8phUzgeJRtJKTWWXIL75egeNhTAAv
         I9d7q35417BGicn3/NlHAvtrG/TYROhewp7lJEwyqFVUjZUcRVpjZdeA6DLu99mrkrwq
         yLBalXmfvqE+HMzPOL6bB+Ym/S3PA+zUpfEiJuqi7YuPksQtMZZt109WVY6afEbetmq0
         Fdzg==
X-Gm-Message-State: ANhLgQ0SZHQgmnlT3sSsBdAi9LJGgdSmvSFcZwu9i1HmlbtX1A16McCF
        3Y0dO23ESBP9m/2MR3+/bfTKsQ==
X-Google-Smtp-Source: ADFU+vvvDajTkf3o6IjX5FE+QAywnKYiZfmK4gu5PNyfYEOckm4wNpPr9HuYEaKhHHw1v+kFkqB3qw==
X-Received: by 2002:a5d:6082:: with SMTP id w2mr27440794wrt.300.1583846617007;
        Tue, 10 Mar 2020 06:23:37 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id s22sm3761199wmc.16.2020.03.10.06.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 06:23:36 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 05/14] nvmem: add a newline for readability
Date:   Tue, 10 Mar 2020 13:22:48 +0000
Message-Id: <20200310132257.23358-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200310132257.23358-1-srinivas.kandagatla@linaro.org>
References: <20200310132257.23358-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Visibly separate the GPIO request from the previous operation in the
code with a newline.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 9bdf0ab88efe..503da67dde06 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -347,6 +347,7 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 		kfree(nvmem);
 		return ERR_PTR(rval);
 	}
+
 	if (config->wp_gpio)
 		nvmem->wp_gpio = config->wp_gpio;
 	else
-- 
2.21.0

