Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E850C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 15:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3BE02076A
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 15:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OMRXoERa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbgGRPN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 11:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbgGRPN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 11:13:28 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6865C0619D2;
        Sat, 18 Jul 2020 08:13:28 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id t15so7760652pjq.5;
        Sat, 18 Jul 2020 08:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JGSq0IYx+3F7ahGe0nRuD8qsgPFh2KVuRvLpoMyrycI=;
        b=OMRXoERaR11qs3I4MVbrNrkfglB+F29g88b3suwlTdN7jqaQPgsUsW75Od2PFDmcbB
         a3AVT2Kcc+taocXI0Rg4BlL+h4/gMihZgbjySg1ue2thjaH1KIS6/gF/XWdYq1Jr1yBY
         KbUoktHZLYoVpXE2yv6JQEJ7zP127BcaEYL39JlHLkrDj9RaFJn0oLm6r37m/1bMAD1b
         D3gLEpKtSGxaPybhIkf0rmGQnyKAV53bLFprTBOVvnwbPDcod9yktip0xahUu+XDSLiE
         sjV6LVHiH3CEg8slEk9rjUBzweTWXiWxDyRgg8o5/h62n3ItFDh+xpZMY8bYYBFa3UJc
         CHRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=JGSq0IYx+3F7ahGe0nRuD8qsgPFh2KVuRvLpoMyrycI=;
        b=Sgx5KWEwx6v6cSogTVM1rGr5Sa6bWy8H2NaghmjHQUD9E36l1pDS1yUrK04Z0tYgnC
         TCryoC2qysmN/TroqOI3sDJuzW8RjVwlvI44N6eZtD0IXqKTxE8M5NCOZoq3lNXQzDFI
         T0tcAZYodmuzl2z6Lkt6FVYzSzG3KvqAVK1loMxuNXhMx+VAlzGpIhUwpcKU93UrVp6q
         kVxwQ/FAKfbE4x1TXXS3KC1vw7uV+4oiyDSCuv5pL4O71nuxJ2I+GbyR4XpCK5v0T4gd
         FFYURgfkKYwz9I2myziDGQd3AWd/hJQTaMPWkKirC684LxfdRebPEJbKft5uQIQY7CPh
         JV9g==
X-Gm-Message-State: AOAM532G2HYry5WHRTHFwSFptAWiB+uCCzPsP5hjoqsSn/cQ7Q3k1qzY
        +ONzdtbFbu6W4kzQNch0hWpJjyGb
X-Google-Smtp-Source: ABdhPJzNqRioh7C2yN6UdM+TLPvqcGyOXBRjpJZmEE69rvNNqUydlu84v7IM7JoDDJ1Pfj21Ojaopg==
X-Received: by 2002:a17:90b:1997:: with SMTP id mv23mr14951265pjb.194.1595085208292;
        Sat, 18 Jul 2020 08:13:28 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b24sm10485089pgn.8.2020.07.18.08.13.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 Jul 2020 08:13:27 -0700 (PDT)
Date:   Sat, 18 Jul 2020 08:13:26 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] hwmon: (drivetemp) Avoid SCT usage on Toshiba DT01ACA
 family drives
Message-ID: <20200718151326.GA163203@roeck-us.net>
References: <0cb2e7022b66c6d21d3f189a12a97878d0e7511b.1595075458.git.mail@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0cb2e7022b66c6d21d3f189a12a97878d0e7511b.1595075458.git.mail@maciej.szmigiero.name>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 18, 2020 at 02:32:10PM +0200, Maciej S. Szmigiero wrote:
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

Applied.

Thanks,
Guenter

> ---
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
>     Changes from v1:
>     'SCT blacklist' -> 'SCT avoid models'
>     
>     Changes from v2:
>     * Switch to prefix matching and use it to match the DT01ACAx family,
>     
>     * Use "!" instead of "== 0",
>     
>     * Add a comment about the contents of the "model" field.
> 
>  drivers/hwmon/drivetemp.c | 43 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> diff --git a/drivers/hwmon/drivetemp.c b/drivers/hwmon/drivetemp.c
> index 0d4f3d97ffc6..72c760373957 100644
> --- a/drivers/hwmon/drivetemp.c
> +++ b/drivers/hwmon/drivetemp.c
> @@ -285,6 +285,42 @@ static int drivetemp_get_scttemp(struct drivetemp_data *st, u32 attr, long *val)
>  	return err;
>  }
>  
> +static const char * const sct_avoid_models[] = {
> +/*
> + * These drives will have WRITE FPDMA QUEUED command timeouts and sometimes just
> + * freeze until power-cycled under heavy write loads when their temperature is
> + * getting polled in SCT mode. The SMART mode seems to be fine, though.
> + *
> + * While only the 3 TB model (DT01ACA3) was actually caught exhibiting the
> + * problem let's play safe here to avoid data corruption and ban the whole
> + * DT01ACAx family.
> +
> + * The models from this array are prefix-matched.
> + */
> +	"TOSHIBA DT01ACA",
> +};
> +
> +static bool drivetemp_sct_avoid(struct drivetemp_data *st)
> +{
> +	struct scsi_device *sdev = st->sdev;
> +	unsigned int ctr;
> +
> +	if (!sdev->model)
> +		return false;
> +
> +	/*
> +	 * The "model" field contains just the raw SCSI INQUIRY response
> +	 * "product identification" field, which has a width of 16 bytes.
> +	 * This field is space-filled, but is NOT NULL-terminated.
> +	 */
> +	for (ctr = 0; ctr < ARRAY_SIZE(sct_avoid_models); ctr++)
> +		if (!strncmp(sdev->model, sct_avoid_models[ctr],
> +			     strlen(sct_avoid_models[ctr])))
> +			return true;
> +
> +	return false;
> +}
> +
>  static int drivetemp_identify_sata(struct drivetemp_data *st)
>  {
>  	struct scsi_device *sdev = st->sdev;
> @@ -326,6 +362,13 @@ static int drivetemp_identify_sata(struct drivetemp_data *st)
>  	/* bail out if this is not a SATA device */
>  	if (!is_ata || !is_sata)
>  		return -ENODEV;
> +
> +	if (have_sct && drivetemp_sct_avoid(st)) {
> +		dev_notice(&sdev->sdev_gendev,
> +			   "will avoid using SCT for temperature monitoring\n");
> +		have_sct = false;
> +	}
> +
>  	if (!have_sct)
>  		goto skip_sct;
>  
