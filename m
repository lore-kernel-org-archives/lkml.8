Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9685C2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 13:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD7BF217BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 13:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580996162;
	bh=KQ1zNlhQGY64IHdB8I6m2LzafLRqPGfU8AX+YoBdzQg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=P+pnqeYN+p5jcpT1PCrGpVU2m1I4mOq3VB0K7PasnS+zenke9Ax7KdG0BsQN6wUBa
	 sHwM0PIWWpD3hYLrC02EWOaH0AJ+SROqk10XiprGjGc7PgMudnHotKqLk/M8+RErms
	 QpitjFmKqbA7kFcV6m6ZqO4zzTipMKQ3L1gZus3k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgBFNgB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 08:36:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:41602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727060AbgBFNgB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 08:36:01 -0500
Received: from localhost (unknown [122.178.198.215])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 330B22082E;
        Thu,  6 Feb 2020 13:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580996161;
        bh=KQ1zNlhQGY64IHdB8I6m2LzafLRqPGfU8AX+YoBdzQg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kJBPHTJYzmbvrcRG634TwPmCRb2rG0lb2roFVEyErmRYAkCTzhIau1RYoal97rzba
         n/QItxXcTNTsnRDzk1f8fEi7JAAGN3moK1meFBhESojb+HexZiMJ2XjAiPd42H8pLi
         RmZzEcv7pEmtwCNcV4PfEZObyh/EXotjJCHKKoCk=
Date:   Thu, 6 Feb 2020 19:05:54 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dejin Zheng <zhengdejin5@gmail.com>
Cc:     peppe.cavallaro@st.com, alexandre.torgue@st.com,
        joabreu@synopsys.com, davem@davemloft.net,
        mcoquelin.stm32@gmail.com, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: stmmac: fix a possible endless loop
Message-ID: <20200206133554.GO2618@vkoul-mobl>
References: <20200206132147.22874-1-zhengdejin5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200206132147.22874-1-zhengdejin5@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-02-20, 21:21, Dejin Zheng wrote:
> It forgot to reduce the value of the variable retry in a while loop
> in the ethqos_configure() function. It may cause an endless loop and
> without timeout.

Thanks for the fix.

Acked-by: Vinod Koul <vkoul@kernel.org>

We should add:
Fixes: a7c30e62d4b8 ("net: stmmac: Add driver for Qualcomm ethqos")

Also, I think this should be CCed stable

-- 
~Vinod
