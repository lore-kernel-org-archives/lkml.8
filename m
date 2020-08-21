Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD400C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 10:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F571207DE
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 10:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xD3tym7x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbgHUKFk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 06:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728101AbgHUKFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 06:05:36 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5D2C061385
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 03:05:36 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id i10so1236670ljn.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 03:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=P6Z4l7H1CmoTdLGQ/Idn5B/IuXADWeekwCsfbIiIVOI=;
        b=xD3tym7xDndje6Ux91b2Q5rDHkGlKl9oeHs8t42VpI4222lDLOp1j/qycuipy04Mn9
         FI+A8wYkiRCU2HJ1LHnMsxAuxWAQHOd1x+lgQO+CazWv9m0Pm8K4RWTpRaCGvaXGjNFs
         ivDaSZwgf3gWtPceoPeRgSUWFOhWP7gPFYJ03H4MOjpD6wowa8hFF0EljI52Mjst1Of0
         bXwfAG03tBHa2HTzwvvOV+qx+8QMZSphNGjQU0IZ1kZeNJ2bd4L0FCGP8bxP2eAaXL2o
         vV+3PDMabyoQe0hdQYTrOg47CShBQwgdtu24XbhxZhS8aWWTQTW6FW3KKPRzTQvy6SDf
         4myg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=P6Z4l7H1CmoTdLGQ/Idn5B/IuXADWeekwCsfbIiIVOI=;
        b=jcOYNLkvrDEkz160TzqQ23y3Pz/qWo3ALoZlSVYTD2MVtxSrFIJOlRHkX6VdoD+0QP
         A6DGISt+JH2x2vjYUzcHDwGUhCmwuDl2dH393kACyGJtreIQnk7yC6oP7G6pTdweger8
         36EvoXKNU0eiqhFKBVFkwajyMDdtXsKgO33q4fT5iJlM//N6pqODxKMVLpXmpv3tBywv
         NMbR4N0rGMElPBV0fY8r4OiDzBxXxsDRrbJaI8j8uDqjrimG68auj3iFsKRlt+1SpfEO
         Wj8PYjaR1JxHnULGjUnMjBKHPbB8xYMHMBfnrE8waJrmtZ5nN16YnFVVhCbotK93Hr4o
         56yQ==
X-Gm-Message-State: AOAM532I5ARCG4MK9TkKmuZfuHSRpvImRCYvyq2W8qUV7y4khuhPCM9w
        DBXZEcwptIGlr8oRfSSzAeggHQ==
X-Google-Smtp-Source: ABdhPJyGtkbq70ZIBc+Lki361KuTbZPSFCFP7Ijv5CXOHP/XowRq0ML6nvqGIXPqz+sKWxCNRHOhxQ==
X-Received: by 2002:a2e:a550:: with SMTP id e16mr1134962ljn.14.1598004334809;
        Fri, 21 Aug 2020 03:05:34 -0700 (PDT)
Received: from jade (h-249-223.A175.priv.bahnhof.se. [98.128.249.223])
        by smtp.gmail.com with ESMTPSA id b15sm283340lji.140.2020.08.21.03.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 03:05:34 -0700 (PDT)
Date:   Fri, 21 Aug 2020 12:05:32 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
List-Id: <soc.lore.kernel.org>
To:     arm@kernel.org, soc@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        op-tee@lists.trustedfirmware.org,
        Jorge Ramirez-Ortiz <jorge@foundries.io>
Subject: [GIT PULL] optee i2c for v5.10
Message-ID: <20200821100532.GA1868056@jade>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello arm-soc maintainers,

Please pull this patch enabling i2c access from secure world via a
trampoline in the OP-TEE driver.

Thanks,
Jens

The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

  git://git.linaro.org/people/jens.wiklander/linux-tee.git tags/optee-i2c-for-v5.10

for you to fetch changes up to c05210ab975771e161427eb47696b869d820bdaf:

  drivers: optee: allow op-tee to access devices on the i2c bus (2020-08-21 11:41:45 +0200)

----------------------------------------------------------------
Enable i2c device access from OP-TEE RPC

Extends the OP-TEE RPC protocol to enable I2C device access. This allows
a driver in secure world to access devices on a normal world I2C bus.

----------------------------------------------------------------
Jorge Ramirez-Ortiz (1):
      drivers: optee: allow op-tee to access devices on the i2c bus

 drivers/tee/optee/optee_msg.h     | 21 +++++++++
 drivers/tee/optee/optee_private.h |  1 +
 drivers/tee/optee/rpc.c           | 95 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 117 insertions(+)
