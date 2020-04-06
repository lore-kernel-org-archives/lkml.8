Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1847AC2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 19:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E957F206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 19:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0j5pq7H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgDFTRz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 15:17:55 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44491 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgDFTRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 15:17:54 -0400
Received: by mail-pl1-f194.google.com with SMTP id h11so201627plr.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 12:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=bTkNKEO9K2OHJMzvrL1U5p5uLy3R1bRstOrT+FY0vxw=;
        b=Q0j5pq7HtM4WNuRRvuL9sqlyULMTuH2OVmUv7HcarOPfZ7LfMzIG8uBuDPxzoxu4Q5
         EyQZVo+7TWMs/LNcCCQsGQx5m5edBKNN783zZlAiKpp4I/8+EiXnwnbFSE0vauG/ioq8
         ORaD04bvqWhWmxKuyyQ8n5Az4V9pElyCdawzd8Cj8qAWqKUiifmzxczPPLUItYrlHyun
         jldAhR2FzC0AiZTSqogl3BZKReeV8FIMlSTsTXapuPQDMxuU65NGOVkxXOfFYmPsdy0u
         ONxGJDmvMZzKcPHc92BmNCtdL1eic0qOScr9s1Kclyg62oExOaaeXjVHRSwbWQsHZYT7
         As7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=bTkNKEO9K2OHJMzvrL1U5p5uLy3R1bRstOrT+FY0vxw=;
        b=oy/h51fDp99G/C1pcWvKYIqbQ88V1gWy6lIXo9aj8E2gLP2f6ukI/f0KhxOEpi7bXL
         QalsHOLKa31OJb62R5NuCIglOpqnyYTZG74c6MjR02wlKBWFCzqZk7ALWX8QCnJhVucu
         qOdr1i4hVvkRZTFAiPU5rP9ZKFXm7iXSM4JsoUZ/4LM33yFxgWiPIa9gCv4xSa3mOi/U
         Kj5W0pzkA8xkWTCGCsGJJH0tOxfCO5YdI35z54u1LqkfCWb+k1/UHEqHJXZNe1oxZf9O
         Mf2BwsJ6lRon8dRLZsj/blptUil8qyr/svBn5cKAJbUPOYfTj4tKisBRZzzzJHTPwr5y
         rE2w==
X-Gm-Message-State: AGi0PubcEBg+iMKQ0zScVZ7IBhQtfWROid0//oUvU28M21m9LX9gskXf
        wCQt0sbE4cZTurfM05xDxPwhk8YU
X-Google-Smtp-Source: APiQypKwCQYeRnTQqcklYL4Y4O9LXO7YEucxPqva3z/ZTz2DJ+H9TaQzeAfSV3fDwBprYGKxW2fEgg==
X-Received: by 2002:a17:902:8215:: with SMTP id x21mr21587469pln.255.1586200673298;
        Mon, 06 Apr 2020 12:17:53 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b26sm9635032pfd.98.2020.04.06.12.17.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Apr 2020 12:17:52 -0700 (PDT)
Date:   Mon, 6 Apr 2020 12:17:51 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Holger =?iso-8859-1?Q?Hoffst=E4tte?= 
        <holger@applied-asynchrony.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: hwmon: drivetemp: bogus values after wake up from suspend
Message-ID: <20200406191751.GA50433@roeck-us.net>
References: <1af049a1-63ae-ee55-05d5-0e55eb00bd0e@applied-asynchrony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1af049a1-63ae-ee55-05d5-0e55eb00bd0e@applied-asynchrony.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 06:23:01PM +0200, Holger Hoffstätte wrote:
> 
> I've been giving the drivetemp hwmon driver a try and am very happy
> with it; works right away and - much to my surprise - doesn't wake up
> HDDs that have gone to sleep. Nice!
> 
> I did notice one tiny thing though: after waking up from suspend, my SSD
> (Samsung 850 Pro) reports a few initial bogus values - suspiciously -128°,
> which is definitely not the temperature in my office. While this is more
> a cosmetic problem, it cramps my monitoring setup and leads to wrong graphs.
> Can't have that!
> 
> So I looked into the source and found that the values are (understandably)
> passed on unfiltered/uncapped. Since it's unlikely any active device has
> operating temperature below-zero, I figured the laziest way is to cap the
> value to positive:
> 
> diff -rup a/drivers/hwmon/drivetemp.c b/drivers/hwmon/drivetemp.c
> --- a/drivers/hwmon/drivetemp.c	2020-04-02 08:02:32.000000000 +0200
> +++ b/drivers/hwmon/drivetemp.c	2020-04-06 18:13:04.892554087 +0200
> @@ -147,7 +147,7 @@ static LIST_HEAD(drivetemp_devlist);
>  #define INVALID_TEMP		0x80
>  #define temp_is_valid(temp)	((temp) != INVALID_TEMP)
> -#define temp_from_sct(temp)	(((s8)(temp)) * 1000)
> +#define temp_from_sct(temp)	(max(0, ((s8)(temp)) * 1000))
>  static inline bool ata_id_smart_supported(u16 *id)
>  {
> 
> The assumption is of course *theoretically* wrong since some
> equipment might indeed operate in negative C°. One way might be
> to use the device's "low" operating point first, but then that
> might not be available and we'd be back to capping to 0.
> I'm open to other suggestions. :)
> 

I think 0 is't much better than -128, unless your office is somewhere
in the Arctic. I'll have to loook up the spec, but I think -128 may mean
"no data". Maybe we can return something like -ENODATA in that case.

Guenter
