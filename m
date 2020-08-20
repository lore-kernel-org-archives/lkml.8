Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78734C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 07:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CDF72076E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 07:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tYF2/zRf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgHTHyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 03:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbgHTHxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 03:53:52 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CDF3C061757;
        Thu, 20 Aug 2020 00:53:52 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id a79so619335pfa.8;
        Thu, 20 Aug 2020 00:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=V7dpkHJntuEfI3gKLsHKE5NL3K2FF0k9pm8mQcVZr3Q=;
        b=tYF2/zRfp2/3qZWZpfB0jI6w2gnBzZfpQeDXb6SkrlT75Uf9PlzW+WPVgo9Ym1Ad46
         GMeVOeZ/Jh9Zk+wh94FZsa2VlbLLZfAAX2ZaZ5IicN/bK1WFlEfs0Eg8x3SIygqcpvEt
         UJxagkQDG/PDSn9VmyXjO+6TbreP3Lg6xEXEfjmmvPVYRhYWRZOtJOGWX5b0zd+cVgkL
         +GN6UZVaqnWKOxLPZQGTJ1L0BNrFLIBQyam5No0lHpnLFqV+TJSt0DfCXDOIxEt94Uzk
         tIhFGesaA2gy6Voyk3GVN3QK2u5AhzzM0nLArhVNeCXaZGeZVTViB3KM0OKL6rVsO/k6
         cu4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=V7dpkHJntuEfI3gKLsHKE5NL3K2FF0k9pm8mQcVZr3Q=;
        b=W+5UTsPcxvTGobXqojqJgxb+TrY8oqKF/D7zDZpvLxFGesvwl3IfWMMqddASzStoXb
         VQR3ttzXHY7IVo67v9Z4HwrhlVxbXD1IvSz+67aHjsZ0y5fSe/jYFytmjh+vhwCYYwGX
         8zspDLx6xBr7AjD6ljpzKMX0HiFvUe9Zg3eCf6xnTVL0B6QPVpMo5gyqhDv9CCrqUlRD
         4Epfrh7JIRc0/aD4c0CDs4Do235S7IbBTla0uM1Fa+sZrqYgoGBIffmgmqsLKQPZdGNb
         m3lyObUfAjXXu/DPTLJzb63D3sPlt5BXlGIUpYvmo7PurbP0qLrn7nL5ZhppgQc3oqOn
         w+6w==
X-Gm-Message-State: AOAM530xvCxNfJCH6Z5JDkrXivIRwKaFmoSgOhI6IyYZcMRfStHseqsO
        /4/q6tyCR0VLOprNkWocCbU=
X-Google-Smtp-Source: ABdhPJxcTwXfOx9IDdIc47j4nhuqEyt43NJ7bWz9WAYnPXuZZyknl+AgRk2hE7/Mk44d+zJ8Vw+iyA==
X-Received: by 2002:a65:4148:: with SMTP id x8mr1596525pgp.245.1597910030790;
        Thu, 20 Aug 2020 00:53:50 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:577:c217:67e6:a40c:a3bf:1945])
        by smtp.gmail.com with ESMTPSA id q71sm1273832pjq.7.2020.08.20.00.53.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Aug 2020 00:53:50 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     matthias.bgg@gmail.com, robh+dt@kernel.org
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v3 0/2] regulator: mt6360: Add support for MT6360 regulator
Date:   Thu, 20 Aug 2020 15:53:40 +0800
Message-Id: <1597910022-22617-1-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series add MT6360 regulator support contains driver and binding document

Gene Chen (2)
  regulator: mt6360: Add support for MT6360 regulator
  regulator: mt6360: Add DT binding documentation

 Documentation/devicetree/bindings/regulator/mt6360-regulator.yaml |  109 ++
 drivers/regulator/Kconfig                                         |    9 
 drivers/regulator/Makefile                                        |    1 
 drivers/regulator/mt6360-regulator.c                              |  458 ++++++++++
 include/dt-bindings/regulator/mediatek,mt6360-regulator.h         |   16 
 5 files changed, 593 insertions(+)

changelogs between v1 & v2
 - regulator: merge regmap to mfd driver for r/w with crc

changelogs between v2 & v3
 - Move regmap define to MFD parent driver
 - Add bindings document

