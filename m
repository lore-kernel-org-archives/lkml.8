Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0106C2D0F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 21:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AA8F2075E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 21:20:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PkrnR+vd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730226AbgDHVUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 17:20:47 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42554 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729540AbgDHVUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 17:20:47 -0400
Received: by mail-lj1-f196.google.com with SMTP id q19so9217530ljp.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 14:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=IqdweVCdvzc2vntA+ndnGJVnpkFTuGWifCd5YOr8biA=;
        b=PkrnR+vdqIX+9aACYJV8/jL2dNKAIMaKYGCnc1b2L2DoWzZIHQV9NYHj0Bgtp8qfpo
         b2HmpqSLCi/Prg3tKr83mxSlfWNkBR2vnPo4q4fdRu+GZmjilSEliom1bYszmaRTo4BF
         fRt5OrPRC8a/yE5EFm4+4c5u5MQZvg1OmZaWvMlKvfkJBpzVwYM5A2+VBBLbCn+G16L2
         miFUh3CYPeoYy2bqtiwm6KPlCjM130NzcuXud+tXonqaFYSzQni7FpVsg0RWISjDwAm/
         8KTmW+zkp+rPI5kXYErBDDUvCaIKnGxVlWriQCduEXgYkoZ/+L2g2RXATuvm/L0TIfB6
         NdFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IqdweVCdvzc2vntA+ndnGJVnpkFTuGWifCd5YOr8biA=;
        b=ELgJOYN6kX7CpHrlxuwFHt6eAN/SXKwmkchAdU0o2bDKudvCTsj1auIsCP1rgYs64r
         Ta4ZfxCFdNEOjRFQbzANgQ2wQAKfU2rDOb2l68LQqayHZ+Y7P9hN9pVtQvZ69AcD0FDr
         a27bxw7z+UAAeApHv1VJ12J5zSTO3DGD1Sp+bpfFL6Mn7BEwlY3scgtxnSMt6Nuwv3wA
         qGUamyMBbg2HAuFCSM5PtKI2oGXWMViReP2altGfaiec4bKCPdIAMeNpLSsPHTBr8Wnp
         0cYj/2ocEvPLVddglyBkM7F+8GMM9mVoqSRkpX++YAQmp/tORSEXLnJM3z5od6WKB+yq
         y5Jg==
X-Gm-Message-State: AGi0PuahWk38wXLzWcf4Z2E7qvoILCxxF2pHqTgRSO9tlY11ad2zZdjd
        Fz2ncv1aCwN84tjQXddqLMfzHQ==
X-Google-Smtp-Source: APiQypKUbaDGiJcTI5Uq1jzGm7dv4uDiizeN2luTguhgODlsIZf4INtYuRrXnGF2OsXN/KWtnLA5aQ==
X-Received: by 2002:a2e:6e15:: with SMTP id j21mr6187491ljc.42.1586380845262;
        Wed, 08 Apr 2020 14:20:45 -0700 (PDT)
Received: from localhost.localdomain (212-5-158-138.ip.btc-net.bg. [212.5.158.138])
        by smtp.gmail.com with ESMTPSA id b28sm17395301ljp.90.2020.04.08.14.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 14:20:44 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Vikash Garodia <vgarodia@codeaurora.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH 0/2] Venus dynamic debug
Date:   Thu,  9 Apr 2020 00:20:22 +0300
Message-Id: <20200408212024.23377-1-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Here are two patches which are modifying the debug
infrastructure in the Venus driver to make it more
flexible and usable during debug specific issues.

Please comment.

Stanimir Varbanov (2):
  venus: Add debugfs interface to set firmware log level
  venus: make debug infrastructure more flexible

 drivers/media/platform/qcom/venus/Makefile    |  2 +-
 drivers/media/platform/qcom/venus/core.c      |  5 ++
 drivers/media/platform/qcom/venus/core.h      |  7 +++
 drivers/media/platform/qcom/venus/dbgfs.c     | 27 ++++++++
 drivers/media/platform/qcom/venus/dbgfs.h     | 12 ++++
 drivers/media/platform/qcom/venus/helpers.c   |  2 +-
 drivers/media/platform/qcom/venus/hfi_msgs.c  | 24 ++++---
 drivers/media/platform/qcom/venus/hfi_venus.c | 27 ++++++--
 .../media/platform/qcom/venus/pm_helpers.c    |  3 +-
 drivers/media/platform/qcom/venus/vdec.c      | 63 +++++++++++++++++--
 drivers/media/platform/qcom/venus/venc.c      |  4 ++
 11 files changed, 147 insertions(+), 29 deletions(-)
 create mode 100644 drivers/media/platform/qcom/venus/dbgfs.c
 create mode 100644 drivers/media/platform/qcom/venus/dbgfs.h

-- 
2.17.1

