Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F2A9C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AB002063A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:28:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nD24KhF8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbgHQI2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 04:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728172AbgHQI1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 04:27:46 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB55C06138A
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 01:27:45 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f1so14076138wro.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 01:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=/MeQgobB67Kfom3s+YkCdvLeiREa8hjlhCt5MNPwpVY=;
        b=nD24KhF8r6AcrSKMIX6irVZl79yTcBlQd36rEnuhaZo8d/9DFl3/aWhsHqODTW4dWE
         6bgjKA+PPn5QUM0eCBPRQsPM/gQbhn2G4vworT+IQsHnZt8JcW5ITsjGcs0Q0Cvt9kJf
         JM7CHEZvaRVRrjhLXofuMnBMXAh4oFIgfQ7tHdIl5VNtE9ose8Ul7M52HH03GPs1agwo
         RoePHIwq+FOy5078Qlj0rHuGiCxu7Mlz3mx0xqhgi8eG+kfXDUigxkMJvGWK17Vd9Gs8
         IqISumd0XG8U/L5gHxzmIEealTXEGjAzqIqMvhXS7hpPV33Wvl5zSjp+74t+N+UpZftC
         P1wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/MeQgobB67Kfom3s+YkCdvLeiREa8hjlhCt5MNPwpVY=;
        b=IQY5w1Vd+aB0Phv6NyV0J2dfO/C6uJBiJ1Ri3zNODu8RzKbanoFp9WWEtjuUnprKwd
         xO0FQNRYjbrZyKCKzh80VQ3WSShVhn7I9PnVge1Ww2dL9bRP1oosjKc3LM/OQIcRVdZu
         UNQT3DraLNDQhZcuSLXvD+EtSRwbztTATeXdi0tXwj1+RhO3V7c5dCKp2/O36I7BW91N
         9kzHGrw7ZMiEoKKvlpRNJNs4+bnvQfwx4Y7NUfTRHPAFvCN67sHgUt8Nwrj8FNfSbg4d
         gJgLyUDPo3tSgFaS1G48B4fXzk3BoNO6rdIoCy9SxdSYfCN+hT3tCTF6v6/Fk9XENnLT
         kmIg==
X-Gm-Message-State: AOAM530jX/eCc38UnskjpmLMHCjqxlSUXSqXGPsF3IIco3GCdavN6UFK
        05+JpcGixmpY0gyMFkZ94WMcGw==
X-Google-Smtp-Source: ABdhPJxRASNZ/4Ci1xX88rgpdzZo6Ubi7BbRnlcmzgqWzruYtPmJ7w373dxouwOPYL109NNb6CuO7A==
X-Received: by 2002:adf:ca06:: with SMTP id o6mr13656275wrh.181.1597652864488;
        Mon, 17 Aug 2020 01:27:44 -0700 (PDT)
Received: from localhost.localdomain ([195.24.90.54])
        by smtp.gmail.com with ESMTPSA id h5sm33270888wrc.97.2020.08.17.01.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 01:27:43 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Cc:     Elliot Berman <eberman@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v2 0/2] Venus - fix firmware load failure
Date:   Mon, 17 Aug 2020 11:27:21 +0300
Message-Id: <20200817082723.17458-1-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Changes since v1:
 * Move the new scm call above assign mem - Elliot Berman

v1 can be found at [1].

regards,
Stan

[1] https://lkml.org/lkml/2020/7/9/472

Stanimir Varbanov (2):
  firmware: qcom_scm: Add memory protect virtual address ranges
  venus: firmware: Set virtual address ranges

 drivers/firmware/qcom_scm.c                  | 24 ++++++++++++++++++++
 drivers/firmware/qcom_scm.h                  |  1 +
 drivers/media/platform/qcom/venus/core.c     |  4 ++++
 drivers/media/platform/qcom/venus/core.h     |  4 ++++
 drivers/media/platform/qcom/venus/firmware.c | 18 ++++++++++++++-
 include/linux/qcom_scm.h                     |  8 ++++++-
 6 files changed, 57 insertions(+), 2 deletions(-)

-- 
2.17.1

