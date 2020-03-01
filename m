Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA56C3F2D1
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 16:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 226EF222C4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 16:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583079867;
	bh=sFtIWk5WhtenuAHah8mLKgj39Bwsw4QfJcapPFFcUtA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RYj6B/GvIOIS91UrkgIzQSzIR/aF0cUmZMLCk2VxySDFH9eQpfzjmCO9/KVFoOYpc
	 f1hurhIQGfFKJmkv1fXXcraCCQXUbT18QwKcXe43dqbFhlRZzgkPjrZLougXaveQed
	 QUq5wBhIEup659mY7RaJf4X38F7Lj0LUkKxo3tm4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbgCAQY0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 11:24:26 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43129 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgCAQYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 11:24:25 -0500
Received: by mail-pg1-f194.google.com with SMTP id u12so4141269pgb.10;
        Sun, 01 Mar 2020 08:24:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b9zTyAU7BXmkEe7ugpwVE5c9UwWjYoVXP/URLOq0tQ4=;
        b=AuDjDuNjYV+gcG+Bx7ABOuHm8+x8ftx8EOeFqbSxF4qIhKTGWCt21YNfNzmfvUbKr6
         Xt+TMD/HM7q8juPH5fkkdyVyHBQJ0ZqRi5QRWQGewFogEWCdVmO+G1kWBdWC80VCaDPq
         bW3yUGNW2UittcVWkRPQlgRSZ40c5kkMcBHyYvg+HHwQzLnaMLaomDZQFZokcuqOfQMx
         7DDG/xjVX3GhsOi6/nVpscg50+kQagX8b5aDs0W64VWQLQu9+HgkYEeOgLIRymNeXpKz
         p8EsgPSGvF0qhaVK504dzan3+7FFj3gQpXafPSj6KFFPhetrogGG3MQjTswsRNMM48CR
         xvWQ==
X-Gm-Message-State: APjAAAWNk54EEK9quXko+ayEScd3/vhNL0l677ydbizzs+86KY/vlCiQ
        OA47+TwW0yXH+CegVDswUTA=
X-Google-Smtp-Source: APXvYqxWX+PrxH14LmuPjZnJ/EeloN1ii+LgDFRMue3c1Vi+GQT4MhSGFu6Y1Xq17Txwcnj8byPCHg==
X-Received: by 2002:a63:1926:: with SMTP id z38mr14678948pgl.303.1583079864452;
        Sun, 01 Mar 2020 08:24:24 -0800 (PST)
Received: from localhost ([2601:647:5b00:710:c2fa:3aa3:193c:db86])
        by smtp.gmail.com with ESMTPSA id y1sm17303083pgi.56.2020.03.01.08.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 08:24:23 -0800 (PST)
Date:   Sun, 1 Mar 2020 08:24:22 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, Wu Hao <hao.wu@intel.com>
Subject: Re: [PATCH] fpga: dfl: pci: fix return value of
 cci_pci_sriov_configure
Message-ID: <20200301162422.GF7593@epycbox.lan>
References: <1582610838-7019-1-git-send-email-yilun.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582610838-7019-1-git-send-email-yilun.xu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 02:07:18PM +0800, Xu Yilun wrote:
> pci_driver.sriov_configure should return negative value on error and
> number of enabled VFs on success. But now the driver returns 0 on
> success. The sriov configure still works but will cause a warning
> message:
> 
>   XX VFs requested; only 0 enabled
> 
> This patch changes the return value accordingly.
> 
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> ---
>  drivers/fpga/dfl-pci.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
> index 89ca292..5387550 100644
> --- a/drivers/fpga/dfl-pci.c
> +++ b/drivers/fpga/dfl-pci.c
> @@ -248,11 +248,13 @@ static int cci_pci_sriov_configure(struct pci_dev *pcidev, int num_vfs)
>  			return ret;
>  
>  		ret = pci_enable_sriov(pcidev, num_vfs);
> -		if (ret)
> +		if (ret) {
>  			dfl_fpga_cdev_config_ports_pf(cdev);
> +			return ret;
> +		}
>  	}
>  
> -	return ret;
> +	return num_vfs;
>  }
>  
>  static void cci_pci_remove(struct pci_dev *pcidev)
> -- 
> 2.7.4
> 

Applied to for-next,

Thanks
