Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C3EDC18E5A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54A8E222D9
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kPkJE7/w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730830AbgCJNXj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:23:39 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35012 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730543AbgCJNXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:23:37 -0400
Received: by mail-wr1-f68.google.com with SMTP id r7so15886266wro.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 06:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/8D8eEixl05Vf9GJv8B/tasfGn3/WQMb9G+5OaTXi04=;
        b=kPkJE7/w29IsOM11+VQoGDOoQcrastDIt6gXRVfR9oybTcYtW19BcwdRNQX8feD/1o
         CWlkND5qyUPDACCUSIxck5bclJwU6xuuQeVfzj3ST1/M9DNocYrZ7G+QWZ4QQrz2F/mt
         XIeh3XAXOAFEZiFJjD4J/QQY0CNFyak/LC7FAe6cIiVhwz8SujqrODCXL6/7nndMyGWf
         sxPPTNmVOnZVdaD6J4w1IdDuIk0wFEFaRtT3CBo0Z4zGv/MhkL1C8NjLS5qo4L0HJWkb
         VDDKXnN9ZSh8f2Z1MjeBzN+3e5Zu4BJpFhwxinrHB/C+YrRm+aYkQfx9HjFdV3oyXPiq
         Rs9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/8D8eEixl05Vf9GJv8B/tasfGn3/WQMb9G+5OaTXi04=;
        b=l+XJmLbinpdlM7dmsBFpyi6H0cGRX+jom8RxGrcBWtplQVBZkeGAS9GtvUh7TNnLLy
         kdpt0swUBmzj/qZSq1ubOaBfpxnsDe2VoDixn3s1YM6y6r48Z/43ffIjCs866ntRI8cc
         iOnjPyKUFcc4SWPbs3IX4OmTIkHD2zXaXc0zIqbQkRG0o26FTpoYT/s8isms7KUAO2fY
         i9Zw6FD/bf9w9MKhExBi8miRyRVEx1OqBNazCoRK8fuMsMN/OQi58NcjOf539xCO6RFJ
         /z5KC73YtyazEcY9HPVVWoSxClaZ9Xz2dEK4/k2UHAsB9BifDFahf6a1DOYQWgXOH0mV
         ms+A==
X-Gm-Message-State: ANhLgQ3LDQx/bxgytBD7AVE0FrYzFLi18z2AIC7S/4kyAyG9t27G9dc2
        VGBmWf7AGR5VyIbIZnaq6uMP6yKTyxE=
X-Google-Smtp-Source: ADFU+vt8blGqjgMhcfZB3veUCXPuk5+f3irTcB+z6DpdnTRV0N7E8J8RWJpR8lck1EROfN76+yly3g==
X-Received: by 2002:adf:f047:: with SMTP id t7mr29233160wro.371.1583846615634;
        Tue, 10 Mar 2020 06:23:35 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id s22sm3761199wmc.16.2020.03.10.06.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 06:23:34 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 04/14] nvmem: remove a stray newline in nvmem_register()
Date:   Tue, 10 Mar 2020 13:22:47 +0000
Message-Id: <20200310132257.23358-5-srinivas.kandagatla@linaro.org>
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

Two newlines are unnecessary - remove one.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 4634af1f6341..9bdf0ab88efe 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -355,7 +355,6 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 	if (IS_ERR(nvmem->wp_gpio))
 		return ERR_CAST(nvmem->wp_gpio);
 
-
 	kref_init(&nvmem->refcnt);
 	INIT_LIST_HEAD(&nvmem->cells);
 
-- 
2.21.0

