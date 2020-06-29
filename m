Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D18C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18DE0204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lnvjLc1b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730545AbgF2VVQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729769AbgF2Swn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:52:43 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC19C00F815
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 05:32:20 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z13so16365729wrw.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 05:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f4yvmeMrYth7vqHMwVBhUCXZW5p/DEPphxbozS+jA6U=;
        b=lnvjLc1bBFbqMU2TfxeyZvdJzgXPTGJDHyapuZIjb+oS4LFvMB8r2/fUcVYnBE5OaE
         w9KYpFZkwCEcTu4keVTFajpMTRIffqCYl/qZLCgMO/dbVRTIPkq2USh0W3X2/5mxnK4X
         hZCO597boD94CSEq0XihDCgRuOuksUoaEsV+k9qFre9ZvmEnKzcuFoaKqLSjMdW/qGAt
         7ocgBiTYsr6oqRJStWX9Xj6X4gJHXy6LW5YeCjA1nEywFtcBOqtuIAGWYyzyS78biusE
         wh4RLszlwl3rhrENusI8biXNYHp9PWU2CiYuIQmq8OD1h6z8FvQG/uwtTJ8d3tXU0RIQ
         sdwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f4yvmeMrYth7vqHMwVBhUCXZW5p/DEPphxbozS+jA6U=;
        b=ADrUTn6svdJnc7Z9Gpnq/hXROzq42xE739j1LnERyXLW1PaVu2FWbfFUFfKs3whzh6
         SFo5pqFYbfKN8/rNfbsSAl4J/lrtW6dTg8g5Oe37SWspSY4AUW0vu76zdziu0aKh37Z4
         Qf5RNPNBen8yOhK+663YPtNQ7cota5SwRdIO8qM+b4d9w2yOYjynZGxotFgKTWPlpP0i
         R9PHFoGE8q1CKRUn82CqvWkO1DkqHPgb+aX/mOMO/j3UT8WpaSNoJGnBqeRR8b8b9cNa
         JYybGh+ajd7aqcuBPmPfEUoQQ6wzuLDY9IQHsuOko1jIqk7/qNRxthR6s2Svl8Op+8IU
         5HIA==
X-Gm-Message-State: AOAM533oMSC3OnsD/5Y4V+gAVZkO6XSo0JPKj6Gj1zYGZB26Wh2SFVzu
        fAX0Tb8MAaOtixehc79Er/x7zg==
X-Google-Smtp-Source: ABdhPJy/09sSLknOKduOER2VRtpSYW/RiFyA61OtJ1cUqDxEZ65G6LFMODiDvN0649LK6VhfkXsznQ==
X-Received: by 2002:a5d:4b4f:: with SMTP id w15mr16564174wrs.84.1593433938785;
        Mon, 29 Jun 2020 05:32:18 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id d201sm28064111wmd.34.2020.06.29.05.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 05:32:18 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] Last batch of W=1 warning fixes in MFD
Date:   Mon, 29 Jun 2020 13:32:10 +0100
Message-Id: <20200629123215.1014747-1-lee.jones@linaro.org>
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

Lee Jones (5):
  mfd: si476x-cmd: Add missing documentation for
    si476x_cmd_fm_rds_status()'s arg 'report'
  mfd: lm3533-ctrlbank: Cap BRIGHTNESS_MAX to 127 since API uses u8 as
    carrier
  mfd: rave-sp: Fix mistake in 'struct rave_sp_deframer's kerneldoc
  mfd: sprd-sc27xx-spi: Fix divide by zero when allocating register
    offset/mask
  mfd: axp20x-i2c: Do not define 'struct acpi_device_id' when
    !CONFIG_ACPI

 drivers/mfd/axp20x-i2c.c      | 2 ++
 drivers/mfd/lm3533-ctrlbank.c | 2 +-
 drivers/mfd/rave-sp.c         | 2 +-
 drivers/mfd/si476x-cmd.c      | 2 ++
 drivers/mfd/sprd-sc27xx-spi.c | 2 +-
 5 files changed, 7 insertions(+), 3 deletions(-)

-- 
2.25.1

