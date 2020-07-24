Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE3FC433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 21:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC5892070B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 21:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H+qRJk2E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbgGXVdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 17:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbgGXVdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 17:33:32 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE72C0619E4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 14:33:31 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id f185so1055444pfg.10
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 14:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B1AqK3EUiV48d+3lz3iz1nmsFf9iop99UmpDlzqxx6Q=;
        b=H+qRJk2Evf7iT6t/qQ/AMdP3HNwHlxLDJA50SR6M1C4GL4Ep2nb146xLvxVr0l19MX
         i5xb/UegDEnSnRHKvBwcgq9NY5W7JlU05DU8G+FLh573udW0vO0hOzP5ditlUXmnOqon
         jOWluibwkrfbqzFhIItHje/FZpqToWAdVWA44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B1AqK3EUiV48d+3lz3iz1nmsFf9iop99UmpDlzqxx6Q=;
        b=hjQnCwDDQ/3MFjevVkjSSHzHEeenEksxzHKiGa8ZqUxfdnMwRFG80MN9ekAIu3D5hc
         VZgF/XSVJD6+6hpyjipvBW7da5s+iM9K0N/sV34HeY9mzCtrmCwHXfhaRkdL9OotttsV
         YZlYXUiMycfyI2QH4bLN0B59wuQ6ReOOQXWHbDwKegwBggCogyC+eZUNZU7dfZ0Y4Wb4
         yTbBlHaPn0Cbqt3Oe8PiWmt+NhwXUB0hiLIg3EKMMvRG1FpkDlME6VdyVzbVOyxiojNx
         O1vYqntBN6tXQVmQIpq53fIsHtkXfdeinr1U1wfP2BZE/2NrJ8uU/mROx/CZ2xoNBBVr
         HksA==
X-Gm-Message-State: AOAM532rmaGAvq5QKWT7QRehHZWvYsVCCM5f1xMZphc/AiTlCFHuTevF
        1KLfVl6iRdWfnviaV3ZqRtQyMw==
X-Google-Smtp-Source: ABdhPJzOJ9pzQnXog72nAIt8UsLKIvb78RU5GK02GZWpuU7oQHATBjt5kG0YapGEpLzXC28sQMiqiw==
X-Received: by 2002:a65:620f:: with SMTP id d15mr9918451pgv.270.1595626411314;
        Fri, 24 Jul 2020 14:33:31 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id z6sm7312919pfn.173.2020.07.24.14.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 14:33:30 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Campello <campello@chromium.org>
Subject: [PATCH 0/3] Some sx9310 iio driver updates
Date:   Fri, 24 Jul 2020 14:33:24 -0700
Message-Id: <20200724213329.899216-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches are only related because I'm looking at this driver. The
first one resends the DT binding for the driver that was merged in
v5.8-rc1 with a small change to update for proper regulators. The second
patch fixes a few printks that are missing newlines and should be
totally non-trivial to apply. The third patch changes whoami to unsigned
to avoid confusing. The fourth patch drops channel_users because it's
unused. The final patch adds support to enable the svdd and vdd supplies
so that this driver can work on a board I have where the svdd supply
isn't enabled at boot and needs to be turned on before this driver
starts to communicate with the chip.

Changes from v1:
 * Two new patches for whoami and channel_uesrs
 * Use bulk regulator APIs for supplies patch
 * Support both regulators

Daniel Campello (1):
  dt-bindings: iio: Add bindings for sx9310 sensor

Stephen Boyd (4):
  iio: sx9310: Add newlines to printks
  iio: sx9310: whoami is unsigned
  iio: sx9310: Drop channel_users[]
  iio: sx9310: Enable vdd and svdd regulators at probe

 .../iio/proximity/semtech,sx9310.yaml         | 60 +++++++++++++++++++
 drivers/iio/proximity/sx9310.c                | 46 +++++++++++---
 2 files changed, 97 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml

Cc: Hartmut Knaack <knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Daniel Campello <campello@chromium.org>

base-commit: b3a9e3b9622ae10064826dccb4f7a52bd88c7407
-- 
Sent by a computer, using git, on the internet

