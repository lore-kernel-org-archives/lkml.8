Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E4EFC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 18:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E7292081A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 18:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FZATBbc8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406077AbgFYSmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 14:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728204AbgFYSml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 14:42:41 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207EEC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 11:42:41 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id l2so5514592wmf.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 11:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=CM6cvOMbPK1tPagXELCKKZh5fN5Sn7S/TQd/N1/ohfE=;
        b=FZATBbc8zj3GI4jG+3XwqQVOp0MgKW7vcyr9zNy4xDfwMIH9dGmzzUKm6z5jzZW1a6
         N2+EM/JcLdD1jJcC78WkQSjemtBvSiXDaEWOVtPCwpukCAaEJqklsnWUCSLJL5RG5T5+
         0ba9NA1McmFEDt7d/sTdvGpBPC1hFADPG0Jq8MapWzYlMba216Kkw0gYfEnDb9aUfcHg
         /uj1zkz9eOrpYg30it6ElDBCbGRPmGeDbAccF1eLlFkQl6AP2404Y7NAu5ctG9x0Qd9H
         F4XXu88Uz8SamkJPErA2PZ72RKtQGROJmigHkms0R9zL/qgz0KW/DfY9zGHng8uW5axA
         8xnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=CM6cvOMbPK1tPagXELCKKZh5fN5Sn7S/TQd/N1/ohfE=;
        b=ECwlwW5fBYQS2WGly3zjhPATpeqDvvFvQSheH6D4PZceIHDk9oOZsIEtM7+Fj9cTMs
         aV6Dh8YD77rDXJvCB3Rz0TAh+bdow+BtYYPjxGjpDs7SJPR5nlU6ECVTOKwA0dy+u4Xx
         REvpLCzHy6OoIor28l3jSmCLVa4bEvidCKPMhCgWJCBmeGC6lizsF1DNlNymivsuUyKa
         cX8dvVW2qMpUTYM4tBALG8vzxsgCmdpt9WnwMSq+HIdoPjpFvi9ge6w9aC0K6SaTbQVS
         xRrStROwlmvPwtB8hgG/kQ2dAqPq47Qs5PUAC6nB+hTX7hXDMxuLCNNEiyCkWPFnsxCQ
         1A4Q==
X-Gm-Message-State: AOAM532d8zqcWjjsIJDk6xcv+WFd9nBgqoWQjh5+S8BoLmSZHIEDmKJ3
        smNA04mMlOTS/N0aNB8M+MRY+GROAto=
X-Google-Smtp-Source: ABdhPJzk/3FAJJFCMqCTCx+/emgASTDy1G7oKK2l2WE1LQCvKRQE9P5sK0XNA96gc0AKQVtaGjs4Lw==
X-Received: by 2002:a7b:c14a:: with SMTP id z10mr4777067wmi.19.1593110559815;
        Thu, 25 Jun 2020 11:42:39 -0700 (PDT)
Received: from dell ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id h18sm32374696wru.7.2020.06.25.11.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 11:42:39 -0700 (PDT)
Date:   Thu, 25 Jun 2020 19:42:37 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/10] regulator: of_regulator: Add missing colon for
 rdev kerneldoc argument
Message-ID: <20200625184237.GV954398@dell>
References: <20200625163614.4001403-1-lee.jones@linaro.org>
 <20200625163614.4001403-4-lee.jones@linaro.org>
 <20200625172942.GE5686@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200625172942.GE5686@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jun 2020, Mark Brown wrote:

> On Thu, Jun 25, 2020 at 05:36:07PM +0100, Lee Jones wrote:
> > Kerneldoc validation gets confused if syntax isn't "@.*: ".
> > 
> > Adding the missing colons squashes the following W=1 warnings:
> 
> >   * of_check_coupling_data - Parse rdev's coupling properties and check data
> >   *			    consistency
> > - * @rdev - pointer to regulator_dev whose data is checked
> > + * @rdev: - pointer to regulator_dev whose data is checked
> 
> It shuts up the warning but are you sure this is going to get formatted
> well by the tools?  We now have a - as the first character in the
> description which I'm guessing the tools are going to render which won't
> look great.

Happy to fix.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
