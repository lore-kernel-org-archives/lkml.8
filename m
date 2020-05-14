Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D588C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 17:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAB88206D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 17:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589476507;
	bh=n5DENuly7GB3vCYWanyi3YFnqNctc7DKWNzlGDezsfA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pVsjv90FdcTcZn/oeeRyEVQsh/9uf5kcezdcdNEnB5yEcc/a+j1bt4rOz5Fd6gNrE
	 FmTBVv6eZTBGUG6cUmK7VnVvCijEThGahnWF3UI41hTs6OVQwv2DxLnLGrXlchVzFX
	 2+hVr/WiVls21DTcvZVkXsDvcqS+M7dAzsWbVzH4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbgENRPG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 13:15:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:39086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbgENRPG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 13:15:06 -0400
Received: from localhost (unknown [122.182.193.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A13962065D;
        Thu, 14 May 2020 17:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589476505;
        bh=n5DENuly7GB3vCYWanyi3YFnqNctc7DKWNzlGDezsfA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z9iSoYsL98wpR4LL3cedmqD0OUIrRXwvlIjkjXjo+/0sXwQA/PppgcNaDn6qysWrA
         tf3Cv8aP9RBHpq6SqXuJc/WxjwpXajYCIEhGUALMv6zsUeNMvTijyPpFHBnUHTDNAl
         wNqDh6jX2JtNwKUWd7INQO0UZmr+0+yRvq/nYgYo=
Date:   Thu, 14 May 2020 22:44:52 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: c630: Add WiFi node
Message-ID: <20200514171452.GE14092@vkoul-mobl>
References: <20191018055841.3729591-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018055841.3729591-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-10-19, 22:58, Bjorn Andersson wrote:
> Specify regulators and enable the &wifi node. The firmware uses the 8
> bit version of the host capability message, so specify this quirk.

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
