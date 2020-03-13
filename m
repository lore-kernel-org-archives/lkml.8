Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD6EC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 10:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90E8020724
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 10:46:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XSViPTWS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgCMKqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 06:46:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40365 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726387AbgCMKqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 06:46:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584096367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vtV+aJw4Dht29bLGuz4fZ76FC7NknKrBd/VUbbOd/EA=;
        b=XSViPTWSYkJTFU7n8+OkNU/ppOw7PTphWN4IcJ742KeTyL++MuqzFQ0hQ+VEd8L9ZkGSK9
        edpwecOU1mCKDltwVwl0YsImDt5UPQpQ10hE3LokNc0nSQ/rtds+u9/DarLTJml2JYkEq2
        64sLw0fnQpxoL2+XmwnYNIeG0KOpyCQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-UuTwfVhEPRioskYUGmKWAw-1; Fri, 13 Mar 2020 06:46:01 -0400
X-MC-Unique: UuTwfVhEPRioskYUGmKWAw-1
Received: by mail-wr1-f71.google.com with SMTP id b12so4121382wro.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 03:46:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vtV+aJw4Dht29bLGuz4fZ76FC7NknKrBd/VUbbOd/EA=;
        b=pydO/J44ZT+sJWUFdy2wIhT0gqoUk+KC5EpLhkJ9KyCfkuAm7rp/iRQJkXoGDEoyzl
         47VxTCvh2RCUV4HHuafEJsQZApWdcQNQkAYrRGdEHQmdkHAOJboRm1cu1JHlC3fHHoJ6
         Ax0zohFhcD/p29kj3BzJ9xddzh0WbXcuizWoLwWT4wwNAqy2My50C2QMBR0l2FK4SMDC
         dZwiOirnE0j2EJF+nP532EsQwfBh+1sT0lQvsgiOSPB0lQkEs8fKPDEyb5By/BuwuciG
         FmRrmqQlrMzHCAxkdYGMiPcsOSCcNbW6uXSb5gZVuauOywQ7Mcc5HoBCpfBvanm+9tS7
         Gnbw==
X-Gm-Message-State: ANhLgQ1Kr4tbcuiNv9BvecKU/AzQrwzMFhnS5gyB8XpYH94lcB70sT+k
        aaC9TS22wlljM1p1KvAY6X31d1hp1N0mvUl+/qSF27RjyAkPTQSXKyCTfFbgO62SnsB2s3IXwim
        uU9Xn0gl1wztIhU8+zznY6ebA
X-Received: by 2002:adf:fc81:: with SMTP id g1mr17843739wrr.410.1584096359295;
        Fri, 13 Mar 2020 03:45:59 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuzspxaIg4ghBUUcSHVHPnTFJA0Yp/blTTVub08BhvaSdIutNqejUAg2LVy4eICj5ERM9ZoLA==
X-Received: by 2002:adf:fc81:: with SMTP id g1mr17843722wrr.410.1584096359101;
        Fri, 13 Mar 2020 03:45:59 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-fc7e-fd47-85c1-1ab3.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:fc7e:fd47:85c1:1ab3])
        by smtp.gmail.com with ESMTPSA id m2sm16647724wml.24.2020.03.13.03.45.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2020 03:45:58 -0700 (PDT)
Subject: Re: [PATCH 3/3] virt: vbox: Use fallthrough;
To:     Joe Perches <joe@perches.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
References: <cover.1584040050.git.joe@perches.com>
 <68773b4cd82288b78ca6fcde8c43e249a025378a.1584040050.git.joe@perches.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <eb4b9c3d-23c4-7b93-9a5d-6686947a818d@redhat.com>
Date:   Fri, 13 Mar 2020 11:45:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <68773b4cd82288b78ca6fcde8c43e249a025378a.1584040050.git.joe@perches.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/12/20 8:17 PM, Joe Perches wrote:
> Convert the various uses of fallthrough comments to fallthrough;
> 
> Done via script
> Link: https://lore.kernel.org/lkml/b56602fcf79f849e733e7b521bb0e17895d390fa.1582230379.git.joe@perches.com/
> 
> And by hand:
> 
> drivers/virt/vboxguest/vboxguest_core.c has a fallthrough comment outside
> of an #ifdef block that causes gcc to emit a warning if converted in-place.
> 
> So move the new fallthrough; inside the containing #ifdef/#endif too.
> 
> Signed-off-by: Joe Perches <joe@perches.com>

Patch looks good to me:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>   drivers/virt/vboxguest/vboxguest_core.c  | 2 +-
>   drivers/virt/vboxguest/vboxguest_utils.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/virt/vboxguest/vboxguest_core.c b/drivers/virt/vboxguest/vboxguest_core.c
> index d823d5..b690a8 100644
> --- a/drivers/virt/vboxguest/vboxguest_core.c
> +++ b/drivers/virt/vboxguest/vboxguest_core.c
> @@ -1553,8 +1553,8 @@ int vbg_core_ioctl(struct vbg_session *session, unsigned int req, void *data)
>   #ifdef CONFIG_COMPAT
>   	case VBG_IOCTL_HGCM_CALL_32(0):
>   		f32bit = true;
> +		fallthrough;
>   #endif
> -		/* Fall through */
>   	case VBG_IOCTL_HGCM_CALL(0):
>   		return vbg_ioctl_hgcm_call(gdev, session, f32bit, data);
>   	case VBG_IOCTL_LOG(0):
> diff --git a/drivers/virt/vboxguest/vboxguest_utils.c b/drivers/virt/vboxguest/vboxguest_utils.c
> index 50920b..739618 100644
> --- a/drivers/virt/vboxguest/vboxguest_utils.c
> +++ b/drivers/virt/vboxguest/vboxguest_utils.c
> @@ -311,7 +311,7 @@ static u32 hgcm_call_linear_addr_type_to_pagelist_flags(
>   	switch (type) {
>   	default:
>   		WARN_ON(1);
> -		/* Fall through */
> +		fallthrough;
>   	case VMMDEV_HGCM_PARM_TYPE_LINADDR:
>   	case VMMDEV_HGCM_PARM_TYPE_LINADDR_KERNEL:
>   		return VMMDEV_HGCM_F_PARM_DIRECTION_BOTH;
> 

