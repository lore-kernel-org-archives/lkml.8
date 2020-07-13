Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C89EC433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 19:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74EE62067D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 19:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594666913;
	bh=USrLtrgtBKMhRPM3OlW0oqbiG/Gn2dCKZIdNmtJEbb0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=b3MhoPOJvXb8xXNt11XytyWnbYXiTyL9z0WW2Jjs2A35DElTxfO+W1xWYRqE2RPln
	 sLEj+iR70fXAfiaeBMuhVyco3t5LfkHc07JbSqGJ320tRCa84R2eZW/fArc6cfnpDF
	 n8rXfN3WEtfA7VvRlf/BaBBbjSrLyiZqSpiaCTNg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgGMTBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 15:01:52 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:42469 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbgGMTBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 15:01:51 -0400
Received: by mail-io1-f67.google.com with SMTP id c16so14659059ioi.9;
        Mon, 13 Jul 2020 12:01:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CQ6pohVThqzS3I/KYfFL7+Hlm4WPavCaDvdC8FwkRZ8=;
        b=Fxx58D/BW5iN5A5j8rimXIiudzp1OKhL80ec+DKRmK+TEjE4ItYAjvEWdcwP0jpBr9
         cgmaJA6xEJjKq9MIxOKOBSYZnx34OGtD2UDgV5clSk1Cs5uu5vmNFybqamPLmWgGS6/E
         hsDBPuw/e9RBuqBc7MzD8H3yAkXU+DqW8NqojTKJbd9FRd/r3dk0SU3D47x7rKInmdRR
         uAg1YhE/Agh7zb6Nn4m63pg84meNzWSpj5a3Mw7VEbrFCfZ5rKF8Bjf0uPAd8NqAl1i6
         iIvmvPqFoRX6e5cuuvm/g5WqiK6H+esqdkTQRk400qm9TQ7lg8ZVsY2jOa9aoP7So4xH
         ZfuQ==
X-Gm-Message-State: AOAM531KnEhAfSnM3j1u9JnVWMs1fbE1T4/HhYbems8YsRTbSGU6u4vo
        H/BFTZcjcJE1DqPemd9yag==
X-Google-Smtp-Source: ABdhPJwyE3bIJvBfP/GGl4yQNVMTMspCf+iz5Gv0rrhwfauUdjh4S3SJ+W14R3si34JxrSa3ZPWO/w==
X-Received: by 2002:a05:6602:1581:: with SMTP id e1mr1290370iow.44.1594666910765;
        Mon, 13 Jul 2020 12:01:50 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id n1sm8761130ilo.68.2020.07.13.12.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 12:01:50 -0700 (PDT)
Received: (nullmailer pid 545673 invoked by uid 1000);
        Mon, 13 Jul 2020 19:01:49 -0000
Date:   Mon, 13 Jul 2020 13:01:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konradybcio@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Sivaprakash Murugesan <sivaprak@codeaurora.org>,
        Anton Vorontsov <anton@enomsg.org>, skrzynka@konradybcio.pl,
        Tony Luck <tony.luck@intel.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Colin Cross <ccross@android.com>,
        linux-arm-msm@vger.kernel.org,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v3 1/8] firmware: qcom_scm: Add msm8994 compatible
Message-ID: <20200713190149.GA545643@bogus>
References: <20200624150107.76234-1-konradybcio@gmail.com>
 <20200624150107.76234-2-konradybcio@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624150107.76234-2-konradybcio@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jun 2020 17:00:59 +0200, Konrad Dybcio wrote:
> This change adds a compatible for msm8994,
> which requires no additional clocks for
> scm to probe correctly.
> 
> Signed-off-by: Konrad Dybcio <konradybcio@gmail.com>
> ---
>  Documentation/devicetree/bindings/firmware/qcom,scm.txt | 1 +
>  drivers/firmware/qcom_scm.c                             | 1 +
>  2 files changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
