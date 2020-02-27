Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A850C4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 04:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F42072467A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 04:13:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CMgGP9Jr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbgB0EN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 23:13:59 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:33352 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727735AbgB0EN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 23:13:58 -0500
Received: by mail-pj1-f65.google.com with SMTP id m7so2791854pjs.0;
        Wed, 26 Feb 2020 20:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=SIAgH7rKdUKGoshqIOin6FqO+krncW7FxfqiqFVRH3w=;
        b=CMgGP9JrpMJQQXJGeatjrkj3DhC95cRF/uucrCugOk8qmgtm2tkaH9kSCaLsreQiSR
         wQrsAxHBI1A4ucPxyHzVI7tTkvD8pgPIZ8TQBFnyOkNSEDE+JGN9wASK06wh0D6S6y9Z
         WqIOIlaNcnQz6byvBs2HXlpxMz15pa6lwmtw9xFPg4LrdY/hvi1bbEEXjIa2SiBxV427
         V60Pw/pIw8O+etZkf8N2/3xgCt+KHNcvRD3xYu+g3iPShW8JlfQuISQAVTPu16aDq/CZ
         V8DXdP9bzm/mowKy3RXjxmV9gjtG4lrcKE2FNldtHMCSR6hlfhPBMSOfLbszDQ4RiiTv
         kq4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SIAgH7rKdUKGoshqIOin6FqO+krncW7FxfqiqFVRH3w=;
        b=IInvClpL20AcEi8UFJ+ira5r01LkaVPugpQASBAWqSb0/LoiZ3PJKzol62aRrU7HG0
         xiQmQLrWxmWp/atxe5K4QPC2kRplMRkmLaAV5UsU4iikQ9Ws5CuApKaGEHpJ0CrE9wfA
         yPM/XcToAhFbGDsYAprnMje/G70jdPx/pwn7lNRaMn9FnVnbDNqXB6HY8KQyBhWH8CbV
         +46kB4E0rCWqubSlZO5Dg8X9ZawD3uZoEIVtlb6aibuV7rsCcwiiSUEUg1OlhU2iZbcV
         XLbX+1B8GtumYEF9LLmY1Ren9XFY6tM41gDiYev8rYvXhmlwP3OZcj67xaryaDB2IDOP
         pmtA==
X-Gm-Message-State: APjAAAVmT0Ut6+4Io/lijt3T38wX9BK4L+pnN8IbUu0Sbl7S7gqp45MK
        UwbYHxQXk/AxEzaUhuEqrvs=
X-Google-Smtp-Source: APXvYqwNCawRksnCDdUdstJsoTQIdLsZ9xk/0Jp/7/K0oRLGqKfUxdgwRoyLhBOSUuY/nERUS9Xz+g==
X-Received: by 2002:a17:90a:cb0f:: with SMTP id z15mr2706443pjt.67.1582776837522;
        Wed, 26 Feb 2020 20:13:57 -0800 (PST)
Received: from sh03840pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id c1sm4729856pfa.51.2020.02.26.20.13.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 26 Feb 2020 20:13:57 -0800 (PST)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     linus.walleij@linaro.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, baolin.wang7@gmail.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] pinctrl: Export some needed symbols at module load time
Date:   Thu, 27 Feb 2020 12:13:46 +0800
Message-Id: <f4e7e20afacb23e6fa7a6b33ea4319b2b3492840.1582776447.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export the pin_get_name()/pinconf_generic_parse_dt_config() symbols needed
by the Spreadtrum pinctrl driver when building it as a module.

Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 drivers/pinctrl/core.c            | 1 +
 drivers/pinctrl/pinconf-generic.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index 446d84f..893b1ac 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -176,6 +176,7 @@ const char *pin_get_name(struct pinctrl_dev *pctldev, const unsigned pin)
 
 	return desc->name;
 }
+EXPORT_SYMBOL_GPL(pin_get_name);
 
 /* Deletes a range of pin descriptors */
 static void pinctrl_free_pindescs(struct pinctrl_dev *pctldev,
diff --git a/drivers/pinctrl/pinconf-generic.c b/drivers/pinctrl/pinconf-generic.c
index 9eb8630..dfef471 100644
--- a/drivers/pinctrl/pinconf-generic.c
+++ b/drivers/pinctrl/pinconf-generic.c
@@ -286,6 +286,7 @@ int pinconf_generic_parse_dt_config(struct device_node *np,
 	kfree(cfg);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(pinconf_generic_parse_dt_config);
 
 int pinconf_generic_dt_subnode_to_map(struct pinctrl_dev *pctldev,
 		struct device_node *np, struct pinctrl_map **map,
-- 
1.9.1

