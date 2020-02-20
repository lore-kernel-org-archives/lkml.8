Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92CC7C11D05
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 10:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C25424654
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 10:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="cw9v+mhd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbgBTKB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 05:01:56 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50315 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbgBTKBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 05:01:51 -0500
Received: by mail-wm1-f67.google.com with SMTP id a5so1316417wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 02:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O+T58/PVEkY9REC+CSDzxK/asJw/FlGJSf/x2KOhKHI=;
        b=cw9v+mhdDqPF/lvJis9JsmFzwH6Orjo18NHmWpxXbdFBY4qbW8ictGK2MJM/f1sk79
         zqytoP5UgLkxJ8NO5lCXCYOVtinGnT9/nTiyLYUk1F5SPEcZ8KUMr8K09T88N2fu2ftj
         4uZZLq9UQ+4IL3Z5farc8lEH55/VuDoDF3F5tHrbYchEbv9Tu5xSRSsmcqNCa4dw9w24
         TlcgghPck3QBjzvW4Mul7X+VLqjQUZ1Ig1iXZt0UMxSZFsQ767CZOS18BN3RFaCKhHbm
         X7Y7QrMYRVndQc2HgiGuRuTSX5VEaSR+4PzbmXkdAfurK+4hlPedm8yC4VRsxmIaNb44
         3n5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O+T58/PVEkY9REC+CSDzxK/asJw/FlGJSf/x2KOhKHI=;
        b=AySHqxPJ9q/oefAev/FvZTkHM2aPfsTDvR5y4zHeXXIlMqwOyv2/6ZbGT1l8ka4SAP
         jsCpBDBU+t4wK8ZNIerPk+czUxUrW0Fcw4F1OlKZ89FH2xQ1RIyisK3s4oiro7semL2R
         WcfisgmhRw4NFUmybMXXnzKeTzthjox2Jto3WeIVqYKzb78r5T4y8HWLp0QXb1oGRCd3
         2AVoziou+3gr5wPYqeu8oFfN33AwZfGdmgN4KQJ48LHTsY5iOhRgOTEH5SfjqIYscobP
         z4yHr2dwjKid+xP4NM9PYFBgFyP6ENc9OXCdoXPLeh+p73KZFcW4P2WYqbXqDpuTjqkr
         JiNw==
X-Gm-Message-State: APjAAAVwBMcp+/XaE3wP8O3j/qL76sbH1FdNzjYwXLIKPdwqVBr5Q7EW
        yYqtlRQjbSebt/V46IziTQkZig==
X-Google-Smtp-Source: APXvYqzVQbMdjAcZil54m2j1OZvhgzFZgUjumbB3Jr84HO8sjnpAKOw0NHFFXztnWSCSFcHuWNj4wQ==
X-Received: by 2002:a05:600c:2104:: with SMTP id u4mr3544388wml.93.1582192910228;
        Thu, 20 Feb 2020 02:01:50 -0800 (PST)
Received: from localhost.localdomain (lfbn-nic-1-188-94.w2-15.abo.wanadoo.fr. [2.15.37.94])
        by smtp.gmail.com with ESMTPSA id z1sm3663496wmf.42.2020.02.20.02.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 02:01:49 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Khouloud Touil <ktouil@baylibre.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v4 4/4] nvmem: release the write-protect pin
Date:   Thu, 20 Feb 2020 11:01:41 +0100
Message-Id: <20200220100141.5905-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200220100141.5905-1-brgl@bgdev.pl>
References: <20200220100141.5905-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Khouloud Touil <ktouil@baylibre.com>

Put the write-protect GPIO descriptor in nvmem_release() so that it can
be automatically released when the associated device's reference count
drops to 0.

Fixes: 2a127da461a9 ("nvmem: add support for the write-protect pin")
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Khouloud Touil <ktouil@baylibre.com>
[Bartosz: tweak the commit message]
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/nvmem/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 071fb897394c..a82375f63d64 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -72,6 +72,7 @@ static void nvmem_release(struct device *dev)
 	struct nvmem_device *nvmem = to_nvmem_device(dev);
 
 	ida_simple_remove(&nvmem_ida, nvmem->id);
+	gpiod_put(nvmem->wp_gpio);
 	kfree(nvmem);
 }
 
-- 
2.25.0

