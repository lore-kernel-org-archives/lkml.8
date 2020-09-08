Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0659C2D0E0
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 00:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC56321D1A
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 00:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pgM6rS69"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbgIHAeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 20:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727769AbgIHAeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 20:34:16 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7F9C061573
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 17:34:16 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id 37so13479341oto.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 17:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IzyYGVSiPefOaHIUtuxegpqEgrmuiDQww3Jq/w4wJEQ=;
        b=pgM6rS69oF8ZUeDRqlGRHXpQx7OqSJ3L+sBs04IeFc5CSjMch/OoecjaoXTW1nySBa
         UBpNaQofKmoYgLFXei1vbfk4iPjkbAMDNvXL3pbFt4/qXIyEjsmpApCdbxj8yQh2DVLO
         +riq8alabr3hOvN6/mrmbCoIo6NRvo5sfmIybnIoQsOajrMRIpJWmai2ccgfdSsmQXm1
         t5BuX1iLBCY4Gjf+TY2v4wEw4EUQW14ibLyJ3is+Hm8eHqd+7ku8igt3oHP8b3hjGNUc
         UC2GrV8nseTwqcwAhvf5dpUyw6iMkCSKydMCX9cEYXT66YYzs7qGFNW6vUdbU0X1uXQM
         788A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=IzyYGVSiPefOaHIUtuxegpqEgrmuiDQww3Jq/w4wJEQ=;
        b=ow5vruPpPdteu5q8Lg9feNwQKG19SDJEwE+bGMjlkg/4aEcGkkD/CTpru0ygjwWlzb
         1CnAaUfxOwXHwzHaUblyh1rnmO0gnqSabmGDtDptRWUna28tounFUKvY+2kE2sEjp2rm
         qL7/eRNy5h8B8XWDqjcUrP01wWX+2eG7G+wNAHhlj6eJY5Sgjp5oonqJZOr9/F1yEeu1
         fWipwUVAs17Yb14IgOPPt/Ey5TavI/0zbKSHlcdiF29+uDhMtAgJY6l9OQFvnmDEUJg/
         SryCG0DTIJCyiLpyDaFs6AY9tMhiWkgq3PLRbJe46qS+4yzMwXiSv1Tpgfdo7zR2EUja
         FA3g==
X-Gm-Message-State: AOAM530Z3dFXUkinvCn4yM3VhZivvLp04wiNiOmrD3z6TmoLQ7/2l6bv
        xtHFZQGoFGMxK7xJiv0Alw==
X-Google-Smtp-Source: ABdhPJwC8fMi7Pn4i7STFy7PUABbRXZ2fBsb0bxYPawrSY0cUukelBa64d/F0l5mx4a8MXtmOV2sdg==
X-Received: by 2002:a9d:2925:: with SMTP id d34mr16024171otb.140.1599525255598;
        Mon, 07 Sep 2020 17:34:15 -0700 (PDT)
Received: from serve.minyard.net ([47.184.170.156])
        by smtp.gmail.com with ESMTPSA id j20sm3237061ots.5.2020.09.07.17.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 17:34:14 -0700 (PDT)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:84ed:77c1:d49f:5e6b])
        by serve.minyard.net (Postfix) with ESMTPSA id D531C18003B;
        Tue,  8 Sep 2020 00:34:13 +0000 (UTC)
Date:   Mon, 7 Sep 2020 19:34:12 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Markus Boehme <markubo@amazon.com>
Cc:     openipmi-developer@lists.sourceforge.net,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Stefan Nuernberger <snu@amazon.com>,
        SeongJae Park <sjpark@amazon.com>, Amit Shah <aams@amazon.com>
Subject: Re: [PATCH 3/3] ipmi: Add timeout waiting for channel information
Message-ID: <20200908003412.GD15602@minyard.net>
Reply-To: minyard@acm.org
References: <1599495937-10654-1-git-send-email-markubo@amazon.com>
 <1599495937-10654-3-git-send-email-markubo@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1599495937-10654-3-git-send-email-markubo@amazon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 07, 2020 at 06:25:37PM +0200, Markus Boehme wrote:
> We have observed hosts with misbehaving BMCs that receive a Get Channel
> Info command but don't respond. This leads to an indefinite wait in the
> ipmi_msghandler's __scan_channels function, showing up as hung task
> messages for modprobe.
> 
> Add a timeout waiting for the channel scan to complete. If the scan
> fails to complete within that time, treat that like IPMI 1.0 and only
> assume the presence of the primary IPMB channel at channel number 0.

This patch is a significant rewrite of the function.  This makes me a
little uncomfortable.  It's generally better to fix the bug in a minimal
patch.  It would be easier to read if you had two patches, one to
restructure the code and one to fix the bug.

One comment inline, but it doesn't matter, because...

