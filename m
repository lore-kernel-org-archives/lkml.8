Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 406C5C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 11:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1477B20888
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 11:36:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YhKv3XDU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388437AbgE1Lg0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 07:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388326AbgE1LgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 07:36:23 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4248C05BD1E
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 04:36:23 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 131so5050106pfv.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 04:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fad3eBoL47RObuH9V/3Rnk6J6MR5mdA+fugdf/ETXNc=;
        b=YhKv3XDUoqOrGa+J+dM4F35V/jbDpzsQw+fhjNAemqGieG8O6zJalxdN0GFNZxUr1s
         p+dYtlkPDBinp1enyDSAHAGl+4mNcrnmSRsVlUbWihTk5Z/hS0X11nMDxGPYMuScPy7M
         qBmsvxhz7tl/zMI0nkZ4u9+WKpG4pJydU7z5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fad3eBoL47RObuH9V/3Rnk6J6MR5mdA+fugdf/ETXNc=;
        b=jsyUc0OxdKvvkQgU30YHXPPDYP2C3VFxY0fwbrTD6CUm+8OhiuVpwzuR3hJiX1RTsA
         KEZcAhGZqAlPMCzT8nvC+aSkhoepL0dlE2l1pxrwC47j5KycAfT06ewvhwIAiRexDCPd
         2vw8qyHi7uvqTqx2GS0bOcCxvH0y3sdNsFlMtP4V0YbDqTMQuJz2zCNzOI7voND4Ut2r
         RFea4n+9SgYlMfGBITFofeu01cIuay8JLKUqKeZ92oXAw7QFoJCUdXb8b3ySk2NG2/L8
         aH6fFggyDKnkjPduyOg+Pqwaz7vK8AOUz18YGcsSv6fEKeeD6GRn3bNUGe9oue0i/Va2
         Gpbg==
X-Gm-Message-State: AOAM530RvZOUZHrADibaZ5xLccVMhwb2ke+ttlqMirXD70PwdmZcCW9b
        1gxDAv7DHGlcj57GnBusGQanugIaWuk=
X-Google-Smtp-Source: ABdhPJznEatG4DCJyfFLr3qB24QWKZDsfngfnonMleJEWcPLQpUaXU/lK0U8kCCbTFJPwJvn9MibAQ==
X-Received: by 2002:a63:d102:: with SMTP id k2mr2530181pgg.178.1590665782413;
        Thu, 28 May 2020 04:36:22 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:476b:691:abc3:38db])
        by smtp.gmail.com with ESMTPSA id g7sm4519961pjs.48.2020.05.28.04.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 04:36:21 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Fabien Lahoudere <fabien.lahoudere@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Tzung-Bi Shih <tzungbi@google.com>
Subject: [PATCH 0/4] platform/chrome: typec: Add mux support
Date:   Thu, 28 May 2020 04:36:01 -0700
Message-Id: <20200528113607.120841-1-pmalani@chromium.org>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds mux control support for USB and DP alternate modes on
devices using the cros-ec-typec driver with Type C switch handles
provided by firmware bindings.

The first patch imports some recent updates to the
EC_CMD_USB_PD_MUX_INFO bit fields from the Chrome EC
code base[1], while the rest add the aforementioned functionality.

This series depends on the following patch :
https://lkml.org/lkml/2020/5/19/1219

[1] : https://chromium.googlesource.com/chromiumos/platform/ec/+/refs/heads/master/include/ec_commands.h

Prashant Malani (4):
  platform/chrome: cros_ec: Update mux state bits
  platform/chrome: typec: Register PD CTRL cmd v2
  platform/chrome: typec: Add USB mux control
  platform/chrome: typec: Support DP alt mode

 drivers/platform/chrome/cros_ec_typec.c       | 190 ++++++++++++++++--
 .../linux/platform_data/cros_ec_commands.h    |  14 +-
 2 files changed, 187 insertions(+), 17 deletions(-)

-- 
2.27.0.rc0.183.gde8f92d652-goog

