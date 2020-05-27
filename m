Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B1DEC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 16:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0006020899
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 16:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WXTLKlT4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730949AbgE0QWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 12:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729884AbgE0QWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 12:22:06 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C241AC05BD1E;
        Wed, 27 May 2020 09:22:05 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x13so11996458pfn.11;
        Wed, 27 May 2020 09:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WgRQyQwNaX2Goqkqxz56C3W/9OHLQN2Fvi2hNnz9VHI=;
        b=WXTLKlT4DSOWS/QRKEwgBx60e9PUQpxizuyNumqo9hlcg+j3aIK5IypbY3wiuPvCrP
         lHSWKRJT3401/pzlyYSaYaWCaNtIx0Oe3uFVjduyC4rhRalJ1Jiumd2PBBbu1VQGektE
         fvMdxe7j4VGD12lK9gQNKu+Fu3icGdPQK6zIEbNymJbzp/UQYe3rAKDZb2X0FLY+b0ps
         MptKaUwzRzIk/pooiucYQXy2bnpWEGt00Vb4HJx6bVoyHeNVURmUS8+6PXwxdWGCXCQ5
         L+sU2jjXvrMGONnXjeYig+bYNLnWUeicbCGqU61nnx3nhFJky0eAyWRlO98J6PcSZ9Xg
         wRaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=WgRQyQwNaX2Goqkqxz56C3W/9OHLQN2Fvi2hNnz9VHI=;
        b=n9+56mDD4ff55NyYiicO/4l5N6gqvYlGw+KoApEy1TjNucg62X8X1k3ChJIyGXQ2gW
         4HyTNfdfGWxFrBkzk2LX9sepVzm/ep6QZSsallUaWuULd/ykFfIougp6Clw24PwbX6LH
         /xMwJisyzbnliDUlKn88ZytbwtklNHwYtvqEILHK6thvF7h9Foqk1iUJlvdnzhyH+7Vv
         m/eKmBzliY7yWHmptiyS6z82wjj5tkzg/+vvN2RRmqDgx5jdISE/EwHEnGb78oXh3MCb
         6Z3BqSYNQM3pa6EveH5i8YG5vYEMx/b3YTPJln9M5+ibW3YJLE9v9zObe1Sws1QWOe9X
         BJqA==
X-Gm-Message-State: AOAM532RZMk4MoNGf6ox7Bwp14/ZNGTp74mb1g3ZzSC24eZad4jt103O
        PwIoG9KV8SekzpRDDpnQWsGYXEgR
X-Google-Smtp-Source: ABdhPJzRtB8OPaaMMidgRqp6P8SP7e9kmlEVKfCwxPFfK162MWraL2Da+SZFXSVdSyq2lAVN3Lp0LA==
X-Received: by 2002:a62:1d89:: with SMTP id d131mr4679473pfd.294.1590596525275;
        Wed, 27 May 2020 09:22:05 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w26sm2469857pfj.20.2020.05.27.09.22.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 May 2020 09:22:04 -0700 (PDT)
Date:   Wed, 27 May 2020 09:22:03 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Henrik Rydberg <rydberg@bitmath.org>,
        Jean Delvare <jdelvare@suse.com>,
        Richard Fontana <rfontana@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] hwmon: applesmc: avoid overlong udelay()
Message-ID: <20200527162203.GA149714@roeck-us.net>
References: <20200527135207.1118624-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527135207.1118624-1-arnd@arndb.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 03:51:57PM +0200, Arnd Bergmann wrote:
> Building this driver with "clang -O3" produces a link error
> after the compiler partially unrolls the loop and 256ms
> becomes a compile-time constant that triggers the check
> in udelay():
> 
> ld.lld: error: undefined symbol: __bad_udelay
> >>> referenced by applesmc.c
> >>>               hwmon/applesmc.o:(read_smc) in archive drivers/built-in.a
> 
> I can see no reason against using a sleeping function here,
> as no part of the driver runs in atomic context, so instead use
> usleep_range() with a wide range and use jiffies for the
> end condition.
> 
Me not either.

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/applesmc.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
> index ec93b8d673f5..316618409315 100644
> --- a/drivers/hwmon/applesmc.c
> +++ b/drivers/hwmon/applesmc.c
> @@ -156,14 +156,19 @@ static struct workqueue_struct *applesmc_led_wq;
>   */
>  static int wait_read(void)
>  {
> +	unsigned long end = jiffies + (APPLESMC_MAX_WAIT * HZ) / USEC_PER_SEC;
>  	u8 status;
>  	int us;
> +
>  	for (us = APPLESMC_MIN_WAIT; us < APPLESMC_MAX_WAIT; us <<= 1) {
> -		udelay(us);
> +		usleep_range(us, us * 16);
>  		status = inb(APPLESMC_CMD_PORT);
>  		/* read: wait for smc to settle */
>  		if (status & 0x01)
>  			return 0;
> +		/* timeout: give up */
> +		if (time_after(jiffies, end))
> +			break;
>  	}
>  
>  	pr_warn("wait_read() fail: 0x%02x\n", status);
> @@ -178,10 +183,11 @@ static int send_byte(u8 cmd, u16 port)
>  {
>  	u8 status;
>  	int us;
> +	unsigned long end = jiffies + (APPLESMC_MAX_WAIT * HZ) / USEC_PER_SEC;
>  
>  	outb(cmd, port);
>  	for (us = APPLESMC_MIN_WAIT; us < APPLESMC_MAX_WAIT; us <<= 1) {
> -		udelay(us);
> +		usleep_range(us, us * 16);
>  		status = inb(APPLESMC_CMD_PORT);
>  		/* write: wait for smc to settle */
>  		if (status & 0x02)
> @@ -190,7 +196,7 @@ static int send_byte(u8 cmd, u16 port)
>  		if (status & 0x04)
>  			return 0;
>  		/* timeout: give up */
> -		if (us << 1 == APPLESMC_MAX_WAIT)
> +		if (time_after(jiffies, end))
>  			break;
>  		/* busy: long wait and resend */
>  		udelay(APPLESMC_RETRY_WAIT);
