Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E6EC47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 16:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F2CA24954
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 16:16:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Br4NUGVA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729975AbgEAQQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 12:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728896AbgEAQQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 12:16:42 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21AACC061A0C;
        Fri,  1 May 2020 09:16:42 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id t199so175352oif.7;
        Fri, 01 May 2020 09:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lgmELjhtwvQPrX77vnoSnk11mljHderl9HxceIw1oe8=;
        b=Br4NUGVAtZWvUXQfy8/75cj/z8IaziKZ8/JMhKNe6IuHC1GGQUXcfYw+cnkh9PBJcS
         vL/LH2WUOOD6MG3Z8PFpVaGInS33IhM7qrlOL9QqRl6VHUxmYS1kLg6qR2iulfHVu/qS
         1dxP/1DKcOsjmiRkHuh2fVwM0l+OtK+shWYfSX4+RNLfqmZAoWBx5ZeIaIZLqyg3IhmT
         YwCKuwLfNm/Fw+u7KTF1qRbPblQGZQibDjnRoaMPxywwlCx5FkAg2NYpPDTx2sXbxHZN
         ktEe8X1QkpVLwTHlW64fiDINZMgDGcGUpI06AqvV3urVhwyv5nf3s9oOBpQc/pA6Wr1s
         0gcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=lgmELjhtwvQPrX77vnoSnk11mljHderl9HxceIw1oe8=;
        b=dQyx+10YGWY2l/xWmG4ZKjfpaJfq7jTO8yhg6b1yc7jwM01jhdztj3BtBpxuxcqCJ8
         Z/kxhNVE4cwqeV6b+4vTgCvi3V9v9PMzGYsHkWIimiACpKCTJq61uViV6IRilQbDNMuF
         XeEbGl+ct7MK6n7kyIT898Bet9fMLqtplugCDGC2HRzrSs3+ehMrCvuNoTD8Mr5GhZZL
         IoxOjN+uG7SaZj3U1Ql+IwifgD6xe0xJIy9PEc7EPYcBZszEDSiKPKEhqe9vAWfqShaV
         eycCHYVW0nsDNfnFYrTbmmOjB57I1c8EdH+NajspdkcDiHhYPZCOR/9I6YjiimrBEqAm
         CbLg==
X-Gm-Message-State: AGi0PuZpTer1sWRkxEDaCS5IyYRKhZsnMMeW9aybG/tHuOHntLgTc5rc
        VR0Up3cLPV4Zu6Kg2J2uxg==
X-Google-Smtp-Source: APiQypImnju0D2j2tlQZOp+12Lxz5mLbARJyu7bikZIcG8ES9reYr4QopOQc75af6+xNAl7K9Viu+g==
X-Received: by 2002:a05:6808:49:: with SMTP id v9mr244950oic.41.1588349801353;
        Fri, 01 May 2020 09:16:41 -0700 (PDT)
Received: from serve.minyard.net ([47.184.149.130])
        by smtp.gmail.com with ESMTPSA id g24sm938859oos.20.2020.05.01.09.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 09:16:40 -0700 (PDT)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:8b39:c3f3:f502:5c4e])
        by serve.minyard.net (Postfix) with ESMTPSA id D712418000D;
        Fri,  1 May 2020 16:16:39 +0000 (UTC)
Date:   Fri, 1 May 2020 11:16:38 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Pragat Pandya <pragat.pandya@gmail.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Harald Seiler <hws@denx.de>,
        openipmi-developer@lists.sourceforge.net
Subject: Re: [PATCH 04/14] docs: move IPMI.txt to the driver API book
Message-ID: <20200501161638.GF9902@minyard.net>
Reply-To: minyard@acm.org
References: <cover.1588345503.git.mchehab+huawei@kernel.org>
 <ae4edbc6753dc522cb93de36800978e3b58e0cfb.1588345503.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae4edbc6753dc522cb93de36800978e3b58e0cfb.1588345503.git.mchehab+huawei@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 01, 2020 at 05:37:48PM +0200, Mauro Carvalho Chehab wrote:
> The IPMI is under drivers/char. This doc describes the kAPI
> part of the IPMI (mainly).
> 
> So, move it to the driver-api directory and add it to the
> corresponding index.rst file.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

This is fine with me.

Acked-by: Corey Minyard <cminyard@mvista.com>

> ---
>  Documentation/driver-api/index.rst              | 1 +
>  Documentation/{IPMI.txt => driver-api/ipmi.rst} | 0
>  2 files changed, 1 insertion(+)
>  rename Documentation/{IPMI.txt => driver-api/ipmi.rst} (100%)
> 
> diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
> index dcc47c029f8e..6567187e7687 100644
> --- a/Documentation/driver-api/index.rst
> +++ b/Documentation/driver-api/index.rst
> @@ -39,6 +39,7 @@ available subsections can be seen below.
>     spi
>     i2c
>     ipmb
> +   ipmi
>     i3c/index
>     interconnect
>     devfreq
> diff --git a/Documentation/IPMI.txt b/Documentation/driver-api/ipmi.rst
> similarity index 100%
> rename from Documentation/IPMI.txt
> rename to Documentation/driver-api/ipmi.rst
> -- 
> 2.25.4
> 
