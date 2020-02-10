Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFBDCC352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 17:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C72442080C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 17:52:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GabQrhEI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbgBJRwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 12:52:01 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45481 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbgBJRwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 12:52:00 -0500
Received: by mail-pf1-f194.google.com with SMTP id 2so4041955pfg.12;
        Mon, 10 Feb 2020 09:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MM7R9V7x4SfJxszh3dZy1asc+0YpWfKxq+33iCkgJuw=;
        b=GabQrhEI7g1MP+cMV9bvR9dwQktgpfyeF8s92oPxorCxTF65Quy0utpXliSB6ZnQBQ
         ga5RUyXfhYrcya0a4d2CpRKwdinAK2ZV38KFlbOeqYhaSOxm9DSQWJXNXzXpc4OBCx4O
         wRnDOReq10omnEy4z76YRO4B/0kIjbanwVaJvE6TSL77zCMPEdgTRxxhPBSGbIs5hfNI
         Rzz+9PHNUpiaSib5CXqyZMQ+qvEjl+JMwTkwhag4ObuukgdfwLlWNLJVzsFdq13f1dYD
         wHjtE6RKHL4TxlfDLK2sZ9I4UaEA30lv9sMBMyVIhOMmuXjXUecgiYRm486xs52W0eSn
         CjYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=MM7R9V7x4SfJxszh3dZy1asc+0YpWfKxq+33iCkgJuw=;
        b=W9nmWdKbEq7hRnV9BM9uNYsIN7vyLtictv+JtAOrBH3Vlph8aPfvyziJUpu6RAyqQk
         OIhIvjTYlsI4nfGH8QaMyYsWmc/4ybT8UFwf4tHrpfFCpNm+qrPhtV+XTtDA22kRbInA
         NR43fIMk2Iuybre8MUTkr4wV71XzMUY/mEUUM2FrfrihmFIBX1zyWgQBhaMm/GpyBF2t
         sZukOTh615zaHPK+4t6b9ngGTX8Ims6Tis5gciQ9iw7Fs8UcyMd4vUMNEZDXpiFClGeg
         n6E1NBXhs43JWfY0hizw/pYqc9tuujZUu0MbrOpi3ij1+LpuKUU37hrKNarQLFj5Ip9C
         MIHQ==
X-Gm-Message-State: APjAAAWtBAPWetwi6s11uvxrOYQekzUVLrSGepohyF3SxCvj5KhtfGPb
        2ObHr3mxJVT4KA9dfwqE1b0=
X-Google-Smtp-Source: APXvYqz8OGqGIw6Dj/1NWzwwvsY0TYQ/8+Hmsz8n9Ry0oUOLEEcDPAe0ccT7JEe+q4YdqNfl35R2Iw==
X-Received: by 2002:a63:7457:: with SMTP id e23mr2869807pgn.386.1581357120158;
        Mon, 10 Feb 2020 09:52:00 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 70sm795638pgd.28.2020.02.10.09.51.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Feb 2020 09:51:59 -0800 (PST)
Date:   Mon, 10 Feb 2020 09:51:58 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Mike Jones <michael-a1.jones@analog.com>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        jdelvare@suse.com, robh+dt@kernel.org, corbet@lwn.net
Subject: Re: [PATCH 2/2] bindings: (hwmon/ltc2978.txt): add support for more
 parts.
Message-ID: <20200210175158.GA31186@roeck-us.net>
References: <1581032654-4330-1-git-send-email-michael-a1.jones@analog.com>
 <1581032654-4330-2-git-send-email-michael-a1.jones@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581032654-4330-2-git-send-email-michael-a1.jones@analog.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 06, 2020 at 04:44:14PM -0700, Mike Jones wrote:
> LTC2972, LTC2979, LTC3884, LTC3889, LTC7880, LTM4664, LTM4677,
> LTM4678, LTM4680, LTM4700.
> 
> Signed-off-by: Mike Jones <michael-a1.jones@analog.com>

Conditionally applied to hwmon-next. We'll see if Rob would like to see
any adjustments.

Thanks,
Guenter

> ---
>  .../devicetree/bindings/hwmon/ltc2978.txt          | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/ltc2978.txt b/Documentation/devicetree/bindings/hwmon/ltc2978.txt
> index b428a70..4e7f621 100644
> --- a/Documentation/devicetree/bindings/hwmon/ltc2978.txt
> +++ b/Documentation/devicetree/bindings/hwmon/ltc2978.txt
> @@ -2,20 +2,30 @@ ltc2978
>  
>  Required properties:
>  - compatible: should contain one of:
> +  * "lltc,ltc2972"
>    * "lltc,ltc2974"
>    * "lltc,ltc2975"
>    * "lltc,ltc2977"
>    * "lltc,ltc2978"
> +  * "lltc,ltc2979"
>    * "lltc,ltc2980"
>    * "lltc,ltc3880"
>    * "lltc,ltc3882"
>    * "lltc,ltc3883"
> +  * "lltc,ltc3884"
>    * "lltc,ltc3886"
>    * "lltc,ltc3887"
> +  * "lltc,ltc3889"
> +  * "lltc,ltc7880"
>    * "lltc,ltm2987"
> +  * "lltc,ltm4664"
>    * "lltc,ltm4675"
>    * "lltc,ltm4676"
> +  * "lltc,ltm4677"
> +  * "lltc,ltm4678"
> +  * "lltc,ltm4680"
>    * "lltc,ltm4686"
> +  * "lltc,ltm4700"
>  - reg: I2C slave address
>  
>  Optional properties:
> @@ -25,13 +35,17 @@ Optional properties:
>    standard binding for regulators; see regulator.txt.
>  
>  Valid names of regulators depend on number of supplies supported per device:
> +  * ltc2972 vout0 - vout1
>    * ltc2974, ltc2975 : vout0 - vout3
> -  * ltc2977, ltc2980, ltm2987 : vout0 - vout7
> +  * ltc2977, ltc2979, ltc2980, ltm2987 : vout0 - vout7
>    * ltc2978 : vout0 - vout7
> -  * ltc3880, ltc3882, ltc3886 : vout0 - vout1
> +  * ltc3880, ltc3882, ltc3884, ltc3886, ltc3887, ltc3889 : vout0 - vout1
> +  * ltc7880 : vout0 - vout1
>    * ltc3883 : vout0
> -  * ltm4676 : vout0 - vout1
> -  * ltm4686 : vout0 - vout1
> +  * ltm4664 : vout0 - vout1
> +  * ltm4675, ltm4676, ltm4677, ltm4678 : vout0 - vout1
> +  * ltm4680, ltm4686 : vout0 - vout1
> +  * ltm4700 : vout0 - vout1
>  
>  Example:
>  ltc2978@5e {
