Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03863C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 10:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6BBA2076A
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 10:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uLZoHBJE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbgCZKjk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 06:39:40 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33648 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727936AbgCZKjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 06:39:40 -0400
Received: by mail-lj1-f195.google.com with SMTP id f20so5874868ljm.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 03:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nm7daEZmRCQGmg/oeW9vSEkTDhWhC4wvKQ8H8nvYJtM=;
        b=uLZoHBJEdtCKbN/cWMQfWVW6g7VVQmFbA9BxpfTJC7cp+MOqzvZrVFfgDeyxQk+57Y
         4WbA08qgC5ei/09QJVDsr4EZguqAkujA6xwZ8S9wOb8KNWCFtRIllODAqTj4DWEiiTsX
         qDydMS8vylDi8g/R3tfS1llR+urMeF4kKg/9i0UnxeqMfJBOdf7GZ+zEWOBzNFr4wfeO
         O4DcQdustyzR8jZ1MeHZKOfDKn0y46nufGHK1V/lertkMrPKavB7nuZiLbesId/A3UGO
         S1alPWvAOgFgldImIijjrtmS/IDo3h8V+OwyBWBk4YzB/WyDfeJc4aVeK1FkOMJrH+Sg
         pn5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nm7daEZmRCQGmg/oeW9vSEkTDhWhC4wvKQ8H8nvYJtM=;
        b=iXjVEIFXI66qbF44P8jiX5+kEsQU7Ftrlw4UCLG5TttS+/+tOxoY/lv6M8+eZI4Sdv
         rlG5wH5VXDZAeIGTMMXTKSgV9gzWgCCE2qZ6nM7Tc1qCiWEt3fZlbualFu/DAXTJd7h1
         YOMn4ObTYMTp7zHN842cxd51wkVi6wiz856dK6B90NI8qYc/epLrIir7EM5uaPIvCqES
         pAwhMl779VzBZo5siObm8rHZuamJvU+0CWlrkc8B2qzwjz7G6FSTjO8s2rHZsU1p3/I/
         pZHKueG80T9/NSY0C+hf6xfipiu4M7fsR0JwOPtY5P0gnso+2OfIloyjZ8nzv/znpVx1
         lEzg==
X-Gm-Message-State: AGi0PuaQx3VDGh5YExMrtGv0LBEa8kU+t/BoLCuFsNRdNqXJ0J0pcDB4
        OGL1sQppEztgmwO944HtqpQoMw==
X-Google-Smtp-Source: APiQypIGUavt2IrOB7A4U98tlaEHV4jg99sIklKUxPb5m6wVRKOPaVtVY3T6r1VJhKDcNeEFtQH5Ww==
X-Received: by 2002:a2e:8109:: with SMTP id d9mr4398900ljg.31.1585219177107;
        Thu, 26 Mar 2020 03:39:37 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id h3sm1304008lfk.30.2020.03.26.03.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 03:39:36 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 0/2] arm64: dts: msm8916: Conform to updated PSCI bindings
Date:   Thu, 26 Mar 2020 11:39:30 +0100
Message-Id: <20200326103932.5809-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PSCI DT binding was recently updated to fix some errors and so was also the
related domain-idle-state DT binding. Therefore, this series updates the
msm8916 to conform to these updates.

Ulf Hansson (2):
  arm64: dts: msm8916: Conform to the domain-idle-state binding
  arm64: dts: msm8916: Conform to the nodename pattern PSCI subnodes

 arch/arm64/boot/dts/qcom/msm8916.dtsi | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

-- 
2.20.1

