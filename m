Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0962C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 23:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB623207FC
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 23:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HOn3483C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729886AbgG1XFf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 19:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729223AbgG1XFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 19:05:34 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA012C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 16:05:34 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id z17so2625245ill.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 16:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X2K1uWR/QwXzI+l+S0k7hjE0zeO95oKopjPckuJcKks=;
        b=HOn3483CcpZx2rWHnawxK0dXc7b7G3G5XyIIEaStLxCW23pUVEwNQSJlsoN5IYnNKY
         0RzfcqUgEwEbc52FV8EqKZrskl8T7j7KFw4co7FnweEU/6zwiFFfZGKBxxQPDxgrn0zb
         JqFA1LXPUUMNTBIiCOnr5umVrMuM3+gdkejyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X2K1uWR/QwXzI+l+S0k7hjE0zeO95oKopjPckuJcKks=;
        b=QDwAnZJPDvOcFyDML/hGJFJWqHM/yofFiD44lJkCC0YLHHQhmoluD1KZVlPSIeQjr5
         FxhE4yg9/PRGqPpellwfZJSQqdtK8juC4NdhHBzVeD/VmUYgpDpzqDmRq7OourU5S3lu
         gjAdOb6Lu9zzHVvyBLvj6RsrwDc/9555D+SWCIFS/DEG0MMc1V10971Wv2QxtdeqCdul
         S2vjjRgrwiRzAnafXY68wiYskTcQyZK5COsRiC736G2biQaHV1BULoZcxyOSMXsg6CYm
         BKZGCUEK4mp73HFXzMaAO502TbbYmqImF82DMQN+1YudTkQvqVcJcHtyaX6yBH6uov+I
         8ESQ==
X-Gm-Message-State: AOAM533802m1kjDktIxL5ZD/Zt/kCnNi5Jnet9LgvZZAj1I7AQLWvWWw
        aoSYX+rjC4XZSPwkgg//IyUAhw==
X-Google-Smtp-Source: ABdhPJxeTMzUL3WLdENfYV1RlntACUW3gDS4unVc7Ykwx0HXqZLKzhm39zzPu64EzsiHP3DPycSDBQ==
X-Received: by 2002:a92:db06:: with SMTP id b6mr26282237iln.228.1595977533862;
        Tue, 28 Jul 2020 16:05:33 -0700 (PDT)
Received: from derch.Home (97-122-92-59.hlrn.qwest.net. [97.122.92.59])
        by smtp.gmail.com with ESMTPSA id w10sm148945ilo.10.2020.07.28.16.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 16:05:33 -0700 (PDT)
From:   Daniel Campello <campello@chromium.org>
To:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Daniel Campello <campello@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>, linux-iio@vger.kernel.org
Subject: [PATCH v2 00/14] sx9310 iio driver updates
Date:   Tue, 28 Jul 2020 17:05:06 -0600
Message-Id: <20200728230520.2011240-1-campello@chromium.org>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
In-Reply-To: <20200728151258.1222876-1-campello@chromium.org>
References: <20200728151258.1222876-1-campello@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first patch resends the DT binding for the driver that was merged in
v5.8-rc1 with a small change to update for proper regulators. The second
through the eleventh patch fixes several issues dropped from v8 to v9
when the initial patch was merged. The twelveth patch fixes a few
printks that are missing newlines and should be totally non-trivial to
apply. The thirteenth patch drops channel_users because it's unused. The
final patch adds support to enable the svdd and vdd supplies so that
this driver can work on a board where the svdd supply isn't enabled at
boot and needs to be turned on before this driver starts to communicate
with the chip.

Changes in v2:
 - Added #io-channel-cells as a required property
 - Reordered error handling on sx9310_resume()
 - Added #include <linux/mod_devicetable.h>
 - Added '\n' to dev_err()
 - Fixed commit message from "iio: sx9310: Align memory"
 - Changed prox_stat to chan_prox_stat bitmap.
 - Fixed dev_err() message
 - Added '\n' to dev_err()

Daniel Campello (12):
  dt-bindings: iio: Add bindings for sx9310 sensor
  iio: sx9310: Update macros declarations
  iio: sx9310: Fix irq handling
  iio: sx9310: Remove acpi and of table macros
  iio: sx9310: Change from .probe to .probe_new
  iio: sx9310: Fixes various memory handling
  iio: sx9310: Use long instead of int for channel bitmaps
  iio: sx9310: Use regmap_read_poll_timeout() for compensation
  iio: sx9310: Update copyright
  iio: sx9310: Simplify error return handling
  iio: sx9310: Use variable to hold &client->dev
  iio: sx9310: Miscellaneous format fixes

Stephen Boyd (2):
  iio: sx9310: Drop channel_users[]
  iio: sx9310: Enable vdd and svdd regulators at probe

 .../iio/proximity/semtech,sx9310.yaml         |  65 +++
 drivers/iio/proximity/sx9310.c                | 424 +++++++++---------
 2 files changed, 277 insertions(+), 212 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml

--
2.28.0.163.g6104cc2f0b6-goog

