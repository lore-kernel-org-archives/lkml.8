Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BCAEC34022
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 07:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30480222D9
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 07:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582097752;
	bh=fX6KRM1X5Jo5RsKxZDPRp/cqOi3EYu6e+t9QUMDjriI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OPZc5RGZrEXl6VwuCzCfd/9AJTfi6mlKnmFycUCXOrarzesii5ezkB6/Tv++s5hUe
	 YmO0j/1YLKlfdJvRc0sEPZVevZR4PVf1G94GdSB80b3gk7bn4n24GHOWS3wDMbhwII
	 s0Ig7eDxWpo9ne5I1WooMiU60JS6CMxtw04rIoVA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgBSHfv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 02:35:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:52936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726548AbgBSHfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 02:35:50 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D36D52176D;
        Wed, 19 Feb 2020 07:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582097750;
        bh=fX6KRM1X5Jo5RsKxZDPRp/cqOi3EYu6e+t9QUMDjriI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nbpaBGt2aLkLH3ZuPkT6aBpFHK2ZLlle7+OW+GguJBosgroGRskPpVF9whQNGQsvI
         PEAFOezHGk/veRsnuLPNdfMdanf5cO+9GFAZGqMeIqp4prWGMMB5KEATX+Q4tEl5y7
         2QLp1KlAYcoFv+hHFmO9ZlA/wx+Poo4n4lIDq4V8=
Date:   Wed, 19 Feb 2020 08:35:48 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vitor Soares <Vitor.Soares@synopsys.com>
Cc:     linux-kernel@vger.kernel.org, linux-i3c@lists.infradead.org,
        Joao.Pinto@synopsys.com, Jose.Abreu@synopsys.com,
        bbrezillon@kernel.org, wsa@the-dreams.de, arnd@arndb.de,
        broonie@kernel.org, corbet@lwn.net
Subject: Re: [PATCH v3 3/5] i3c: master: add i3c_for_each_dev helper
Message-ID: <20200219073548.GA2728338@kroah.com>
References: <cover.1582069402.git.vitor.soares@synopsys.com>
 <868e5b37fd817b65e6953ed7279f5063e5fc06c5.1582069402.git.vitor.soares@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <868e5b37fd817b65e6953ed7279f5063e5fc06c5.1582069402.git.vitor.soares@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 01:20:41AM +0100, Vitor Soares wrote:
> Introduce i3c_for_each_dev(), an i3c device iterator for use by i3cdev.
> 
> Signed-off-by: Vitor Soares <vitor.soares@synopsys.com>
> ---
>  drivers/i3c/internals.h |  1 +
>  drivers/i3c/master.c    | 12 ++++++++++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/drivers/i3c/internals.h b/drivers/i3c/internals.h
> index bc062e8..a6deedf 100644
> --- a/drivers/i3c/internals.h
> +++ b/drivers/i3c/internals.h
> @@ -24,4 +24,5 @@ int i3c_dev_enable_ibi_locked(struct i3c_dev_desc *dev);
>  int i3c_dev_request_ibi_locked(struct i3c_dev_desc *dev,
>  			       const struct i3c_ibi_setup *req);
>  void i3c_dev_free_ibi_locked(struct i3c_dev_desc *dev);
> +int i3c_for_each_dev(void *data, int (*fn)(struct device *, void *));
>  #endif /* I3C_INTERNAL_H */
> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> index 21c4372..8e22da2 100644
> --- a/drivers/i3c/master.c
> +++ b/drivers/i3c/master.c
> @@ -2640,6 +2640,18 @@ void i3c_dev_free_ibi_locked(struct i3c_dev_desc *dev)
>  	dev->ibi = NULL;
>  }
>  
> +int i3c_for_each_dev(void *data, int (*fn)(struct device *, void *))
> +{
> +	int res;
> +
> +	mutex_lock(&i3c_core_lock);
> +	res = bus_for_each_dev(&i3c_bus_type, NULL, data, fn);
> +	mutex_unlock(&i3c_core_lock);

Ick, why the lock?  Are you _sure_ you need that?  The core should
handle any list locking issues here, right?

I don't see bus-specific-locks around other subsystem functions that do
this (like usb_for_each_dev).

thanks,

greg k-h
