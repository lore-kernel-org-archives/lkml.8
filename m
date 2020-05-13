Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9088C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 15:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 046B02065C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 15:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GSuHkBHq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389259AbgEMPVX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 11:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389208AbgEMPVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 11:21:22 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22E3C061A0C;
        Wed, 13 May 2020 08:21:21 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id u5so5313991pgn.5;
        Wed, 13 May 2020 08:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=3yRyofDBUmX/6AiJcNBUrwOztf43oL+1vzquNOT5/mo=;
        b=GSuHkBHq8QgfFxtm2FP3EqTycxL336tHfmghS0MWuRb/rZPxShnQNx9Oee5rFOVyg0
         l/ptw/VloyZIy9MuyPiCRnZnw1HYrJbiRV+1lCEvK8qa6/CdoQif+hOiv2RJY1gxa6Hr
         bw5XWNivpCWVwAihiUpFMmqS0hMvl0cunD/O3OrhNu+5u7XUaY0wv//2cl3LHI8Mw/Cw
         tucG5Ob2OZE5ochimEJwebGMfaUMc4jniQliCKYtomCi+cdQdbXVrTgqvilkhCAWPVUC
         3ZinFt7WcjDy1uT68siR3VE84bwM2c8qlXx12DK0RIkBO/oPY2IHgNvhk9p5UelMWfHM
         en4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=3yRyofDBUmX/6AiJcNBUrwOztf43oL+1vzquNOT5/mo=;
        b=GQW/8/U7NxSempPNmSgMKWiI+iXCL2TPwLRk6ErPGskj4pAAdND2otdD1PZCinCZyI
         +OLYgxextDwwTNoE/5cLHznILQPZrL2jp4GtRyAnlaGm02BsqgtCk+2+fSBjJlkFRl4I
         mWhxkhUgaAMrY2L2nXIQnihEh2LWAq0ldGWAU5myR1JPI8kqkJSHvwkImDXEmqMikffc
         Ui0poGWA3gy00CY9CxKSePTFA3+jCVhQy0uDFGmBshH+jNB1MiCBYOAy9dFZDJuQhgkJ
         oREy43pA6jddxRmwwvsZGsV88aIr1r8Fs8U4ZidG0GCEFFG3pld/FkxSC86OATG0iBDv
         S4pA==
X-Gm-Message-State: AGi0PuYfMd0iax/GOsfVOsd+jabjsG3mKM7TVXq51z+pyT12dGmOFTC1
        cGWqfKWUlXwKPXXGsOlc4eA=
X-Google-Smtp-Source: APiQypLCGbbc3jPoqU2PX5STXtYWYF43p0LqJ06UayKzWFa+d92ts/mOM23v1/nJALaPOTFIbYxNZw==
X-Received: by 2002:aa7:8042:: with SMTP id y2mr26714744pfm.94.1589383281502;
        Wed, 13 May 2020 08:21:21 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l137sm15425893pfd.107.2020.05.13.08.21.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 May 2020 08:21:21 -0700 (PDT)
Date:   Wed, 13 May 2020 08:21:20 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Amy.Shih@advantech.com.tw
Cc:     she90122@gmail.com, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        oakley.ding@advantech.com.tw, jia.sui@advantech.com.cn,
        yuechao.zhao@advantech.com.cn, Hy.Lee@advantech.com.tw
Subject: Re: [v1,1/1] hwmon: (nct7904) Fix the incorrect rang of temperature
 limitation registers.
Message-ID: <20200513152120.GA125233@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 09:38:06AM +0000, Amy.Shih@advantech.com.tw wrote:
> From: Amy Shih <amy.shih@advantech.com.tw>
> 
> The format of temperature limitation registers are 8-bit 2's complement
> and the range is -128~127.
> Converts the reading value to signed char to fix the incorrect range
> of temperature limitation registers.
> 
> Signed-off-by: Amy Shih <amy.shih@advantech.com.tw>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/nct7904.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/nct7904.c b/drivers/hwmon/nct7904.c
> index 6fb06f7..04f2a8e 100644
> --- a/drivers/hwmon/nct7904.c
> +++ b/drivers/hwmon/nct7904.c
> @@ -390,6 +390,7 @@ static int nct7904_read_temp(struct device *dev, u32 attr, int channel,
>  	struct nct7904_data *data = dev_get_drvdata(dev);
>  	int ret, temp;
>  	unsigned int reg1, reg2, reg3;
> +	s8 temps;
>  
>  	switch (attr) {
>  	case hwmon_temp_input:
> @@ -495,7 +496,8 @@ static int nct7904_read_temp(struct device *dev, u32 attr, int channel,
>  
>  	if (ret < 0)
>  		return ret;
> -	*val = ret * 1000;
> +	temps = ret;
> +	*val = temps * 1000;
>  	return 0;
>  }
>  
> -- 
> 1.8.3.1
> 
