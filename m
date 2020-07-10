Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E582C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D83BF20767
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:51:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WqiItYKo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727886AbgGJNv5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 09:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727074AbgGJNv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 09:51:57 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D2CC08C5DD
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 06:51:57 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id o38so4417809qtf.6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 06:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mD9V7UZ4VWyDxWe0RMtKVzjCoRnAKAU2sQu7+0bQiPk=;
        b=WqiItYKo6aJJIGl1rr7X+RB9osWX1B+DB5otWhGQjHKVrRJGlIcJK1w0roY2sG4EoY
         VT8K80E9tG9Cr+i6LHHTLs0g6oUaQiY8oHENTfwrrYF3DfBPu8Vy7ePQe+gBXGdeyYAF
         cUQN3bR8KMqQSP2SQyKqE/mhYz6C5DxGD47gQaU7etBLtvD7vmD3qO7Zx9KjESXqOIP0
         ibNCwRhEXjn1H8KEbDO4yEEJ+2yXQPEBMbD8E8MA6lG+Gnsbk6xY9SFCgg6R4ajgx5dy
         5zKrwMOXG08neINui2kn/1VApOEWXziohOGomoNL4bfuFfjOu1YrEgm278xzct3DtrJ0
         F0xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mD9V7UZ4VWyDxWe0RMtKVzjCoRnAKAU2sQu7+0bQiPk=;
        b=Oz6H7KQrjGZPLNu2c1kL0I6kY28a3nlGgkc2vbi4CiFS8TB0o5KdEcL+wnkxbOBuAC
         pv8KdFlwKBocewS/EVEkKdPdvkdG03t9yBFB3QJbESwsdJxFp6M63cRUwK7QpDLrSK64
         O6L70WKWkVUCby/NAzEN94LECfdMt4nYzmmp51EZapDWYMmiWa7TeCgGDtPmkrNogP3/
         yf/azkC8we8TeQTeLWQoNs+glKmK9plVW3BQLvOnTPukCi3vuvJ7T4bvLWLQoJwXF828
         SMNyxGRGYU+MY0rgd7ZM24PVI6BbK1oNjGIt0AQ043kKB0mQEUkjU6KkgYyIFLzWCZM0
         G7hg==
X-Gm-Message-State: AOAM532LBACuxxC99EMk35zPxcDpOc5iTjSFmemNsoVJXrv2HcFR6xiT
        4FZ7g78PQloKkjSTl8Urt8kt3Q==
X-Google-Smtp-Source: ABdhPJwswF77/4I/t9HjfotGGECVwUdfdQ/4b1ljvJWj6XIaMmJums4pdCo2QSzyWfRWSEtO61NklA==
X-Received: by 2002:ac8:1972:: with SMTP id g47mr71075904qtk.180.1594389116195;
        Fri, 10 Jul 2020 06:51:56 -0700 (PDT)
Received: from pop-os.fios-router.home (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.googlemail.com with ESMTPSA id h197sm7574059qke.51.2020.07.10.06.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 06:51:55 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com, robh+dt@kernel.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/4] thermal: Introduce support for monitoring falling temperature
Date:   Fri, 10 Jul 2020 09:51:50 -0400
Message-Id: <20200710135154.181454-1-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thermal framework today supports monitoring for rising temperatures and
subsequently initiating cooling action in case of a thermal trip point
being crossed. There are scenarios where a SoC need some warming action to
be activated if the temperature falls below a cetain permissible limit.
Since warming action can be considered mirror opposite of cooling action,
most of the thermal framework can be re-used to achieve this.

This patch series is yet another attempt to add support for monitoring
falling temperature in thermal framework. Unlike the first attempt[1]
(where a new property was added to thermal trip point binding to indicate
direction of temperature monitoring), this series introduces a new trip
point type (THERMAL_TRIP_COLD) to indicate a trip point at which falling
temperature monitoring must be triggered. This patch series uses Daniel
Lezcano's recently added thermal genetlink interface[2] to notify userspace
of falling temperature and rising temperature at the cold trip point. This
will enable a user space engine to trigger the relevant mitigation for
falling temperature. At present, no support is added to any of the thermal
governors to monitor and mitigate falling temperature at the cold trip
point;rather all governors return doing nothing if triggered for a cold
trip point. As future extension, monitoring of falling temperature can be
added to the relevant thermal governor. 

Patch series introducing various resources that are used as warming devices
on Qualcomm sdm845:
https://lkml.org/lkml/2019/7/29/749 (already merged)
https://lkml.org/lkml/2020/6/3/1112 (under review)

1.https://lkml.org/lkml/2019/9/18/1180
2.https://lkml.org/lkml/2020/7/6/238 

Thara Gopinath (4):
  dt-bindings:thermal:Add cold trip point type
  thermal: Add support for cold trip point
  thermal:core:Add genetlink notifications for monitoring falling
    temperature
  thermal: Modify thermal governors to do nothing for "cold" trip points

 .../devicetree/bindings/thermal/thermal.txt   |  1 +
 drivers/thermal/gov_bang_bang.c               |  8 +++++++
 drivers/thermal/gov_fair_share.c              |  8 +++++++
 drivers/thermal/gov_power_allocator.c         |  8 +++++++
 drivers/thermal/gov_step_wise.c               |  8 +++++++
 drivers/thermal/thermal_core.c                | 21 +++++++++++++------
 drivers/thermal/thermal_of.c                  |  1 +
 include/uapi/linux/thermal.h                  |  1 +
 8 files changed, 50 insertions(+), 6 deletions(-)

-- 
2.25.1

