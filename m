Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D416BC2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 06:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1418221F4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 06:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pum1V9QR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbgDQGTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 02:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726769AbgDQGTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 02:19:32 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D4AC061A10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 23:19:32 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id z6so590274plk.10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 23:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KaLJhIb2coWa2IjtKOIs6upgn6eKZTcPbPyZ0hH1G/w=;
        b=pum1V9QRu7JWtqiISczgYG5AuFxwS+Fql8hsyYmqBZqKf0czD7DCeAOZgyQP/eGBo1
         Nd8FQtWs/ARrjiv89qVpS8TDcHVAaaIPP0U4KfaO/mW80TcgIA+v8Ned1APmhO/3eSkh
         dazy+e9Ms36g3uO9BbsWYNQE/zp2K/QSfswKso1lgfwFWqERt7L1N8NXlNl4UPduyzo+
         P7x7qLXLy692BCHNM9Bg8ub2EzmZMMQqSwx2PpuLMNg+u3s5yqoLAttKNtOR9oph/DCd
         QQN07AOJWozGtrNL6ovZ9VfrFD5mMyFoNydRcyvr8Vb23rTQjgB7vkltketGXnkRkdF5
         L4mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KaLJhIb2coWa2IjtKOIs6upgn6eKZTcPbPyZ0hH1G/w=;
        b=rppV+fhRGOefvFXOdtZiLLVjSWgJhxyUMh8PsJ3Tlh5XoqmSNkpdIXMFWwCXBaGYp0
         yY9KS3jGBPcKECcJ9qX6c/Uf57ZkyFzi/YYzcEmyM2xWUWyRqaKwyRpmfUy0jGAHlden
         JgPx9Ix28wzzIk2B6vmRc2Ud2yPcwE4DCxkGUEGcJdtyjHVtoIKtSuNbt5rZU9b9GxED
         WLN/JUBZubNTm9LZZsivG0JQxYqu/m8EJIrIkdliNDTbdCZYE9MLhWpoo/2ebTmTAxQ6
         +XsTGRQNRgBCsosL880duGJriJYq1rCGkPdfOFNiPs14bTwiU/TQqKg/27bwVn6Sv34T
         FB5A==
X-Gm-Message-State: AGi0PubyJ9vmONKddqFKPmutz61nlgEuJrJmFT/BPGcxBgFX6QmYwSQ1
        MYrFKFKRkd3MZzirib5k/gUTOA==
X-Google-Smtp-Source: APiQypKDP9jWF1DA4n5s/9cYwHwRSSE0WT9LP9meqBOnZghzN/Sf/XINr47C4piJRj5/RJNRne8xag==
X-Received: by 2002:a17:90b:3443:: with SMTP id lj3mr2508468pjb.38.1587104371547;
        Thu, 16 Apr 2020 23:19:31 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id nu13sm4696201pjb.22.2020.04.16.23.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 23:19:30 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 0/2] Qualcomm SM8250 TLMM binding and driver
Date:   Thu, 16 Apr 2020 23:19:05 -0700
Message-Id: <20200417061907.1226490-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Binding and driver for the Qualcomm SM8250 TLMM pinctrl block

Bjorn Andersson (1):
  dt-bindings: pinctrl: qcom: Add sm8250 pinctrl bindings

Venkata Narendra Kumar Gutta (1):
  pinctrl: qcom: Add sm8250 pinctrl driver.

 .../bindings/pinctrl/qcom,sm8250-pinctrl.yaml |  147 ++
 drivers/pinctrl/qcom/Kconfig                  |    9 +
 drivers/pinctrl/qcom/Makefile                 |    1 +
 drivers/pinctrl/qcom/pinctrl-sm8250.c         | 1361 +++++++++++++++++
 4 files changed, 1518 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml
 create mode 100644 drivers/pinctrl/qcom/pinctrl-sm8250.c

-- 
2.24.0

