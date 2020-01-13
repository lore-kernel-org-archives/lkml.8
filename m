Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B4EC33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 15:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 880552187F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 15:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578928436;
	bh=k37G7crg/rnM1OPMgaFjdTDn+Y4irTU6HvEVxVieUjM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=NceGfSuW+xrRpn1SVbjcB0liMSCX6Jq5Gdtj6yrycIPKd/mPOrTjAIhcW6qbYYOJx
	 +eD0aOMWaXBi6534DqR5bdPUeTsQHkebGuguJ4+HKzrR0bhapbI7pSTx7eYGTL6fOA
	 XZLYw4XV4J78QMzcNA/4e+9TuYy+qr7S7j1pRZI8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729285AbgAMPNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 10:13:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:39932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726567AbgAMPNy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 10:13:54 -0500
Received: from cakuba (unknown [172.58.35.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E949207E0;
        Mon, 13 Jan 2020 15:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578928434;
        bh=k37G7crg/rnM1OPMgaFjdTDn+Y4irTU6HvEVxVieUjM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2hwwdBpUxEHlF/MjAnrClMUvpSXE0hViNfyJbeItXwrJg/UYJfNs7k4g0NTGgL4qg
         oB47bgNla0FdArsPtX9RFkZtKktMmYBl6EAK5tKv6DMGQWLM3whpFWy2ndFngr58H1
         e/SiSW/FESxRge2qm/qM6l5ZH530SABcPO51G5uQ=
Date:   Mon, 13 Jan 2020 07:12:51 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Jose Abreu <Jose.Abreu@synopsys.com>
Cc:     netdev@vger.kernel.org, Joao Pinto <Joao.Pinto@synopsys.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        "David S. Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/8] net: stmmac: tc: Add support for ETF
 Scheduler using TBS
Message-ID: <20200113071251.1d9d51f6@cakuba>
In-Reply-To: <4a4290706a9166d67d2d455dfa9d5f259699a036.1578920366.git.Jose.Abreu@synopsys.com>
References: <cover.1578920366.git.Jose.Abreu@synopsys.com>
        <4a4290706a9166d67d2d455dfa9d5f259699a036.1578920366.git.Jose.Abreu@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jan 2020 14:02:37 +0100, Jose Abreu wrote:
> +static int tc_setup_etf(struct stmmac_priv *priv,
> +			struct tc_etf_qopt_offload *qopt)
> +{
> +

There's a couple places I spotted where continuation lines are not
aligned to the opening parenthesis, and here we have a spurious blank
line. Please run this through checkpatch --strict, I see quite a few
legit errors there.
