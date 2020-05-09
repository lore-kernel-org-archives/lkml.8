Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F6D0C38A2A
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 01:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D65912192A
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 01:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588989245;
	bh=U+oZAKvfEcBrfRy9eyomxP9xIkvNuHokIR9NHxLx7Zc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=VDaC6s7P5KrnkDFBAze4by+RIns5sI3CV1aC3L5LS+KtRj8DrbRmivI7iJ5+ql2ne
	 8p/JzXQProBzkONrqTzu0j6yUdvIWDd0EgFQ01A1oQYG3rhjpU/G4jsuGy+bzyrWZJ
	 t4D2GeyLS8+AgXuwhjTaqjKN/g+968Eqy08lOxww=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbgEIByE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 21:54:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:49306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727828AbgEIByE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 21:54:04 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C534E218AC;
        Sat,  9 May 2020 01:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588989244;
        bh=U+oZAKvfEcBrfRy9eyomxP9xIkvNuHokIR9NHxLx7Zc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cGn2b3P5tW4EYFTSJEN81nzCiav1F+xOpHytKoNr7DJqbCPbBFkFnaFbH9Gk1kA96
         tBCcbKMxGr5vccRKF/qQAny0phnH+kO9kQS2zMQkdQBkKFeMDJzVsGNj+47oDxIjlk
         rvYb2vT9rVgskaDm3E0Doe6mpomM86q5TOYF1gUE=
Date:   Fri, 8 May 2020 18:54:02 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     davem@davemloft.net, fthain@telegraphics.com.au,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] net/sonic: Fix some resource leaks in error handling
 paths
Message-ID: <20200508185402.41d9d068@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200508172557.218132-1-christophe.jaillet@wanadoo.fr>
References: <20200508172557.218132-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  8 May 2020 19:25:57 +0200 Christophe JAILLET wrote:
> @@ -527,8 +531,9 @@ static int mac_sonic_platform_remove(struct platform_device *pdev)
>  	struct sonic_local* lp = netdev_priv(dev);
>  
>  	unregister_netdev(dev);
> -	dma_free_coherent(lp->device, SIZEOF_SONIC_DESC * SONIC_BUS_SCALE(lp->dma_bitmode),
> -	                  lp->descriptors, lp->descriptors_laddr);
> +	dma_free_coherent(lp->device,
> +			  SIZEOF_SONIC_DESC * SONIC_BUS_SCALE(lp->dma_bitmode),
> +			  lp->descriptors, lp->descriptors_laddr);
>  	free_netdev(dev);
>  
>  	return 0;

This is a white-space only change, right? Since this is a fix we should
avoid making cleanups which are not strictly necessary.
