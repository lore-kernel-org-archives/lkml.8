Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95CF4C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 17:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B9BE20848
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 17:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ln+YYohf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731329AbgCaRCe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 13:02:34 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42479 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731285AbgCaRCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 13:02:32 -0400
Received: by mail-oi1-f196.google.com with SMTP id e4so19527014oig.9;
        Tue, 31 Mar 2020 10:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=id2xxsG8HdP6q9xFW9MmRd4xH5edJmLoce+xqnoklSM=;
        b=Ln+YYohfvUI1Rn402zQNq4/Tunb2vzjCDx+ZlXhWlcgB5/MRsOteTXXqu7nzjV3ZMD
         dahwlWLYYvBKq/iimi9bHTdtAZz4/oLR5as/Vwr5Eg//UtFX9YqjrV9GHYFf14vayBzT
         6HJkJSUwk3jJd6d8xJngZY+GfyHg1Ag86rh20SbbdIXHmghgOslK9IhGLUJMF+N7bNXD
         JhthmUweI5X6NYY/Yn99lTC0Si4s9xAxTBfbS1dYRJV/SoZS+lfwM+qzaE7KZmcZPHY+
         0wZJKPbW94ZFztcU6lnPiZOwqM1PBGBqNqAnE20+EKhknku1EhcGTN2T6/A8WvdO0fNP
         XhQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=id2xxsG8HdP6q9xFW9MmRd4xH5edJmLoce+xqnoklSM=;
        b=Q4rdjl3/rvARdLqpnEl+YA6atz0+xkgIT+5I//mEI0Rt5q60inwFzeEVDehhfxQ0NX
         5fq+0G3XPeP18Y04ODvZis/+PvsLu4ZBhGuVaG7o6+YmyA85pstZ2RUIl5jSqZF2CDms
         kT3LkUalSYiLbcT44McIP1UzdPK8bJZjek2hHYKWQx4EXQcVvnRsnxS8+vysQWW0UMsz
         JJ7qhPqdDtY8syn6xsUfNuxpjD8yTpPlHLSyJZtAUzrKJd0YvlB7kHXJUjlNuu/DkRKI
         A6nAZulNhgLzwyCtBptKXhRipYgucROaCXQSzE7at3GDZaKKVlQfJShtoVnC4fMK/bFS
         KsdQ==
X-Gm-Message-State: ANhLgQ1r1t50j4Zi3qhHUZt7bbGZi59BGLl/ZtL/f1c8SalotHBWlVuH
        EUh9UroGC0ltXAfBRRLELVY=
X-Google-Smtp-Source: ADFU+vth7hHXB71hCpzRlXiX79+rJwCE6+IaxSB5vsQPun29d1yYVBmdSpcpsXuLB5QjvEAMh0qPMQ==
X-Received: by 2002:aca:d78a:: with SMTP id o132mr2837176oig.60.1585674150925;
        Tue, 31 Mar 2020 10:02:30 -0700 (PDT)
Received: from desertvoice.lan ([2601:3c7:8303:2a10::21c])
        by smtp.gmail.com with ESMTPSA id h7sm2952605otk.3.2020.03.31.10.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 10:02:30 -0700 (PDT)
From:   George Hilliard <thirtythreeforty@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     George Hilliard <thirtythreeforty@gmail.com>,
        Icenowy Zheng <icenowy@aosc.io>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] musb: sunxi: add support for the suniv MUSB controller
Date:   Tue, 31 Mar 2020 12:02:17 -0500
Message-Id: <20200331170219.267732-4-thirtythreeforty@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200331170219.267732-1-thirtythreeforty@gmail.com>
References: <20200331170219.267732-1-thirtythreeforty@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The suniv SoC has a MUSB controller like the one in A33, but with a SRAM
region to be claimed.

Add support for it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
George Hilliard: debugged, match existing style
Signed-off-by: George Hilliard <thirtythreeforty@gmail.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
---
v1..v2: reordered sun{50,iv} to match `sort` order.

 drivers/usb/musb/sunxi.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/musb/sunxi.c b/drivers/usb/musb/sunxi.c
index f3f76f2ac63f..9b353b97fb06 100644
--- a/drivers/usb/musb/sunxi.c
+++ b/drivers/usb/musb/sunxi.c
@@ -714,14 +714,17 @@ static int sunxi_musb_probe(struct platform_device *pdev)
 	INIT_WORK(&glue->work, sunxi_musb_work);
 	glue->host_nb.notifier_call = sunxi_musb_host_notifier;
 
-	if (of_device_is_compatible(np, "allwinner,sun4i-a10-musb"))
+	if (of_device_is_compatible(np, "allwinner,sun4i-a10-musb") ||
+	    of_device_is_compatible(np, "allwinner,suniv-f1c100s-musb")) {
 		set_bit(SUNXI_MUSB_FL_HAS_SRAM, &glue->flags);
+	}
 
 	if (of_device_is_compatible(np, "allwinner,sun6i-a31-musb"))
 		set_bit(SUNXI_MUSB_FL_HAS_RESET, &glue->flags);
 
 	if (of_device_is_compatible(np, "allwinner,sun8i-a33-musb") ||
-	    of_device_is_compatible(np, "allwinner,sun8i-h3-musb")) {
+	    of_device_is_compatible(np, "allwinner,sun8i-h3-musb") ||
+	    of_device_is_compatible(np, "allwinner,suniv-f1c100s-musb")) {
 		set_bit(SUNXI_MUSB_FL_HAS_RESET, &glue->flags);
 		set_bit(SUNXI_MUSB_FL_NO_CONFIGDATA, &glue->flags);
 	}
@@ -818,6 +821,7 @@ static const struct of_device_id sunxi_musb_match[] = {
 	{ .compatible = "allwinner,sun6i-a31-musb", },
 	{ .compatible = "allwinner,sun8i-a33-musb", },
 	{ .compatible = "allwinner,sun8i-h3-musb", },
+	{ .compatible = "allwinner,suniv-f1c100s-musb", },
 	{}
 };
 MODULE_DEVICE_TABLE(of, sunxi_musb_match);
-- 
2.26.0

