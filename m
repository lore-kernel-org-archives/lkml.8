Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7025C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 08:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84EBB207FC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 08:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ydtyon2y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbgGJIwf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 04:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbgGJIwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 04:52:35 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4F6C08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 01:52:34 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id 9so5550350ljv.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 01:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=SOf7VhktuFKx34ZBJi++opyzeaVIB9yGYq7CWp3mcyA=;
        b=Ydtyon2yZkRskjNRgg9ckcUMJhuBUZC9/N1BgTM9oRG5sHrjthBBFCoeMaYrSRRLl1
         mbYBa9Mam9gU02NSM67e6IEf6o6Y6j7L8w8IGEXOmy0S1VSCP72clbky59RRtAR+279e
         KM0jAvq2C2H3s4E8CMrbxa4pyK/FR81uP0GTHU6RGsatBY1LQQLs34LJYEHjqFZjmb17
         61bDBO7qWJ5XsIJFRZiH/f0nANLe6ZIJvMSf4m6EhxdbrdKrNKy/Zsi3wwy/tRAQ//DO
         WdZUP57cru6wQgwd/VC9Ihcx+oe+cFSQ7hAeICXCHFheCXRLFF4/Y3Y9rDMyQ2JoDMnX
         Vbfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=SOf7VhktuFKx34ZBJi++opyzeaVIB9yGYq7CWp3mcyA=;
        b=kJaC0mW231zHch6qKg6UCSiVd5t5D0HzJV6QZ0TmdbCWQgzk3vniAcU6uATWHkeTra
         PK21ISYdpeGof+abHvY5Hp59zf/RwWSha6Ir7SHt8YLzgORYFlYBH8Py+L5JuB+mGhJz
         fzAefyq02vcP3/6BGX1a8VLDOC1vcqILtagwzm3JZANo9hdwWWzF6b2bNI+KONoykAs3
         Pw3mE8L/q3O/sJ8QGLAboDDFEdWpNHicL6/b5p+IAmmHoaCEdQZYQS2rVgcMdgfai3ex
         749Ler5100FEvwDAaIiMQkf6n0j+AgEKwu8Li10109s9ByQ3IKyrtuL8taltLQiFy9E1
         pqlA==
X-Gm-Message-State: AOAM531ICgmMN5Vkjw1ryVbrpeVTfx6zRCNxH0NYVEwtgQ2JsVCIsp2W
        dGJqmQ1eAGx2wIeWI5vOrclUWA==
X-Google-Smtp-Source: ABdhPJzsqEaYR4D2UhGTLMEzgTZ8UByj8LNtRq/174vcISNAaOMoiTIZUE7Ht2Hh67s5i3KuNIuqng==
X-Received: by 2002:a2e:9619:: with SMTP id v25mr40788978ljh.324.1594371153084;
        Fri, 10 Jul 2020 01:52:33 -0700 (PDT)
Received: from jade (h-249-223.A175.priv.bahnhof.se. [98.128.249.223])
        by smtp.gmail.com with ESMTPSA id q13sm1919854lfb.55.2020.07.10.01.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 01:52:32 -0700 (PDT)
Date:   Fri, 10 Jul 2020 10:52:30 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
List-Id: <soc.lore.kernel.org>
To:     arm@kernel.org, soc@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        tee-dev@lists.linaro.org, op-tee@lists.trustedfirmware.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Maxim Uvarov <maxim.uvarov@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [GIT PULL] optee bus for v5.9
Message-ID: <20200710085230.GA1312913@jade>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello arm-soc maintainers,

Please pull these patches enabling multi-stage OP-TEE bus enumeration
and also adds a TPM driver for a OP-TEE based fTPM Trusted Application.

The TPM driver depends on and takes advantage of the multi-stage OP-TEE bus
enumeration by indicating that it should be probed after tee-supplicant has
been started.

Jarkko, one of the TPM maintainers, has been involved in reviewing these
patches and agrees that I can include the TPM patch in the pull request.

Thanks,
Jens

The following changes since commit 3d77e6a8804abcc0504c904bd6e5cdf3a5cf8162:

  Linux 5.7 (2020-05-31 16:49:15 -0700)

are available in the Git repository at:

  git://git.linaro.org/people/jens.wiklander/linux-tee.git tags/optee-bus-for-v5.9

for you to fetch changes up to 9f1944c23c8cb1c033b73de80cf6c612a2a80a2b:

  tpm_ftpm_tee: register driver on TEE bus (2020-07-10 09:41:58 +0200)

----------------------------------------------------------------
Enable multi-stage OP-TEE bus enumeration

Probes drivers on the OP-TEE bus in two steps. First for drivers which
do not depend on tee-supplicant. After tee-supplicant has been started
probe the devices which do depend on tee-supplicant.

Also introduces driver which uses an OP-TEE based fTPM Trusted
Application depends on tee-supplicant NV RAM implementation based on
RPMB secure storage.

----------------------------------------------------------------
Maxim Uvarov (3):
      optee: use uuid for sysfs driver entry
      optee: enable support for multi-stage bus enumeration
      tpm_ftpm_tee: register driver on TEE bus

 Documentation/ABI/testing/sysfs-bus-optee-devices |  8 +++
 MAINTAINERS                                       |  1 +
 drivers/char/tpm/tpm_ftpm_tee.c                   | 70 +++++++++++++++++++----
 drivers/tee/optee/core.c                          | 27 ++++++++-
 drivers/tee/optee/device.c                        | 38 ++++++------
 drivers/tee/optee/optee_private.h                 | 10 +++-
 6 files changed, 119 insertions(+), 35 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-optee-devices
