Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B10C54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 10:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF6C2206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 10:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GkA+hZw7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729283AbgELK4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 06:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726891AbgELK4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 06:56:14 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BDBCC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 03:56:14 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id g4so13101880ljl.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 03:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=bT/HV8hKW5HFeYzrVYV5eprh+/2g1GPPXvFEs0sLOGA=;
        b=GkA+hZw7YEOX4+20N3I3Lf5fuuJ2b2IwQMy0zf1+SAhArmmZycL6ahx3yao44bDWfE
         PCOawk2ab+w4cK28MCoquYmuz/XM8dctNxRu8id3llBrGkIk10Ml41bc8GbrZRkOcAHw
         1FLMkco2eCO0lryIkGp6U5Sh45rgcg0h1FYE4wfOIVv5F/76LdpKNFc7xya3NzWKK+a7
         kh1T7Jn+7HrGaGpjtpVt4MRK1zG+q6GnCFdsvz75e90Vwdaf0LhHmBPHyKDxOt3y47ga
         6n6ulFuhrTTQKFWEHT7Zq40ugZvXfsXK5YSXJ/or07NdT7Dj89vJi7J7EhQoZNXhObpo
         8ayw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=bT/HV8hKW5HFeYzrVYV5eprh+/2g1GPPXvFEs0sLOGA=;
        b=XbqmIOXtlIKB7LUDt0GGkRCUaL5M5CSdReQiwfYa6j5mzyHQK6B7ShhanK3il5IUCJ
         l6rZR52HcgO3SOVZcNEX1APLe62qkYIe39HgvLshkM+1ybdW9GsMNf3N5jgayF2abhA0
         qlV0Qb8TBBX3CC6FkzaYp5qtZYDiaoYlyXZHRlRIpghFhM62GEkq2ZtkQlO/yL55HXhW
         63FaIJ4+S8T0qwTexvGwsN6VHt13FC9Z36sAy6ImFEGkWcp+Q1vBFQ9jNF3apPLTwLEv
         f1sYEn7HCARa/3w3zf3FkWGLcx5qaeSEHd2wkNEOm+I2PVDoHg5IzPQxfBh6cgDk504V
         zpqg==
X-Gm-Message-State: AOAM531HAS9LFtF+haxSrRiCFET3+nioZt25pPIEbIfZGCH0HWOUuTk8
        ZNdmuxhrJhhSMk8SwTUb2KaJv65kszQ=
X-Google-Smtp-Source: ABdhPJzD8bRxBBT1KcKC1IqKF/1DlVQlp+CWy2kGTe1ARrQhoKg8bmMAui4fSVwjkQkUnhyjsMhvEw==
X-Received: by 2002:a2e:9843:: with SMTP id e3mr13492936ljj.249.1589280972242;
        Tue, 12 May 2020 03:56:12 -0700 (PDT)
Received: from jade (81-236-179-152-no272.tbcn.telia.com. [81.236.179.152])
        by smtp.gmail.com with ESMTPSA id l11sm10677845lji.99.2020.05.12.03.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 03:56:11 -0700 (PDT)
Date:   Tue, 12 May 2020 12:56:09 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     Vesa =?utf-8?B?SsOkw6Rza2Vsw6RpbmVu?= 
        <vesa.jaaskelainen@vaisala.com>
Cc:     op-tee@lists.trustedfirmware.org,
        Rijo Thomas <Rijo-john.Thomas@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Hongbo Yao <yaohongbo@huawei.com>,
        Colin Ian King <colin.king@canonical.com>,
        linux-kernel@vger.kernel.org, tee-dev@lists.linaro.org
Subject: Re: [PATCH v2 0/3] tee: add support for session's client UUID
 generation
Message-ID: <20200512105608.GA6646@jade>
References: <20200430123711.20083-1-vesa.jaaskelainen@vaisala.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200430123711.20083-1-vesa.jaaskelainen@vaisala.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 03:37:08PM +0300, Vesa Jääskeläinen wrote:
> TEE Client API defines that from user space only information needed for
> specified login operations is group identifier for group based logins.
> 
> REE kernel is expected to formulate trustworthy client UUID and pass that
> to TEE environment. REE kernel is required to verify that provided group
> identifier for group based logins matches calling processes group
> memberships.
> 
> TEE specification only defines that the information passed from REE
> environment to TEE environment is encoded into on UUID.
> 
> In order to guarantee trustworthiness of client UUID user space is not
> allowed to freely pass client UUID.
> 
> Vesa Jääskeläinen (3):
>   tee: add support for session's client UUID generation
>   tee: optee: Add support for session login client UUID generation

I'm picking up these two patches.

>   [RFC] tee: add support for app id for client UUID generation

I'm waiting with this patch until we've reached some conclusion.

Thanks,
Jens

> 
>  drivers/tee/Kconfig      |   1 +
>  drivers/tee/optee/call.c |   6 +-
>  drivers/tee/tee_core.c   | 211 +++++++++++++++++++++++++++++++++++++++
>  include/linux/tee_drv.h  |  16 +++
>  4 files changed, 233 insertions(+), 1 deletion(-)
> 
> -- 
> 2.17.1
> 
> Changes v1->v2:
> 
> * Changed goto labels to be more logical
> * Capture error if formatted string for UUIDv5 does not fit into buffer
> 
> Notes:
> 
> This patcheset has been designed so that it can be iteratively intergrated
> meaning that the application ID (RFC patch) part can be left for later when
> there is agreed solution for that.
> 
> TEE specification leaves Linux behavior undefined. It does not define any
> UUID value for name space. UUID in here is randomly generated with uuidgen
> tool.
> 
> I have also include amdtee people as this method probably should also be
> applied in there.
> 
> Using op-tee@lists.trustedfirmware.org instead of tee-dev@lists.linaro.org as
> latter is deprecated old list.
> 
> Original issue in OP-TEE OS tracker:
> https://github.com/OP-TEE/optee_os/issues/3642
> 
> Related reviews and demonstration for the concept:
> https://github.com/linaro-swg/linux/pull/74
> https://github.com/OP-TEE/optee_client/pull/195
> https://github.com/OP-TEE/optee_test/pull/406
