Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C2CDC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 08:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD4F22075A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 08:27:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ycDzMQmt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgE2I1W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 04:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbgE2I1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 04:27:21 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B721C08C5C6
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 01:27:21 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id b6so1584533ljj.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 01:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6UQE/mAll7rVLi4VPpwEHXC2IWoXCtROl3EiNZAwRO8=;
        b=ycDzMQmtIxL6lDpp2m41RyTEW9DhzxlEQ9V9CAN9TJSEoRHJbfO+a3f7d9qf+hHNS4
         Kj0KHIttMZI+Ag5l5vPWNv22AIBkAPezJI4Xs8zJWnZwuBHtoj0nxyFiwfGTwVO4Gx7Z
         KSWUi4ruriRjaOsX7/QZbGC7JttB4VHY1U3OJERz07RVI7XBdkiqCe5N8idYvMfqnd/f
         U1VdfT2SuGsi/mOL8p4NEghCog50AkMCEEOWLmUCB1KWUMYJYiHS98pQQjgM/RpENbQo
         MM3wl4DT1UN2g6OjL+JVxa+uaVYP9f/c1ta3U91avAxHQTOomHOffmDovRTcjvd+pkb0
         0PRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6UQE/mAll7rVLi4VPpwEHXC2IWoXCtROl3EiNZAwRO8=;
        b=asUVzQ6HZe5670ls+4fsE4udtEgOPyeoy1NTOBIxoywlZXBldqK6xycFxLFNrsnenj
         fQ9Iq+Cpeyb6vfqlZnFYOZVmApeAsT7DGcsOByLFqRXcpX0D/4FsG50uMegs9B+7+JMf
         WFfI0zXvGI+1WO49PeLKx3/rFNjdHPlwnDra0PA8HWcsAhxAP2d4DqX+ULFEwWu3DqNT
         x2P9Kqa9fBkZ3AgsaE4rlTUDSRdBYkVojjwNCVk+iyoZtINLvLttbSVC/PFHIE3xyvuQ
         23gBuRzjpISpEfqd+uh6iHCQWezPKJUTl4pc3DDNs0fqgqLTSsbok/Y7fp0fG5gFCJgy
         ui+g==
X-Gm-Message-State: AOAM533nVaqtklzFARhQxhZlVtt2mYuSHUxd17k/yuxdfLt/h3iYn9l1
        qp2VbueM5CzCCHPi8qlOSrOFm18tNC8=
X-Google-Smtp-Source: ABdhPJwsoCOWGqkz3zk1Bc8knROHTezUnpe/8krWFSr26/RAH/a/Nb7QCfBniy0JZx6gbS+Mn08Y9w==
X-Received: by 2002:a2e:750d:: with SMTP id q13mr185328ljc.448.1590740839237;
        Fri, 29 May 2020 01:27:19 -0700 (PDT)
Received: from localhost.localdomain ([176.59.41.83])
        by smtp.gmail.com with ESMTPSA id y20sm1878450lji.31.2020.05.29.01.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 01:27:18 -0700 (PDT)
From:   Maxim Uvarov <maxim.uvarov@linaro.org>
To:     linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org
Cc:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        gregkh@linuxfoundation.org, jens.wiklander@linaro.org,
        linux-integrity@vger.kernel.org, arnd@linaro.org,
        sumit.garg@linaro.org, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATCHv5 0/3] optee: register drivers on optee bus
Date:   Fri, 29 May 2020 11:26:58 +0300
Message-Id: <20200529082701.13457-1-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v5: - removed pr_err and fix typos in description (Jarkko Sakkinen)
    - added missed kfree in optee_open()
v4: - sysfs entry is optee-ta-uuid (Jerome Forissier, Sumit Garg)
    - added Documentation/ABI/testing/sysfs-bus-optee-devices (Greg Kroah-Hartman)
v3: - support tee-suppicant restart (Jens Wiklander)
    - description and comments (Jarkko Sakkinen)
    - do not name optee drivers by index in sysfs (Sumit Garg)
v2: - write TEE with capital letters.
    - declare __optee_enumerate_device() as static.

Maxim Uvarov (3):
  optee: do drivers initialization before and after tee-supplicant run
  optee: use uuid for sysfs driver entry
  tpm_ftpm_tee: register driver on TEE bus

 .../ABI/testing/sysfs-bus-optee-devices       |  8 +++
 MAINTAINERS                                   |  2 +
 drivers/char/tpm/tpm_ftpm_tee.c               | 70 ++++++++++++++++---
 drivers/tee/optee/core.c                      | 24 ++++++-
 drivers/tee/optee/device.c                    | 23 +++---
 drivers/tee/optee/optee_private.h             | 10 ++-
 6 files changed, 114 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-optee-devices

-- 
2.17.1

