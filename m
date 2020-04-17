Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F5BC352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 10:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA129221EC
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 10:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YO8mOk7b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729844AbgDQKpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 06:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729143AbgDQKpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 06:45:12 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E527C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 03:45:10 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id u10so1414386lfo.8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 03:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OOXAVYgcfazn+Kp2sijY0OnrpeLZ73nHGu/TeI4B9JM=;
        b=YO8mOk7biFYLUfcg+pBXN/b07QrhLpOFRIuoeii6jVnK1g7X+SuODzlcfs4dkpFdy1
         0P2qzCVH0Svgual9NVDEzB4dJQskrRK6wf2GGkSfH2Ea4y4dQAuptukNHA36Rm+T5U2A
         ao9IsRvVc8cZDaNurdcapZNtmYo1RgAUlSTgh/ivR6tps7o6U6PbknpmN+xqWxF7QyVJ
         wPbwLfAog3NH6iV3FlECfBKZV5i6XtHLxItDMCtSjMS76wbTa2Je+TTAJNBDbWPaHhsN
         v4x0o3uX3dxW7oMQoQk+ubWyZBI4pFadJ3xUaCcH/6BdxH6iE988/ogAgwsvllZ7L2NL
         ZJkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OOXAVYgcfazn+Kp2sijY0OnrpeLZ73nHGu/TeI4B9JM=;
        b=kRS1CdGBq/oMrMRzUy9zPTnUGhfQ3NxZslXj++YumWcWxRJFYu2hlCIeMCSTEU3BeE
         Br5uLKXg51qz6aAtFLL1/AO/B99/jSMC5w7lYQqyq8KWidmC2a9r2me5+1ZgF4wfVDL/
         2HtS3sqbZfxLMhPucvZjhff5BQtKZXUIq/lWNlq/4TQ+wvNZgj1rI6q2PB49rY/it63P
         /RwhOj5Fn6k5fkfHQo2BjSv90GOZ5oPLBMmr1ERfXP1WwoNOth10ioFKPtNgO+BtixAr
         eqyigdXpD/lY0Oo3fvYerTtp1JFc2s2NCRDgyvUDaxLtFGiRe1I6OZi0ZBnNdaeFAHi/
         b1CA==
X-Gm-Message-State: AGi0PuaDCnXBWirqHkeLUxKVp4sMpKE8WCq9BygeYbwZm1NuRTa2AQeR
        R/ZwBUw4KLrAkdTkq9E93RrGTYqL9ETB9zcUs16z3Q==
X-Google-Smtp-Source: APiQypKryf1TaEj6EY1h8Sc7BIdHwd0eVmA52KHCrRd7x7r2BQz298tBmlXWjjDTDtxsguXhNOckrNYZ/Zq5AOeq4UM=
X-Received: by 2002:ac2:41d9:: with SMTP id d25mr1677099lfi.204.1587120308928;
 Fri, 17 Apr 2020 03:45:08 -0700 (PDT)
MIME-Version: 1.0
References: <1585286988-10671-1-git-send-email-sumit.garg@linaro.org>
In-Reply-To: <1585286988-10671-1-git-send-email-sumit.garg@linaro.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Fri, 17 Apr 2020 16:14:57 +0530
Message-ID: <CAFA6WYOqB2BwrZhgm1=btEmPwxYVpKKFAgOE2mYOUrUykgmiLw@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] Enhance TEE kernel client interface
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jerome Forissier <jerome@forissier.org>,
        Stuart Yoder <stuart.yoder@arm.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

On Fri, 27 Mar 2020 at 11:00, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Earlier this patch-set was part of TEE Trusted keys patch-set [1]. But
> since these are completely independent enhancements for TEE kernel
> client interface which can be merged separately while TEE Trusted keys
> discussions are ongoing.
>
> Patch #1 enables support for registered kernel shared memory with TEE.
>
> Patch #2 enables support for private kernel login method required for
> cases like trusted keys where we don't wan't user-space to directly
> access TEE service.
>
> [1] https://lkml.org/lkml/2019/10/31/430
>
> Changes in v6:
> - Reserve only half of GP implementation defined range for kernel space.
>
> Changes in v5:
> - Misc. renaming of variables.
>
> Sumit Garg (2):
>   tee: enable support to register kernel memory
>   tee: add private login method for kernel clients
>

In case we don't have any further comments, would you like to pick up these?

-Sumit

>  drivers/tee/tee_core.c   |  7 +++++++
>  drivers/tee/tee_shm.c    | 28 +++++++++++++++++++++++++---
>  include/linux/tee_drv.h  |  1 +
>  include/uapi/linux/tee.h |  9 +++++++++
>  4 files changed, 42 insertions(+), 3 deletions(-)
>
> --
> 2.7.4
>
