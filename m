Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E120C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 21:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 028212082F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 21:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594676348;
	bh=MVacFtsb4vNf7+gSS+PSj+9LHHwfMMEyml37hny7jRI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fMgm8D8TmzZmPceV2nBlSsrLJBkwTjJq2oe0YOWPtF2zzdWFeFymDO7Z9yXrYlb4O
	 +veGTZYYb4rORuj2bWphiHUOWKG+TkqiqXFRkcemm69YHjOVrMd+Q/yiIUJ75I5xev
	 cilbH0F8e3SKXwUHaBZghXTLBsACF4dAvQPGzti0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgGMVjH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 17:39:07 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:40084 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbgGMVjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 17:39:06 -0400
Received: by mail-il1-f193.google.com with SMTP id e18so12508395ilr.7;
        Mon, 13 Jul 2020 14:39:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EdBTRjYgonQ4n/xwV9Lanc05+D2tIq1HVeK6rFmGHsw=;
        b=N2Yhgh164HCfIfOLu+QrvHjdx3GOuIvG5FruYLpLOVQWa4bJ6H8XkCYGnPoFZeZZo7
         C9E+MMYV9Ldj3dsxsRqezWBFP4E2mZQqMXBG/u/5jL0LaCvou73AqcxC+qfDuN/zh9qN
         N6y5ai4CPle+fcBCHnU4NXD532S6SlxiU14M7u1IxxzCPpecherAtcZo6A8PnVx5TxgI
         lc3RnIQPy3elGwX6e0eyIFmynJvJRXRISK4FSvhSJno2L1S1bEV+qnE6git9VuGZWm3I
         rvo0s5k9FWqvBAUnPj/77DGb9XqgtnjWcsZT3wF/E+V3BEp5YUyv8XPeWaza9Z49lDGr
         uXrw==
X-Gm-Message-State: AOAM531cdld6jnWAjWW68ubfI5dJl9mllYbjUWaEHnjvLPS8NacM0DFf
        jWt2vfKs5umvprChGXmVXA==
X-Google-Smtp-Source: ABdhPJyAC3Al6bnbWdMb3ZWrGr8qKNbe4Yy5Xdr0GY628TTB5I0UNKUYeeP49dtMuRZMAxOHeaSC5Q==
X-Received: by 2002:a05:6e02:13b1:: with SMTP id h17mr1654033ilo.155.1594676345425;
        Mon, 13 Jul 2020 14:39:05 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id r124sm7933561iod.40.2020.07.13.14.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 14:39:04 -0700 (PDT)
Received: (nullmailer pid 773476 invoked by uid 1000);
        Mon, 13 Jul 2020 21:39:03 -0000
Date:   Mon, 13 Jul 2020 15:39:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     linux-actions@lists.infradead.org, Stephen Boyd <sboyd@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        linux-clk@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Michael Turquette <mturquette@baylibre.com>,
        devicetree@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v3 2/6] dt-bindings: clock: Add APB, DMAC, GPIO bindings
 for Actions S500 SoC
Message-ID: <20200713213903.GA773423@bogus>
References: <cover.1593788312.git.cristian.ciocaltea@gmail.com>
 <67112af4f5bc0cc5e70ce8410feb369cc72972b8.1593788312.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67112af4f5bc0cc5e70ce8410feb369cc72972b8.1593788312.git.cristian.ciocaltea@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Jul 2020 20:05:08 +0300, Cristian Ciocaltea wrote:
> Add the missing APB, DMAC and GPIO clock bindings constants for
> Actions Semi S500 SoC.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> ---
> Changes in v3:
>  - Preserved the original values of the existing bindings and moved
>    the newly added constants bellow, as indicated by Stephen
> 
> Changes in v2:
>  - None
> 
>  include/dt-bindings/clock/actions,s500-cmu.h | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
