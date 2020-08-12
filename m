Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68652C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 01:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39F962054F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 01:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uuYeM7kN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgHLBnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 21:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbgHLBnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 21:43:21 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398C3C06174A;
        Tue, 11 Aug 2020 18:43:21 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id y206so193275pfb.10;
        Tue, 11 Aug 2020 18:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YES8VqMRuW00rmoC1R22Qi8IRpCzo5Gd0iswt9weQBg=;
        b=uuYeM7kNudgVbWQu1/imVKTRbpa9ZXbLkEF5NJLrv7T8D4N/DulEodE4drALGxPjOG
         mX6gsZuBYp4iW9hxkfWBIj8ph43PrXBC6gqu4j++eD8bnDfaOnQSFkT4Qz5IHeP8MXRB
         PScch6wA9IKvyXbZbFfiFRH82Hos5k6mTBnPzY2wau7UZBpN4G1Z+VzQ4VKCEicUltY7
         s4l8xUYJwy89Tez+276WXVuBBCLA3x3X9loEv92v9tHAvE6dKwGImFUNDEJ9PUpxdJEA
         wvKhanOcxp9/v2np8e7D0AhOUI6nh0acZesZ0Lrnrwl+ESNOObvIE/CHWF9WR8J4gaOH
         8BzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=YES8VqMRuW00rmoC1R22Qi8IRpCzo5Gd0iswt9weQBg=;
        b=Sa1OcGGzAwkcs4FE+UR5oZTTiidXS8plQCzgVUSVsWCEILdHykInV4Q05S5nD9/wuQ
         zw3rRWx3LYIHzAXfVauC2p4W+RR4fAjGVQ9SOFprDW7BbaOZi8gs9JKz65UAwhHe4d9p
         XKNL1GqzaskBlUcXZ9k0HjybgwZfo+eW36N1NHrOB22yD7NXGHB6vp7cwD9FZVtOglfE
         b9MWQBYAPFc6oA3dbWj/Bzcz/wMKJRW9SKy9uyvnwqHAZAxBHRfDttkNrmYVm4eseE5i
         S7QfR+A0jKUY9XbMQGtQDCT8K3QybavhicTx5mLlWyUEh+lZqNG9M14U/PHli4wjcBuO
         6Qlg==
X-Gm-Message-State: AOAM532PkLtb6f0fw56CnIdsN1hdukFVezSDxUSbOK7NShrMlhVmLSlT
        ICeX/ZQB5b5YcqNJyJ/ZbYVoFvSA
X-Google-Smtp-Source: ABdhPJx9Tcy5SwC6zv8KnJYxeeqYGcqs8v2ZQX3B4E8jW9jFCc17HgCGk+ogXmP1jWhchVH5fKKEsg==
X-Received: by 2002:a62:1614:: with SMTP id 20mr8896080pfw.258.1597196600691;
        Tue, 11 Aug 2020 18:43:20 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e2sm356626pfm.37.2020.08.11.18.43.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Aug 2020 18:43:20 -0700 (PDT)
Date:   Tue, 11 Aug 2020 18:43:19 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tcpm: During PR_SWAP, source caps should be sent only
 after tSwapSourceStart
Message-ID: <20200812014319.GA116801@roeck-us.net>
References: <20200812001439.545655-1-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200812001439.545655-1-badhri@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 05:14:39PM -0700, Badhri Jagan Sridharan wrote:
> From the spec:
> "6.6.8.1 SwapSourceStartTimer
> The SwapSourceStartTimer Shall be used by the new Source, after a Power
> Role Swap or Fast Role Swap, to ensure that it does not send
> Source_Capabilities Message before the new Sink is ready to receive the
> Source_Capabilities Message. The new Source Shall Not send the
> Source_Capabilities Message earlier than tSwapSourceStart after the
> last bit of the EOP of GoodCRC Message sent in response to the PS_RDY
> Message sent by the new Source indicating that its power supply is
> ready."
> 
> This fixes TD.PD.CP.E3, TD.PD.CP.E4, TD.PD.CP.E5 failures
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>

Nit below, otherwise

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Note that I wasn't copied on this patch and only noticed it accidentally.

Guenter

> ---
> Changes since V1:
> - Comment on the permissible values of tSwapSourceStart
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 2 +-
>  include/linux/usb/pd.h        | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 3ef37202ee37..d38347bd3335 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -3555,7 +3555,7 @@ static void run_state_machine(struct tcpm_port *port)
>  		 */
>  		tcpm_set_pwr_role(port, TYPEC_SOURCE);
>  		tcpm_pd_send_control(port, PD_CTRL_PS_RDY);
> -		tcpm_set_state(port, SRC_STARTUP, 0);
> +		tcpm_set_state(port, SRC_STARTUP, PD_T_SWAP_SRC_START);
>  		break;
>  
>  	case VCONN_SWAP_ACCEPT:
> diff --git a/include/linux/usb/pd.h b/include/linux/usb/pd.h
> index b6c233e79bd4..ed5eed73ccf8 100644
> --- a/include/linux/usb/pd.h
> +++ b/include/linux/usb/pd.h
> @@ -473,6 +473,7 @@ static inline unsigned int rdo_max_power(u32 rdo)
>  #define PD_T_ERROR_RECOVERY	100	/* minimum 25 is insufficient */
>  #define PD_T_SRCSWAPSTDBY      625     /* Maximum of 650ms */
>  #define PD_T_NEWSRC            250     /* Maximum of 275ms */
> +#define PD_T_SWAP_SRC_START	20     /* Minimum of 20ms */

Odd alignment. Same as with the previous two lines which don't use tabs
either.

>  
>  #define PD_T_DRP_TRY		100	/* 75 - 150 ms */
>  #define PD_T_DRP_TRYWAIT	600	/* 400 - 800 ms */
