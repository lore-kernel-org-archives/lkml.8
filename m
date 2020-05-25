Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F0EC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 11:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D19ED2078B
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 11:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AAegB7qh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390293AbgEYLwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 07:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390160AbgEYLwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 07:52:43 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE8AC05BD43
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 04:52:42 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id a25so8801564ljp.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 04:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=EAb/Fg0BKQ2SLEZWHdKOtDRqYys+prhP5YSWE2/wW08=;
        b=AAegB7qhped/HXBu/QvGmSMBrl5wssFyVxV1rgNEF2QpoXDYbIeJvgMD1VCmAFHYJl
         7Hd3/KdogUfWnQ5ttYGOqnMJV593Y8NX/KEAARakLw8f2YNk6rO8B/qNUCNQuprKoozm
         MSgKFtKH2DZ/iHAhhagSyB6So0yVUbUVpvXU/YzdYkAeYvatzmUpOXcomta996F07AAP
         rNAUuVuwQ7Bs5zmhbMagUhIfcgacL1P9sZIB5x5J8g1tUizryJWIr73h0M8PWaxl8h5b
         xL5nb9CuxNYt3UyP9EnNdiN7Ot/vfdRSCcx9VeImHtdHEoIRodQxigKMeaUQWHVDXdwf
         9aEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EAb/Fg0BKQ2SLEZWHdKOtDRqYys+prhP5YSWE2/wW08=;
        b=ZLacIMPTXQk8D5EXdFcoWGXDba+SsZoPnLRSsUINBTMMWFQtjfTjkHfA7ZjNUzDaEw
         KeOajl1wW7q74t6ho/MHuDDhehYK2XkvXO+4+VaZJpsM5mg9at3ecRBQlHNRcsewQvdq
         0gRXX6FYAKRmDqR4K5cNPjiqS0+bDnnrtZtTWelJ4GfXSYCOFy+Pc+tOWyrB98bVVx/B
         Pg/iUZ1b4h0H4Q0b07T/8Ul0RkVhztY7w/ZldINByN8PW0VFoULBGq+p8CqhSwWlCvaN
         npE3DVfIlWKdhkgdJEcVpjuy9QDwLWy4X1neOrKmMBBuMby+T500/v0Qbe7yuFGAmbmv
         /k3A==
X-Gm-Message-State: AOAM533CtPxIfg+0GV96CofZtS2JxwVZ23k/UoOPFnQ3mlGoU5EuG2vd
        UKFq4+vRKsZCwIYC57/Oa4ewtiGcwXM=
X-Google-Smtp-Source: ABdhPJz4vVBkBbYK5Hebd468+iOG/jumV1UF36/XyP3voWsKxi+q/Nq4Z0xE1HYniZslqjXW8lxJXA==
X-Received: by 2002:a2e:97c2:: with SMTP id m2mr11214486ljj.404.1590407561004;
        Mon, 25 May 2020 04:52:41 -0700 (PDT)
Received: from localhost.localdomain ([176.59.41.83])
        by smtp.gmail.com with ESMTPSA id y130sm4847756lfc.22.2020.05.25.04.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 04:52:40 -0700 (PDT)
From:   Maxim Uvarov <maxim.uvarov@linaro.org>
To:     linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org
Cc:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        gregkh@linuxfoundation.org, jens.wiklander@linaro.org,
        linux-integrity@vger.kernel.org, arnd@linaro.org,
        sumit.garg@linaro.org, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATCHv3 0/3] optee: register drivers on optee bus
Date:   Mon, 25 May 2020 14:52:32 +0300
Message-Id: <20200525115235.5405-1-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3: - support tee-suppicant restart (Jens Wiklander)
    - description and comments ( Jarkko Sakkinen)
    - do not name optee drivers by index in sysfs (Sumit Garg)
v2: - write TEE with capital letters.
    - declare __optee_enumerate_device() as static.

Hello,

This patchset fixes issues with probing() tee, optee and optee driver
if they were compiled into kernel, built as modules or any mixed
combination.
These changes require optee-os changes which already were merged.
Main corresponding commits are:
https://github.com/OP-TEE/optee_os/commit/9389d8030ef198c9d7b8ab7ea8e877e0ace3369d
https://github.com/OP-TEE/optee_os/commit/bc5921cdab538c8ae48422f5ffd600f1cbdd95b2

optee_enumerate_devices() which discovers Trusted Applications on tee
bus is split up on 2 changes. Do probe of drivers which do not require
userspace support of tee-supplicant and stage two to run drivers with
support of tee-supplicant only after tee supplicant run. 

Best regards,
Maxim.
Maxim Uvarov (3):
  optee: do drivers initialization before and after tee-supplicant run
  optee: use uuid for sysfs driver entry
  tpm_ftpm_tee: register driver on TEE bus

 drivers/char/tpm/tpm_ftpm_tee.c   | 70 ++++++++++++++++++++++++++-----
 drivers/tee/optee/core.c          | 28 +++++++++++--
 drivers/tee/optee/device.c        | 23 ++++++----
 drivers/tee/optee/optee_private.h | 10 ++++-
 4 files changed, 108 insertions(+), 23 deletions(-)

-- 
2.17.1

