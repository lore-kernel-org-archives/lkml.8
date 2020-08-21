Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1315C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 06:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7832420738
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 06:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fMEkVuVN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbgHUGV1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 02:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgHUGVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 02:21:25 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E405C061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 23:21:25 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id y2so653951ljc.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 23:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=L2GL4FMgc/dSMOohNfUAefXXfnpWIv3+pJWm+SgM0hU=;
        b=fMEkVuVNPXsUdpLu94DxjsRcpHErma5pTjbfM2Oz93C7Pz1/rCR9Rc42NEGRQyGVA0
         e5qt5B4wH2s62jAY1HDYneEuD3KzU2ZHOAH45kgG38hDDdQffHA/YkEJjHD5buGh8Ap5
         TRuC6uKrwdPxOCyPy7fcvk04tcpWl2AH6lbYmS2qgRstct7jVHszm38L5YVTN+UvSj4Z
         VjY9UyQneg3fieaCszPy1wBx8QvdCYpySDQak5V2KNZDQDS/k657feOilzstvqvxWz9/
         86feiSl3+ky9mkMnNiki5ccwfdrHjsJ2/ZTq8wR3Y0Tu7Njmv30F7p7hKUwkVtPSMk9D
         eh3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L2GL4FMgc/dSMOohNfUAefXXfnpWIv3+pJWm+SgM0hU=;
        b=KFca7MktPxJ5C3Y1ewtAEba3adA12I+PJxrNaUQvjXPzp1X05RvbMDfnA8HiyiAYCC
         +SKGe94NcjCvAJ0aaCXJgEieLFByqxuPo3RmPgrtJSsvnROmRNgfQhGZ4LE7PZxUCO8s
         O8xGVkArwqmyFlx6U6UjUu90iHo5pmHJbc5gn5RU24kab2qJitHqAzHkTgNAC6mDOla1
         YJ6Kr2xHpGgs2HonetF+tT6jzJW2ECBApo5FDPeIwkYnC81v379FxluCU/HSb7zykvv4
         bIyIy4whpc3k9/YTgBkG6YgV0OX/6QUrgAnSJWUJXvOAyMCTyHEtrjzYR4DHzq6rbiig
         hSMw==
X-Gm-Message-State: AOAM5319ABMZjAbokqwEtbdegykyXlSPuMO06mrfkIDO7d8QFcGKEnL4
        C1MVAv9t/cBSlqwka5uRivufVg==
X-Google-Smtp-Source: ABdhPJzuK4VmvYfPlSxrNdvXuyb9K9Colt6ot6MsF3X4j/XQ+D6iII3Gm7+KTYTi8x4BCDvkgLJGIg==
X-Received: by 2002:a2e:8157:: with SMTP id t23mr778218ljg.417.1597990883459;
        Thu, 20 Aug 2020 23:21:23 -0700 (PDT)
Received: from jade (h-249-223.A175.priv.bahnhof.se. [98.128.249.223])
        by smtp.gmail.com with ESMTPSA id a23sm175171ljp.121.2020.08.20.23.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 23:21:22 -0700 (PDT)
Date:   Fri, 21 Aug 2020 08:21:21 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     Jorge Ramirez-Ortiz <jorge@foundries.io>
Cc:     sumit.garg@linaro.org, ricardo@foundries.io, mike@foundries.io,
        tee-dev@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv9] drivers: optee: allow op-tee to access devices on the
 i2c bus
Message-ID: <20200821062121.GA1020247@jade>
References: <20200814111221.5813-1-jorge@foundries.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200814111221.5813-1-jorge@foundries.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 01:12:21PM +0200, Jorge Ramirez-Ortiz wrote:
> Some secure elements like NXP's SE050 sit on I2C buses. For OP-TEE to
> control this type of cryptographic devices it needs coordinated access
> to the bus, so collisions and RUNTIME_PM dont get in the way.
> 
> This trampoline driver allow OP-TEE to access them.
> 
> Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
> ---
> v9: params return value must be written before optee_msg_to_param is called
> v8: review fixes:
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
>  drivers/tee/optee/rpc.c           | 95 +++++++++++++++++++++++++++++++
>  3 files changed, 117 insertions(+)

Looks good. Did you test this with the recently merged
https://github.com/OP-TEE/optee_os/pull/4033 ?

Cheers,
Jens
