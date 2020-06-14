Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 239DFC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 06:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3A5C206D7
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 06:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592116635;
	bh=CqiJHndOITylQyFknB3HhhThYqsFY4mizwwhaZKhX9c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BHAwVK6LZnI7Xz1IzkP0veYzFczS7O0aAkVULfIOilpsGkWTwAzM+1qVDiccZy1ql
	 npp9rCR2U/XYXwv76fr2/SDxe/c18Ro88x4FWl7lOSf7LeG667XVDIBwqZ16ydkz3+
	 i4hNdqstlckS+EIQa6W5nWbMLsSrDylX0kZzl4HI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgFNGhN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 02:37:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:51654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725265AbgFNGhN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 02:37:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50ABA206D7;
        Sun, 14 Jun 2020 06:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592116632;
        bh=CqiJHndOITylQyFknB3HhhThYqsFY4mizwwhaZKhX9c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t8qGhmZXyUXTysKPfZlfnxvnfqki9d8pMh36+YwV+2ej10UvPg6aDcG7syfXe7LUq
         9TnSRL3HtZkBDxO3x32XOlo34CEyES3hlBEyID88x6l6IINlKPKCRPEbRHyruqb+0K
         bUc3A5qnbnlpqFU/D7pm2zTTLWEahRGzMaSl6p48=
Date:   Sun, 14 Jun 2020 08:37:10 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4 2/3] venus: Make debug infrastructure more flexible
Message-ID: <20200614063710.GB2611869@kroah.com>
References: <20200613223919.7038-1-stanimir.varbanov@linaro.org>
 <20200613223919.7038-3-stanimir.varbanov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200613223919.7038-3-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 14, 2020 at 01:39:18AM +0300, Stanimir Varbanov wrote:
>  	if (slot == -1) {
> -		dev_dbg(inst->core->dev, "%s: no free slot\n", __func__);
> +		VDBGH("no free slot for timestamp\n");

Again, no, you just lost a lot of valuable information by changing to a
different format (like driver, specific device, etc.).  Please don't do
this, it just makes the information less than before.

thanks,

greg k-h
