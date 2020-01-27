Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF72C32771
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 23:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FD15206BF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 23:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iKJYkAu/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbgA0Xy6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 18:54:58 -0500
Received: from mail-pj1-f73.google.com ([209.85.216.73]:38883 "EHLO
        mail-pj1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbgA0Xy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 18:54:57 -0500
Received: by mail-pj1-f73.google.com with SMTP id 14so299176pjo.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 15:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=gntUp+SDXttnQBr/sc5cO3EsNHTPBbbt8uIYn4TJA2s=;
        b=iKJYkAu/HQnaxOEoyoyVHO60MC+U5XKfW9fiWKbMH70o4IcKZqg/8wyv+3aRvbFbvu
         nULy26QTeKImnh/3jyjjyYs/EPa9695yYzvs6D2R97xcgvFB/m02Nh0Qe7lFrxOH5ZtU
         4fU5CLktqtCjUssNKlMRRaYVPTRsBIDCcTCdz6oYayiFu1UZ80YSWAKmySUXR4O8yS3V
         aTAd+K39cMTFRSPHSzVNRc8ES+rcQ/wAaJQsp2uQB00t2UvRv1oI0HcHRyOhAcYZQUrc
         IwpZtUoIbUXJNkHGFQHVn1MvW+S3+Os8iMZC/xAFseXj20h60mNHgUwP1hBfyiUGX4QO
         QBVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gntUp+SDXttnQBr/sc5cO3EsNHTPBbbt8uIYn4TJA2s=;
        b=plKIY4bi5JINVXvI3C0kk5Mny+ogTa9ZpkunFDoVZVc4goVORHobygSbxUwYZsfFK7
         nAWhg1+qZ/cZ0dq61TH6+ud/6JHFgy6LfZodynkHTjb3DaUmU3m1L8KxvmHfdM7e9g7s
         0cWxtcFeZQxtPF+A/7rAk5FFrVZVhNsheDbHJpI2Jl6hvinbJ+9aCKjUMjElM5UfAy7K
         cBrw6G8+ux10RlYXVz+r8H/a3Xd+wqTsUHBhOgbrfV0Uw/p1H4bxj0rrpptmkfgN8rnq
         pQS6hYMuonr/NR002IAsM7hdiue9n+Og0SpumS6s0k0QEtC+3A4iM8mU4TDqccsQoBbe
         Iy+Q==
X-Gm-Message-State: APjAAAVrglpG31ysTI87pIzOxSCpDPy3WNqy14lA3Y3bEv4liYrqu31e
        ZT/AsfZ5NqWzaJpfJa7Mb1MMJp4igPs4JBKO7Ub9Rg==
X-Google-Smtp-Source: APXvYqz5lz8Bx5r+hOfkxT89taKmjq4XVEOcglFFrUjs0O7WjK+Y+IZCN7vcLSVeAwBbcJ6semWNObbc7RcHxrlyYdCb3A==
X-Received: by 2002:a63:9548:: with SMTP id t8mr21223163pgn.205.1580169297243;
 Mon, 27 Jan 2020 15:54:57 -0800 (PST)
Date:   Mon, 27 Jan 2020 15:53:53 -0800
In-Reply-To: <20200127235356.122031-1-brendanhiggins@google.com>
Message-Id: <20200127235356.122031-3-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20200127235356.122031-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v1 2/5] reset: brcmstb-rescal: add unspecified HAS_IOMEM dependency
From:   Brendan Higgins <brendanhiggins@google.com>
To:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        davidgow@google.com, heidifahim@google.com,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently CONFIG_RESET_BRCMSTB_RESCAL=y implicitly depends on
CONFIG_HAS_IOMEM=y; consequently, on architectures without IOMEM we get
the following build error:

/usr/bin/ld: drivers/reset/reset-brcmstb-rescal.o: in function `brcm_rescal_reset_probe':
drivers/reset/reset-brcmstb-rescal.c:76: undefined reference to `devm_ioremap_resource'

Fix the build error by adding the unspecified dependency.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 drivers/reset/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 461b0e506a26f..a19bd303f31a9 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -51,6 +51,7 @@ config RESET_BRCMSTB
 
 config RESET_BRCMSTB_RESCAL
 	bool "Broadcom STB RESCAL reset controller"
+	depends on HAS_IOMEM
 	default ARCH_BRCMSTB || COMPILE_TEST
 	help
 	  This enables the RESCAL reset controller for SATA, PCIe0, or PCIe1 on
-- 
2.25.0.341.g760bfbb309-goog

