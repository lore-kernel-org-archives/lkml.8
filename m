Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B6AC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 21:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EF312070E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 21:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595021773;
	bh=9/FdhTq39PmyIKiHwQV4Tapn4Byu26rw3gOTHxdJiXU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=fbmunkssWsngsd5Ah05Jt0CM8xfPiQtWnWmv3R0wNkCu56/enJywQbzyMQ/3FbUYL
	 YHOOvEO0+c7atmw2/mXjTQGOIZAT5TOyrqIB3w6WRXNI1y+tpG2PVARCwR1H8RIHXx
	 Q993dFGCCnaiJYg9L7NWxls4ZrvTEDrapzrXSjgU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbgGQVgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 17:36:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:36906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726204AbgGQVgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 17:36:11 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D0E72064B;
        Fri, 17 Jul 2020 21:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595021771;
        bh=9/FdhTq39PmyIKiHwQV4Tapn4Byu26rw3gOTHxdJiXU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=xOYY+B2BspFSPIRldzafzYIVDpdDBgoVLAfiLd97RZh+ss+QnQ2u4f8j13ryBT/kg
         IAl2krY3716AedBcw+5BlOR0grWmuo7aAdOV9WUvEKZmnpr1eaWwx1+2Xk378Y3JIr
         z1SF1IeANi4JledkyK+u+ttVb1v+XwMl+O/6yXuA=
Date:   Fri, 17 Jul 2020 16:36:09 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, guohanjun@huawei.com
Subject: Re: [PATCH] PCI/ASPM: add missing newline when printing parameter
 'policy' by sysfs
Message-ID: <20200717213609.GA774873@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594972765-10404-1-git-send-email-wangxiongfeng2@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 03:59:25PM +0800, Xiongfeng Wang wrote:
> When I cat ASPM parameter 'policy' by sysfs, it displays as follows.
> It's better to add a newline for easy reading.
> 
> [root@localhost ~]# cat /sys/module/pcie_aspm/parameters/policy
> [default] performance powersave powersupersave [root@localhost ~]#
> 
> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>

Applied to pci/aspm for v5.9, thanks!

> ---
>  drivers/pci/pcie/aspm.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index b17e5ff..253c30c 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -1182,6 +1182,7 @@ static int pcie_aspm_get_policy(char *buffer, const struct kernel_param *kp)
>  			cnt += sprintf(buffer + cnt, "[%s] ", policy_str[i]);
>  		else
>  			cnt += sprintf(buffer + cnt, "%s ", policy_str[i]);
> +	cnt += sprintf(buffer + cnt, "\n");
>  	return cnt;
>  }
>  
> -- 
> 1.7.12.4
> 
