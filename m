Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB428C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 11:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91FF520748
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 11:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgGJLAv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 07:00:51 -0400
Received: from mga04.intel.com ([192.55.52.120]:55165 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726725AbgGJLAe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 07:00:34 -0400
IronPort-SDR: iZz5AYw7Mbko+H6Rdi66VCxgO9exC5S19rlIVUuY/vaiKdhoH0IwmyxzYukeFwc3APbJgQJ/q8
 WR5hjqLtKbgw==
X-IronPort-AV: E=McAfee;i="6000,8403,9677"; a="145675899"
X-IronPort-AV: E=Sophos;i="5.75,335,1589266800"; 
   d="scan'208";a="145675899"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2020 04:00:29 -0700
IronPort-SDR: XdkAEivM2YYp9oVAy6dGqlOEK5E1+rC0Ng/rd1ENK4qYSpK7yB4Y88FvAlybwiZbFkDuwfwbHK
 bOXQa1B9czIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,335,1589266800"; 
   d="scan'208";a="280613516"
Received: from taverna-mobl.ger.corp.intel.com (HELO localhost) ([10.252.53.137])
  by orsmga003.jf.intel.com with ESMTP; 10 Jul 2020 04:00:25 -0700
Date:   Fri, 10 Jul 2020 14:00:24 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>
List-Id: <soc.lore.kernel.org>
Cc:     arm@kernel.org, soc@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        tee-dev@lists.linaro.org, op-tee@lists.trustedfirmware.org,
        Maxim Uvarov <maxim.uvarov@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>
Subject: Re: [GIT PULL] optee bus for v5.9
Message-ID: <20200710110024.GB2614@linux.intel.com>
References: <20200710085230.GA1312913@jade>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710085230.GA1312913@jade>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 10:52:30AM +0200, Jens Wiklander wrote:
> Hello arm-soc maintainers,
> 
> Please pull these patches enabling multi-stage OP-TEE bus enumeration
> and also adds a TPM driver for a OP-TEE based fTPM Trusted Application.
> 
> The TPM driver depends on and takes advantage of the multi-stage OP-TEE bus
> enumeration by indicating that it should be probed after tee-supplicant has
> been started.
> 
> Jarkko, one of the TPM maintainers, has been involved in reviewing these
> patches and agrees that I can include the TPM patch in the pull request.
> 
> Thanks,
> Jens
> 
> The following changes since commit 3d77e6a8804abcc0504c904bd6e5cdf3a5cf8162:
> 
>   Linux 5.7 (2020-05-31 16:49:15 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.linaro.org/people/jens.wiklander/linux-tee.git tags/optee-bus-for-v5.9
> 
> for you to fetch changes up to 9f1944c23c8cb1c033b73de80cf6c612a2a80a2b:
> 
>   tpm_ftpm_tee: register driver on TEE bus (2020-07-10 09:41:58 +0200)
> 
> ----------------------------------------------------------------
> Enable multi-stage OP-TEE bus enumeration
> 
> Probes drivers on the OP-TEE bus in two steps. First for drivers which
> do not depend on tee-supplicant. After tee-supplicant has been started
> probe the devices which do depend on tee-supplicant.
> 
> Also introduces driver which uses an OP-TEE based fTPM Trusted
> Application depends on tee-supplicant NV RAM implementation based on
> RPMB secure storage.
> 
> ----------------------------------------------------------------
> Maxim Uvarov (3):
>       optee: use uuid for sysfs driver entry
>       optee: enable support for multi-stage bus enumeration
>       tpm_ftpm_tee: register driver on TEE bus
> 
>  Documentation/ABI/testing/sysfs-bus-optee-devices |  8 +++
>  MAINTAINERS                                       |  1 +
>  drivers/char/tpm/tpm_ftpm_tee.c                   | 70 +++++++++++++++++++----
>  drivers/tee/optee/core.c                          | 27 ++++++++-
>  drivers/tee/optee/device.c                        | 38 ++++++------
>  drivers/tee/optee/optee_private.h                 | 10 +++-
>  6 files changed, 119 insertions(+), 35 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-optee-devices

Thank you! Looks legit to me.

/Jarkko
