Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E38E8C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 05:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0BC6206DB
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 05:30:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XqvYk7Ep"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgC0FaI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 01:30:08 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39983 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbgC0FaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 01:30:08 -0400
Received: by mail-pl1-f195.google.com with SMTP id h11so3036769plk.7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 22:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Lm1u47S5JidKhkVx8IGA84wVeHQdBB/rw6jHTncgb7g=;
        b=XqvYk7Epaq1pQelWWkRRLUw7ghr3v/gqHkUyKn19in2OkkChCI6RdHwLRfhQoMMz2z
         b2zS0lZJ9oasZj6eSowszO8uJVYND+T87nHAfm7GKdqiIp/uWH49PJERyoGhfFZXJxYH
         AhItwM/fth1TwRqH0G2fQoh4bFntDWX4tWY7Ij6aXpQu6Q9DVNrnVTMvlZH+udrsSN7Z
         6odx8c1SxO6PAQGIVBO+uBl93GJXGSnVHMR5lcja8DmGwupgu2PSMi+hXjfkNvJgRXo8
         ctJSh6vDrHfR+fxJuEghBEYWAlbqpi1ZRhSlWa+hs6midxmScRy+WecEJgQ0/DsPCukr
         oUuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Lm1u47S5JidKhkVx8IGA84wVeHQdBB/rw6jHTncgb7g=;
        b=dP85GMyx0of+GR9VNTWFn2TpzuEUDFANru0O55o4o+I2DZL4TlkJNe62sil4z3p+Sk
         8Xu1zZvbnEs9Aolk5yQaINM47RRYebU7APRQjzoy+vUlLj1mArppwx+gKxozcnnVjYk0
         QGjlsDVStC6Vl6PzVHPlb+9uYdWxk1su7k8zWliGPCJOb5U//v+anZWt8GBB3oPr4QeW
         xba6wdnItEy0skhnzOq1QHFywlaW/Rd7c1w8vzaPA6LInYaFtV+WN8On62ca/XQHd8Hx
         ScPEfE9M2C6ZdhGK33jRlsHGe80oOHAU8wCzVNKoLKwdoVo5zw6gLg9L2kulDBOkU4pq
         btew==
X-Gm-Message-State: ANhLgQ0tLFxCT7KQvqeLqt0nFZE7UShMMCXGpU6keR1s9J6m2zG0InLi
        WQergiLLZ2hHkg9t+v6PS6v6GFnpHcU=
X-Google-Smtp-Source: ADFU+vtWkGzz91/Ck9l0BTTs9lOA8IG21kYm30dzrPfG0zvuls8V79S0oH29+cY87jCoAyEUGOFUbA==
X-Received: by 2002:a17:90a:cb87:: with SMTP id a7mr3925645pju.114.1585287007100;
        Thu, 26 Mar 2020 22:30:07 -0700 (PDT)
Received: from localhost.localdomain ([117.210.211.37])
        by smtp.gmail.com with ESMTPSA id l5sm3003637pgt.10.2020.03.26.22.30.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 26 Mar 2020 22:30:06 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     jens.wiklander@linaro.org
Cc:     tee-dev@lists.linaro.org, linux-kernel@vger.kernel.org,
        jerome@forissier.org, stuart.yoder@arm.com,
        daniel.thompson@linaro.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v6 0/2] Enhance TEE kernel client interface
Date:   Fri, 27 Mar 2020 10:59:46 +0530
Message-Id: <1585286988-10671-1-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Earlier this patch-set was part of TEE Trusted keys patch-set [1]. But
since these are completely independent enhancements for TEE kernel
client interface which can be merged separately while TEE Trusted keys
discussions are ongoing.

Patch #1 enables support for registered kernel shared memory with TEE.

Patch #2 enables support for private kernel login method required for
cases like trusted keys where we don't wan't user-space to directly
access TEE service.

[1] https://lkml.org/lkml/2019/10/31/430

Changes in v6:
- Reserve only half of GP implementation defined range for kernel space.

Changes in v5:
- Misc. renaming of variables.

Sumit Garg (2):
  tee: enable support to register kernel memory
  tee: add private login method for kernel clients

 drivers/tee/tee_core.c   |  7 +++++++
 drivers/tee/tee_shm.c    | 28 +++++++++++++++++++++++++---
 include/linux/tee_drv.h  |  1 +
 include/uapi/linux/tee.h |  9 +++++++++
 4 files changed, 42 insertions(+), 3 deletions(-)

-- 
2.7.4

