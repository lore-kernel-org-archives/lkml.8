Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F2BC2BA15
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 17:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 081E0207FF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 17:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hnyAoV/8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404185AbgDCRuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 13:50:13 -0400
Received: from mail-qv1-f67.google.com ([209.85.219.67]:46557 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403912AbgDCRuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 13:50:12 -0400
Received: by mail-qv1-f67.google.com with SMTP id bu9so3994617qvb.13
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 10:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6RqKi5kQS7abbcK/m1MeYgXWyu5S1dWWUHnw0at9jU4=;
        b=hnyAoV/88z+dlStydxHrx8vJJda32g/f6iLhSfqsoXgbvHFR0fKod2GO+mjA7AMilm
         K8sayx6yZNn4mNTqNmSHR6Z4zshubd5vm+PpE9d/xCiHeAfvwbc2fWlWkKpxe/3Qna/w
         o95oqnQsktIYx+OQHocxLgJwacDbZI75GdSX8UzoQznNWqoS7/+i3TbeF3BqpecqkDg3
         xtCX75JbLMROPmKKjR8HzUg1PbHYFI7fRb505sSqP05/wdQFrGvwapN82De8OjTed/+Z
         D10mknQQn1jwnOlj7ZGc49ajapHlBqsVMl8vy803lptaH1CA58uvrEqpgY4gP9sWZecb
         gpgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6RqKi5kQS7abbcK/m1MeYgXWyu5S1dWWUHnw0at9jU4=;
        b=I7J7i4Z4wVUcZP/j87ZZTpCIYlH75KKRVw6T8+wfHD+C1XsPBxP+Gtj0E5sxFfvZxw
         ayXlhMH/+U7nk6oGaaMt0BZdlTGSINQq6I+T87ZOaE1eI9Jbpi4BvmAEGMbr+3VKTRYM
         CvsDU1xAxEgEIjjFxX/s5it51zESCFy/1jY+ehVXKBCqPXWClfUgAtSyM53aVoHlAUps
         Ipkga2+d+mfZlPk9GYPIl4hN846pK1o5xTnhvpGMnDB8GzmycoaRDL064c5AI4jPVOzH
         dutWTImUhNin7R0A1CrkwqIwrzQHPhXQWtqfrc9jYoPJOZAW1ebRIwtjOLUUOl8RHojv
         eUmA==
X-Gm-Message-State: AGi0PuaJwLMXFGTyms0++ygfHAIDKGFqf4lVOoQhLNlQY6hrttxTN20Z
        ElYIb4zyrBH1xWf5pgJcFOmocim9FIzBoA==
X-Google-Smtp-Source: APiQypKqlXQdNVDSxOjJ1Ms50Az8IIgj5YUggK9m6THUtnyNdT511yDYfxOcjAcIrniOVwzOCbpasA==
X-Received: by 2002:a05:6214:b0a:: with SMTP id u10mr9744314qvj.45.1585936211473;
        Fri, 03 Apr 2020 10:50:11 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id 77sm6821225qkh.26.2020.04.03.10.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 10:50:10 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Andy Gross <agross@kernel.org>
Cc:     linux-remoteproc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] remoteproc: bug fixes
Date:   Fri,  3 Apr 2020 12:50:02 -0500
Message-Id: <20200403175005.17130-1-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes some bugs in remoteproc error paths.  The last
patch is derived from something I posted before, but has been
updated to based on Linus' current master branch.

					-Alex

Alex Elder (3):
  remoteproc: fix a bug in rproc_alloc()
  remoteproc: qcom_q6v5_mss: fix a bug in q6v5_probe()
  remoteproc: qcom_q6v5_mss: fix q6v5_probe() error paths

 drivers/remoteproc/qcom_q6v5_mss.c   | 33 +++++++++++++++++-----------
 drivers/remoteproc/remoteproc_core.c |  4 ++--
 2 files changed, 22 insertions(+), 15 deletions(-)

-- 
2.20.1

