Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86485C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 16:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A849206C3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 16:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FK5LCKD6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406176AbgFYQbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 12:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406106AbgFYQbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 12:31:35 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02EAEC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 09:31:35 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 22so6196572wmg.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 09:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qdWwmg+14n1DaRnl28IG08HFZIgAWf2t2MbKwndU72c=;
        b=FK5LCKD6iFHHeVVjAxhMxhYZcMvBoFRLR8fjGOpwtjFYS8k9YnGFmPzD3hjrZuj9Pf
         xhIZvNgsss7GUxL+YC8TXbXjh66qK11uEht/EKVKsQSF6YvM2vEYb4DU1aCDt0u5hLQa
         dZslwcmbqcQJ8AaoXYMyHSzWEC+Q/AbQdO5U6y+IpfJoYAm66d6w+CGNAdfsCBBnN84b
         Nb8ZVcyIwMMAnwSJ2YhBAG8lNGBhr9JyM2bgJ6Q+u35zZdRIrHe6sT5IXo9KWS+YSYAR
         mIFUxnvleI/EA41CgG/wtz9xt47260OxaIBrU26vlyrBUUybpC1XVYGmPzQ6D1z00uTT
         wbvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qdWwmg+14n1DaRnl28IG08HFZIgAWf2t2MbKwndU72c=;
        b=iSrfzk3lFBN+T+pNYkXTQ0Lj9d/34q0Pi5ZnY1mIgtKF6e6HbnhTA8P3UqAkAjpaag
         WcjdFDJkARuBDmAeQYbFQu8YHdXkxA6Jwyt3vpYKQ0aXOFKTcJ+im+OFgKUHFmyuoxti
         CKAN/Z8oJMp8WlvLwJNe08Kofc7JilXRZX+Hn399UxXHvFAc4zKZozpzkH1Ibwo2WAN8
         eazoOlhDjN4xcWRTX/ByB1iAL0XWYY/Oz+2US0kSAAbbDakllRC8AJgrGrucWrQp+GA/
         liiyAW7QrGekgxUpfCYz1TPjIsQ4fU6tEU/Mn8NIqBvWnlBgrS8Yz/WgsN9jKZ/FbKJS
         pzaQ==
X-Gm-Message-State: AOAM530YVLiGZ/btVyHSAp7A2AMFauOhsNI7XtbWD8eU+DJcMqVSTIgi
        hNWNuSQ1SLynbKSquWj/AXbtdw==
X-Google-Smtp-Source: ABdhPJw1piJm7Krc+6zZ/CPphPU41qmSodbZFwZS2w7ooTz/ljI1XcCYZLUgxlMk0YlnaxqHPdW65A==
X-Received: by 2002:a1c:a4c6:: with SMTP id n189mr4168059wme.173.1593102693664;
        Thu, 25 Jun 2020 09:31:33 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id l8sm32090847wrq.15.2020.06.25.09.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 09:31:33 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 00/10] Fix a yet more W=1 warnings in MFD
Date:   Thu, 25 Jun 2020 17:31:17 +0100
Message-Id: <20200625163127.4000462-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Attempting to clean-up W=1 kernel builds, which are currently
overwhelmingly riddled with niggly little warnings.

Lee Jones (10):
  mfd: cros_ec_dev: Fix cros_feature_to_{name,cells} struct descriptions
  mfd: tps65218: Repair incorrect function argument name
    's/tps65218/tps/'
  mfd: tps65217: Repair incorrect function argument name
    's/tps65217/tps/'
  mfd: ab3100-otp: Add missing colon(s) for all documented kerneldoc
    arguments
  mfd: tps65010: Remove delcared and set, but never used variable
    'status'
  mfd: si476x-cmd: Repair wrongly described function argument
    's/response/resp'
  mfd: si476x-cmd: Add missing colon(s) for all documented kerneldoc
    arguments
  mfd: si476x-i2c: Add description for si476x_core_fwver_to_revision()'s
    arg 'func'
  mfd: si476x-i2c: Fix spelling mistake in case() statement's
    FALLTHROUGH comment
  mfd: si476x-cmd: Update si476x_cmd_am_rsq_status()'s kerneldoc

 drivers/mfd/ab3100-otp.c  | 20 +++++------
 drivers/mfd/cros_ec_dev.c |  4 +--
 drivers/mfd/si476x-cmd.c  | 72 ++++++++++++++++++---------------------
 drivers/mfd/si476x-i2c.c  |  7 +++-
 drivers/mfd/tps65010.c    |  5 ++-
 drivers/mfd/tps65217.c    |  4 +--
 drivers/mfd/tps65218.c    |  4 +--
 7 files changed, 58 insertions(+), 58 deletions(-)

-- 
2.25.1