While thinking about this, I realized an issue with these patches.
There should be timers in the lower layers that detect that the BMC does
not respond and should return an error response.  This is supposed to be
guaranteed by the lower layer, you shouldn't need timers here.  In fact,
if you abort with a timer here, you should get a lower layer reponds
later, causing other issues.

So, this is wrong.  If you are never getting a response, there is a bug
in the lower layer.  If you are not getting the error response as
quickly as you would like, I'm not sure what to do about that.

The first patch, of course, is an obvious bug fix.  I'll include that.

-corey

> 
> Signed-off-by: Stefan Nuernberger <snu@amazon.com>
> Signed-off-by: Markus Boehme <markubo@amazon.com>
> ---
>  drivers/char/ipmi/ipmi_msghandler.c | 72 ++++++++++++++++++++-----------------
>  1 file changed, 39 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
> index 2a2e8b2..9de9ba6 100644
> --- a/drivers/char/ipmi/ipmi_msghandler.c
> +++ b/drivers/char/ipmi/ipmi_msghandler.c
> @@ -3315,46 +3315,52 @@ channel_handler(struct ipmi_smi *intf, struct ipmi_recv_msg *msg)
>   */
>  static int __scan_channels(struct ipmi_smi *intf, struct ipmi_device_id *id)
>  {
> -	int rv;
> +	long rv;
> +	unsigned int set;
>  
> -	if (ipmi_version_major(id) > 1
> -			|| (ipmi_version_major(id) == 1
> -			    && ipmi_version_minor(id) >= 5)) {
> -		unsigned int set;
> +	if (ipmi_version_major(id) == 1 && ipmi_version_minor(id) < 5) {

This is incorrect, it will not correctly handle IPMI 0.x BMCs.  Yes,
they exist.

> +		set = intf->curr_working_cset;
> +		goto single_ipmb_channel;
> +	}
>  
> -		/*
> -		 * Start scanning the channels to see what is
> -		 * available.
> -		 */
> -		set = !intf->curr_working_cset;
> -		intf->curr_working_cset = set;
> -		memset(&intf->wchannels[set], 0,
> -		       sizeof(struct ipmi_channel_set));
> -
> -		intf->null_user_handler = channel_handler;
> -		intf->curr_channel = 0;
> -		rv = send_channel_info_cmd(intf, 0);
> -		if (rv) {
> -			dev_warn(intf->si_dev,
> -				 "Error sending channel information for channel 0, %d\n",
> -				 rv);
> -			intf->null_user_handler = NULL;
> -			return -EIO;
> -		}
> +	/*
> +	 * Start scanning the channels to see what is
> +	 * available.
> +	 */
> +	set = !intf->curr_working_cset;
> +	intf->curr_working_cset = set;
> +	memset(&intf->wchannels[set], 0, sizeof(struct ipmi_channel_set));
>  
> -		/* Wait for the channel info to be read. */
> -		wait_event(intf->waitq, intf->channels_ready);
> +	intf->null_user_handler = channel_handler;
> +	intf->curr_channel = 0;
> +	rv = send_channel_info_cmd(intf, 0);
> +	if (rv) {
> +		dev_warn(intf->si_dev,
> +			 "Error sending channel information for channel 0, %ld\n",
> +			 rv);
>  		intf->null_user_handler = NULL;
> -	} else {
> -		unsigned int set = intf->curr_working_cset;
> +		return -EIO;
> +	}
>  
> -		/* Assume a single IPMB channel at zero. */
> -		intf->wchannels[set].c[0].medium = IPMI_CHANNEL_MEDIUM_IPMB;
> -		intf->wchannels[set].c[0].protocol = IPMI_CHANNEL_PROTOCOL_IPMB;
> -		intf->channel_list = intf->wchannels + set;
> -		intf->channels_ready = true;
> +	/* Wait for the channel info to be read. */
> +	rv = wait_event_timeout(intf->waitq, intf->channels_ready, 5 * HZ);
> +	if (rv == 0) {
> +		dev_warn(intf->si_dev,
> +			 "Timed out waiting for channel information. Assuming a single IPMB channel at 0.\n");
> +		goto single_ipmb_channel;
>  	}
>  
> +	goto out;
> +
> +single_ipmb_channel:
> +	/* Assume a single IPMB channel at zero. */
> +	intf->wchannels[set].c[0].medium = IPMI_CHANNEL_MEDIUM_IPMB;
> +	intf->wchannels[set].c[0].protocol = IPMI_CHANNEL_PROTOCOL_IPMB;
> +	intf->channel_list = intf->wchannels + set;
> +	intf->channels_ready = true;
> +
> +out:
> +	intf->null_user_handler = NULL;
>  	return 0;
>  }
>  
> -- 
> 2.7.4
> 
