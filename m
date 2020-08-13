Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6460C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 07:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA7D320781
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 07:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K4fsOwUe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgHMH2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 03:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgHMH2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 03:28:40 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0446C061757
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 00:28:39 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id 185so5076826ljj.7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 00:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9A2E5sqNP8Ur86nuTmyML9szkC+ZunMpV+dNMjMXjqM=;
        b=K4fsOwUeiyHReNZe1j2qRvqmR9s3AbQPwfSz9E2uEaR9cXdq6iP9TtVpwe7OdQSFXh
         9q788UtZ3oRj7Psp/WNvlwx6urVyGtmEoX9SC3Dk7SD4NtodMssn2Ktvqnzo8tk7r4qk
         WY1FOYRsmzBztznkBIbv0faFG1JvIWO6rMunIJY66N6AAUxR23IHtpDUJxagolBHsD4/
         NpB0+PPcPSogYqIIhlSCJYivFH+wwXGTz4+dTOhFgYX90+/iV1C4eo+2LlHlc8IUSpw/
         DXpbvyow8n+7dn3zBVzz/YERjBe8vbdpUYMjfrFh6W1UYvbjkQj7jXV4WXfJFBavewes
         /jNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9A2E5sqNP8Ur86nuTmyML9szkC+ZunMpV+dNMjMXjqM=;
        b=TVn72OQAYqMmo21BWihekOVnIXxJkZwqCFxOhGMfCNntexiRKu9WIlsExH+oaZ2AOA
         vp6Y71k7kMJ6EYMaVzXxRKyhOoMm76tr64sflALFQbV2Sx4AWcgsVfreyJFpmqIIfwFe
         L9PtRFDjnezzB/bQQT4yAzZgnsgadCKmcHqaqnaFHONU7xUINdJAKXbDRr2evCyfMLHV
         /rD5eYDOvNw3t6XOCu96WEU1psgFn4Y7A5N7LQmujq7Z/Xu0Nd7vo5ivZ33TKEymydSt
         O+FNr0CSUHdWNGLtGJ9ECDZAQEbW8E0wzH7tCCwCCn3hPwh6SgBZH2VkU/JSvUHczjXT
         NPOg==
X-Gm-Message-State: AOAM530bQjxfOR46zsgyEfcQDpbnk7/9Vl1/sdHfTMez3q7XIhjKoEGb
        6e5feEBAH0v15CgjIWg6Fi1h4g==
X-Google-Smtp-Source: ABdhPJwnh0kXgqwoECU5Eoh9/rO+6I77ys6iDHCNQnhG01QQ4cSt3Gx4ERhrYlWDGAERr+6IanYjmA==
X-Received: by 2002:a2e:9111:: with SMTP id m17mr1534763ljg.263.1597303718233;
        Thu, 13 Aug 2020 00:28:38 -0700 (PDT)
Received: from jade (h-249-223.A175.priv.bahnhof.se. [98.128.249.223])
        by smtp.gmail.com with ESMTPSA id s4sm994147lfc.56.2020.08.13.00.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 00:28:37 -0700 (PDT)
Date:   Thu, 13 Aug 2020 09:28:35 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     Jorge Ramirez-Ortiz <jorge@foundries.io>
Cc:     sumit.garg@linaro.org, ricardo@foundries.io, mike@foundries.io,
        tee-dev@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv8] drivers: optee: allow op-tee to access devices on the
 i2c bus
Message-ID: <20200813072835.GA501056@jade>
References: <20200812120652.30012-1-jorge@foundries.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200812120652.30012-1-jorge@foundries.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 12, 2020 at 02:06:52PM +0200, Jorge Ramirez-Ortiz wrote:
> Some secure elements like NXP's SE050 sit on I2C buses. For OP-TEE to
> control this type of cryptographic devices it needs coordinated access
> to the bus, so collisions and RUNTIME_PM dont get in the way.
> 
> This trampoline driver allow OP-TEE to access them.
> 
> Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
> ---
> 
> v8: review fixes
>     fix types and add TEEC_ERROR_NOT_SUPPORTED to GP errors
> v7: add support for ten bit i2c slave addressing
> v6: compile out if CONFIG_I2C not enabled
> v5: alphabetic order of includes
> v4: remove unnecessary extra line in optee_msg.h
> v3: use from/to msg param to support all types of memory
>     modify OPTEE_MSG_RPC_CMD_I2C_TRANSFER message id
> 
>  drivers/tee/optee/optee_msg.h     | 21 +++++++
>  drivers/tee/optee/optee_private.h |  1 +
>  drivers/tee/optee/rpc.c           | 96 +++++++++++++++++++++++++++++++
>  3 files changed, 118 insertions(+)
> 

This looks good to me. Did you test this with the recently merged
https://github.com/OP-TEE/optee_os/pull/4024 ?

Cheers,
Jens
