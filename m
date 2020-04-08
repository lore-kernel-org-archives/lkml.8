Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20900C2BA2B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 11:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E52F52076D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 11:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fj4kbjPm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbgDHLI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 07:08:26 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44789 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbgDHLIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 07:08:25 -0400
Received: by mail-wr1-f67.google.com with SMTP id c15so7285363wro.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 04:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uz8UY4eWPJrlC/KHAdRsMpZsS+aRJqI8gmWI20mDg+s=;
        b=fj4kbjPmHVx5Aq7luyrz5Ec2HyEpIV74NPD7KGBOSquGJHEe85K+/i+xc6OBHI/72N
         gZqESCnrYhdXbm5qLhael05Y+uXXjB5ynaZRM7facAZgFZ9hLVZU+8D7pznC0wLnWJ1l
         wBpFwJGlEbu2sy7ZUX8uF55hvdaPWv7rFCTJrmpLIRAYIRwFwHczLYnE/qXt2zSyHpxM
         NF/wxFpK58xXcqQOTo83kaRjnOUldA3ba4aJpSzGyXiM5Hjpi3HW3O+cSovFVrZvScIA
         aKnD0vdu+SPzC+oyAM8xB0P8K6wVr9MP/GezOAUCRVHfB2G/qpe+nhPGhte8Phhc03u5
         EJww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uz8UY4eWPJrlC/KHAdRsMpZsS+aRJqI8gmWI20mDg+s=;
        b=Z+ryYTfNnd8UjkfvZ1L9kAZ4pt0mkDzrqVnHXfJSKhEQXaltcVZJTbLwEev8qpxQEq
         jJ9cAPEWUcA3+glwCvbuOR9DrXY9gBYf79Ibw0ehJ0FCiVVPv/fnKDzQKPCSvfSn6fMD
         IJ61yeG3vXkGH+y4DF4m80H3mPOq6AUL6gMe/2PYGKb6UPK5dCxukoedmWz9rE1/MOyF
         BArfGEOG1RWk8OtO7vMVBMavkL6SgDp1gFWKm4RWqNvvf5LANsvGuajEZilRkyTkJZfW
         wZr3dInApUeZlYjBYge2g+xCORQJico++ytv5xu87k0pSxJz16V8J5nge139PEKLIen5
         FZkQ==
X-Gm-Message-State: AGi0Pub4ZNozqIXSdVQCEQ8s6vRraeMCzjTB2Coy2cjoDyltRwTETdbE
        Q5hTs41Nkbes9z5aZKOrtP5G0g==
X-Google-Smtp-Source: APiQypIHRKuvNtlqBzAppetUZdYeMh5uW9upNPqzx1rWVmyvdyQVhoEmPglxFVAPk23/+WwHIT1oGQ==
X-Received: by 2002:adf:db0a:: with SMTP id s10mr7916205wri.361.1586344103363;
        Wed, 08 Apr 2020 04:08:23 -0700 (PDT)
Received: from localhost.localdomain ([37.120.50.78])
        by smtp.gmail.com with ESMTPSA id i8sm37596253wrb.41.2020.04.08.04.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 04:08:22 -0700 (PDT)
From:   Robert Foss <robert.foss@linaro.org>
To:     Dongchun Zhu <dongchun.zhu@mediatek.com>,
        Fabio Estevam <festevam@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Tomasz Figa <tfiga@chromium.org>,
        Maxime Ripard <maxime@cerno.tech>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Robert Foss <robert.foss@linaro.org>
Subject: [PATCH v4 0/3] media: ov8856: Add devicetree support
Date:   Wed,  8 Apr 2020 13:08:13 +0200
Message-Id: <20200408110816.2712841-1-robert.foss@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds devicetree support to the ov8856 driver.
In order to to aid debugging and enable future sensor
modes to be supported, module revision detection is also added.


Dongchun Zhu (1):
  media: dt-bindings: ov8856: Document YAML bindings

Robert Foss (2):
  media: ov8856: Add devicetree support
  media: ov8856: Implement sensor module revision identification

 .../devicetree/bindings/media/i2c/ov8856.yaml | 143 +++++++++++++
 MAINTAINERS                                   |   1 +
 drivers/media/i2c/ov8856.c                    | 196 ++++++++++++++++--
 3 files changed, 325 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/ov8856.yaml

-- 
2.25.1

