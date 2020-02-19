Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB50C34056
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 18:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 950AE24671
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 18:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582137980;
	bh=V0/0RXn2CjSi+e6U4mKdjZ80KfPSNX+qhYddvJb3vKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=J+HG3GSxGcCY24QIiVHur9+sfo2EvA+5qOrKDA8Hqt0n4Qnz/qtVASXa+XuqOwxqy
	 qAHJdsouif0a/qBSahmDpSZ1dqRelNmIEkr3o5wosCADAJwk0Rl9Aeb5Bvc0229L5V
	 /zCNfVFQdVeCwXQnU7Oo61LN6rzcnD0hB+fTudOo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbgBSSqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 13:46:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:35902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726634AbgBSSqT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 13:46:19 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 209BB24670;
        Wed, 19 Feb 2020 18:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582137978;
        bh=V0/0RXn2CjSi+e6U4mKdjZ80KfPSNX+qhYddvJb3vKc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rLFw+mv5jHMginBd7XU0pCop7fnJiuFjCusQ4+LY5MMMXsaMJr2qw7hnT9nfOnGLJ
         u9S3wmmP1JgMmnw9O7OhHmlQhuVqajyWaIEA/0cUGwrCRlXfBG1v5WhH0Pf6YvtmuJ
         SZKGF0zPYo0QkDy0yFTM9fxxTEoDfTW2kb7BcPkM=
Date:   Wed, 19 Feb 2020 19:46:16 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kaaira Gupta <kgupta@es.iitr.ac.in>
Cc:     Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: comedi: change CamelCase to CAPS
Message-ID: <20200219184616.GA2854654@kroah.com>
References: <20200219174646.GA27559@kaaira-HP-Pavilion-Notebook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219174646.GA27559@kaaira-HP-Pavilion-Notebook>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 11:16:46PM +0530, Kaaira Gupta wrote:
> fix checkpatch.pl check of 'Avoid CamelCase' by changing NI_CtrSource to
> NI_CTRSOURCE in all the files. Change it to CAPS because it is a MICRO

What is a "MICRO"?

> Signed-off-by: Kaaira Gupta <kgupta@es.iitr.ac.in>

Are you sure this is ok?  I think this comes directly from a spec sheet
so changing it might not be good.

as proof:

> @@ -104,7 +104,7 @@ struct ni_device_routes ni_pci_6070e_device_routes = {
>  		{
>  			.dest = TRIGGER_LINE(0),
>  			.src = (int[]){
> -				NI_CtrSource(0),
> +				NI_CTRSOURCE(0),
>  				NI_CtrGate(0),
>  				NI_CtrInternalOutput(0),
>  				NI_CtrOut(0),

Looks like all of these are CamelCase, why are you changing only one?
They all should be the same, and odds are, how they are today is fine,
right?

Look at the git history of these files to be sure.

thanks,

greg k-h
