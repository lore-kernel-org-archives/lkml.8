Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E05CC34022
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C0FD24656
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:41:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732152AbgB0OlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:41:22 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38060 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730977AbgB0OlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:41:20 -0500
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 312FB295F73;
        Thu, 27 Feb 2020 14:41:19 +0000 (GMT)
Date:   Thu, 27 Feb 2020 15:41:15 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Vitor Soares <Vitor.Soares@synopsys.com>
Cc:     pgaj@cadence.com, bbrezillon@kernel.org,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] i3c: Add modalias sysfs attribute
Message-ID: <20200227154115.77c42274@collabora.com>
In-Reply-To: <a90f64f830128cd12762153de7828b775574c156.1582796652.git.vitor.soares@synopsys.com>
References: <cover.1582796652.git.vitor.soares@synopsys.com>
        <a90f64f830128cd12762153de7828b775574c156.1582796652.git.vitor.soares@synopsys.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Feb 2020 12:31:07 +0100
Vitor Soares <Vitor.Soares@synopsys.com> wrote:

> Create modalias sysfs attribute for modalias devices.

					^i3c

No need to send a new version, I'll fix it when applying.

> 
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Vitor Soares <vitor.soares@synopsys.com>
> ---
>  drivers/i3c/master.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> index b6db828..925e1ed 100644
> --- a/drivers/i3c/master.c
> +++ b/drivers/i3c/master.c
> @@ -241,12 +241,34 @@ static ssize_t hdrcap_show(struct device *dev,
>  }
>  static DEVICE_ATTR_RO(hdrcap);
>  
> +static ssize_t modalias_show(struct device *dev,
> +			     struct device_attribute *da, char *buf)
> +{
> +	struct i3c_device *i3c = dev_to_i3cdev(dev);
> +	struct i3c_device_info devinfo;
> +	u16 manuf, part, ext;
> +
> +	i3c_device_get_info(i3c, &devinfo);
> +	manuf = I3C_PID_MANUF_ID(devinfo.pid);
> +	part = I3C_PID_PART_ID(devinfo.pid);
> +	ext = I3C_PID_EXTRA_INFO(devinfo.pid);
> +
> +	if (I3C_PID_RND_LOWER_32BITS(devinfo.pid))
> +		return sprintf(buf, "i3c:dcr%02Xmanuf%04X", devinfo.dcr,
> +			       manuf);
> +
> +	return sprintf(buf, "i3c:dcr%02Xmanuf%04Xpart%04Xext%04X",
> +		       devinfo.dcr, manuf, part, ext);
> +}
> +static DEVICE_ATTR_RO(modalias);
> +
>  static struct attribute *i3c_device_attrs[] = {
>  	&dev_attr_bcr.attr,
>  	&dev_attr_dcr.attr,
>  	&dev_attr_pid.attr,
>  	&dev_attr_dynamic_address.attr,
>  	&dev_attr_hdrcap.attr,
> +	&dev_attr_modalias.attr,
>  	NULL,
>  };
>  ATTRIBUTE_GROUPS(i3c_device);

