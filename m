Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 810E1C3F2D8
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 12:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A9D92072D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 12:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kEFjk2FJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbgCEM4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 07:56:52 -0500
Received: from mail-pf1-f175.google.com ([209.85.210.175]:37685 "EHLO
        mail-pf1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbgCEM4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 07:56:50 -0500
Received: by mail-pf1-f175.google.com with SMTP id p14so2746973pfn.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 04:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Dprw7ZFMCDJrSnYhVdBa1Xg6BNbV4uRfUelp4S9rGA0=;
        b=kEFjk2FJuT0bTqOB47M1X5eP6R8OteYtR4JIWqXJuOgVb8iPKklyX/l9optB/f2RF9
         ZFPrFzSdZB1QoolioWMI3bQpTQhbGDIeyPjt0qAOoVa0PB5Vnis3oqlGPIWkgosKd2td
         xA1MwoIGNLL1F/iJgQK1cQvlXRf9UR+gbexWXIpby6u/wkDksjvuDSSCc+QR5H/QvdAc
         2fpxGieTanfotI8/fE5Zq9eDbUvuc+tTO/NcuEY+hycugklihEUVvL4dvfAAJQOqtBZX
         DRFuoOfElyCHL2m0u4AqlKswio203EqZ5A0lUPw93fDT2jKOq2WvCL5ae2kpTR1MTG9o
         PWNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Dprw7ZFMCDJrSnYhVdBa1Xg6BNbV4uRfUelp4S9rGA0=;
        b=JM/ampC5H0DCWnCo9J9n11vqOEQlZPQ7e0YpetaBFdKKXD48d2lsQ023NPSjCOtR7V
         OaOXFnkOTrYAB2T5ELyLUMflw11QrAgg995z1JSpz9aE8x4rtfdXRtgWMRE2mDi66wE6
         ol1PmJCNDW5n2tlCo94V3I97dakaONIteDypRsNL+eJjarrsWWLRfd0yGjdzC+8yKX3a
         Luwt5tlrhkPXuy2dseFPIzXW4mTZYCmdnPR1pikd/4ZwR0R47kfHCzCywY9SyRLe3CO8
         CmsRgkNdzSRv13TXelXTAdWU1t1T0/nASy0ChHdYo4lX/FLsap9YSsswM3PO8J7oMrGp
         DUjg==
X-Gm-Message-State: ANhLgQ3PhUu636u3ioGzNH0M1EB0D2Wr2vZJsC9YtRQaCOCGK/A2vIgX
        9ye5CWhfJsD/y8tJDdTwqzYEm7599E0=
X-Google-Smtp-Source: ADFU+vt6eJdigGY0gJ+ou8rfZpvaDtLlREuL14K8KGvtSIycxJ1ayhllrOFyBNHe/bBZis7imub9UA==
X-Received: by 2002:aa7:97b4:: with SMTP id d20mr8372466pfq.62.1583413008653;
        Thu, 05 Mar 2020 04:56:48 -0800 (PST)
Received: from localhost ([103.195.202.216])
        by smtp.gmail.com with ESMTPSA id 13sm31824464pfi.78.2020.03.05.04.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 04:56:47 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        swboyd@chromium.org, mka@chromium.org, daniel.lezcano@linaro.org,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v2 0/3] Convert thermal bindings to yaml
Date:   Thu,  5 Mar 2020 18:26:40 +0530
Message-Id: <cover.1583412540.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Here is a series splitting up the thermal bindings into 3 separate bindings
in YAML, one each of the sensor, cooling-device and the thermal zones.
Since I was learning about YAML parsers while creating these bindings,
there are bound to be some issues.

Changes since v1:
- Addressed review comments from Rob
- Moved the license back to GPLv2, waiting for other authors to give
  permission to relicense to BSD-2-Clause as well
- Fixed up warnings thrown by dt_binding_check

I have to add that the bindings as they exist today, don't really follow
the "describe the hardware" model of devicetree. e.g. the entire
thermal-zone binding is a software abstraction to tie arbitrary,
board-specific trip points to cooling strategies. This doesn't fit well
into the model where the same SoC in two different form-factor devices e.g.
mobile and laptop, will have fairly different thermal profiles and might
benefit from different trip points and mitigation heuristics. I've started
some experiments with moving the thermal zone data to a board-specific
platform data that is used to initialise a "thermal zone driver".

In any case, if we ever move down that path, it'll probably end up being v2
of the binding, so this series is still relevant.

Please help review.

Regards,
Amit

Amit Kucheria (3):
  dt-bindings: thermal: Add yaml bindings for thermal sensors
  dt-bindings: thermal: Add yaml bindings for thermal cooling-devices
  dt-bindings: thermal: Add yaml bindings for thermal zones

 .../thermal/thermal-cooling-devices.yaml      | 114 ++++++
 .../bindings/thermal/thermal-sensor.yaml      |  72 ++++
 .../bindings/thermal/thermal-zones.yaml       | 325 ++++++++++++++++++
 3 files changed, 511 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/thermal-cooling-devices.yaml
 create mode 100644 Documentation/devicetree/bindings/thermal/thermal-sensor.yaml
 create mode 100644 Documentation/devicetree/bindings/thermal/thermal-zones.yaml

-- 
2.20.1

