Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BCBC34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 09:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3CF4206E2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 09:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582018707;
	bh=wN2JB0HJOjbQl/J39ymDQJ32DK1gzowbEoZAxeaoJwU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xfJrRrhOIbECAac8yf3/sHR/bTarHcd4YW6D2/ziYkx1crC6607iPTW1ndbKJu8rf
	 9mPtB68y4y0enfPKNJG8uf4Db0BGCwHmPlovWI1nqvvTyTEljtdy8B0svoMbYP7pUg
	 7Mv/tfOy7c7wyFcmosEAg1dA9UiNykHindNSw+Io=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgBRJi0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 04:38:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:44080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726539AbgBRJiY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 04:38:24 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D56C5206E2;
        Tue, 18 Feb 2020 09:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582018704;
        bh=wN2JB0HJOjbQl/J39ymDQJ32DK1gzowbEoZAxeaoJwU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v4LNxdHGj6cz++0BF3KqsO5JRRU1gQlsjgXrZU7ucabAD+RqnMFycvRl/BcYq+mq2
         rysMF5EGJHzDWOBCz86+gzh4xy/U1Mb6TlcOPWVesLec18RlkuDGblYKKe6qpbPYe2
         psdXLMcbgHHAh4VECtx9w7vBrxcT0Za20fPIAH7s=
Date:   Tue, 18 Feb 2020 17:38:18 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>
Subject: Re: linux-next: build failure after merge of the imx-mxs tree
Message-ID: <20200218093817.GD6075@dragon>
References: <20200218130859.3deb3404@canb.auug.org.au>
 <AM0PR04MB4481EE01C21245B588A9EDAD88110@AM0PR04MB4481.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR04MB4481EE01C21245B588A9EDAD88110@AM0PR04MB4481.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 02:18:00AM +0000, Peng Fan wrote:
> 
> > Subject: linux-next: build failure after merge of the imx-mxs tree
> 
> Sorry for this. I'll fix it. It should be the functions not defined when
> IMX_SCU not defined.

I'm dropping the patch from my branch for now.

Shawn
