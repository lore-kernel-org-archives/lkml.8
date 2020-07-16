Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4FE6C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 04:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A39920775
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 04:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NAxHUWpU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbgGPERD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 00:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgGPERD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 00:17:03 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141DCC061755;
        Wed, 15 Jul 2020 21:17:03 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id d4so4194463pgk.4;
        Wed, 15 Jul 2020 21:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NFWKAnqwIMZO+jCeZOqem/0WTb649YZirzCP4sMo3vU=;
        b=NAxHUWpU88h2Es2qByrl1j7WIsDFhBB3rt9YvdCFI9yjg5nAMJ+wptf3dgOo4o1H61
         sEjdQ4wOuFsHESze83Xib87RCB0pwOC3276duLKpex0gzUP70LtIu63TSeImhr7zKnAQ
         MCOMVWcTJnRbZgzKdPdGfn9z37J0JSJJLL7GcBLnsRsQnZsubsGmeWxBumFYBZgOx8Wj
         U7x1bLxlfLtFYGX3dW5IGc5QG91qhKiISTijylKiZZARTI8khdAddKvytNKRLNcyXY9C
         PHZkrN0ifGz4o37iezrXBnwcMidTrHvtdOHzhpDrOBxpbCcdVktgIIR6M1OvagNiB23S
         jk3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=NFWKAnqwIMZO+jCeZOqem/0WTb649YZirzCP4sMo3vU=;
        b=MhmgsPzAxW3EnoBWljnawOSKd/rNrnjdmKYHu0xK49Yy17quyEjez8va4lztyPGPHF
         5tTJbDnUQLOYs4AtpoOAIbkO3whnNJjJU1P7BblxrsmfdrgdfQ4jS4sOYiLzStVn4wKl
         o7ymOaD6+vh1fUfT1zhMK0fbKFOOjVOFV/AeiFvCjnGPivxoaMo1oMqqhVYa3e79ZJec
         zes+xXKJoWKdIxvizdUB2TAd2hrdZlQ3AYQ/h3Lzx4Xw8uHmUEhoVXfGiAmiuqWwBgjC
         8eF8hpO/VLYRmcewnmRiIuL5nnQLKe/TRMtSdVeynDc2fL7zEIJ8QJLjvIWaQ3cydwwN
         5v+w==
X-Gm-Message-State: AOAM532K1Nv+02YHuR2Y3RlBumJqmOKmZ+/AyUxGWkmdmC4d5Dl2R7ul
        G3DUn1tGxkQWIUuuQ8iJdIjkqFhU
X-Google-Smtp-Source: ABdhPJy8CxHLVhY59zwXk75I8HIChF7zIF/EhGAiVtpMsr0XlKva4fUXA/Im8lKUH0vClRC/fxARmg==
X-Received: by 2002:a63:7c4d:: with SMTP id l13mr2696707pgn.12.1594873022410;
        Wed, 15 Jul 2020 21:17:02 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i125sm3428916pgd.21.2020.07.15.21.17.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2020 21:17:01 -0700 (PDT)
Subject: Re: [PATCH 3/3 v3] usb: typec: tcpm: Stay in BIST mode till hardreset
 or unattached
To:     Badhri Jagan Sridharan <badhri@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        reg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200716034128.1251728-1-badhri@google.com>
 <20200716034128.1251728-3-badhri@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <0bfb2170-df93-0be2-1eeb-cdcac77bda0c@roeck-us.net>
Date:   Wed, 15 Jul 2020 21:16:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200716034128.1251728-3-badhri@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/15/20 8:41 PM, Badhri Jagan Sridharan wrote:
> Port starts to toggle when transitioning to unattached state.
> This is incorrect while in BIST mode.
> 
> 6.4.3.1 BIST Carrier Mode
> Upon receipt of a BIST Message, with a BIST Carrier Mode BIST Data Object,
> the UUT Shall send out a continuous string of BMC encoded alternating "1"s
> and “0”s. The UUT Shall exit the Continuous BIST Mode within
> tBISTContMode of this Continuous BIST Mode being enabled(see
> Section 6.6.7.2).
> 
> 6.4.3.2 BIST Test Data
> Upon receipt of a BIST Message, with a BIST Test Data BIST Data Object,
> the UUT Shall return a GoodCRC Message and Shall enter a test mode in which
> it sends no further Messages except for GoodCRC Messages in response to
> received Messages. See Section 5.9.2 for the definition of the Test Data
> Frame. The test Shall be ended by sending Hard Reset Signaling to reset the
> UUT.
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Version history:
> Changes since V1:
> - None
> 
> Changes since V2:(Guenter's suggestions)
> - Fixed formatting error
> - Reduced timeout to 50ms
> 
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 7 +++++--
>  include/linux/usb/pd.h        | 1 +
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 379fcab9dbd973..38b958a9650104 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -3559,6 +3559,8 @@ static void run_state_machine(struct tcpm_port *port)
>  		switch (BDO_MODE_MASK(port->bist_request)) {
>  		case BDO_MODE_CARRIER2:
>  			tcpm_pd_transmit(port, TCPC_TX_BIST_MODE_2, NULL);
> +			tcpm_set_state(port, unattached_state(port),
> +				       PD_T_BIST_CONT_MODE);
>  			break;
>  		case BDO_MODE_TESTDATA:
>  			if (port->tcpc->set_bist_data) {
> @@ -3569,8 +3571,6 @@ static void run_state_machine(struct tcpm_port *port)
>  		default:
>  			break;
>  		}
> -		/* Always switch to unattached state */
> -		tcpm_set_state(port, unattached_state(port), 0);
>  		break;
>  	case GET_STATUS_SEND:
>  		tcpm_pd_send_control(port, PD_CTRL_GET_STATUS);
> @@ -3960,6 +3960,9 @@ static void _tcpm_pd_vbus_off(struct tcpm_port *port)
>  static void _tcpm_pd_hard_reset(struct tcpm_port *port)
>  {
>  	tcpm_log_force(port, "Received hard reset");
> +	if (port->bist_request == BDO_MODE_TESTDATA && port->tcpc->set_bist_data)
> +		port->tcpc->set_bist_data(port->tcpc, false);
> +
>  	/*
>  	 * If we keep receiving hard reset requests, executing the hard reset
>  	 * must have failed. Revert to error recovery if that happens.
> diff --git a/include/linux/usb/pd.h b/include/linux/usb/pd.h
> index a665d7f211424d..b6c233e79bd457 100644
> --- a/include/linux/usb/pd.h
> +++ b/include/linux/usb/pd.h
> @@ -483,4 +483,5 @@ static inline unsigned int rdo_max_power(u32 rdo)
>  #define PD_N_CAPS_COUNT		(PD_T_NO_RESPONSE / PD_T_SEND_SOURCE_CAP)
>  #define PD_N_HARD_RESET_COUNT	2
>  
> +#define PD_T_BIST_CONT_MODE	50 /* 30 - 60 ms */
>  #endif /* __LINUX_USB_PD_H */
> 

