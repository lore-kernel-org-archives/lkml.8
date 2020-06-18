Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C859C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 14:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A71020888
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 14:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592488977;
	bh=Zi1nm8yHfREwF4pP+1YaTpENFiQVaBW3aml0Ie6+ioc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aIvxSH6FiYiLQHyoKyz+H1TMqxKV0djSlV8XZuYhjpaHEAw3dqw7pC/62AzXnxPkh
	 ZLaOSoqIo9gdKSy8PUQF+MxyAKMpExMwKq1z2Qo4VJBPfh9/ExTIVGvEQrifkuTFF8
	 RPrZBuYQpKUoA52ZPMJB44NdMJ1UKaRlLA5fp8yw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730306AbgFROCz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 10:02:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:37586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbgFROCx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 10:02:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82C5920773;
        Thu, 18 Jun 2020 14:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592488972;
        bh=Zi1nm8yHfREwF4pP+1YaTpENFiQVaBW3aml0Ie6+ioc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AsekxYtZ+W3shsJuZkhmOP8ftSzIZWj3LdaIR+n5JPw6tmfCXYtPBkJ/L4wq7rkta
         OqOCFXwnqjKTC7lMgkrVyAMoQWa1P1kEI++WrlwahA/AcYRIVSI6UVTiGHRgq5mMP+
         Kq4HWK8AvQRD7fT5XAdYkXybufco8nXjhaURPVy0=
Date:   Thu, 18 Jun 2020 16:02:44 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Macpaul Lin <macpaul.lin@mediatek.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Felipe Balbi <balbi@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, Jim Lin <jilin@nvidia.com>,
        Siqi Lin <siqilin@google.com>,
        Mediatek WSD Upstream <wsd_upstream@mediatek.com>,
        Macpaul Lin <macpaul.lin@gmail.com>
Subject: Re: [PATCH v3] usb: replace hardcode maximum usb string length by
 definition
Message-ID: <20200618140244.GA2576793@kroah.com>
References: <1592201855-8218-1-git-send-email-macpaul.lin@mediatek.com>
 <1592471618-29428-1-git-send-email-macpaul.lin@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592471618-29428-1-git-send-email-macpaul.lin@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 05:13:38PM +0800, Macpaul Lin wrote:
> Replace hardcode maximum usb string length (126 bytes) by definition
> "MAX_USB_STRING_LEN".
> 
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> Acked-by: Alan Stern <stern@rowland.harvard.edu>
> ---
> Changes for v2:
>   - Add definition "MAX_USB_STRING_LEN" in ch9.h instead of in usb.h.
>     Thanks for Alan's suggestion.
> Changes for v3:
>   - Rebase to 5.8-rc1 and resolve conflict.
> 
>  drivers/usb/gadget/composite.c |    4 ++--
>  drivers/usb/gadget/configfs.c  |    2 +-
>  drivers/usb/gadget/usbstring.c |    4 ++--
>  include/uapi/linux/usb/ch9.h   |    3 +++
>  4 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
> index cb4950c..d0de016 100644
> --- a/drivers/usb/gadget/composite.c
> +++ b/drivers/usb/gadget/composite.c
> @@ -1041,7 +1041,7 @@ static void collect_langs(struct usb_gadget_strings **sp, __le16 *buf)
>  	while (*sp) {
>  		s = *sp;
>  		language = cpu_to_le16(s->language);
> -		for (tmp = buf; *tmp && tmp < &buf[126]; tmp++) {
> +		for (tmp = buf; *tmp && tmp < &buf[MAX_USB_STRING_LEN]; tmp++) {
>  			if (*tmp == language)
>  				goto repeat;
>  		}
> @@ -1116,7 +1116,7 @@ static int get_string(struct usb_composite_dev *cdev,
>  			collect_langs(sp, s->wData);
>  		}
>  
> -		for (len = 0; len <= 126 && s->wData[len]; len++)
> +		for (len = 0; len <= MAX_USB_STRING_LEN && s->wData[len]; len++)
>  			continue;
>  		if (!len)
>  			return -EINVAL;
> diff --git a/drivers/usb/gadget/configfs.c b/drivers/usb/gadget/configfs.c
> index 32b637e..70dd4ba 100644
> --- a/drivers/usb/gadget/configfs.c
> +++ b/drivers/usb/gadget/configfs.c
> @@ -115,7 +115,7 @@ static int usb_string_copy(const char *s, char **s_copy)
>  	char *str;
>  	char *copy = *s_copy;
>  	ret = strlen(s);
> -	if (ret > 126)
> +	if (ret > MAX_USB_STRING_LEN)
>  		return -EOVERFLOW;
>  
>  	str = kstrdup(s, GFP_KERNEL);
> diff --git a/drivers/usb/gadget/usbstring.c b/drivers/usb/gadget/usbstring.c
> index 7c24d1c..8a8d647 100644
> --- a/drivers/usb/gadget/usbstring.c
> +++ b/drivers/usb/gadget/usbstring.c
> @@ -55,9 +55,9 @@
>  		return -EINVAL;
>  
>  	/* string descriptors have length, tag, then UTF16-LE text */
> -	len = min ((size_t) 126, strlen (s->s));
> +	len = min((size_t)MAX_USB_STRING_LEN, strlen(s->s));
>  	len = utf8s_to_utf16s(s->s, len, UTF16_LITTLE_ENDIAN,
> -			(wchar_t *) &buf[2], 126);
> +			(wchar_t *) &buf[2], MAX_USB_STRING_LEN);
>  	if (len < 0)
>  		return -EINVAL;
>  	buf [0] = (len + 1) * 2;
> diff --git a/include/uapi/linux/usb/ch9.h b/include/uapi/linux/usb/ch9.h
> index 2b623f3..cc02d05 100644
> --- a/include/uapi/linux/usb/ch9.h
> +++ b/include/uapi/linux/usb/ch9.h
> @@ -364,6 +364,9 @@ struct usb_config_descriptor {
>  
>  /*-------------------------------------------------------------------------*/
>  
> +/* USB String descriptors can contain at most 126 characters. */
> +#define MAX_USB_STRING_LEN	126

Nit, as this is part of the userspace api, we should make this
"USB_MAX_STRING_LEN" as we should be using "USB_" for all exports here.

That seems to be the case already except for one really odd set of
"TEST_" defines, which I'll go fix up after this...

I will just hand-edit this patch to make that change so you don't have
to respin it again...

thanks,

greg k-h
