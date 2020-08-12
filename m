Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE6EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 16:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89C962076B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 16:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgHLQNA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 12:13:00 -0400
Received: from smtprelay0087.hostedemail.com ([216.40.44.87]:46150 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726394AbgHLQM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 12:12:59 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 03A5618224D6A;
        Wed, 12 Aug 2020 16:12:59 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: bikes50_180d8bd26fec
X-Filterd-Recvd-Size: 1729
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Wed, 12 Aug 2020 16:12:57 +0000 (UTC)
Message-ID: <89523042b8d574fa49e7d5c52ec12f1f5f848773.camel@perches.com>
Subject: Re: [PATCH 20/44] staging: mfd: hi6421-spmi-pmic: fix some coding
 style issues
From:   Joe Perches <joe@perches.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org
Date:   Wed, 12 Aug 2020 09:12:56 -0700
In-Reply-To: <867108ee50302f933fade56f8c25ef775ade36b3.1597247164.git.mchehab+huawei@kernel.org>
References: <cover.1597247164.git.mchehab+huawei@kernel.org>
         <867108ee50302f933fade56f8c25ef775ade36b3.1597247164.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-08-12 at 17:56 +0200, Mauro Carvalho Chehab wrote:
> Checkpatch complains about some minor issues inside this
> driver that were not addressed by the previous patch.
> 
> Address them.
[]
> diff --git a/include/linux/mfd/hi6421-spmi-pmic.h b/include/linux/mfd/hi6421-spmi-pmic.h
[]
> @@ -38,7 +38,8 @@ struct hi6421_spmi_pmic {
>  	unsigned int				*irqs;
>  	int					irqnum;
>  	int					irqarray;
> -	struct hi6421_spmi_irq_mask_info 	irq_mask_addr;
> +
> +	struct hi6421_spmi_irq_mask_info	irq_mask_addr;
>  	struct hi6421_spmi_irq_info		irq_addr;
>  };

Was adding a blank line one of checkpatch complaints?
I doubt it. 

