Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 054D2C3F2D2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 12:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C991B2187F
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 12:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kAB4d29/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbgCBMyi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 07:54:38 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35394 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727820AbgCBMyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 07:54:37 -0500
Received: by mail-pg1-f194.google.com with SMTP id 7so5404573pgr.2;
        Mon, 02 Mar 2020 04:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HEh7CqSCXgWfailCBb8Rs+qB5N+bl/4veud+2lfhJ3c=;
        b=kAB4d29/ko/klMw//ZuCCDjxlWJmKBj6aYjBLaaWpXUGa2HrPYNP995nR9WGuqSzEH
         fluQ71pG7wsJkuGZvSsfu9JFGjGYfuE2cE151OiwrNC8PZl9x7XioTn+VbgU4RWQ6Ufw
         GgU3QbFS+76CeEIMQMe0lV0COD1vE8CdUdiRrVXjRz3FrXNwnmW8+QUQN8L4Lafo/5fJ
         BWFDW81BAltxPyU7ZV8VjT9u6VvUnvAjS5i2hgMj2ydh4iKsv9v1Vlqq5jEN1vpvIg0Y
         QdIRXqAXYtyUBZ0QuRW7az7jsrlAdBclNrfA1UDgOlJbuZRMexRIy58eiuYpgu1KVA7m
         xv/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HEh7CqSCXgWfailCBb8Rs+qB5N+bl/4veud+2lfhJ3c=;
        b=dXv9KOnIxOcWCKz7Gd8sUyldUQGxv9VgaZMePu6gf08O+oPScLPsiji1qtOzim/Kpl
         FQXr43HpOpkE6t7BT9mFG13M6JUNiHSt2Ce9aIrnpT4wFNTLogRJjM6hQ3317AItqyfO
         XmwfPCmwixtkK6Hi4/Ntpe3auGx8m4EH73HKYqXGZpOF27vy+R7urty/3v3MioZmU1de
         KrZnTO6ybvSUVt+x0XaX+hJkLMR+vuoX3JD0aYvwoUBpE+h9s8VR49l8WGafW/KTX7Iv
         VRruhFTXvl3EzQb70EraJePLe6iU8jJnwi+tTsbtX/Y68RTNln34z9PTasEQvXXMH8mx
         chrQ==
X-Gm-Message-State: APjAAAUCvUiXgFaT97Hk2rlEtoIwmizrnaUkqydDXLQjgaZvYSyIU7g9
        FVqyIWY6r7oGtKaXX/YzIFI=
X-Google-Smtp-Source: APXvYqzvXVSEfr6bpf3GIPRYKUv7jKl6r8NlwZCenHEBeS4uW+3WkXAE27vkYrNhhLNvUn6R77Ka4w==
X-Received: by 2002:aa7:8299:: with SMTP id s25mr17299604pfm.261.1583153675622;
        Mon, 02 Mar 2020 04:54:35 -0800 (PST)
Received: from localhost.localdomain ([103.51.74.208])
        by smtp.gmail.com with ESMTPSA id p2sm2138238pfb.41.2020.03.02.04.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 04:54:35 -0800 (PST)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Kevin Hilman <khilman@baylibre.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCHv2 2/2] clk: meson: g12a: set cpub_clk flags to CLK_IS_CRITICAL
Date:   Mon,  2 Mar 2020 12:53:09 +0000
Message-Id: <20200302125310.742-3-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200302125310.742-1-linux.amoon@gmail.com>
References: <20200302125310.742-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Odroid n2, cpub_clk is not geting enable, which lead the stalling
at booting of the device, updating flags to CLK_IS_CRITICAL which help
enable all the parent for cpub_clk.

Fixes: ffae8475b90c (clk: meson: g12a: add notifiers to handle cpu clock change);
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Suggested-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
Previous changes
	fix the commit $subject and $message as previously I was
        wrong on the my findings.
        Added the Fixed tags to the commit.

Following Neil's suggestion, I have prepared this patch.
https://patchwork.kernel.org/patch/11177441/#22964889
---
 drivers/clk/meson/g12a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
index d2760a021301..7237d08b4112 100644
--- a/drivers/clk/meson/g12a.c
+++ b/drivers/clk/meson/g12a.c
@@ -681,7 +681,7 @@ static struct clk_regmap g12b_cpub_clk = {
 			&g12a_sys_pll.hw
 		},
 		.num_parents = 2,
-		.flags = CLK_SET_RATE_PARENT,
+		.flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
 	},
 };
 
-- 
2.25.1

