Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 755E6C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 13:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53777207E8
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 13:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ulPrDM6Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730499AbgFRNxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 09:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730502AbgFRNw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 09:52:56 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75267C0613ED
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 06:52:56 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id q19so7357016lji.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 06:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qj3LT34tWN51iOOJ4mJdNrdJmQibtyKe/xjeI2mJQFQ=;
        b=ulPrDM6YGm23/CCKuij/YFME1OgWjz12T6he4JmOYnNTklxP5k0EmK7cZUyaC8YxAq
         6TdEyDL8Zl9bypcF0DRwnjAHwopEollw/H01rMgntDUrVjSJx/qn3QNhKz3G21klYbc/
         eXbBH48QAoP4DCvhacxL2wrSU1HLQxd8auFqTIiYBTackiw9ZW7XsvbIS1kGLFpFqRAN
         6MpjGkyG3MwxuWuURobYFu6lYztOye341rdgyq4i9GcxQEdv8Rf+OxrYDP+ZIIDPIlz0
         w1l/c2bSUQ0kH46r7qElgSjh89MhYQhQlF0y1MR6SCQeOe8YmIfHeerIb4dNTROeVIeY
         EMjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qj3LT34tWN51iOOJ4mJdNrdJmQibtyKe/xjeI2mJQFQ=;
        b=sX66HEwMk/wwGgk1ItaWSJ6fg+MUuL9gMz2s8hjidTL4I6YG3IHTpc3FrLRD/zM59V
         SVuxioOPbGg8+5vsz2w1Oeh3OMQ6isJDHrBFQSpsGXnk6odeSQJ1qipAnslAyVxTC/fn
         KcwdHYP42ej1+R3ZHEOQ/WnpT5TO6XFwmyqq8Zp8G5tOvdOsEaMg4AYKNgzMUjyrLkr5
         hdjDyos0Q/j7jPXBzIk1kg/ZiP6o0tFDa1cnh77tejuxaSJZQGO0JAn0US4JuTa7tA1+
         0biGx0m0g4fPd8loKsdkeFMt110f3DNJRqBDsRl7kdsAH2qGLsAJlUGQxD09NoF9L8v3
         qvIg==
X-Gm-Message-State: AOAM530382aAzV6USTozTNcS7VyVQ3cCPdSsJixhjEH2x+NjddflegKf
        pbBv/aSz0n3XgxMMqlDpiUsqvwK795E=
X-Google-Smtp-Source: ABdhPJwaMJiel+UnL81pH7RKKu0ZzlHkyaNhB0u/XhfY7cznaMGmnZfRuXmOYmLSbjrorIzuICtysQ==
X-Received: by 2002:a2e:b0c3:: with SMTP id g3mr2326087ljl.31.1592488374584;
        Thu, 18 Jun 2020 06:52:54 -0700 (PDT)
Received: from maximlap.d-systems.local ([185.75.190.112])
        by smtp.gmail.com with ESMTPSA id f2sm768324lfc.11.2020.06.18.06.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 06:52:54 -0700 (PDT)
From:   Maxim Uvarov <maxim.uvarov@linaro.org>
To:     linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org
Cc:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        gregkh@linuxfoundation.org, jens.wiklander@linaro.org,
        linux-integrity@vger.kernel.org, arnd@linaro.org,
        sumit.garg@linaro.org, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATCHv9 0/3] optee: register drivers on optee bus
Date:   Thu, 18 Jun 2020 16:52:48 +0300
Message-Id: <20200618135251.5761-1-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v9: - new mailing list in Docs, update kernel version (Jens Wiklander)
    - use Big Endian format to print UUID (Sumit Garg)
v8: - fix v7 check.
v7: - check return value of dev_set_name() (Jarkko Sakkinen)
v6: - description, comments, patches reorder and destroy workqueue (Sumit Garg)
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
  optee: use uuid for sysfs driver entry
  optee: enable support for multi-stage bus enumeration
  tpm_ftpm_tee: register driver on TEE bus
Maxim Uvarov (3):
  optee: use uuid for sysfs driver entry
  optee: enable support for multi-stage bus enumeration
  tpm_ftpm_tee: register driver on TEE bus

 .../ABI/testing/sysfs-bus-optee-devices       |  8 +++
 MAINTAINERS                                   |  1 +
 drivers/char/tpm/tpm_ftpm_tee.c               | 70 ++++++++++++++++---
 drivers/tee/optee/core.c                      | 27 ++++++-
 drivers/tee/optee/device.c                    | 38 +++++-----
 drivers/tee/optee/optee_private.h             | 10 ++-
 6 files changed, 119 insertions(+), 35 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-optee-devices

-- 
2.17.1

