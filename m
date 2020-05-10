Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97032C54E8A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 09:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 771B9208E4
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 09:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589104563;
	bh=cQSr1HS81+V30WagzCd/YqqVCmaLXvKM/9B2aSABrlY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=RlWpUyQ2c2Yh7kP8XTVNX7af4+TmhUMF0pu26Csc/PW7uGgkgRXQr0kwYHRkYC2VH
	 e9bjBDa2K12mTHLiAjFttaPmV2x5nZ6+gXxIkls1uDTCO6ai4Kj4ghH93siQpaH9X5
	 yhhLh3DGgyYy/MGzow9emsfg67g/MxC08jBHRP/8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbgEJJ4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 05:56:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:58164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725994AbgEJJ4C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 05:56:02 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 482AA20820;
        Sun, 10 May 2020 09:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589104562;
        bh=cQSr1HS81+V30WagzCd/YqqVCmaLXvKM/9B2aSABrlY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=q1wnvjDzywli3oofFSy4iomVjMB8Eo8elFHYjtawRagYiMi+4FzYyi/QWRG71L0+v
         2Bj7kaGjy87aAEiqsxTtli3mc8yhN3gIrx2GwFe54FjgwLyGufmh2ilCbVUlUnaoqq
         PZF7bztSGvH1oHr2RUz0uXX1T+uHOjvQAZPpaAww=
Date:   Sun, 10 May 2020 10:55:57 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] iio: sca3000: Remove an erroneous get_device() call in
 sca3000_read_data()
Message-ID: <20200510105557.716fa742@archlinux>
In-Reply-To: <6e972e9b-c799-f0ad-91ac-144640b463f6@web.de>
References: <6e972e9b-c799-f0ad-91ac-144640b463f6@web.de>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 May 2020 17:30:06 +0200
Markus Elfring <Markus.Elfring@web.de> wrote:

> > This looks really unusual to have a 'get_device()' hidden in a 'dev_err()' call.  
> 
> Is there a need to prevent similar function calls by the means of
> advanced source code analysis?

It's a seriously stupid bug so I'd have thought unlikely to
occur often enough to be worth it.

Jonathan

> 
> Regards,
> Markus

