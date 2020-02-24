Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 781A0C35679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 07:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 484F320578
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 07:25:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UAvCFsUk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbgBXHZo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 02:25:44 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41877 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbgBXHZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 02:25:43 -0500
Received: by mail-pl1-f195.google.com with SMTP id t14so3682284plr.8
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2020 23:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pjmsw2c59UnP8bQTcR0v67l8n2Do0c3ipHd2w0BLgDw=;
        b=UAvCFsUkzi4NHTluHdWcn5wDT40ImYUMrkXDGvP+rlkh34aMNX7VR3G6cWJsG+C5kv
         VBXTaD07DS2Ntcv58V5c1jaoS+2kQSHxDDmLxOZ4MhBqVL+l7ozf3PlwOJYLy9Axl8QC
         raFopR/h6T4KN2OeT8yN+bdaxAvNCupz0mfDAv5/sdtuZjq7mSeAPkLD8VokSpzm3FSb
         XlfPvxQm2Rcbvwm+AusMJbH6xWMYEGJCldE481V0edXktO8xO3HyvQgC/Ni7+Jtb6wZh
         3MJ2Y9HI9QOABI4QjFkzEWy5Tglwf/5nGxtvr+SywIIkbcHru4PQnZ5rnMLXFcBXTTup
         ePPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pjmsw2c59UnP8bQTcR0v67l8n2Do0c3ipHd2w0BLgDw=;
        b=bqiu2JZlGDKZy4YTBYEN1f8DX4CT9szDZEmheNkEc1RF5HRPSRcs14HrzfOGu+6IEX
         QHHoy5EMexjr4jP9i/F4G6qicrq0o7Y/iaHZx5ln9Fk9mWKAVqS8MjtZffy4fBqiFA0X
         6LKO3hwgX85FjE63cvt28PCE6L0Us+1S0n+I/pf8NIz2ne3nzN8obaYHEigGbTnEB4AN
         7c5oL/+E/3WJLUARri7CBL5iXmrz1qxIIfGxW8AH+6zgLiXPrv6aKD5v7ITjQZuj/YmO
         oeUsjdDBrFEEu+7cMzEXfcvxH9GyQ/EoEEIsn/6oD08RjF+HA9GK2+89qfI7T2nmnI1k
         H4Ew==
X-Gm-Message-State: APjAAAXkpuY5Fh5wWM+ageXSL8J8guNjyUnmNoB9YmqYdrJEoLYrVVuo
        nfCAgxnqx7117EEFiWmhadfc8ZsdeCM=
X-Google-Smtp-Source: APXvYqyuEjegHI+TTFtAPD15xyrk4kjVIQfTd/OCLyY41lTTSOjgFzLRwSNoHBoQ46H6DvZt+SXzKQ==
X-Received: by 2002:a17:90a:d801:: with SMTP id a1mr19064921pjv.34.1582529142409;
        Sun, 23 Feb 2020 23:25:42 -0800 (PST)
Received: from localhost ([45.127.44.57])
        by smtp.gmail.com with ESMTPSA id e6sm11360185pfh.32.2020.02.23.23.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2020 23:25:41 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        swboyd@chromium.org, mka@chromium.org, daniel.lezcano@linaro.org,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [RFC PATCH v1 0/3] Convert thermal bindings to yaml
Date:   Mon, 24 Feb 2020 12:55:34 +0530
Message-Id: <cover.1582528977.git.amit.kucheria@linaro.org>
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

 .../thermal/thermal-cooling-devices.yaml      | 114 +++++++
 .../bindings/thermal/thermal-sensor.yaml      |  70 ++++
 .../bindings/thermal/thermal-zones.yaml       | 302 ++++++++++++++++++
 3 files changed, 486 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/thermal-cooling-devices.yaml
 create mode 100644 Documentation/devicetree/bindings/thermal/thermal-sensor.yaml
 create mode 100644 Documentation/devicetree/bindings/thermal/thermal-zones.yaml

-- 
2.20.1

