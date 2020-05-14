Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C40C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 17:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 339092065F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 17:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589476307;
	bh=GJ+zMvzM9NaCTf4oi/AU+Wf/RvXsh4BDEFrZEBVzsa0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CUHNAG+SL88PmCnopUQreffbh4Rv8H8BR5k/Nghd1M4O/w5i6zuTLSCArYf8hTMmo
	 dYqmN8WmJgWacwfGQexKvcZfFrsnzYct7w4lTgAit4wnKfQjDe26HLCCTySW0qHBQs
	 5IdbgyouMNQkClDdlLJgyeSsmDfjbX9a2qEldGFY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgENRLq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 13:11:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:38248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbgENRLq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 13:11:46 -0400
Received: from localhost (unknown [122.182.193.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEB5E2065D;
        Thu, 14 May 2020 17:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589476306;
        bh=GJ+zMvzM9NaCTf4oi/AU+Wf/RvXsh4BDEFrZEBVzsa0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CzPReWBYjG7+wqnmeeEIWmeD9RWs4vL9vCYbYnotstb30e8xEP3lehH3+XYDhw1s4
         6mJDmjn7UYm6heeM8UnKzqT/DVtoYcjIOHzwhK6vs1+fyneGY6eE19SrTgs6Na/Wa0
         UQaaNk+fPqk7xWikpI8ROUyS8WTuNYVK74HY1VYQ=
Date:   Thu, 14 May 2020 22:41:30 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] clk: qcom: gdsc: Handle supply regulators
Message-ID: <20200514171130.GB14092@vkoul-mobl>
References: <20200417070044.1376212-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417070044.1376212-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-04-20, 00:00, Bjorn Andersson wrote:
> Handle supply regulators for GDSCs to allow probe deferral when regulators are
> not yet present/enabled and to allow the GDSC to enable/disable dependencies as
> needed.

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
