Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E597C433E3
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 18:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 786B820748
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 18:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nyvIq9/n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbgGKSTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 14:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728667AbgGKSTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 14:19:55 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21716C08C5DD;
        Sat, 11 Jul 2020 11:19:55 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id f16so3987059pjt.0;
        Sat, 11 Jul 2020 11:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r/O31HTyFTU09sJKGsQaSt7I4ZOQ9kI3I3BUbn+Nyeg=;
        b=nyvIq9/nKgF26KtXb4F5ugi3ouo9vHeJhVxKOr8So/RShA1xPe8EDigNpJNdi5Ory8
         KBziLEbwleHzJDe4pXWUVdeqNygJFAwn/ptPc4iqD6oACJT8jWHenhhI9KgqMfJiWf5s
         /V+T5LD7ggcfa3qYoBaGSMAmtqDP2Ah+Qt0o6BU9TfG3tC/YAL+3wdOq8IU9rV9r3PQj
         xkFSi6HmBEgIffl2Jq6OS/mo8I8c4BVOM8lzJi0KQnKlZ0KW5C3pc3kbO6cl7xn2F/8K
         M6Xtkl1jNVnfpa50J4DwXkJ0+mCdK6xN3U4LNhp4bioVvrYhz8LaBxvRGWGwzc4DL+qD
         Q8pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=r/O31HTyFTU09sJKGsQaSt7I4ZOQ9kI3I3BUbn+Nyeg=;
        b=NyXoLYOPmvJyOrFnCkAXblknuTspRdkqh9C0eSSwyigpsZ0NJSNKc6fYiNiEq4820u
         rTXDuAJ95GU0JwbXH6mR+6gTd4VOnfoCpdGhYFHezgxF8D/F1kBMNLCqYz9Pv5xUSv8X
         C60sLzD5S9djfPVCElHRe9LR+j2LzmbHerGkY8bifQpVE341zXmOHOxluRj83bI33YFr
         NDEjd/ifbc4LY/QUlrIa/g5suhPQwjY++Uj+NPI31Q0GP/ujLPCazgbDWK8J4yXyAWL9
         hcz558cazLI9WJjbQimEjKAmOTLah8YzeyV+abEOlpTbLwdukGVgKX7lnEUezKrt0G4e
         XaKQ==
X-Gm-Message-State: AOAM532v7tmNdsjzL2V2e8Ii/CV2jI0NCxrDjiwlszwtnKR+wBybkp8B
        Nyp/YpRq8XxsF3aAEpaQ9jSzFD0giLk=
X-Google-Smtp-Source: ABdhPJw43tu1dMlQ1k+02bgdIuQh+5/+gjxN72LqIRd2AvdcpprbR1r8oz325N9NIp31Dsv+DY/sPA==
X-Received: by 2002:a17:902:7b92:: with SMTP id w18mr53979905pll.258.1594491594292;
        Sat, 11 Jul 2020 11:19:54 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s30sm8789045pgn.34.2020.07.11.11.19.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 11 Jul 2020 11:19:53 -0700 (PDT)
Date:   Sat, 11 Jul 2020 11:19:52 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (drivetemp) Avoid SCT usage on Toshiba DT01ACA
 family drives
Message-ID: <20200711181952.GA213963@roeck-us.net>
References: <42108b47d0e3d64c6d36618425c9f920ff469600.1594404501.git.mail@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42108b47d0e3d64c6d36618425c9f920ff469600.1594404501.git.mail@maciej.szmigiero.name>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 08:10:03PM +0200, Maciej S. Szmigiero wrote:
> It has been observed that Toshiba DT01ACA family drives have
> WRITE FPDMA QUEUED command timeouts and sometimes just freeze until
> power-cycled under heavy write loads when their temperature is getting
> polled in SCT mode. The SMART mode seems to be fine, though.
> 
> Let's make sure we don't use SCT mode for these drives then.
> 
> While only the 3 TB model was actually caught exhibiting the problem let's
> play safe here to avoid data corruption and extend the ban to the whole
> family.
> 
> Fixes: 5b46903d8bf3 ("hwmon: Driver for disk and solid state drives with temperature sensors")
> Cc: stable@vger.kernel.org
> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> ---

I am out of town; more thorough review later. Quick feedback: Terms such
as "blacklist" have run out of favor. Please use a different term.

Thanks,
Guenter

> Sending again since the previous message bounced for most recipients.
> 
> Notes:
>     This behavior was observed on two different DT01ACA3 drives.
>     
>     Usually, a series of queued WRITE FPDMA QUEUED commands just time out,
>     but sometimes the whole drive freezes. Merely disconnecting and
>     reconnecting SATA interface cable then does not unfreeze the drive.
>     
>     One has to disconnect and reconnect the drive power connector for the
>     drive to be detected again (suggesting the drive firmware itself has
>     crashed).
>     
>     This only happens when the drive temperature is polled very often (like
>     every second), so occasional SCT usage via smartmontools is probably
>     safe.
> 
>  drivers/hwmon/drivetemp.c | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/drivers/hwmon/drivetemp.c b/drivers/hwmon/drivetemp.c
> index 0d4f3d97ffc6..4fd51fa8c6e3 100644
> --- a/drivers/hwmon/drivetemp.c
> +++ b/drivers/hwmon/drivetemp.c
> @@ -285,6 +285,36 @@ static int drivetemp_get_scttemp(struct drivetemp_data *st, u32 attr, long *val)
>  	return err;
>  }
>  
> +static const char * const sct_blacklist_models[] = {
> +/*
> + * These drives will have WRITE FPDMA QUEUED command timeouts and sometimes just
> + * freeze until power-cycled under heavy write loads when their temperature is
> + * getting polled in SCT mode. The SMART mode seems to be fine, though.
> + *
> + * While only the 3 TB model was actually caught exhibiting the problem
> + * let's play safe here to avoid data corruption and ban the whole family.
> + */
> +	"TOSHIBA DT01ACA0",
> +	"TOSHIBA DT01ACA1",
> +	"TOSHIBA DT01ACA2",
> +	"TOSHIBA DT01ACA3",
> +};
> +
> +static bool drivetemp_sct_blacklisted(struct drivetemp_data *st)
> +{
> +	struct scsi_device *sdev = st->sdev;
> +	unsigned int ctr;
> +
> +	if (!sdev->model)
> +		return false;
> +
> +	for (ctr = 0; ctr < ARRAY_SIZE(sct_blacklist_models); ctr++)
> +		if (strncmp(sdev->model, sct_blacklist_models[ctr], 16) == 0)
> +			return true;
> +
> +	return false;
> +}
> +
>  static int drivetemp_identify_sata(struct drivetemp_data *st)
>  {
>  	struct scsi_device *sdev = st->sdev;
> @@ -326,6 +356,13 @@ static int drivetemp_identify_sata(struct drivetemp_data *st)
>  	/* bail out if this is not a SATA device */
>  	if (!is_ata || !is_sata)
>  		return -ENODEV;
> +
> +	if (have_sct && drivetemp_sct_blacklisted(st)) {
> +		dev_notice(&sdev->sdev_gendev,
> +			   "will avoid using SCT for temperature monitoring\n");
> +		have_sct = false;
> +	}
> +
>  	if (!have_sct)
>  		goto skip_sct;
>  
