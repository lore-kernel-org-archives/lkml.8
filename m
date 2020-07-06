Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A2EC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 14:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7115C2070C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 14:01:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eyOmmyVV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729304AbgGFOBE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 10:01:04 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27741 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729294AbgGFOBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 10:01:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594044060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=plR445Drk3eeFEnzym0LmKRY+r16mbP2yKRnTLNcumQ=;
        b=eyOmmyVVSqZQ3btGRHGkKYEr7d1xTaGPYqoC9w13l5x7vE+1ZrzdtSph9QOETrbNOavBto
        p4V6qghd+Bmi0qIjj+hFS53Bs2O+6Ukh8BHuwOSEy0OU7/EcC32Kk+nUbE1O7QE0sxVBbH
        bU09ygUaK9E/BaV7dlSp1Mm/gUx/8q8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-KhNLlIAHN9Sfaxkvg7ZL1A-1; Mon, 06 Jul 2020 10:00:58 -0400
X-MC-Unique: KhNLlIAHN9Sfaxkvg7ZL1A-1
Received: by mail-ej1-f70.google.com with SMTP id y10so29705914ejd.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 07:00:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=plR445Drk3eeFEnzym0LmKRY+r16mbP2yKRnTLNcumQ=;
        b=YGl09wHFKNF5U85LToBb7Sm9aaHXx5dnB5043LKTRbjHg3hmLoRX10xCrOuNcqYAne
         caGYjtYwOvJdny4dhpsOyazdqK9DD/Mt+s+oKKmgEe9UG1XL43FYkCIsxZPKnG/Gi4ZW
         mwoS8sQZ1Krpy2WZXlGPsVE247OYnSjTzFf68Ix8xK9GGt+jtXr2U1H6p6dG+Cc79g8H
         vI+LaaTk96suofUum5l3KGkgIhPLNHSez+MsfcERNw1i3lbg3Ww+fIlJK8x5WWlBYsMq
         cdana7XYf2LqtawLC4/bQk4CEL4swc/hztC5nrWazM0M3Vy8J0Ru5vq1zDxcpBgoVEt3
         lb8Q==
X-Gm-Message-State: AOAM532PuFRuIVIK4yv8kLVDki7xfoH31udfvRGNlkWV8CRzr+T1hAnE
        ekve7F0RUAckdbNU3euJwlUOiaUBAg4niwb2uMMHt0zL2tWO0B35qo+ixmgdH91bAERnwiMRPGL
        OW/o3bqz5qOD0rKNd+4259Fg4
X-Received: by 2002:a05:6402:202e:: with SMTP id ay14mr55866483edb.233.1594044057623;
        Mon, 06 Jul 2020 07:00:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwokWAQDe0bD6JJ8Z9MjAp3h3YbM7dv+sokIOUz5rBXKpDFtUHf2aONLLEEwiCQIl5my75xOA==
X-Received: by 2002:a05:6402:202e:: with SMTP id ay14mr55866456edb.233.1594044057460;
        Mon, 06 Jul 2020 07:00:57 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id mf24sm16808096ejb.58.2020.07.06.07.00.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2020 07:00:56 -0700 (PDT)
Subject: Re: [PATCH 08/32] usb: typec: tcpm: tcpm: Remove dangling unused
 'struct tcpm_altmode_ops'
To:     Lee Jones <lee.jones@linaro.org>, gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
References: <20200706133341.476881-1-lee.jones@linaro.org>
 <20200706133341.476881-9-lee.jones@linaro.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <ca14707c-7d40-07ac-da1d-ca27a2e93dcd@redhat.com>
Date:   Mon, 6 Jul 2020 16:00:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200706133341.476881-9-lee.jones@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/6/20 3:33 PM, Lee Jones wrote:
> Looks as though a079973f462a3 ("usb: typec: tcpm: Remove tcpc_config
> configuration mechanism") pulled out the only use of 'tcpm_altmode_ops'
> last year.  No need to keep it around.
> 
> Fixes the following W=1 kernel build warning(s):
> 
>   drivers/usb/typec/tcpm/tcpm.c:1551:39: warning: ‘tcpm_altmode_ops’ defined but not used [-Wunused-const-variable=]
>   1551 | static const struct typec_altmode_ops tcpm_altmode_ops = {
>   | ^~~~~~~~~~~~~~~~
> 
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

This is necessary for adding Display port over Type-C support
on devices using the tcpm code, rather then firmware, to do
the Type-C alt-mode negotiation.

I have a local patch in my tree which adds support for this.

But Heikki did not like my approach, so that patch
(which needs the bits you are removing) never landed
upstream:

https://patchwork.kernel.org/patch/11199517/

Which is somewhat old now.

Heikki said he would look into an approach to this more to
his liking. Heikki an progress on this area?

Regards,

Hans



> ---
>   drivers/usb/typec/tcpm/tcpm.c | 51 -----------------------------------
>   1 file changed, 51 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 82b19ebd7838e..d6913eb0ea54d 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -1503,57 +1503,6 @@ static int tcpm_validate_caps(struct tcpm_port *port, const u32 *pdo,
>   	return 0;
>   }
>   
> -static int tcpm_altmode_enter(struct typec_altmode *altmode, u32 *vdo)
> -{
> -	struct tcpm_port *port = typec_altmode_get_drvdata(altmode);
> -	u32 header;
> -
> -	mutex_lock(&port->lock);
> -	header = VDO(altmode->svid, vdo ? 2 : 1, CMD_ENTER_MODE);
> -	header |= VDO_OPOS(altmode->mode);
> -
> -	tcpm_queue_vdm(port, header, vdo, vdo ? 1 : 0);
> -	mod_delayed_work(port->wq, &port->vdm_state_machine, 0);
> -	mutex_unlock(&port->lock);
> -
> -	return 0;
> -}
> -
> -static int tcpm_altmode_exit(struct typec_altmode *altmode)
> -{
> -	struct tcpm_port *port = typec_altmode_get_drvdata(altmode);
> -	u32 header;
> -
> -	mutex_lock(&port->lock);
> -	header = VDO(altmode->svid, 1, CMD_EXIT_MODE);
> -	header |= VDO_OPOS(altmode->mode);
> -
> -	tcpm_queue_vdm(port, header, NULL, 0);
> -	mod_delayed_work(port->wq, &port->vdm_state_machine, 0);
> -	mutex_unlock(&port->lock);
> -
> -	return 0;
> -}
> -
> -static int tcpm_altmode_vdm(struct typec_altmode *altmode,
> -			    u32 header, const u32 *data, int count)
> -{
> -	struct tcpm_port *port = typec_altmode_get_drvdata(altmode);
> -
> -	mutex_lock(&port->lock);
> -	tcpm_queue_vdm(port, header, data, count - 1);
> -	mod_delayed_work(port->wq, &port->vdm_state_machine, 0);
> -	mutex_unlock(&port->lock);
> -
> -	return 0;
> -}
> -
> -static const struct typec_altmode_ops tcpm_altmode_ops = {
> -	.enter = tcpm_altmode_enter,
> -	.exit = tcpm_altmode_exit,
> -	.vdm = tcpm_altmode_vdm,
> -};
> -
>   /*
>    * PD (data, control) command handling functions
>    */
> 

