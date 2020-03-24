Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33389C41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 05:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0936D20724
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 05:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OVJfwC4b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbgCXF3K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 01:29:10 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34785 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbgCXF3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 01:29:10 -0400
Received: by mail-pl1-f196.google.com with SMTP id a23so6957401plm.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 22:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ra3lKpyRwpXEMv7HLjwjk2xlSk4Do59iXflfneeNh40=;
        b=OVJfwC4b1PEr/2jykKzhhdZvbXbHUcn76l1jFofytmydV+hZD1SG74gGKktPsDAqSN
         zFKJ9gjIseLoywqXUMffqa6z41YelbniVwpLO4cn8k0/mGxSfs7+o5oFd6hvmdDBA392
         TgFhjkqejJ48IaOASEmZVcLA3uow/kBIBJQFR1sTibJHVU9HxbwaajHYFBRxYfkt7Lfc
         nhCBas2c5k3T//9GSC0RH3Dr+dlmRIu9zN8KVHOIwDLqy2qQQJMantm2Ab9ZGL/wN+9z
         m5wDS3bK9tYy8DXYGGxibpI3a8L9q46iPYyA83+bBvhoIk76AogOmzXTIYGzB8UYj+2N
         q1iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ra3lKpyRwpXEMv7HLjwjk2xlSk4Do59iXflfneeNh40=;
        b=FRz4VezFgsR4oU080/Mwart5Fcp+9TwutW9TL2qJw4Smy/M155HzAuEW6BrQq4D+EE
         rNvYQVeGwjuYxMK0DZkkjrPCUs0OZLU8c8+4c1fxD/tj1pnayq9zmsx9fcB2i+GkZCPR
         Iu/07tsR8uE/V9V9bJ9p0feC0w/9Naty/isM1mHOKQM2F8c4YSCpUR7FqLE2ITrCyKq3
         cGjYR55KmRsS0llK9p7eaQfXXx6UtECE2lhwLHBg4SBL8JdtPv6Cca2pYKt+sexKiGt7
         ZPmx2b4sD/b+0Ix41ToB9bCmO+NfqXC3rmbeM4ZVQdJSAq4sFyUp6/KNCS+mwy/P2nax
         kz4Q==
X-Gm-Message-State: ANhLgQ1pdc9ij1rFcuA+JroFBlag+137IsF3BJtfYW5KwFkgBwj2K2zl
        UPu7OlrbQgLt1s+j0hjSGSKRJA==
X-Google-Smtp-Source: ADFU+vtODNbfRHAyBz68wwxhAstaZapwyPZvFzxoO8Q8NW3QROIugYa6Kgu2ZXMASrFt7wQDdwTfxA==
X-Received: by 2002:a17:90a:bd01:: with SMTP id y1mr3362201pjr.129.1585027748925;
        Mon, 23 Mar 2020 22:29:08 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id j14sm2795413pgk.74.2020.03.23.22.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 22:29:08 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/4] remoteproc: Panic handling
Date:   Mon, 23 Mar 2020 22:29:00 -0700
Message-Id: <20200324052904.738594-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for invoking a panic handler in remoteproc drivers, to allow them
to invoke e.g. cache flushing on the remote processors in response to a kernel
panic - to aid in post mortem debugging of system issues.

Bjorn Andersson (4):
  remoteproc: Traverse rproc_list under RCU read lock
  remoteproc: Introduce "panic" callback in ops
  remoteproc: qcom: q6v5: Add common panic handler
  remoteproc: qcom: Introduce panic handler for PAS and ADSP

 drivers/remoteproc/qcom_q6v5.c       | 20 ++++++++++
 drivers/remoteproc/qcom_q6v5.h       |  1 +
 drivers/remoteproc/qcom_q6v5_adsp.c  |  8 ++++
 drivers/remoteproc/qcom_q6v5_pas.c   |  8 ++++
 drivers/remoteproc/remoteproc_core.c | 57 +++++++++++++++++++++++++---
 include/linux/remoteproc.h           |  3 ++
 6 files changed, 92 insertions(+), 5 deletions(-)

-- 
2.24.0

