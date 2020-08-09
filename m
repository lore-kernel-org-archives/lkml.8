Return-Path: <SRS0=dnKw=BT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25EA4C433E1
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 18:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F24A82067C
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 18:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FkWr+kqG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgHISzq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Aug 2020 14:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbgHISzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 14:55:45 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09775C061786
        for <linux-kernel@vger.kernel.org>; Sun,  9 Aug 2020 11:55:45 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id p8so3671772pgn.13
        for <linux-kernel@vger.kernel.org>; Sun, 09 Aug 2020 11:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PAZaN/L7VPPLwbaC7UrCX4+FJ1ItiEX2Jrle8fqhZ0o=;
        b=FkWr+kqGCgeaKDLnZG6Jb9jbU0UEDeIJtXezXQYcwCJrFPvPkeMT6NFaE4BqOMgwg7
         7IltwePRC1bT8x6/NY6kbdYOlgYMDONJDziZv266NcVAp+h7IRyKV3f81KqhOJpCZSDx
         v+n7zkQnpyd4glU8pLOxAQOzYKkjDPZlF6OjErb1yprLmzjcRhDp3TGpVxmuFk0BOrHP
         TFqf5mOniK8ky7b6/OxykfdXWNfhEd/lQ3GtAl3fDEKNer241lNtdi3Y39dCS414HbGA
         RUUvyWVtyniOlaShzpWYNtF5xPDZFdRep9OFep+EOjbx5pkqrPpRcC++OfkKaD+GBaET
         5znA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=PAZaN/L7VPPLwbaC7UrCX4+FJ1ItiEX2Jrle8fqhZ0o=;
        b=fRQxQuoP5BGX45VkJu0/RXWvUPun/Jv3Z9RmJspwON76ZJZBG9Q8vxxtj/hyno0CKp
         51sdrzX6sZYV02ABY+B4lEcH6YB1OWuiGEy4mUUk1GPG0gwUsFWdeYy7SSra2XtEppY1
         b3YVCoWFA96B2VrWV+F0LRil3i5VP/qRq+1nUBnMn89F1UOFzx+2KUApnqX6HYFvena8
         dCs5ef0TyGlpsU/jZtYKzDvqGRPO9nB/AG9VuUl1c76PZYX0YatHkf9uy4Ro77ybMK2j
         lwavwuOmfICYTrcz6YnZhLiLbO/w8K44UQQJ9nsGkMkMy0511spPgjcnoaAeOFK7sa4v
         1ieg==
X-Gm-Message-State: AOAM532vDISpish2bWp4oSSCQuEKdIrnsvvehxFAe34rmAVjpifcLlpR
        J9e/zH+qAVZ8+mQYI9DvnZCjMOTG
X-Google-Smtp-Source: ABdhPJzhi9hHF2qPnMoFx4QOZ2zhNt/Zq4cc6Dq3yX7qgdrpgVmXLJz/nI4iI+9rrn/94a8OOWGU5w==
X-Received: by 2002:a62:5284:: with SMTP id g126mr21785655pfb.139.1596999343723;
        Sun, 09 Aug 2020 11:55:43 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c15sm19191410pfo.115.2020.08.09.11.55.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Aug 2020 11:55:42 -0700 (PDT)
Date:   Sun, 9 Aug 2020 11:55:41 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Joshua Thompson <funaho@jurai.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org,
        Laurent Vivier <lvivier@redhat.com>,
        Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/9] macintosh/via-macii: Poll the device most likely to
 respond
Message-ID: <20200809185541.GA133779@roeck-us.net>
References: <cover.1593318192.git.fthain@telegraphics.com.au>
 <5836f80886ebcfbe5be5fb7e0dc49feed6469712.1593318192.git.fthain@telegraphics.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5836f80886ebcfbe5be5fb7e0dc49feed6469712.1593318192.git.fthain@telegraphics.com.au>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Jun 28, 2020 at 02:23:12PM +1000, Finn Thain wrote:
