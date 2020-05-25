Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B02C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 19:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B31392068D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 19:38:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NV7Xwp09"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390259AbgEYTiS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 15:38:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55416 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2390153AbgEYTh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 15:37:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590435477;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g/qzPb+rigzdeEpxfy8/9J5YI6QH1NmXqrwZrz57pB0=;
        b=NV7Xwp09IagT94JZkQGtwQ6hshBBLHnq/n5R0T5jdJxs8pTDCJ2rTlWPgBdyOARb9XhoHO
        6afv91rVOoy4yg0u9SOCmdpBB9gyWcp4MnWjU8hNbsR0vnHvdvAcm5i3N7F0wAezHZ7SnC
        oanLYvuugW5C6Ej88onoi0oyNTDvvYg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-7EgWKUoIO_OheqLYDoSj0g-1; Mon, 25 May 2020 15:37:53 -0400
X-MC-Unique: 7EgWKUoIO_OheqLYDoSj0g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B23D100726B;
        Mon, 25 May 2020 19:37:52 +0000 (UTC)
Received: from fuller.cnet (ovpn-116-16.gru2.redhat.com [10.97.116.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D310682A20;
        Mon, 25 May 2020 19:37:51 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 35C89416CE4E; Mon, 25 May 2020 16:34:32 -0300 (-03)
Date:   Mon, 25 May 2020 16:34:32 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, trix@redhat.com, bhu@redhat.com,
        Luwei Kang <luwei.kang@intel.com>, Wu Hao <hao.wu@intel.com>
Subject: Re: [PATCH v5 6/7] fpga: dfl: afu: add AFU interrupt support
Message-ID: <20200525193432.GF22266@fuller.cnet>
References: <1587370303-25568-1-git-send-email-yilun.xu@intel.com>
 <1587370303-25568-7-git-send-email-yilun.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587370303-25568-7-git-send-email-yilun.xu@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 04:11:42PM +0800, Xu Yilun wrote:
> AFU (Accelerated Function Unit) is dynamic region of the DFL based FPGA,
> and always defined by users. Some DFL based FPGA cards allow users to
> implement their own interrupts in AFU. In order to support this,
> hardware implements a new UINT (AFU Interrupt) private feature with
> related capability register which describes the number of supported
> AFU interrupts as well as the local index of the interrupts for
> software enumeration, and from software side, driver follows the common
> DFL interrupt notification and handling mechanism, and it implements
> two ioctls below for user to query number of irqs supported and set/unset
> interrupt triggers.
> 
>  Ioctls:
>  * DFL_FPGA_PORT_UINT_GET_IRQ_NUM
>    get the number of irqs, which is used to determine how many interrupts
>    UINT feature supports.
> 
>  * DFL_FPGA_PORT_UINT_SET_IRQ
>    set/unset eventfds as AFU interrupt triggers.
> 
> Signed-off-by: Luwei Kang <luwei.kang@intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Acked-by: Wu Hao <hao.wu@intel.com>
> ----
> v2: use DFL_FPGA_PORT_UINT_GET_IRQ_NUM instead of
>     DFL_FPGA_PORT_UINT_GET_INFO
>     Delete flags field for DFL_FPGA_PORT_UINT_SET_IRQ
> v3: put_user() instead of copy_to_user()
>     improves comments
> v4: use common functions to handle irq ioctls
> v5: Minor fixes for Hao's comments
> ---
>  drivers/fpga/dfl-afu-main.c   | 28 ++++++++++++++++++++++++++++
>  include/uapi/linux/fpga-dfl.h | 23 +++++++++++++++++++++++
>  2 files changed, 51 insertions(+)
> 
> diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
> index b1ed7b4..753cda4 100644
> --- a/drivers/fpga/dfl-afu-main.c
> +++ b/drivers/fpga/dfl-afu-main.c
> @@ -530,6 +530,30 @@ static const struct dfl_feature_ops port_stp_ops = {
>  	.init = port_stp_init,
>  };
>  
> +static long
> +port_uint_ioctl(struct platform_device *pdev, struct dfl_feature *feature,
> +		unsigned int cmd, unsigned long arg)
> +{
> +	switch (cmd) {
> +	case DFL_FPGA_PORT_UINT_GET_IRQ_NUM:
> +		return dfl_feature_ioctl_get_num_irqs(pdev, feature, arg);
> +	case DFL_FPGA_PORT_UINT_SET_IRQ:
> +		return dfl_feature_ioctl_set_irq(pdev, feature, arg);
> +	default:
> +		dev_dbg(&pdev->dev, "%x cmd not handled", cmd);
> +		return -ENODEV;
> +	}
> +}
> +
> +static const struct dfl_feature_id port_uint_id_table[] = {
> +	{.id = PORT_FEATURE_ID_UINT,},
> +	{0,}
> +};
> +
> +static const struct dfl_feature_ops port_uint_ops = {
> +	.ioctl = port_uint_ioctl,
> +};
> +
>  static struct dfl_feature_driver port_feature_drvs[] = {
>  	{
>  		.id_table = port_hdr_id_table,
> @@ -548,6 +572,10 @@ static struct dfl_feature_driver port_feature_drvs[] = {
>  		.ops = &port_stp_ops,
>  	},
>  	{
> +		.id_table = port_uint_id_table,
> +		.ops = &port_uint_ops,
> +	},
> +	{
>  		.ops = NULL,
>  	}
>  };
> diff --git a/include/uapi/linux/fpga-dfl.h b/include/uapi/linux/fpga-dfl.h
> index b6495ea..1621b07 100644
> --- a/include/uapi/linux/fpga-dfl.h
> +++ b/include/uapi/linux/fpga-dfl.h
> @@ -187,6 +187,29 @@ struct dfl_fpga_irq_set {
>  					     DFL_PORT_BASE + 6,	\
>  					     struct dfl_fpga_irq_set)
>  
> +/**
> + * DFL_FPGA_PORT_UINT_GET_IRQ_NUM - _IOR(DFL_FPGA_MAGIC, DFL_PORT_BASE + 7,
> + *								__u32 num_irqs)
> + *
> + * Get the number of irqs supported by the fpga AFU interrupt private
> + * feature.
> + * Return: 0 on success, -errno on failure.
> + */
> +#define DFL_FPGA_PORT_UINT_GET_IRQ_NUM	_IOR(DFL_FPGA_MAGIC,	\
> +					     DFL_PORT_BASE + 7, __u32)
> +
> +/**
> + * DFL_FPGA_PORT_UINT_SET_IRQ - _IOW(DFL_FPGA_MAGIC, DFL_PORT_BASE + 8,
> + *						struct dfl_fpga_irq_set)
> + *
> + * Set fpga AFU interrupt trigger if evtfds[n] is valid.
> + * Unset related interrupt trigger if evtfds[n] is a negative value.
> + * Return: 0 on success, -errno on failure.
> + */
> +#define DFL_FPGA_PORT_UINT_SET_IRQ	_IOW(DFL_FPGA_MAGIC,	\
> +					     DFL_PORT_BASE + 8,	\
> +					     struct dfl_fpga_irq_set)
> +
>  /* IOCTLs for FME file descriptor */
>  
>  /**
> -- 
> 2.7.4


Reviewed-by: Marcelo Tosatti <mtosatti@redhat.com>

