Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136A9C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 06:13:48 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD75D20731
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 06:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5wLPNWC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD75D20731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbgDMGNq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 02:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:48212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbgDMGNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 02:13:46 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3EEC0A3BE0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 23:13:46 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id a13so4101077pfa.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 23:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/Ax8MGILFoIMpiKsL4JnhfuslvJSyn3opwBMU4G5wbk=;
        b=L5wLPNWClPnYoOmshy+R2trcjZHukYTbcfkSVkOujKaOkD23x/WWQiolmc3ceXISD+
         8bqShMOrFviTlsNeHEuuBEWhe8hq9If9ncnP2ZMZhiwCaegA5u2+WWQGy318y+s05xxE
         UmCsJdhuBEr0g3a8xrcPddZI0S2ltIvFgQO38smZ5/A2U26scqNqgy4bB/OU/44AsWc3
         jslNGwH0dzo0jdt/XrB955CgLoFhvAREL3on3Zc+ZqGWPuNylSQEw5KECARcntswz/4V
         sgyBuGEahw6B0IE/LdEqs0c+wTBpI43xt78bPwmwUTbA1R9RsSu4ok7AKfkPo4zEwTE6
         rfGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/Ax8MGILFoIMpiKsL4JnhfuslvJSyn3opwBMU4G5wbk=;
        b=fKS93ZgmgHhtybDAzyIQAR7qbxzHVxYGZvPTiFzkhuWT71wlCpweQmZZz4MI6HFNnW
         47fHqYP2M5KxVOOGSzflFFQx/YlEzGn6jHY/MZW49HjbKhiV/UXisRfg2VYya+AUAEtM
         hETzV748Yd2wR1GuPlVX9eWKvGsfIR5FA8BcWXbWz+7ZHd8aacq6jm2zg77YAI4D/65s
         upnstwVvvltAiHQOL4pHJT6BDUZcjSRyq7nJBkoPy4p6DRQU5ZNbgScz6VgAsbgzIufl
         KbV6UAggOthqUyL+vn1gnq0SGQOoX1u0eLtoAecFdlmXpeWov/lbX1Pb8+LM+PvorQ7g
         3vyw==
X-Gm-Message-State: AGi0PubX3B+vAzTQ0ISF+HYB4MjqJmwJ9OlaMEde6o6P9rtpR4NzG54N
        YuuFCvI7Y37SMei3psAzKc4=
X-Google-Smtp-Source: APiQypLIX0VOcM8zYOYY1f0OHeC3Cz7Bhsg3ctX/J1lsZzK5pZamuHU6c1F0RFpU9lOXg97c+D84Sw==
X-Received: by 2002:a63:a70b:: with SMTP id d11mr15873792pgf.358.1586758425688;
        Sun, 12 Apr 2020 23:13:45 -0700 (PDT)
Received: from localhost.localdomain ([45.135.186.19])
        by smtp.gmail.com with ESMTPSA id w5sm7712645pfw.154.2020.04.12.23.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2020 23:13:44 -0700 (PDT)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     lee.jones@linaro.org, arnd@arndb.de, broonie@kernel.org
Cc:     baolin.wang7@gmail.com, orsonzhai@gmail.com, zhang.lyra@gmail.com,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 0/3] Add new reg_update_bits() support
Date:   Mon, 13 Apr 2020 14:13:18 +0800
Message-Id: <cover.1586757922.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Spreadtrum platform uses a special set/clear method to update
registers' bits, thus this patch set registers a physical regmap
bus into syscon core to support this feature instead of using the
MMIO bus, which is not a physical regmap bus.

Any comments are welcome. Thanks.

Changes from RFC v1:
 - Add new helper to registers a physical regmap bus instead of
 using the MMIO bus.

Baolin Wang (3):
  mfd: syscon: Support physical regmap bus
  regmap: Add bus reg_update_bits() support
  soc: sprd: Add Spreadtrum special bits updating support

 drivers/base/regmap/regmap.c   |  1 +
 drivers/mfd/syscon.c           | 16 ++++++-
 drivers/soc/Kconfig            |  1 +
 drivers/soc/Makefile           |  1 +
 drivers/soc/sprd/Kconfig       | 16 +++++++
 drivers/soc/sprd/Makefile      |  2 +
 drivers/soc/sprd/sprd_syscon.c | 76 ++++++++++++++++++++++++++++++++++
 include/linux/mfd/syscon.h     |  7 ++++
 8 files changed, 118 insertions(+), 2 deletions(-)
 create mode 100644 drivers/soc/sprd/Kconfig
 create mode 100644 drivers/soc/sprd/Makefile
 create mode 100644 drivers/soc/sprd/sprd_syscon.c

-- 
2.17.1

