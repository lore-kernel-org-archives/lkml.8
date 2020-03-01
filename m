Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C08C3F2CD
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 16:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB0FF222C4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 16:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583079809;
	bh=FGyHgCll20nxD/0teXTpNRKac+kCq+aGdwbkatZOtEQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Eo72Hp2AYt3cMIV+WlIxCPYyZCb0FvmMfeXaDzfsN4V/FOGoQUE3rOnsu7+8wPJ+w
	 lKH6n0n21ZxhmZtnbnY0oXLhnp5IffCQqA+lU+GgonZZUQmmxL8W95QcMt2nYoMjyq
	 /mpx+zFTqrKvNOfwu6nZxE/HQ9pCvLa9GpUMPs30=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgCAQX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 11:23:28 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:36729 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgCAQX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 11:23:28 -0500
Received: by mail-pj1-f66.google.com with SMTP id d7so391544pjw.1;
        Sun, 01 Mar 2020 08:23:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sGDHMYa2zIpllxKVtEh6fLENFNHlRZiC8UQBM60H7b0=;
        b=NpXGjNkGyJSNnzBo+zk0JcCiUR07a2PzjbAkD2mJKwMczazoUHOjAOSpaYDW74vUV5
         2nnKUS2PAILHxBPXlGpuxF5IO0nmYO+7f5937WPjIAAyOIH6GROaxK8WXTXuyJ1dbSxB
         rXkC/hOpvFE8mK9vbrJqzBjfsjR7X3mO9zpwlKpt28pkjDydb8CjhqKUp9yd5fUJDwFm
         7TQ3A46bHn7/DAbId8uWJz+Q/j/DAigFptDV8erVaybRtirC5wcLXfJIcJF2bYhtfu1j
         Ugy5U08jIUopbyg1lcu7hj/f5sPcNbXyMKzrsUGL5FCnhdQGU2d+U9tU72icXLfQ1aIB
         nOuQ==
X-Gm-Message-State: APjAAAXUYfKH40DSeN4fdtXBxbRbC31BoqHIl2Sf2MLkLwoU1ygtH9gl
        q+1pop2WV0k9r5s7Am4Vd18=
X-Google-Smtp-Source: APXvYqwszWP0QkrO80UloQcOBsxCtbGfjx/E89FFLPOTlDqev5jXQxxJpaxFcvO4gaQxDMdd79/Avw==
X-Received: by 2002:a17:90a:a005:: with SMTP id q5mr15884127pjp.103.1583079807151;
        Sun, 01 Mar 2020 08:23:27 -0800 (PST)
Received: from localhost ([2601:647:5b00:710:c2fa:3aa3:193c:db86])
        by smtp.gmail.com with ESMTPSA id z13sm17768824pge.29.2020.03.01.08.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 08:23:26 -0800 (PST)
Date:   Sun, 1 Mar 2020 08:23:25 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     richard.gong@linux.intel.com
Cc:     gregkh@linuxfoundation.org, mdf@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, dinguyen@kernel.org,
        linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Richard Gong <richard.gong@intel.com>
Subject: Re: [PATCHv1 2/7] arm64: dts: agilex: correct FPGA manager driver's
 compatible value
Message-ID: <20200301162325.GE7593@epycbox.lan>
References: <1581696052-11540-1-git-send-email-richard.gong@linux.intel.com>
 <1581696052-11540-3-git-send-email-richard.gong@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581696052-11540-3-git-send-email-richard.gong@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 10:00:47AM -0600, richard.gong@linux.intel.com wrote:
> From: Richard Gong <richard.gong@intel.com>
> 
> Correct the compatible property value for FPGA manager driver on
> Intel Agilex SoC platform.
> 
> Signed-off-by: Richard Gong <richard.gong@intel.com>
> ---
>  arch/arm64/boot/dts/intel/socfpga_agilex.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
> index e1d357e..8c29853 100644
> --- a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
> +++ b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
> @@ -544,7 +544,7 @@
>  				memory-region = <&service_reserved>;
>  
>  				fpga_mgr: fpga-mgr {
> -					compatible = "intel,stratix10-soc-fpga-mgr";
> +					compatible = "intel,agilex-soc-fpga-mgr";
>  				};
>  			};
>  		};
> -- 
> 2.7.4
> 
Applied to for-next,

Thanks
