Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC0EC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 06:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D72C220732
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 06:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=foundries-io.20150623.gappssmtp.com header.i=@foundries-io.20150623.gappssmtp.com header.b="o+lduEZX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgHUGhE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 02:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbgHUGhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 02:37:03 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40D4C061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 23:37:02 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a5so923301wrm.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 23:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries-io.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=skZa9gs2C+QBUYUqWQg7XBlQIg3Lke8/gakwm3y/JJA=;
        b=o+lduEZXzkFzTtm6Ava8WMK+NmvOzXsUluoVn8Q7oaUjnEQK/QwRaEND2VIkBOhgaU
         H+aF3TUkeHLkuLyu8DAKeU8zeJT7XSKUIHmYzxZu2EWjPjYjnBK1780vQCwBVK5Cb5nh
         t1TXRiYpsrAKSvHqetH1F99ZY669Pc4LTkuNnRaIEGkdqysfhuJzdXH58ZWJTtAFonmv
         XgeUTWD8CyU2zllj6Oda76zuPAyDOPR/1BhMv2ldhzIX+hr/ube09wJ418HLVuhByI0o
         bOIGyqya/tXJCF5rEfQXMk2+kHEei8thRLceAenb2jKEULfZS153FDfU3tZJsq5bskmy
         Y8Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=skZa9gs2C+QBUYUqWQg7XBlQIg3Lke8/gakwm3y/JJA=;
        b=sJ3+wqbUPnuZ92mcQGaR/ljsDUhVT9PYjA7q/AAxp/PMyon46y3H128K6GJ1XRc1gD
         x4mbGzZtvY3KB+qsvsvrUvwDdUyULCtoynAADmo6qkgh4UaFIhEpF37/Uc0H/rx/CiuS
         ao8zP2Q3PudRyZGG9l6+OahhfWx6+SS+9baalUyB2vFMB/xEInqBCvRxV9E4vtfOdEpf
         bZCSXP1SVejAuOzXkNWu/N5to//RRi6e3xjrTEiHRrrxb7Ga/uZqDfC5Ov2/Y3TwHaWk
         dHTVKsS43XvFs+58i7MrL8UONUVLGij+VxXm/OpWZ+kY/y/isuPZeJitoWtcdB2Pov3U
         fSrQ==
X-Gm-Message-State: AOAM532GrDfxDn3KEMd9ByzX1eX/d2zl6OxjwQ8df17KV4z6Y4FFylwz
        fXXe9Sx0NexnAD6HG2myaEDZYA==
X-Google-Smtp-Source: ABdhPJzeZe27zDcSX98qh8ygngArDlRW7ojneExjH1Br0oBNK5GJue9Q9pFJFlTiS/xO3Lidepvk5g==
X-Received: by 2002:adf:ab05:: with SMTP id q5mr1216136wrc.46.1597991821391;
        Thu, 20 Aug 2020 23:37:01 -0700 (PDT)
Received: from trex (239.red-83-34-184.dynamicip.rima-tde.net. [83.34.184.239])
        by smtp.gmail.com with ESMTPSA id g18sm2441618wru.27.2020.08.20.23.36.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Aug 2020 23:37:00 -0700 (PDT)
From:   "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
X-Google-Original-From: "Jorge Ramirez-Ortiz, Foundries" <JorgeRamirez-Ortiz>
Date:   Fri, 21 Aug 2020 08:36:57 +0200
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     Jorge Ramirez-Ortiz <jorge@foundries.io>, sumit.garg@linaro.org,
        ricardo@foundries.io, mike@foundries.io, tee-dev@lists.linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv9] drivers: optee: allow op-tee to access devices on the
 i2c bus
Message-ID: <20200821063657.GA20356@trex>
References: <20200814111221.5813-1-jorge@foundries.io>
 <20200821062121.GA1020247@jade>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821062121.GA1020247@jade>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/08/20, Jens Wiklander wrote:
> On Fri, Aug 14, 2020 at 01:12:21PM +0200, Jorge Ramirez-Ortiz wrote:
> > Some secure elements like NXP's SE050 sit on I2C buses. For OP-TEE to
> > control this type of cryptographic devices it needs coordinated access
> > to the bus, so collisions and RUNTIME_PM dont get in the way.
> > 
> > This trampoline driver allow OP-TEE to access them.
> > 
> > Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
> > ---
> > v9: params return value must be written before optee_msg_to_param is called
> > v8: review fixes:
> >     fix types and add TEEC_ERROR_NOT_SUPPORTED to GP errors
> > v7: add support for ten bit i2c slave addressing
> > v6: compile out if CONFIG_I2C not enabled
> > v5: alphabetic order of includes
> > v4: remove unnecessary extra line in optee_msg.h
> > v3: use from/to msg param to support all types of memory
> >     modify OPTEE_MSG_RPC_CMD_I2C_TRANSFER message id
> > 
> >  drivers/tee/optee/optee_msg.h     | 21 +++++++
> >  drivers/tee/optee/optee_private.h |  1 +
> >  drivers/tee/optee/rpc.c           | 95 +++++++++++++++++++++++++++++++
> >  3 files changed, 117 insertions(+)
> 
> Looks good. Did you test this with the recently merged
> https://github.com/OP-TEE/optee_os/pull/4033 ?
>

yes, I did retest and it is good.

thanks!

> Cheers,
> Jens