> Poll the most recently polled device by default, rather than the lowest
> device address that happens to be enabled in autopoll_devs. This improves
> input latency. Re-use macii_queue_poll() rather than duplicate that logic.
> This eliminates a static struct and function.
> 
> Fixes: d95fd5fce88f0 ("m68k: Mac II ADB fixes") # v5.0+
> Tested-by: Stan Johnson <userm57@yahoo.com>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

With this patch applied, the qemu "q800" emulation no longer works and is stuck
in early boot. Any idea why that might be the case, and/or how to debug it ?

Thanks,
Guenter

> ---
>  drivers/macintosh/via-macii.c | 99 +++++++++++++++++++----------------
>  1 file changed, 53 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/macintosh/via-macii.c b/drivers/macintosh/via-macii.c
> index 6aa903529570d..d4f1a65c5f1fd 100644
> --- a/drivers/macintosh/via-macii.c
> +++ b/drivers/macintosh/via-macii.c
> @@ -77,6 +77,10 @@ static volatile unsigned char *via;
>  #define ST_ODD		0x20		/* ADB state: odd data byte */
>  #define ST_IDLE		0x30		/* ADB state: idle, nothing to send */
>  
> +/* ADB command byte structure */
> +#define ADDR_MASK	0xF0
> +#define CMD_MASK	0x0F
> +
>  static int macii_init_via(void);
>  static void macii_start(void);
>  static irqreturn_t macii_interrupt(int irq, void *arg);
> @@ -117,7 +121,8 @@ static int reply_len; /* number of bytes received in reply_buf or req->reply */
>  static int status;          /* VIA's ADB status bits captured upon interrupt */
>  static int last_status;              /* status bits as at previous interrupt */
>  static int srq_asserted;     /* have to poll for the device that asserted it */
> -static int command_byte;         /* the most recent command byte transmitted */
> +static u8 last_cmd;              /* the most recent command byte transmitted */
> +static u8 last_poll_cmd; /* the most recent Talk R0 command byte transmitted */
>  static int autopoll_devs;      /* bits set are device addresses to be polled */
>  
>  /* Check for MacII style ADB */
> @@ -179,35 +184,49 @@ static int macii_init_via(void)
>  /* Send an ADB poll (Talk Register 0 command prepended to the request queue) */
>  static void macii_queue_poll(void)
>  {
> -	/* No point polling the active device as it will never assert SRQ, so
> -	 * poll the next device in the autopoll list. This could leave us
> -	 * stuck in a polling loop if an unprobed device is asserting SRQ.
> -	 * In theory, that could only happen if a device was plugged in after
> -	 * probing started. Unplugging it again will break the cycle.
> -	 * (Simply polling the next higher device often ends up polling almost
> -	 * every device (after wrapping around), which takes too long.)
> -	 */
> -	int device_mask;
> -	int next_device;
>  	static struct adb_request req;
> +	unsigned char poll_command;
> +	unsigned int poll_addr;
>  
> +	/* This only polls devices in the autopoll list, which assumes that
> +	 * unprobed devices never assert SRQ. That could happen if a device was
> +	 * plugged in after the adb bus scan. Unplugging it again will resolve
> +	 * the problem. This behaviour is similar to MacOS.
> +	 */
>  	if (!autopoll_devs)
>  		return;
>  
> -	device_mask = (1 << (((command_byte & 0xF0) >> 4) + 1)) - 1;
> -	if (autopoll_devs & ~device_mask)
> -		next_device = ffs(autopoll_devs & ~device_mask) - 1;
> -	else
> -		next_device = ffs(autopoll_devs) - 1;
> +	/* The device most recently polled may not be the best device to poll
> +	 * right now. Some other device(s) may have signalled SRQ (the active
> +	 * device won't do that). Or the autopoll list may have been changed.
> +	 * Try polling the next higher address.
> +	 */
> +	poll_addr = (last_poll_cmd & ADDR_MASK) >> 4;
> +	if ((srq_asserted && last_cmd == last_poll_cmd) ||
> +	    !(autopoll_devs & (1 << poll_addr))) {
> +		unsigned int higher_devs;
> +
> +		higher_devs = autopoll_devs & -(1 << (poll_addr + 1));
> +		poll_addr = ffs(higher_devs ? higher_devs : autopoll_devs) - 1;
> +	}
>  
> -	adb_request(&req, NULL, ADBREQ_NOSEND, 1, ADB_READREG(next_device, 0));
> +	/* Send a Talk Register 0 command */
> +	poll_command = ADB_READREG(poll_addr, 0);
> +
> +	/* No need to repeat this Talk command. The transceiver will do that
> +	 * as long as it is idle.
> +	 */
> +	if (poll_command == last_cmd)
> +		return;
> +
> +	adb_request(&req, NULL, ADBREQ_NOSEND, 1, poll_command);
>  
>  	req.sent = 0;
>  	req.complete = 0;
>  	req.reply_len = 0;
>  	req.next = current_req;
>  
> -	if (current_req != NULL) {
> +	if (WARN_ON(current_req)) {
>  		current_req = &req;
>  	} else {
>  		current_req = &req;
> @@ -266,37 +285,22 @@ static int macii_write(struct adb_request *req)
>  /* Start auto-polling */
>  static int macii_autopoll(int devs)
>  {
> -	static struct adb_request req;
>  	unsigned long flags;
> -	int err = 0;
>  
>  	local_irq_save(flags);
>  
>  	/* bit 1 == device 1, and so on. */
>  	autopoll_devs = devs & 0xFFFE;
>  
> -	if (autopoll_devs && !current_req) {
> -		/* Send a Talk Reg 0. The controller will repeatedly transmit
> -		 * this as long as it is idle.
> -		 */
> -		adb_request(&req, NULL, ADBREQ_NOSEND, 1,
> -		            ADB_READREG(ffs(autopoll_devs) - 1, 0));
> -		err = macii_write(&req);
> +	if (!current_req) {
> +		macii_queue_poll();
> +		if (current_req && macii_state == idle)
> +			macii_start();
>  	}
>  
>  	local_irq_restore(flags);
> -	return err;
> -}
>  
> -static inline int need_autopoll(void)
> -{
> -	/* Was the last command Talk Reg 0
> -	 * and is the target on the autopoll list?
> -	 */
> -	if ((command_byte & 0x0F) == 0x0C &&
> -	    ((1 << ((command_byte & 0xF0) >> 4)) & autopoll_devs))
> -		return 0;
> -	return 1;
> +	return 0;
>  }
>  
>  /* Prod the chip without interrupts */
> @@ -333,7 +337,12 @@ static void macii_start(void)
>  	 */
>  
>  	/* store command byte */
> -	command_byte = req->data[1];
> +	last_cmd = req->data[1];
> +
> +	/* If this is a Talk Register 0 command, store the command byte */
> +	if ((last_cmd & CMD_MASK) == ADB_READREG(0, 0))
> +		last_poll_cmd = last_cmd;
> +
>  	/* Output mode */
>  	via[ACR] |= SR_OUT;
>  	/* Load data */
> @@ -424,10 +433,11 @@ static irqreturn_t macii_interrupt(int irq, void *arg)
>  				if (req->done)
>  					(*req->done)(req);
>  
> -				if (current_req)
> +				if (!current_req)
> +					macii_queue_poll();
> +
> +				if (current_req && macii_state == idle)
>  					macii_start();
> -				else if (need_autopoll())
> -					macii_autopoll(autopoll_devs);
>  			}
>  
>  			if (macii_state == idle) {
> @@ -507,14 +517,11 @@ static irqreturn_t macii_interrupt(int irq, void *arg)
>  
>  		macii_state = idle;
>  
> -		/* SRQ seen before, initiate poll now */
> -		if (srq_asserted)
> +		if (!current_req)
>  			macii_queue_poll();
>  
>  		if (current_req)
>  			macii_start();
> -		else if (need_autopoll())
> -			macii_autopoll(autopoll_devs);
>  
>  		if (macii_state == idle)
>  			via[B] = (via[B] & ~ST_MASK) | ST_IDLE;
> -- 
> 2.26.2
> 
