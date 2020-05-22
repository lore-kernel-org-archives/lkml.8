Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19411C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 13:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD65020679
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 13:22:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BFNiuief"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729796AbgEVNWz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 09:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729008AbgEVNWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 09:22:54 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58DAEC061A0E;
        Fri, 22 May 2020 06:22:54 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x13so5186544pfn.11;
        Fri, 22 May 2020 06:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tvV8H8iaSx8j1KBrvJAPfKvYld57AGXC1GD/IpW0w6M=;
        b=BFNiuief5Bh/c+aNaqSi4SYxoQXl2ywpjSlCnBd7tgwE36vK6g3KKs00MGc6co3Xft
         vKbE/emtIclZPGxcwqwMFTxKbF/Pf9dUfOlU+N6dhoQqM66Tz7sFVwLrKnDmA50y1qN4
         reUePoswLJSkY4DKGa+Vl6pK9xVWedDCJt5cr0jFj7tQH1nW7rMq1lp+CiWU8/GqRJBB
         NvoHOBICe1KB3Ad7Aw/ovaevvAiVC7yYNTR890vrGnh4qN9yFpE5oQEuwJlMEhRHRM/w
         +6f0zVNePdImtrIaJRXaK1vvHWng6vZNuJ1fteVv6o6P68xiX/jhGoYMevBTIqlX3U3N
         onRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=tvV8H8iaSx8j1KBrvJAPfKvYld57AGXC1GD/IpW0w6M=;
        b=lYOyVQUT19IkvMTwVQTgN4mydXmfT3lB0xxPvGoQkmZo06NrNEXydZc4C9WFw7MZAy
         BWIl7sUg6x4JfPtj4YpfqOJMOZlAeMZU9YCnhqX7K7gQdcjxlHr1V0htp302HbbWDZij
         jBUp+8oVyjuqg9BQYSbjqzdRnbeh5PVvvDqiax5Xs+pC2Bxv5LB/Glop/iQXaAKu/Yv1
         kTEeR3WEhXDor/yeU7CzCnqtpQYl1pT3rswMRpGkW39/m+oRLlZj9bboTNQR9InxgS+k
         nhy65qVDXuG80sawCjP4wi9HRmCubECSNrjTzAsv9QhmrXRqgj2tdkTSM+oJ9/ffxD/Y
         rBeA==
X-Gm-Message-State: AOAM531VQipoBr7gvdVnCqYfjtkkudm8z6Wa3mvK+Q8vUIOajMZcQ84X
        8mfXPavWv2bOBNQQ1eM23xo=
X-Google-Smtp-Source: ABdhPJzWVBm8e8X1m3Mj9UtD/bZlduYmtuYG2vfyIeErKFBwIvdwOUTOC5NqsY4VR/xcO6Ax4Qf57g==
X-Received: by 2002:a62:2c8d:: with SMTP id s135mr4009960pfs.231.1590153773791;
        Fri, 22 May 2020 06:22:53 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z6sm6567130pgu.85.2020.05.22.06.22.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 May 2020 06:22:52 -0700 (PDT)
Date:   Fri, 22 May 2020 06:22:51 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     zhenghaili <hailizheng1993@gmail.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        hailizheng <haili.zheng@powercore.com.cn>
Subject: Re: [PATCH] drivers/hwmon/nct7802: Replace container_of() API
Message-ID: <20200522132251.GA221470@roeck-us.net>
References: <1589891119-16508-1-git-send-email-haili.zheng@powercore.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589891119-16508-1-git-send-email-haili.zheng@powercore.com.cn>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 08:25:19AM -0400, zhenghaili wrote:
> From: hailizheng <haili.zheng@powercore.com.cn>
> 
> Replace container_of() API with kobj_to_dev().
> 
> Signed-off-by: hailizheng <haili.zheng@powercore.com.cn>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/nct7802.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/nct7802.c b/drivers/hwmon/nct7802.c
> index 2e97e56..570df8e 100644
> --- a/drivers/hwmon/nct7802.c
> +++ b/drivers/hwmon/nct7802.c
> @@ -679,7 +679,7 @@ static struct attribute *nct7802_temp_attrs[] = {
>  static umode_t nct7802_temp_is_visible(struct kobject *kobj,
>  				       struct attribute *attr, int index)
>  {
> -	struct device *dev = container_of(kobj, struct device, kobj);
> +	struct device *dev = kobj_to_dev(kobj);
>  	struct nct7802_data *data = dev_get_drvdata(dev);
>  	unsigned int reg;
>  	int err;
> @@ -778,7 +778,7 @@ static struct attribute *nct7802_in_attrs[] = {
>  static umode_t nct7802_in_is_visible(struct kobject *kobj,
>  				     struct attribute *attr, int index)
>  {
> -	struct device *dev = container_of(kobj, struct device, kobj);
> +	struct device *dev = kobj_to_dev(kobj);
>  	struct nct7802_data *data = dev_get_drvdata(dev);
>  	unsigned int reg;
>  	int err;
> @@ -853,7 +853,7 @@ static struct attribute *nct7802_fan_attrs[] = {
>  static umode_t nct7802_fan_is_visible(struct kobject *kobj,
>  				      struct attribute *attr, int index)
>  {
> -	struct device *dev = container_of(kobj, struct device, kobj);
> +	struct device *dev = kobj_to_dev(kobj);
>  	struct nct7802_data *data = dev_get_drvdata(dev);
>  	int fan = index / 4;	/* 4 attributes per fan */
>  	unsigned int reg;
