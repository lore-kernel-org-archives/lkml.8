Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0840C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 00:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 856A52065D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 00:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eFBgkYUp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbgGJAnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 20:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbgGJAnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 20:43:08 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC7BC08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 17:43:08 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id j187so5068026ybj.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 17:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=PChTsD7+lOfYquQN6+h5WG1wyZRkuvc0gJ7VnIMPpcI=;
        b=eFBgkYUpUC19TYrSClaWnACSWhKB0k5jcDpo+PTCgNBUkAiDzm+ORJ7p+M7sjb66Ka
         lWtCn0H5by6dCE82W0iKV6mmx6kRgCqc+3AxVy8yWqUYQu43g026sorjNlQ0d1PDuQAZ
         29onMDkcy7/BpVBNOy1dwqDwjF+o8P8j+QhxUaXtj8tXYMCoJM0ZhcydfKpz4AB/eBDZ
         zWFSbDcHte5W/BvRP/taIxaEwuwcJY6eLjxsQH1s4riNeWuJGxvmV1zSQZqbBX2rVib5
         frgB94mh32Q9xz6rqcnyjrvx5EBbgbfZ2rBqxlsZnkuaxUTQnvF0rXIuSr1J4FI/Ark1
         2ZUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=PChTsD7+lOfYquQN6+h5WG1wyZRkuvc0gJ7VnIMPpcI=;
        b=WZU2u84R6JQGc/EV83ULFCz/NGkmDG295G2jVB4MxA30VL7jUyKSQ6hXTXrmp5bGKa
         wNSCR+ILOzeD+iKgKmmdqFXTle+kZJiZ8Xta5xIKa6A6EOcZjd589xU6dLJsYEzCw8sV
         TRUgdjK36hQnqm3AGyv9CmM19mjm601NoSTc7KMgoMHpbiZTF2tp5CBnnbOy0S8Z4sCm
         9wxlV3ZtlVJmNfn0wRMSNBk4IlA45dcaU3GPXuWyatOryDQqy3yC6GRqyCT5w81tvbWj
         e9b7cm9OrFWQT3OcGwOJfz1oKJc7U6cjohZwm5yPzmDb+0p6QLIygdmBHH44v21adyFn
         t5rw==
X-Gm-Message-State: AOAM530r+iBjsiedirwQgVv+26GlaRmYUJ/HvI1LYcboOyMJ52GRTiGm
        yullkw0eVWmMr55w8DhuT6v8As3/UYyC9ehG
X-Google-Smtp-Source: ABdhPJw3ovj5xIgTKeUgsA84rILy0QjfSh1DlsEiwU5RWnjTdC3QlkA8ODLexpuSzMstbWzOEt5EKdjDztKvbJhN
X-Received: by 2002:a25:c547:: with SMTP id v68mr1490103ybe.508.1594341787646;
 Thu, 09 Jul 2020 17:43:07 -0700 (PDT)
Date:   Fri, 10 Jul 2020 00:42:58 +0000
Message-Id: <20200710004258.296017-1-linchuyuan@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
Subject: [PATCH] dt-bindings: hwmon: adm1272: add adm1272-adm1275-temp1-en binding
From:   Chu Lin <linchuyuan@google.com>
To:     linux@roeck-us.net
Cc:     belgaied@google.com, jasonling@google.com, jdelvare@suse.com,
        linchuyuan@google.com, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhongqil@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Problem:
	adm1272 and adm1278 supports temperature sampling. The
current way of enabling it requires the user manually unbind the device
from the driver, flip the temperature sampling control bit and then bind
the device back to the driver. It would be nice if we can control this in a
better way by reading the dt.

Solution:
	Introducing device tree binding adm1272-adm1278-temp1-en. If the
flag is set, flip the temp1_en control bit on probing.

Testing:
make dt_binding_check

Signed-off-by: Chu Lin <linchuyuan@google.com>
---
 Documentation/devicetree/bindings/hwmon/adm1275.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/adm1275.txt b/Documentation/devicetree/bindings/hwmon/adm1275.txt
index 1ecd03f3da4d..4403fe30f005 100644
--- a/Documentation/devicetree/bindings/hwmon/adm1275.txt
+++ b/Documentation/devicetree/bindings/hwmon/adm1275.txt
@@ -15,6 +15,8 @@ Optional properties:
 
 - shunt-resistor-micro-ohms
 	Shunt resistor value in micro-Ohm
+- adm1272-adm1278-temp1-en
+	Enable temperature sampling. This is supported on adm1272 and adm1278
 
 Example:
 
@@ -22,4 +24,5 @@ adm1272@10 {
 	compatible = "adi,adm1272";
 	reg = <0x10>;
 	shunt-resistor-micro-ohms = <500>;
+	adm1272-adm1278-temp1-en;
 };
-- 
2.27.0.383.g050319c2ae-goog

