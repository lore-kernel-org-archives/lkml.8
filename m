Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DAE7C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 19:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1D67207DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 19:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUNl/o4R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbgH0Tsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 15:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbgH0Tsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 15:48:51 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84CF1C061264;
        Thu, 27 Aug 2020 12:48:51 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id mt12so3186295pjb.4;
        Thu, 27 Aug 2020 12:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jkP498pf3yWtYUd662NOXv9qut7wRmoZhgkMJ7DLOl4=;
        b=JUNl/o4RrtrxtgVgYdRTC+XnGySjMeqIuCm5m7aI/CdUZOdssgNQ6oWEYykMMBjJX6
         qnz7yl+1QYzzQEwdFW6i/+QVBqAfN07Gzjr5t1zuBgpnWgjScTOJ0RsGmVygZBe0qkTF
         uwpKa8LYZaqe2N/n1HpfMZ3/fA87iGpbBAXVnmVV8LiQchVSR8TC4JCt3gQH+VklPEGR
         ZQw713Te0pbcBBua6vY1tKX2R2wxPoSqdeS9Pf7LDjv1Io87DUiJmpko5UDXIsoBASzn
         v+/JjDhPLV2GwhiAvUkOWe7LTcblLnMW8qJBvQiuKZCnkWVIB9DjbkFTllrPXzXcs0wz
         DEAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=jkP498pf3yWtYUd662NOXv9qut7wRmoZhgkMJ7DLOl4=;
        b=TBVz9vdIIHWwvmx+pR9l+weod4CzjUnycK2r+zA+dDblsdBtdfzXADWNOsOJBxQbmH
         KrvYIBCiYxrOQt74ZPQKSa0n8l1QwUmacN2gCoavPZL/j6YPHdFdk2QCBB1bDtf5cbju
         0tkAKKvNEKUa0baE8nSBrbumBLZ/B6BqPLn9Mx6aoBuI3wYEGeQuOTtKNdpQmDXoHlak
         qQlUg586XxH4iOf1qDHh5eh1B1QAvIQYPocyJWIZXC6CuzhcSuiCp1Hrpav7MXj+5QMJ
         5siu/n+1VZoP+hx6G1+cmKdSedeWpdRm9hgVbemU8mlD0/MauvSk8AAYB6GVgdB7uTdK
         fx1Q==
X-Gm-Message-State: AOAM532E+dSqv+qMhv+WGo/u3aXzm9Ldg1e/cyJC2oBE70FqTTBoI0S/
        bbHy/zQ0I/28wTwHxxo8fSDUsUXDaWU=
X-Google-Smtp-Source: ABdhPJxAGQIJCkWMMlz40OFPBBXBVve9rxgRztqYETs9wws+nY9rGO6NgAeD7rA9Jqn2L3wRz+fehw==
X-Received: by 2002:a17:90a:2c06:: with SMTP id m6mr399808pjd.129.1598557731085;
        Thu, 27 Aug 2020 12:48:51 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s17sm3250366pgm.63.2020.08.27.12.48.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Aug 2020 12:48:50 -0700 (PDT)
Date:   Thu, 27 Aug 2020 12:48:48 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Robert Jones <rjones@gateworks.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] hwmon: gsc-hwmon: scale temperature to millidegrees
Message-ID: <20200827194848.GA232549@roeck-us.net>
References: <1598548824-16898-1-git-send-email-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1598548824-16898-1-git-send-email-tharvey@gateworks.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 10:20:24AM -0700, Tim Harvey wrote:
> The GSC registers report temperature in decidegrees celcius so we
> need to scale it to represent the hwmon sysfs API of millidegrees.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/gsc-hwmon.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hwmon/gsc-hwmon.c b/drivers/hwmon/gsc-hwmon.c
> index 3dfe2ca..c6d4567 100644
> --- a/drivers/hwmon/gsc-hwmon.c
> +++ b/drivers/hwmon/gsc-hwmon.c
> @@ -172,6 +172,7 @@ gsc_hwmon_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
>  	case mode_temperature:
>  		if (tmp > 0x8000)
>  			tmp -= 0xffff;
> +		tmp *= 100; /* convert to millidegrees celsius */
>  		break;
>  	case mode_voltage_raw:
>  		tmp = clamp_val(tmp, 0, BIT(GSC_HWMON_RESOLUTION));
