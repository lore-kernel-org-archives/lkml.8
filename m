Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8DBCC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 18:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DD78206E2
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 18:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594231974;
	bh=hvKRNfMyeBHu/9wm0SV0OGAY0ZTvVFSZ4zLaUgL4D4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fWbXDRxWpzpECANzyavD4ivfFrF+boj1ZH4XCuLo81dSil4s8BnAMNE4tRzcwH5mu
	 bvLLy7Ct3iDp6GQLNwRrBl5nlJ6z1zBffqNU2gSZsCAAW7PqTncIc5p1RP89BN837C
	 GkfGNlV50lBKhYjlSn+nDrcyzwPbYntmTnLga9Hg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgGHSMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 14:12:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:38320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbgGHSMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 14:12:53 -0400
Received: from embeddedor (unknown [201.162.240.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 179A0206E2;
        Wed,  8 Jul 2020 18:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594231972;
        bh=hvKRNfMyeBHu/9wm0SV0OGAY0ZTvVFSZ4zLaUgL4D4Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v7WF6GK1CVpZTjId5iLA3pc1zVqEXX8wfP7oXm8NcW0yA0JGMaYuOAd08ujbAFWne
         1YvWI0WL7LAW5WKpUn+VkEKoBU7+vdthnCwrLLCcbciImkKAgBbHA6hJVLrS8pbWnT
         Z2qX1ml7O63udmj29ud1mjjsT0zxtImrefnJShHM=
Date:   Wed, 8 Jul 2020 13:18:21 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     David Miller <davem@davemloft.net>
Cc:     jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kuba@kernel.org
Subject: Re: [PATCH][next] net/sched: Use fallthrough pseudo-keyword
Message-ID: <20200708181821.GD11533@embeddedor>
References: <20200707172138.GA27126@embeddedor>
 <20200707.154805.1403371276897720695.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707.154805.1403371276897720695.davem@davemloft.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 03:48:05PM -0700, David Miller wrote:
> From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Date: Tue, 7 Jul 2020 12:21:38 -0500
> 
> > Replace the existing /* fall through */ comments and its variants with
> > the new pseudo-keyword macro fallthrough[1]. Also, remove unnecessary
> > fall-through markings when it is the case.
> > 
> > [1] https://www.kernel.org/doc/html/latest/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through
> > 
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> Applied, thanks.

Thanks, Dave.

--
Gustavo
