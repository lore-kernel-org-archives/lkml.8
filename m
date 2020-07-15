Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDB6C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 16:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D31202065E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 16:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mGCLh8sm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgGOQYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 12:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbgGOQYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 12:24:10 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B0DC061755;
        Wed, 15 Jul 2020 09:24:09 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id z5so3318680pgb.6;
        Wed, 15 Jul 2020 09:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n1owiFS7zFRAwYxxmKrW5ayuAVDGr5L90IuLEk/BlMU=;
        b=mGCLh8smW73FQqNooYUV59HNgCW/VTKhYFcghPxw98L9oiNtnl3s7mM65etHaap9UI
         Qc7Xo5cZyATcPkV7+2/B4T4hR20Riqn4cqJ13GEtEac4oHdJNltx4S5pQHsnQDX+LLin
         zb3e7DCNus4w2CCvcmdKY8NJb01E6EgJPu9RIMJ0YHi8ateoe68xq/WMvkWGp8fxQIlb
         dYMkYMpKm4eNrtn6bg4tj9mUNZxJjTcsoPXBO2x9WW+ZPkibs+4CkYbVd1Y+dLgIA/ax
         HDmcXDPlbQsdEmkODoptIw/PZDRofOGomTc6DVq4Q7t2gaTLpXFPVSMth8g8ElfBayf7
         xiMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=n1owiFS7zFRAwYxxmKrW5ayuAVDGr5L90IuLEk/BlMU=;
        b=a44C8fa3GwrVZKR+jP840bDD7u2QMjS2cxEr1EXLdsynX0qDpNs5kxQaWYSfwSMuVd
         Pmr5n+Tr1O26HLQ9QRhJSN0anqcDck7RfsjW9TptZZdHa7uPoSpTSCkmvAQyeRgq9aYj
         jZOx5T6V/vvAdHKALMkd+1e5H1kRnSZqzderhzOdHq7HO2gW37YH8NjZut1T2RXJNfZK
         mkbFY62U5RVOF7TH8MDfkAthgMIRu9HcZAvry/kHF27KGX7nZ0NpUErNjW8Y+sZiIqEx
         blpeM71nQQQvQtqL+G5vVF+jFOzhOLqJtoVkmtpXTsyHumjOL19FmMt6pSGQDav2vp42
         e+ug==
X-Gm-Message-State: AOAM53264GHQiLNQdBibToVt1SEorVL5HiAIgB9tabFUVaLcJN9LJ8vp
        gCg5REn++dfqxuGtBWdHSRb/jdAT
X-Google-Smtp-Source: ABdhPJza46HrtNnxP/nz8YHLiABgw3Ik3e6qK3OOAgrkArxsqSvnu2yOl8S3Bv5oboG+a1/D1eUTGw==
X-Received: by 2002:a65:64c5:: with SMTP id t5mr474232pgv.28.1594830249130;
        Wed, 15 Jul 2020 09:24:09 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d16sm2568537pfo.156.2020.07.15.09.24.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2020 09:24:08 -0700 (PDT)
Subject: Re: [PATCH 1/3 v2] usb: typec: tcpci: Support BIST test data mode for
 compliance.
To:     Badhri Jagan Sridharan <badhri@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        reg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200714231207.866838-1-badhri@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <0e8bb91c-031f-7e39-4343-c2c4c4ad9692@roeck-us.net>
Date:   Wed, 15 Jul 2020 09:24:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200714231207.866838-1-badhri@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/20 4:12 PM, Badhri Jagan Sridharan wrote:
> Quoting from TCPCI spec:
> "Setting this bit to 1 is intended to be used only when a USB compliance
> tester is using USB BIST Test Data to test the PHY layer of the TCPC. The
> TCPM should clear this bit when a disconnect is detected.
> 0: Normal Operation. Incoming messages enabled by RECEIVE_DETECT
> passed to TCPM via Alert.
> 1: BIST Test Mode. Incoming messages enabled by RECEIVE_DETECT
> result in GoodCRC response but may not be passed to the TCPM via
> Alert."
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>

This needs to be the second patch in the series. The set_bist_data
callback doesn't exist yet.

Other than that, for the code itself:

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Version history:
> Changes since V1:(Guenter's suggestions)
> - Split the change into two: TCPM and TCPCI
> - Move BIST log to TCPM log
> - Alignment and column count changes
> ---
>  drivers/usb/typec/tcpm/tcpci.c | 9 +++++++++
>  drivers/usb/typec/tcpm/tcpci.h | 1 +
>  2 files changed, 10 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
> index 753645bb25273a..f57d91fd0e0924 100644
> --- a/drivers/usb/typec/tcpm/tcpci.c
> +++ b/drivers/usb/typec/tcpm/tcpci.c
> @@ -227,6 +227,14 @@ static int tcpci_set_vconn(struct tcpc_dev *tcpc, bool enable)
>  				enable ? TCPC_POWER_CTRL_VCONN_ENABLE : 0);
>  }
>  
> +static int tcpci_set_bist_data(struct tcpc_dev *tcpc, bool enable)
> +{
> +	struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
> +
> +	return regmap_update_bits(tcpci->regmap, TCPC_TCPC_CTRL, TCPC_TCPC_CTRL_BIST_TM,
> +				 enable ? TCPC_TCPC_CTRL_BIST_TM : 0);
> +}
> +
>  static int tcpci_set_roles(struct tcpc_dev *tcpc, bool attached,
>  			   enum typec_role role, enum typec_data_role data)
>  {
> @@ -530,6 +538,7 @@ struct tcpci *tcpci_register_port(struct device *dev, struct tcpci_data *data)
>  	tcpci->tcpc.set_pd_rx = tcpci_set_pd_rx;
>  	tcpci->tcpc.set_roles = tcpci_set_roles;
>  	tcpci->tcpc.pd_transmit = tcpci_pd_transmit;
> +	tcpci->tcpc.set_bist_data = tcpci_set_bist_data;
>  
>  	err = tcpci_parse_config(tcpci);
>  	if (err < 0)
> diff --git a/drivers/usb/typec/tcpm/tcpci.h b/drivers/usb/typec/tcpm/tcpci.h
> index 303ebde265465c..11c36d086c8608 100644
> --- a/drivers/usb/typec/tcpm/tcpci.h
> +++ b/drivers/usb/typec/tcpm/tcpci.h
> @@ -36,6 +36,7 @@
>  
>  #define TCPC_TCPC_CTRL			0x19
>  #define TCPC_TCPC_CTRL_ORIENTATION	BIT(0)
> +#define TCPC_TCPC_CTRL_BIST_TM		BIT(1)
>  
>  #define TCPC_ROLE_CTRL			0x1a
>  #define TCPC_ROLE_CTRL_DRP		BIT(6)
> 

