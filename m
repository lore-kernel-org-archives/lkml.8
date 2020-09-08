Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D15C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 00:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA8FB2193E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 00:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YHGL1MCJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbgIHAH6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 20:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727058AbgIHAH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 20:07:56 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5BA6C061573
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 17:07:56 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id 11so6543839oiq.6
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 17:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0MQIFD0wSalUsY9jIwWCsu5F2vysByo4q9dNLulJ/BE=;
        b=YHGL1MCJ0qBeAdroqQwPzNeRgphRAZwvlt1bZQSqOdTCKQIOo1NCczfWD7rrkfEC76
         wUlyVWhTmY+o6YX9wr2V9H9ZmmXDdZXr8ofNtZKLBhbXSIuCHNUixPdDBu+qCP6lkLl4
         HlAW/r/upZQVvGXyI3DutyYz91ognzMFDJ68ukDPqZk81ZYdJfBKUIJj5GYeFKraFpRX
         sk+J0dmHR9eeWGLbdXchWHVIWSlvr7aCj8sQjD8wGCAt8wgxGnj8uQ1oTD6oIhCkB6QQ
         7LbuPmbfFp6t3OTXaPyl7Cl2gEYDOdJdmsZo9fFW3MoGIB056fUgEUfYdQPmTwv6p1MJ
         y6lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=0MQIFD0wSalUsY9jIwWCsu5F2vysByo4q9dNLulJ/BE=;
        b=kevnSfw1XQHY3k0Vj0kFfkHdhRUvVJZBgWauhNGQan9/QyliYJ+4uoiYJvk59sDx0J
         K0X6FyifcKMLOlaz+TErBG+YvoRdFSYADmCijqZDkRVJUF8GV1rmlVC6rZhAA9/47nPc
         mA3zYTyfc7fzx0cY14HZexdbymDeJCpmyQ6Cv8/xkiDPM8OLllDOA4B4wn71tg49SYEF
         E7sH7HUneVVTILCIvJC6EnZVsUj8Tply28dpSSJbMlBdfy7MPdjlNL8IUCA6NakfAiSD
         K6LUWQaXmrC9xsBkRsHLEDYT64oqQg7DFBdAUoVkgTErsIalkHYGbr+aJIETBC1e6IsJ
         kYGg==
X-Gm-Message-State: AOAM531z1LoQdmEviQNbS/pYeil48WGSr6rl7pXkjqDttWP/s+Ubl2AW
        Do5t0Ln5SoWqnzk2RxITSA==
X-Google-Smtp-Source: ABdhPJylqM+6LzCyyHHbYv5f+3+wRyhKMMat4iC74kHjMarIVyRYEWMM2QveN4Qjm7uF5280ucheSQ==
X-Received: by 2002:aca:fc07:: with SMTP id a7mr1085851oii.106.1599523676274;
        Mon, 07 Sep 2020 17:07:56 -0700 (PDT)
Received: from serve.minyard.net ([47.184.170.156])
        by smtp.gmail.com with ESMTPSA id h24sm2764562otj.33.2020.09.07.17.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 17:07:55 -0700 (PDT)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:84ed:77c1:d49f:5e6b])
        by serve.minyard.net (Postfix) with ESMTPSA id C503B18003B;
        Tue,  8 Sep 2020 00:07:54 +0000 (UTC)
Date:   Mon, 7 Sep 2020 19:07:53 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Markus Boehme <markubo@amazon.com>
Cc:     openipmi-developer@lists.sourceforge.net,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Stefan Nuernberger <snu@amazon.com>,
        SeongJae Park <sjpark@amazon.com>, Amit Shah <aams@amazon.com>
Subject: Re: [PATCH 2/3] ipmi: Add timeout waiting for device GUID
Message-ID: <20200908000753.GC15602@minyard.net>
Reply-To: minyard@acm.org
References: <1599495937-10654-1-git-send-email-markubo@amazon.com>
 <1599495937-10654-2-git-send-email-markubo@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1599495937-10654-2-git-send-email-markubo@amazon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 07, 2020 at 06:25:36PM +0200, Markus Boehme wrote:
> We have observed hosts with misbehaving BMCs that receive a Get Device
> GUID command but don't respond. This leads to an indefinite wait in the
> ipmi_msghandler's __get_guid function, showing up as hung task messages
> for modprobe.
> 
> According to IPMI 2.0 specification chapter 20, the implementation of
> the Get Device GUID command is optional. Therefore, add a timeout to
> waiting for its response and treat the lack of one the same as missing a
> device GUID.

This patch looks good.  It's a little bit of a rewrite, but the reasons
are obvious.

-corey

> 
> Signed-off-by: Stefan Nuernberger <snu@amazon.com>
> Signed-off-by: Markus Boehme <markubo@amazon.com>
> ---
>  drivers/char/ipmi/ipmi_msghandler.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
> index 2b213c9..2a2e8b2 100644
> --- a/drivers/char/ipmi/ipmi_msghandler.c
> +++ b/drivers/char/ipmi/ipmi_msghandler.c
> @@ -3184,18 +3184,26 @@ static void guid_handler(struct ipmi_smi *intf, struct ipmi_recv_msg *msg)
>  
>  static void __get_guid(struct ipmi_smi *intf)
>  {
> -	int rv;
> +	long rv;
>  	struct bmc_device *bmc = intf->bmc;
>  
>  	bmc->dyn_guid_set = 2;
>  	intf->null_user_handler = guid_handler;
>  	rv = send_guid_cmd(intf, 0);
> -	if (rv)
> +	if (rv) {
>  		/* Send failed, no GUID available. */
>  		bmc->dyn_guid_set = 0;
> -	else
> -		wait_event(intf->waitq, bmc->dyn_guid_set != 2);
> +		goto out;
> +	}
>  
> +	rv = wait_event_timeout(intf->waitq, bmc->dyn_guid_set != 2, 5 * HZ);
> +	if (rv == 0) {
> +		dev_warn_once(intf->si_dev,
> +			      "Timed out waiting for GUID. Assuming GUID is not available.\n");
> +		bmc->dyn_guid_set = 0;
> +	}
> +
> +out:
>  	/* dyn_guid_set makes the guid data available. */
>  	smp_rmb();
>  
> -- 
> 2.7.4
> 
