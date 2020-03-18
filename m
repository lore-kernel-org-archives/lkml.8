Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F13C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 11:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7443020770
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 11:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584532305;
	bh=rs4bW0ZkVYcjeCL/A3Dq7xVlHy1e1mmqD+dUYRHTOV4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=u00JZsp3i1xUr6u0iDre0BfWaxriBfjDaIjijQXQKg3jy9Lp97CqaDlgrYxjQY4Zq
	 7AREbRT6lTqUVtqjY3uQATOkOi4Kgsp9VUcms0CI8ey4J214XBvjqqFe6fEHkB3Ao5
	 c8DWSBARn4iRkTTFXsoZXoyT1YlWNvl2Lvoui7Xo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbgCRLvo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 07:51:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:60968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726586AbgCRLvo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 07:51:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 194272076D;
        Wed, 18 Mar 2020 11:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584532303;
        bh=rs4bW0ZkVYcjeCL/A3Dq7xVlHy1e1mmqD+dUYRHTOV4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UA5oJmRW1Y3nkwrN+PxYHwOUwy7KCIYjMDZpxhQ7+8l7cn585mnhCDiCwkUg2uNqj
         1M9zGCSCFbixeD2m6QHFMuJojACUIlZ8IGdXEbzT7iuMdV3r9/4AgZosWCL510hsHf
         G1yXGg9Gp1cOWzeFnTaUcV5nzK0asQVaoRwE25WQ=
Date:   Wed, 18 Mar 2020 12:51:41 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jolly Shah <jolly.shah@xilinx.com>
Cc:     ard.biesheuvel@linaro.org, mingo@kernel.org,
        matt@codeblueprint.co.uk, sudeep.holla@arm.com,
        hkallweit1@gmail.com, keescook@chromium.org,
        dmitry.torokhov@gmail.com, michal.simek@xilinx.com,
        rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rajan Vaja <rajan.vaja@xilinx.com>
Subject: Re: [PATCH v3 20/24] firmware: xilinx: Add APIs to read/write
 GGS/PGGS registers
Message-ID: <20200318115141.GB2472686@kroah.com>
References: <1583538452-1992-1-git-send-email-jolly.shah@xilinx.com>
 <1583538452-1992-21-git-send-email-jolly.shah@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583538452-1992-21-git-send-email-jolly.shah@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 06, 2020 at 03:47:28PM -0800, Jolly Shah wrote:
> --- a/include/linux/firmware/xlnx-zynqmp.h
> +++ b/include/linux/firmware/xlnx-zynqmp.h
> @@ -105,6 +105,10 @@ enum pm_ioctl_id {
>  	IOCTL_GET_PLL_FRAC_MODE,
>  	IOCTL_SET_PLL_FRAC_DATA,
>  	IOCTL_GET_PLL_FRAC_DATA,
> +	IOCTL_WRITE_GGS,
> +	IOCTL_READ_GGS,
> +	IOCTL_WRITE_PGGS,
> +	IOCTL_READ_PGGS,

You do not have explicit numbers here?  Bold :)

greg k-h
