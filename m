Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20083C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 02:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA1B02085B
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 02:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="yql8zbdx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388276AbgEXCOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 22:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387932AbgEXCOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 22:14:01 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3C4C061A0E
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 19:14:01 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id z80so14761743qka.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 19:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dAvMUr5VDe0uNAxODcg8+zSeRgKSv9N5mSpKXFgOC4A=;
        b=yql8zbdxjGHPj6B6azXNxw4GasqS2Kh88s2Xd6xjxQP6dMCQi/Sq+TAJHcc8VHnQ4k
         xl6RChxRJPPv1vV5jy3sRn0U3atL1812e8JL66PApjPX13VDqGb0EGtR/+Cv+v+FDaCL
         pf+vqieVO/m1MRVlYn1r9G0dzbSo49csViUHBiKECZTRLmY6VjRXSsEjcp4y87PD8YkO
         5/ftqlnodB5IJIKOWLqyPHLKfVFBhcPNXPKGlN1iiG71AK7h8SEuTnQub8iek9siMrEZ
         vAX77e8uGh4M3s8bSiOyrz1ecFpk8GgjbOwdWhymKaqlGaJpZnhMgYhsxhk57AwbDfJG
         rfCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dAvMUr5VDe0uNAxODcg8+zSeRgKSv9N5mSpKXFgOC4A=;
        b=jd0Fy4VroXJiggsLDbqmENcxEEEfZiMmuHR61HwhCh623oZZAq+QaylW7LXQOvFmqn
         0xw7g7R1FakCCJc5fIp6+ka1oQnEQyrD2OLZsENP+TfTQpuLZAPZ1YQSGj4E8mM6kMUl
         ppagMFJlAIXAr/t53MLUZr1POCv92mCeN06LjDFwaKwpnarZ1qfueA0U3QBBo7dJmivg
         Tp3Za5rLMawt1vWSaGubY3BS8+XKxC4y7pDKnmjVsCAsc1bU+a3tXIOZGHbpz7VZFJr+
         17xgL9iLEfWV1hU2FSsxyHWmfsMQ+abxN6vmH9ufh6sIkOiLmfZMaOx1vbLDq+Oye9k1
         mytg==
X-Gm-Message-State: AOAM533Cn5D81K6oChEOl9HgCVx1NiscWdetNHtxIS965ut1h27qu+EI
        oIHRRHgBzww/k1j/vUTOoKi5EQ==
X-Google-Smtp-Source: ABdhPJzItXRfhNbsVaGbhWFsucdV/K81Di3YGSNeb2CVAdiYAqttvwZdkx5l6oHApiM9AXYrtCgVug==
X-Received: by 2002:a37:68ca:: with SMTP id d193mr19318692qkc.148.1590286440708;
        Sat, 23 May 2020 19:14:00 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id t189sm1625501qkc.87.2020.05.23.19.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2020 19:14:00 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org (open list:GENERIC PHY FRAMEWORK),
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 0/3] phy: qcom-qmp: add V4 USB PHYs
Date:   Sat, 23 May 2020 22:14:12 -0400
Message-Id: <20200524021416.17049-1-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for sm8150 secondary USB PHY and both sm8250 USB PHYs.

Jonathan Marek (3):
  phy: qcom-qmp: Allow different values for second lane
  phy: qcom-qmp: Add QMP V4 USB3 UNIPHY
  phy: qcom-qmp: Add QMP V4 USB3 PHY support for sm8250

 drivers/phy/qualcomm/phy-qcom-qmp.c | 408 +++++++++++++++++++++++++++-
 drivers/phy/qualcomm/phy-qcom-qmp.h |   7 +
 2 files changed, 403 insertions(+), 12 deletions(-)

-- 
2.26.1

