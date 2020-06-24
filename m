Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAFC1C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 07:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C32882084D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 07:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592983639;
	bh=/IEQjo3dkaHLyL3FMHe3F00O94pOiS2lVlYclHP0hng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=p4eOI4vVsIxHHzxePi8LPbKE8GcmwA71v3qEvY3ZB/qt/YvEtgxoJgx4OeGOdg3nq
	 manoqTU0EPSo0JgT4683agWs6IioJE0v/HYmyC+vouMvcC7666eOGhj6dSIuldrvBz
	 oGzvv5Odb5f35bRWa1YfH0Vhk8j5XESbqsSHojn4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389793AbgFXH1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 03:27:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:38556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728858AbgFXH1P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 03:27:15 -0400
Received: from localhost (unknown [171.61.66.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0921207DD;
        Wed, 24 Jun 2020 07:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592983634;
        bh=/IEQjo3dkaHLyL3FMHe3F00O94pOiS2lVlYclHP0hng=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sJUx1RIsexRztruW+f9TxU13MlXVJ7pznN2/Vmk8knlQ72ZDkTDbA9xQIN4nvWCmK
         yMRxxU9nVcGZymdMMubKAMGUsrK18AKbgbZPLk+jWXJr7PRNyFBO0Ef6lflRqi57/K
         3muyQgWvqXj+YGWgaR9gJemzXLNm87hVxjli1MKw=
Date:   Wed, 24 Jun 2020 12:57:10 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH][next] dmaengine: ti: k3-udma: Use struct_size() in
 kzalloc()
Message-ID: <20200624072710.GK2324254@vkoul-mobl>
References: <20200619224334.GA7857@embeddedor>
 <20200624055535.GX2324254@vkoul-mobl>
 <fa304f0ef1dba4fcf5e495f3c2feb4d3816f20ac.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa304f0ef1dba4fcf5e495f3c2feb4d3816f20ac.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-06-20, 22:56, Joe Perches wrote:
> On Wed, 2020-06-24 at 11:25 +0530, Vinod Koul wrote:
> > On 19-06-20, 17:43, Gustavo A. R. Silva wrote:
> > > Make use of the struct_size() helper instead of an open-coded version
> > > in order to avoid any potential type mistakes.
> > > 
> > > This code was detected with the help of Coccinelle and, audited and
> > > fixed manually.
> > > 
> > > Addresses-KSPP-ID: https://github.com/KSPP/linux/issues/83
> 
> Is this odd tag really useful?

Not at all :)

-- 
~Vinod
