Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE7FC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 21:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4D8620706
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 21:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598304228;
	bh=LO1EEB144C2vD5cYYmOu1dLJPWOThQQ/laiuqMTmvWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=S2uUO/XnLv6JGkEVCD84YwLbecMutaBmgeyto+edwxBfARxon7d2gRTYnCzWRxLG8
	 fRV/wY2D2dkZf+Uvo+Dhqr/gboPgERKQ6a/iOkLUGINchrD/+iB+TTt9m9dDm2M1+W
	 pIQ7QnI9nyUNF6o3rz6DFHhqFdxdsxzzuyM4C57o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgHXVXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 17:23:48 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:42414 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbgHXVXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 17:23:45 -0400
Received: by mail-io1-f66.google.com with SMTP id g13so10281083ioo.9;
        Mon, 24 Aug 2020 14:23:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DYG0ILvFxNKM05Xe+HSbAjxQcLfwP0Jr68vg3DfN5q8=;
        b=A/6tmk+7J4pMP145E6+LNdmxl476Jen+t8gxykBYqYuiS9CzSya4jBdcW+rEfQfZq6
         Xdan25fPSQ26bW1GKuM/xPhg4ObzgOWta/w4MLgT+mB2FQyScYccGWKj3L6/i1Pf30ca
         pdogkMfC6Dcj4JREvNpmN0gF6tJnJjRup0rlFQCmyVMZJwKgYY8aU8sEPOg71bRcBPZI
         nuCibXGcdWN11tiUC1ne1z3+Dw6oWQCQojcj5xyvV0wgebP5LdjIZbffbIzyBwFtXfJt
         11w26IiBgpPOJMCR2SIig5L0LKKyQIgxjJrKiJUvpi++PwmC2B4Bp1E6R+Bd5FCUOKEz
         fUYw==
X-Gm-Message-State: AOAM533JixQrYCUQ0HJM9Xa+czNogFbT/1vx5hiHfR3wH2Y8P9N8snHY
        HMIaIK+jPTDifIOFvYkeew==
X-Google-Smtp-Source: ABdhPJzXtING/zXpOypB5KNMcRp+7WblWNsKV+7ju4aN3WqY6cvZhBEIox0+vNTYZRCJOwij5qml4A==
X-Received: by 2002:a5d:9344:: with SMTP id i4mr6449153ioo.106.1598304224852;
        Mon, 24 Aug 2020 14:23:44 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id f186sm3347485ioa.42.2020.08.24.14.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 14:23:44 -0700 (PDT)
Received: (nullmailer pid 3323541 invoked by uid 1000);
        Mon, 24 Aug 2020 21:23:41 -0000
Date:   Mon, 24 Aug 2020 15:23:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     lgirdwood@gmail.com, cy_huang <u0084500@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        cy_huang@richtek.com, gene_chen@richtek.com
Subject: Re: [PATCH 1/3] regulator: rt4801: Add support for RT4801 Display
 Bias regulator driver
Message-ID: <20200824212341.GA3321545@bogus>
References: <1597461262-25878-1-git-send-email-u0084500@gmail.com>
 <159776976828.56451.5593321071237177212.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159776976828.56451.5593321071237177212.b4-ty@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 05:56:08PM +0100, Mark Brown wrote:
> On Sat, 15 Aug 2020 11:14:20 +0800, cy_huang wrote:
> > Adds support for the RT4801 DSV. It has two regulators (DSVP/DSVN) with
> > an I2C interface. DSVP/DSVN can provide the display panel module for the
> > positive/negative voltage range from (+/-)4V to (+/-)6V.
> 
> Applied to
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next
> 
> Thanks!
> 
> [1/3] regulator: rt4801: Add support for RT4801 Display Bias regulator driver
>       commit: 5bbbfc7f7f0a44b7a85ab3872dd2ccce7019f7b1
> [2/3] regulator: rt4801: Add DT binding documentation
>       commit: fd6b928db8a05fcd8629320c52eae214a8615aae
> [3/3] regulator: rt4801: Fix the dt-binding document for dtc check.
>       commit: 6f4ac2844b61d43c0c48b7c67a974d9f6e4ddd9c

Really? Despite my comments patch 3 should both be squashed and is still 
just wrong.

Rob
