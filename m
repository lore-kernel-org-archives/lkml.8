Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E696C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 01:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A72020716
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 01:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GpMKX9Qs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbgHKBvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 21:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728046AbgHKBvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 21:51:13 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CADAAC06174A;
        Mon, 10 Aug 2020 18:51:13 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id m71so6351614pfd.1;
        Mon, 10 Aug 2020 18:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cQifSZOziOnvUK04OfVsd2hJ+niYunqai4Bzh6MMUq4=;
        b=GpMKX9QsiJdKjPn5Jj//JsC4RG82dGOsZkU3qkonR198ZambfctqGxjsjdodfw/kQO
         pLAAfP7eLrnhcD4SxAj/z9wbio5EjQzjWODNhFd/wMi05guYpCytbPAgboVRm7g1ohrp
         VbnN+QiotDhkWqseLUA4G7I6pEvt3xKgpA7WIrNNqINoYX+8WFB6kasctuEa22zgrKmX
         tCEUcsHIaRoOq/W4Ex5mMsxmRB+OTYSCPrV4nyrGRMWN62wvYdNon2a5VfykeliVt7Pc
         P+0r5CsSMMwCywWgvUDXXKaxPWSqk/E3U/E5TxCJvaEkhrriy85o2h7X1gbKDf0GXA+U
         2zWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=cQifSZOziOnvUK04OfVsd2hJ+niYunqai4Bzh6MMUq4=;
        b=XfdwdQqE4gaKRWz/9TUCmdL9OgX7QyRPyVME4NNi9MgJuBoTrNUKIA2jso9Y2Qba6U
         7N4c2qOZk8iX/mJwTPoXRiH1z0bkXwCLvS1SlfpQ5rGsetMxPPyeh+jeT5mlPiySuEhv
         qNOyFNMF/qYKKFRCh/drcEcEImCmu/jrBzakgvzdwb13G7F19g7SeCABAgo9x+zlbF1M
         SWyOZtqXXH1aTAVkfcau7yx8hSAchjQKE3/17gQ6cDh0OwzSyn32lHLJgF1liJny2WBZ
         82z907aczpqqn8Wyi8i0cZHyFY+pX9r4C4ecSRSjLTiX90pnMs1q8Va1q9TN254KnIXx
         qSEQ==
X-Gm-Message-State: AOAM532QfsJ/5VJO+w7Ajepbr13CT9K7pkj1l2EjhQg04cbRDUHcwtlF
        NCmoEbTAuWiqPlGgQ4IiLc9Z4K9Y
X-Google-Smtp-Source: ABdhPJwELZF1ZtMSd2g60KqHk+2RwVtTNs6cV6S7HprEoy+m7mfhHsbA9UezTeH4N32ExqDY4g80cA==
X-Received: by 2002:aa7:8743:: with SMTP id g3mr3830918pfo.76.1597110673022;
        Mon, 10 Aug 2020 18:51:13 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h1sm24700567pfr.39.2020.08.10.18.51.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2020 18:51:12 -0700 (PDT)
Subject: Re: [PATCH v1] usb: typec: tcpm: Fix TDA 2.2.1.1 and TDA 2.2.1.2
 failures
To:     Badhri Jagan Sridharan <badhri@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200811011126.130297-1-badhri@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <ef32ea96-16c8-772b-2c80-8df43ee8f668@roeck-us.net>
Date:   Mon, 10 Aug 2020 18:51:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200811011126.130297-1-badhri@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/20 6:11 PM, Badhri Jagan Sridharan wrote:
>>From the spec:
> "7.1.5 Response to Hard Resets
> Hard Reset Signaling indicates a communication failure has occurred and
> the Source Shall stop driving VCONN, Shall remove Rp from the VCONN pin
> and Shall drive VBUS to vSafe0V as shown in Figure 7-9. The USB connection
> May reset during a Hard Reset since the VBUS voltage will be less than
> vSafe5V for an extended period of time. After establishing the vSafe0V
> voltage condition on VBUS, the Source Shall wait tSrcRecover before
> re-applying VCONN and restoring VBUS to vSafe5V. A Source Shall conform
> to the VCONN timing as specified in [USB Type-C 1.3]."
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 3ef37202ee37..e41c4e5d3c71 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -3372,13 +3372,19 @@ static void run_state_machine(struct tcpm_port *port)
>  			tcpm_set_state(port, SNK_HARD_RESET_SINK_OFF, 0);
>  		break;
>  	case SRC_HARD_RESET_VBUS_OFF:
> -		tcpm_set_vconn(port, true);
> +		/*
> +		 * 7.1.5 Response to Hard Resets
> +		 * Hard Reset Signaling indicates a communication failure has occurred and the
> +		 * Source Shall stop driving VCONN, Shall remove Rp from the VCONN pin and Shall
> +		 * drive VBUS to vSafe0V as shown in Figure 7-9.
> +		 */
> +		tcpm_set_vconn(port, false);
>  		tcpm_set_vbus(port, false);
>  		tcpm_set_roles(port, port->self_powered, TYPEC_SOURCE,
>  			       tcpm_data_role_for_source(port));
> -		tcpm_set_state(port, SRC_HARD_RESET_VBUS_ON, PD_T_SRC_RECOVER);

I am a bit concerned about this. If I understand correctly, it means that
we won't turn VBUS back on unless a SRC_HARD_RESET_VBUS_OFF PD event is received.
Is that correct ? What happens if that event is never received ?

Thanks,
Guenter

>  		break;
>  	case SRC_HARD_RESET_VBUS_ON:
> +		tcpm_set_vconn(port, true);
>  		tcpm_set_vbus(port, true);
>  		port->tcpc->set_pd_rx(port->tcpc, true);
>  		tcpm_set_attached_state(port, true);
> @@ -3944,7 +3950,11 @@ static void _tcpm_pd_vbus_off(struct tcpm_port *port)
>  		tcpm_set_state(port, SNK_HARD_RESET_WAIT_VBUS, 0);
>  		break;
>  	case SRC_HARD_RESET_VBUS_OFF:
> -		tcpm_set_state(port, SRC_HARD_RESET_VBUS_ON, 0);
> +		/*
> +		 * After establishing the vSafe0V voltage condition on VBUS, the Source Shall wait
> +		 * tSrcRecover before re-applying VCONN and restoring VBUS to vSafe5V.
> +		 */
> +		tcpm_set_state(port, SRC_HARD_RESET_VBUS_ON, PD_T_SRC_RECOVER);
>  		break;
>  	case HARD_RESET_SEND:
>  		break;
> 

