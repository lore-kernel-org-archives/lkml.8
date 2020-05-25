Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B17DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 19:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 709EE20723
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 19:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XzCcfLD7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389985AbgEYThy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 15:37:54 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26910 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390069AbgEYThx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 15:37:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590435472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Aw+P2gJN5/FUhrBwNIybhDRUm5TXXBpyMiHMjIF9NwY=;
        b=XzCcfLD7q6PrU6w9voN2+GeDdZh+qnm8ck9T9WG3SCDccnCFcPDuU49w2kaLwAlRyeU3je
        H3h7yK/f4GoyT2/d3JqRyi1ZW+i89eDd+7VsVcdgIyOkPB2B0xr9lv/nVOvyPlLUXQLgll
        hYJGRTfht9n7Q8DTUJ8i7Y8ZhBW/sWg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-ZNJno5OdPFKuw-aydWN_Sg-1; Mon, 25 May 2020 15:37:51 -0400
X-MC-Unique: ZNJno5OdPFKuw-aydWN_Sg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EDBB48015D1;
        Mon, 25 May 2020 19:37:49 +0000 (UTC)
Received: from fuller.cnet (ovpn-116-16.gru2.redhat.com [10.97.116.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A921260BE1;
        Mon, 25 May 2020 19:37:49 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id BAF35416CE4F; Mon, 25 May 2020 16:35:50 -0300 (-03)
Date:   Mon, 25 May 2020 16:35:50 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, trix@redhat.com, bhu@redhat.com,
        Luwei Kang <luwei.kang@intel.com>, Wu Hao <hao.wu@intel.com>
Subject: Re: [PATCH v5 7/7] Documentation: fpga: dfl: add descriptions for
 interrupt related interfaces.
Message-ID: <20200525193550.GG22266@fuller.cnet>
References: <1587370303-25568-1-git-send-email-yilun.xu@intel.com>
 <1587370303-25568-8-git-send-email-yilun.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587370303-25568-8-git-send-email-yilun.xu@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 04:11:43PM +0800, Xu Yilun wrote:
> This patch adds introductions of interrupt related interfaces for FME
> error reporting, port error reporting and AFU user interrupts features.
> 
> Signed-off-by: Luwei Kang <luwei.kang@intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Acked-by: Wu Hao <hao.wu@intel.com>
> ----
> v2: Update Documents cause change of irq ioctl interfaces.
> v3: No change
> v4: Update interrupt support part.
> v5: No change
> ---
>  Documentation/fpga/dfl.rst | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
> index 094fc8a..702bf62 100644
> --- a/Documentation/fpga/dfl.rst
> +++ b/Documentation/fpga/dfl.rst
> @@ -89,6 +89,8 @@ The following functions are exposed through ioctls:
>  - Program bitstream (DFL_FPGA_FME_PORT_PR)
>  - Assign port to PF (DFL_FPGA_FME_PORT_ASSIGN)
>  - Release port from PF (DFL_FPGA_FME_PORT_RELEASE)
> +- Get number of irqs of FME global error (DFL_FPGA_FME_ERR_GET_IRQ_NUM)
> +- Set interrupt trigger for FME error (DFL_FPGA_FME_ERR_SET_IRQ)
>  
>  More functions are exposed through sysfs
>  (/sys/class/fpga_region/regionX/dfl-fme.n/):
> @@ -144,6 +146,10 @@ The following functions are exposed through ioctls:
>  - Map DMA buffer (DFL_FPGA_PORT_DMA_MAP)
>  - Unmap DMA buffer (DFL_FPGA_PORT_DMA_UNMAP)
>  - Reset AFU (DFL_FPGA_PORT_RESET)
> +- Get number of irqs of port error (DFL_FPGA_PORT_ERR_GET_IRQ_NUM)
> +- Set interrupt trigger for port error (DFL_FPGA_PORT_ERR_SET_IRQ)
> +- Get number of irqs of UINT (DFL_FPGA_PORT_UINT_GET_IRQ_NUM)
> +- Set interrupt trigger for UINT (DFL_FPGA_PORT_UINT_SET_IRQ)
>  
>  DFL_FPGA_PORT_RESET:
>    reset the FPGA Port and its AFU. Userspace can do Port
> @@ -378,6 +384,19 @@ The device nodes used for ioctl() or mmap() can be referenced through::
>  	/sys/class/fpga_region/<regionX>/<dfl-port.n>/dev
>  
>  
> +Interrupt support
> +=================
> +Some FME and AFU private features are able to generate interrupts. As mentioned
> +above, users could call ioctl (DFL_FPGA_*_GET_IRQ_NUM) to know whether or how
> +many interrupts are supported for this private feature. Drivers also implement
> +an eventfd based interrupt handling mechanism for users to get notified when
> +interrupt happens. Users could set eventfds to driver via
> +ioctl (DFL_FPGA_*_SET_IRQ), and then poll/select on these eventfds waiting for
> +notification.
> +In Current DFL, 3 sub features (Port error, FME global error and AFU interrupt)
> +support interrupts.
> +
> +
>  Add new FIUs support
>  ====================
>  It's possible that developers made some new function blocks (FIUs) under this
> -- 
> 2.7.4


Reviewed-by: Marcelo Tosatti <mtosatti@redhat.com>

