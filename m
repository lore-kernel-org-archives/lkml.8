Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA175C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 15:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E36722314
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 15:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579621303;
	bh=WX5uBua3UM4vxvRCI/rg0QKKPfvNZyvLT/tIaNLdY/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YYSLJs+zSBYxx9PH+tguU64OJQvrqCozHw050brMbzdOwQIGAo5jXwLzaBpdjAZqT
	 TtnihQ1yuOz8kh1hX4UOYfWs8y9AHoytUGV1gqJaS7bYhKR9lOr9pftId+55cVKCO4
	 lcjnzHVywTdzNfwS3P9z4pr4JcutOmBrPSSi8hQs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729423AbgAUPlm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 10:41:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:34492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729043AbgAUPlm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 10:41:42 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 407B3207E0;
        Tue, 21 Jan 2020 15:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579621301;
        bh=WX5uBua3UM4vxvRCI/rg0QKKPfvNZyvLT/tIaNLdY/Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vy8cWKcnSObFqaB6ykvi32eq74hI84H0YfTilsIWjDJqHohpet281Q3EAvp8E5ObN
         7cqrWOeijNgemEOV6xeegC0rWbEqLZOEEcaR1I9kl6quiMqZyWh8RS2FLSCeFtnK/4
         fkzGkrmGB9CduAD1sZKTHOilX/L4tglA819YU2dU=
Date:   Tue, 21 Jan 2020 16:41:39 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Ooi, Joyce" <joyce.ooi@intel.com>
Cc:     "Loh, Tien Hock" <tien.hock.loh@intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "See, Chin Liang" <chin.liang.see@intel.com>,
        "Tan, Ley Foon" <ley.foon.tan@intel.com>
Subject: Re: [PATCH] MAINTAINERS: Replace Tien Hock Loh as Altera PIO
 maintainer
Message-ID: <20200121154139.GA588670@kroah.com>
References: <20200103170155.100743-1-joyce.ooi@intel.com>
 <SN6PR11MB2750CD8233FF8F14B006B343BD390@SN6PR11MB2750.namprd11.prod.outlook.com>
 <BL0PR11MB289899043DC031AE4DB21AA8F20D0@BL0PR11MB2898.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL0PR11MB289899043DC031AE4DB21AA8F20D0@BL0PR11MB2898.namprd11.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 08:06:23AM +0000, Ooi, Joyce wrote:
> Hi Greg,
> 
> Can you please add my name to the maintainer list if there is no concern? Thanks.

Why me?  I am not the gpio maintainer...

