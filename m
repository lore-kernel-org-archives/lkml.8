Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF16C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 14:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C8892073E
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 14:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ek6i81JW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbgGEOvK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 10:51:10 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57623 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726861AbgGEOvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 10:51:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593960669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=iXCxfmDIqLR0YY1Yveu6peJuEk9aFuiQ279/+YX39vE=;
        b=ek6i81JWQQHCngtpI/XvhanoIkfhgVG775elK5kYc0zzVJAvRO65gnDk0slwVN6LQwVv5R
        xnV8M2FsMPRv3gLsg/etNTF0t8Qrx8gAWEgWy1ggG/+m9NIXmOtkRzdMuYwqv9/85eC3O2
        kkDvh53QUFuR/db4wujLoGw5s5KK4No=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-0fLysM_WMwykuDtWryFjOQ-1; Sun, 05 Jul 2020 10:51:05 -0400
X-MC-Unique: 0fLysM_WMwykuDtWryFjOQ-1
Received: by mail-qt1-f200.google.com with SMTP id 71so18275116qte.5
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jul 2020 07:51:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iXCxfmDIqLR0YY1Yveu6peJuEk9aFuiQ279/+YX39vE=;
        b=COODZCWurx8YSXSDLfr6kRumMcAIwWSzyq7wsAzK61oTs1kpP7Tif2ZxDvdB9LgfJq
         sETzae2nxsQItaXeHABtDNoxpKDjPgQ2xb1aenKsZnnk++u/oLnlel/luRd8uKyk6d6V
         wlt9XZx8krpGvTiwI83ZHSoRyNS4zFPFKR1jCcrlVXGkxRgviW3TtPLWosdnveqH38yf
         RTAzIepTgWusW/8Z2ANtFcpLixxyMOJKU43JyqXvXEUh+SVaOTcKWajK1LJfFhknzuPv
         Yn60rag2Wvyu1rsK7sDf7lYeFOjTUqxuKnNEmyBuLYghLpkqo7rHl+GCcICaV5kVZoYb
         yC+w==
X-Gm-Message-State: AOAM5336+xS9Lz9hHdBhf8PB4I0c74zKqFegirYeOjkVNmnPX9znlGwj
        /pL0myiU6Xn55NXE+GScnmnFWt3lq8Gm0buFsADqUiHnQZUz3qepbS+JWFfOrjni762g5WG7RNi
        L+fpaqoqb+gZ+/8pJSZ+7CVd7
X-Received: by 2002:a05:620a:1282:: with SMTP id w2mr41504921qki.196.1593960664740;
        Sun, 05 Jul 2020 07:51:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwWTIqnguVvpnywYSxPHy22VXsfHPo1AXr38eRYcmQQNSWIJu768VxjNNiP3WlrfVmxuHOCLQ==
X-Received: by 2002:a05:620a:1282:: with SMTP id w2mr41504905qki.196.1593960664505;
        Sun, 05 Jul 2020 07:51:04 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id b22sm13573907qka.43.2020.07.05.07.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2020 07:51:03 -0700 (PDT)
From:   trix@redhat.com
To:     agross@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] soc: qcom-geni-se: fix configury of qcom-geni-se.c
Date:   Sun,  5 Jul 2020 07:50:55 -0700
Message-Id: <20200705145055.14629-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

In a randconfig, qcom-geni-se.c breaks with

drivers/soc/qcom/qcom-geni-se.c: In function ‘geni_remove_earlycon_icc_vote’:
drivers/soc/qcom/qcom-geni-se.c:819:11: error: implicit declaration of function ‘of_get_next_parent’; did you mean ‘of_get_parent’? [-Werror=implicit-function-declaration]
  parent = of_get_next_parent(wrapper->dev->of_node);
           ^~~~~~~~~~~~~~~~~~
           of_get_parent

qcom-geni-sec.c correctly includes the linux/of.h header.
But the header depends on CONFIG_OF being set.

So add depends to QCOM_GENI_SE

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/soc/qcom/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 899f8c066797..f699cfa33d7d 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -29,6 +29,7 @@ config QCOM_COMMAND_DB
 config QCOM_GENI_SE
 	tristate "QCOM GENI Serial Engine Driver"
 	depends on ARCH_QCOM || COMPILE_TEST
+	depends on OF
 	help
 	  This driver is used to manage Generic Interface (GENI) firmware based
 	  Qualcomm Technologies, Inc. Universal Peripheral (QUP) Wrapper. This
-- 
2.18.1

