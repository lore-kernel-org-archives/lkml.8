Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B3AC2BB84
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 00:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9617F2080A
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 00:03:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YkrDh/el"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbgIHADj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 20:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728252AbgIHADc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 20:03:32 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF819C061573
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 17:03:30 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id 60so519773otw.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 17:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L8oNMgR3V486OSRxon6NQEkiONwS5O4dd9QWGg4Xngc=;
        b=YkrDh/elvp6AlfWLCCw41Cv611AXJ0pzoGq0h2OjJgSu7mW0RuIgIVq6z95Nwih60M
         A6fnnBhd92YqOAzaTDKqS+GYrNwXvB5VfmeBlOEhmNWVkR05jkeO4mQZU9y/UE56nLst
         0L49/h4RwACTfVWL35h9PJTCB0J9e35905HdScsCW/wBqiQFsJeV7lEsrtdJo7ZGioJd
         obARRG4eFocg1zhdKlmkwkBIhrVvJfcGXLpaD1kg2cWA0S06WALmdka6VqDE0+t5GMsj
         cQwuzYNC5fJc2GNihar2g7I0AQoaFAE/OS7lS3k03EWj4RKMykZBM44ilb8g1+/Uki4I
         ITmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=L8oNMgR3V486OSRxon6NQEkiONwS5O4dd9QWGg4Xngc=;
        b=pfbNvSiwTqyEMO2PazIddMJv6P8uLMAtTERj/eGINeGq3gN/FbrNMIndE87NnHfXwN
         VroFMcH5pHNhHBiwjeE23Tw/2YSEyIoXCx6XTh+H9jPE4X3CtBTB3LUxGlmiBzHrkb91
         krr5TgldyYN5ckfF1IHMb/+QlZMOeo/YsLnEDNa8B2dsR7a6i6U3mXLp7z42gp+F5KX9
         amfD2gAZ+pyFvzeB8Osoza+ea6ucu7mFJq0x8/IlMpAgQwyVPajFzH6takQPLYUmuNzM
         E9X0htvBNDNSTdWBpCH2AA+6jXbUg7D36LkdwqmwxpAC+FcC/4f1rryj4NSYSlIRe3Vb
         bFcQ==
X-Gm-Message-State: AOAM532+sGyAVFDez5zrf28ZDGVpThKs+Qpd/ppw3ZF+oCYmrlGTkiei
        z9aHXwT5HvZb6cg1Gjx5dg==
X-Google-Smtp-Source: ABdhPJx4xHUKZjAD0PXmb/o0pO/ou6m/g3Z/JN1DNQVsf5+MuZdVc/v6st5nCRnQuvMzYbhOogpweA==
X-Received: by 2002:a9d:69c9:: with SMTP id v9mr15168348oto.90.1599523410109;
        Mon, 07 Sep 2020 17:03:30 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id 91sm3291127otn.18.2020.09.07.17.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 17:03:29 -0700 (PDT)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:84ed:77c1:d49f:5e6b])
        by serve.minyard.net (Postfix) with ESMTPSA id E63F818003B;
        Tue,  8 Sep 2020 00:03:27 +0000 (UTC)
Date:   Mon, 7 Sep 2020 19:03:26 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Markus Boehme <markubo@amazon.com>
Cc:     openipmi-developer@lists.sourceforge.net,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Stefan Nuernberger <snu@amazon.com>,
        SeongJae Park <sjpark@amazon.com>, Amit Shah <aams@amazon.com>
Subject: Re: [PATCH 1/3] ipmi: Reset response handler when failing to send
 the command
Message-ID: <20200908000326.GB15602@minyard.net>
Reply-To: minyard@acm.org
References: <1599495937-10654-1-git-send-email-markubo@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1599495937-10654-1-git-send-email-markubo@amazon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 07, 2020 at 06:25:35PM +0200, Markus Boehme wrote:
> When failing to send a command we don't expect a response. Clear the
> `null_user_handler` like is done in the success path.

This is correct.  I guess, from the next two patches, I know how you
found this.

I can incude this, but I will ask some questions in the later patches.

-corey

> 
> Signed-off-by: Markus Boehme <markubo@amazon.com>
> ---
>  drivers/char/ipmi/ipmi_msghandler.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
> index 737c0b6..2b213c9 100644
> --- a/drivers/char/ipmi/ipmi_msghandler.c
> +++ b/drivers/char/ipmi/ipmi_msghandler.c
> @@ -2433,7 +2433,7 @@ static int __get_device_id(struct ipmi_smi *intf, struct bmc_device *bmc)
>  
>  	rv = send_get_device_id_cmd(intf);
>  	if (rv)
> -		return rv;
> +		goto out_reset_handler;
>  
>  	wait_event(intf->waitq, bmc->dyn_id_set != 2);
>  
> @@ -2443,6 +2443,7 @@ static int __get_device_id(struct ipmi_smi *intf, struct bmc_device *bmc)
>  	/* dyn_id_set makes the id data available. */
>  	smp_rmb();
>  
> +out_reset_handler:
>  	intf->null_user_handler = NULL;
>  
>  	return rv;
> @@ -3329,6 +3330,7 @@ static int __scan_channels(struct ipmi_smi *intf, struct ipmi_device_id *id)
>  			dev_warn(intf->si_dev,
>  				 "Error sending channel information for channel 0, %d\n",
>  				 rv);
> +			intf->null_user_handler = NULL;
>  			return -EIO;
>  		}
>  
> -- 
> 2.7.4
> 
