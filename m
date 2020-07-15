Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94962C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 16:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6937E20672
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 16:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ast/VbZc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbgGOQch (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 12:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgGOQcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 12:32:35 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6000AC061755;
        Wed, 15 Jul 2020 09:32:35 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id t6so3337811pgq.1;
        Wed, 15 Jul 2020 09:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zdauEg1QYJHxq8lIpaEnDDgHmG9a8ZcmjBSfBB8sjJU=;
        b=ast/VbZche5CTHwfZWsWG9DwetxqFuPcIQv2kUliATWkXFHHb0TIlwq3fhhGlhWBbD
         sikCB4eMbWMl0zo75IQ+d2Jw5URzRDzW0wiIxFP+UWUcrfV6mVOQA7XIZxj5PvCyaqNm
         vrlB2HWSKLE8RDN7RrxhZWya293Ld6VlgoUNPvDnqVS9On9Nq8XbGuh/xo3s4wDdQ+S0
         q4osOqXF37WoiBwtPL32aTtcZRzfxVxwFC6qrqCKkygHvADn/10qJAt0qRhBDBhzK61Y
         A7Ak6esJVSr1wfR5Hl1xB52ohqyVAbZQc5HMP+WakI6S3Vewa+5N2En8KWyBVUeUgBoI
         V+bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=zdauEg1QYJHxq8lIpaEnDDgHmG9a8ZcmjBSfBB8sjJU=;
        b=GGQMZWycE9ULrNdjYWqy/UEvuylP8pXfs4ZRZoPLCgqEY4/JoeGpZ/i1mumXehYr30
         QB3p7l0ui+u2NX6OxLnvb3lAlodpo9kaKswz1WthPQviLMPJb4VtrS27tsj7oPX8UO8D
         c4vlMbGJrQYLba+aSQsz42qt2T9JPDfXwmEQny2+7uq7Up2441oIr+QxOfdjadB4P8IA
         VPekCyDN2P0RyfTySTVS8SL7PTQ9O/zdKuBsUeCVlUEyfrm+v+yCXZSYbniO0kl475B9
         T8pGrVrVYgNCV6+k+1/riTOr6dMQvOCi5ge8t54LHWbC6KlEVQo0MdeyqQ3O4CS0GmFB
         Jnlg==
X-Gm-Message-State: AOAM532XPpbF31jcSkMJisnzFAO3QViNXSaLwn9Gxe+xtnNZ+Vab8Num
        rKVxAfUTM/5U1yEQijkEhR+X3dr8
X-Google-Smtp-Source: ABdhPJxyx7Vf1yJ095YmEk1ZvI1xd+g2GJvmGrrv14Z+opklroTb5jaZ6eV+bxuKdx1qEVriAJO2pA==
X-Received: by 2002:a63:7206:: with SMTP id n6mr460154pgc.342.1594830754731;
        Wed, 15 Jul 2020 09:32:34 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x7sm2277056pfp.96.2020.07.15.09.32.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2020 09:32:34 -0700 (PDT)
Subject: Re: [PATCH 3/3 v2] usb: typec: tcpm: Stay in BIST mode till hardreset
 or unattached
To:     Badhri Jagan Sridharan <badhri@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        reg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200714231207.866838-1-badhri@google.com>
 <20200714231207.866838-3-badhri@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <2c9e0f1a-3071-8fe7-54d1-6ce670268197@roeck-us.net>
Date:   Wed, 15 Jul 2020 09:32:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200714231207.866838-3-badhri@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/20 4:12 PM, Badhri Jagan Sridharan wrote:
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
> ---
> Version history:
> Changes since V1:
> -  None
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 8 ++++++--
>  include/linux/usb/pd.h        | 1 +
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 379fcab9dbd973..245cfe80948502 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -3559,6 +3559,8 @@ static void run_state_machine(struct tcpm_port *port)
>  		switch (BDO_MODE_MASK(port->bist_request)) {
>  		case BDO_MODE_CARRIER2:
>  			tcpm_pd_transmit(port, TCPC_TX_BIST_MODE_2, NULL);
> +			tcpm_set_state(port, unattached_state(port),
> +				       PD_T_BIST_CONT_MODE);

One line should now be sufficient.

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
> @@ -3960,6 +3960,10 @@ static void _tcpm_pd_vbus_off(struct tcpm_port *port)
>  static void _tcpm_pd_hard_reset(struct tcpm_port *port)
>  {
>  	tcpm_log_force(port, "Received hard reset");
> +	if (port->bist_request ==  BDO_MODE_TESTDATA &&

Nit: Extra space after "=="

Also, I think this now fits into one line (line length limit is 100).

> +	    port->tcpc->set_bist_data)
> +		port->tcpc->set_bist_data(port->tcpc, false);
> +
>  	/*
>  	 * If we keep receiving hard reset requests, executing the hard reset
>  	 * must have failed. Revert to error recovery if that happens.
> diff --git a/include/linux/usb/pd.h b/include/linux/usb/pd.h
> index a665d7f211424d..b420d8d613cd23 100644
> --- a/include/linux/usb/pd.h
> +++ b/include/linux/usb/pd.h
> @@ -483,4 +483,5 @@ static inline unsigned int rdo_max_power(u32 rdo)
>  #define PD_N_CAPS_COUNT		(PD_T_NO_RESPONSE / PD_T_SEND_SOURCE_CAP)
>  #define PD_N_HARD_RESET_COUNT	2
>  
> +#define PD_T_BIST_CONT_MODE	60 /* 30 - 60 ms */

Maybe a bit less to ensure that it is disabled within 60 ms. If we use
the maximum, we may end up having it enabled for more than 60 ms, which
would violate the specification and may tick some picky compliance test
system.

Thanks,
Guenter

>  #endif /* __LINUX_USB_PD_H */
> 

