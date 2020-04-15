Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB78FC2BA2B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 06:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6CAF206D9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 06:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Df5prwBn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393513AbgDOGPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 02:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2393496AbgDOGOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 02:14:54 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53671C061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 23:14:53 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id a13so1077456pfa.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 23:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HqQvOKqfrHmlAX92Y682AdF2gTPigwd+5eBqOa7fcfE=;
        b=Df5prwBn+5ezXeOmd8ekPAfWpFczjY16mDdI8p+4Df4zHEeJNSIey/YUZdmd2ArmYO
         GJ1oVoj4lzgWnaT0TTHmdXzfvcNCHi8JCId35FXkwqW4c6dzhb5pzDKRlFYn/Feta8eA
         LH1ozPrQgPOZLh9V4iKOJYgXaPwQICXPJlvqRzRLOXatsSbHw3GX/6Uh7w8oV1ClQdLF
         TT5pLTY9AgC3hYk849f/1m9Dv1+RVIVPjnwPQN1Do+ftkAiT7Y7WaUIbowJcjq9UWnM1
         ytAgJ62QB8rA5bcgAaO2o8uYlbuvq1NjDprxzbFbzfktDHiTAlmzt9TpjJSNKJ1EMvz0
         bufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HqQvOKqfrHmlAX92Y682AdF2gTPigwd+5eBqOa7fcfE=;
        b=IZDGIqIideN2tbTnF+wHFJ7uEia6FGDpi+uQg9sWKy2xYvJJbpQwXAg8rZS6n7WW4b
         HJYsCRWozveRUX1jPwfvwiZErDwr/RBujKDKgtx5iUyvYshwjxMoMCR/va3eHuErIHPj
         S8jvmNvUFIkd3thmBh6zBVoWY2mAh1k5FAgfAifNAfvtBb1+HcbbAXzPGypayMyp8k2S
         aBKikpxtMO1EuKjGC7nXnSvCXvtLeVN1KfUHp4KUk0s5W44BgDUWKyWK/2ZmB6H2lyhO
         /8w3cfAapz5Fc3lOLjNcP9qgOZmNDb9T9/UGCxUt/Bw/zP0MLZFXiubr3asQPCeUmpRU
         cGcw==
X-Gm-Message-State: AGi0PuYrsk2PfDCk+vLJK5NvybYZxjLro724L3aWlD65xcNMFZq9OrzX
        aMPJxwD2n/4lKpy+O9W1GbleQg==
X-Google-Smtp-Source: APiQypK4jsIQQbeIVh7i0t4TdFr1EvsteW6AJaD6lxkNT7mK5sIRI0rfopbstmRfzG2YOPYTpTb5HQ==
X-Received: by 2002:a63:e210:: with SMTP id q16mr24711275pgh.26.1586931292670;
        Tue, 14 Apr 2020 23:14:52 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id e196sm2939332pfh.43.2020.04.14.23.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 23:14:52 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Qualcomm SM8250 regulators and UFS
Date:   Tue, 14 Apr 2020 23:14:28 -0700
Message-Id: <20200415061430.740854-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define regulators for SM8250 MTP and add UFS nodes.

Bryan O'Donoghue (2):
  arm64: dts: qcom: sm8250-mtp: Add pm8150, pm8150l and pm8009
  arm64: dts: qcom: sm8250: Add UFS controller and PHY

 arch/arm64/boot/dts/qcom/sm8250-mtp.dts | 351 ++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sm8250.dtsi    |  71 +++++
 2 files changed, 422 insertions(+)

-- 
2.24.0

