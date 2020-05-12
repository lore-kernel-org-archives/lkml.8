Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2147ECA90AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 18:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6A8220714
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 18:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589306430;
	bh=6ybMNosTnj9A54T0sdFcdYBIPDjIp0M+eT+TUICpV2w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tjn2mUAXKZQjbp6Rl1EdsvxNsvw3+sUqv+NGdbMqofLePabUTq858AP45UF9KB3bF
	 0CPJUX6lM1D5OPGfkryddBMfa+wIs5xrf2vDWul6NBf/lvNaekAIz3SywRuKzgApzK
	 7jSqwxy1hCyzRFV75Rwi/WoZO3iS2RW4qMRumG+g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730344AbgELSA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 14:00:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:50246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbgELSA2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 14:00:28 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BE5120673;
        Tue, 12 May 2020 18:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589306428;
        bh=6ybMNosTnj9A54T0sdFcdYBIPDjIp0M+eT+TUICpV2w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tOsFO3YzqYyRmheH0sY74sFTrSLKlnO3Hn5fsEb1aAvpWlBC9MIn/3loRl2hS3v3P
         Y9sbCZ77tH0JCDf/sFaSQalmSEMV0KUwRijxggCY64blFndf7HcHEFczCF8YMrePD2
         avFvFVMQQnC1XmF54L2JirNk5aXQ+Bxey4fybnJg=
Date:   Tue, 12 May 2020 13:05:02 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     David Miller <davem@davemloft.net>
Cc:     sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sparc64: Replace zero-length array with flexible-array
Message-ID: <20200512180502.GC4897@embeddedor>
References: <20200507192302.GA16402@embeddedor>
 <20200507.184916.273108688700388097.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507.184916.273108688700388097.davem@davemloft.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 06:49:16PM -0700, David Miller wrote:
> From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Date: Thu, 7 May 2020 14:23:02 -0500
> 
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> Applied, thank you.

Thanks, Dave.

--
Gustavo
