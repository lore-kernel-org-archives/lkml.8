Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B884C33CA4
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 16:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 227AC2084D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 16:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s1Tqw9Zo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730423AbgAKQdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 11:33:40 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:53150 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729957AbgAKQdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 11:33:39 -0500
Received: by mail-pj1-f67.google.com with SMTP id a6so2278901pjh.2;
        Sat, 11 Jan 2020 08:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EJk0VSmbNLzlXiN+YtDRbRoDplzmsNEh41yGWI93WhY=;
        b=s1Tqw9ZouVYrob4EDNWRXBM7rE5yTt9qmENRsQmB0eSBrNFf1wQUkHQE5CGYvSt0yf
         poE2OBK8yONK0FgdPCgVMusxmozUC4b2Yw2Ln91v2tzXTcNzbkeiT7WtmhSWh7nEJH5Q
         7NB2gRBJ+pEsCaEwXmYM05e8QBPdDhK6MHV0kWMd7i44lfpQIgBDHKZ10huMm9PoNR5p
         RpzyBpRrSXd0Fq3lVggOB2hCRIyXqBpEBQLej+hM+fkSEB6uv6GLln3p9Fl5/gWeqMrS
         GgKz/e6BMQ+ipavYWo5ub6wuEnh49sGzW7y8letYS1PFHfjP9CdeadrHk0Ucz8tOIwg/
         nMVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=EJk0VSmbNLzlXiN+YtDRbRoDplzmsNEh41yGWI93WhY=;
        b=Jc2NHdNnto6c5258XABOgUhQ9wSBpWzX+EyXLgf1p0S351fPHV2inhXF2IDQaaOGi7
         mR7/WyS/K0Cc8aQwJoZS8a6z3e/OFmvuMO378biGWymEzN3J/E9FtX+33HrxpqrM7xDp
         vqDSur29aNHe+l9+6TZxaIZ42YucXHe6tTaAre+zpEyxsMrM/20VsUmhY9L72+1RfGDH
         0tvjxaXFXRfEZYAha/IY6gqzEdzbDv+HfntWjQ6HjQYiwaJVzEUPKD6B+BKzC2MRhz5N
         CJ3ktBDG0lf11TLt+li1wfUaWZ1xPz9hR1mEs0HIt8V8OjInqPIKcyOLVg6glBe/WcBG
         1k0w==
X-Gm-Message-State: APjAAAUdBJudGmFAKqt7+2K/rWjNxnMR3l4u9lXQnA+pD2AjmQST+Nvi
        9B9AVku7H5hy4cxE+QF8nlEhNyJQ
X-Google-Smtp-Source: APXvYqy1cqC+vKLrRlF0ZP6Vj0BVWuXy7cgoaQOdZGDCzYUF19tBkHoo3CXBVGnrcWeEv0TvHzYMqQ==
X-Received: by 2002:a17:90a:d804:: with SMTP id a4mr12735233pjv.11.1578760418644;
        Sat, 11 Jan 2020 08:33:38 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n24sm7460416pff.12.2020.01.11.08.33.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 11 Jan 2020 08:33:38 -0800 (PST)
Date:   Sat, 11 Jan 2020 08:33:37 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Beniamin Bia <beniamin.bia@analog.com>
Cc:     linux-hwmon@vger.kernel.org, Michael.Hennerich@analog.com,
        linux-kernel@vger.kernel.org, jdelvare@suse.com,
        mark.rutland@arm.com, lgirdwood@gmail.com, broonie@kernel.org,
        devicetree@vger.kernel.org, biabeniamin@outlook.com
Subject: Re: [PATCH v3 3/3] MAINTAINERS: add entry for ADM1177 driver
Message-ID: <20200111163337.GA5935@roeck-us.net>
References: <20200107105929.18938-1-beniamin.bia@analog.com>
 <20200107105929.18938-3-beniamin.bia@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107105929.18938-3-beniamin.bia@analog.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2020 at 12:59:29PM +0200, Beniamin Bia wrote:
> Add Beniamin Bia and Michael Hennerich as a maintainer for ADM1177 ADC.
> 
> Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>

Applied to hwmon-next.

Thanks,
Guenter

> ---
> Changes in v3:
> -nothing changed
>  MAINTAINERS | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3ef731fc753b..bc19b624fcd5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -978,6 +978,15 @@ W:	http://ez.analog.com/community/linux-device-drivers
>  F:	drivers/iio/imu/adis16460.c
>  F:	Documentation/devicetree/bindings/iio/imu/adi,adis16460.yaml
>  
> +ANALOG DEVICES INC ADM1177 DRIVER
> +M:	Beniamin Bia <beniamin.bia@analog.com>
> +M:	Michael Hennerich <Michael.Hennerich@analog.com>
> +L:	linux-hwmon@vger.kernel.org
> +W:	http://ez.analog.com/community/linux-device-drivers
> +S:	Supported
> +F:	drivers/hwmon/adm1177.c
> +F:	Documentation/devicetree/bindings/hwmon/adi,adm1177.yaml
> +
>  ANALOG DEVICES INC ADP5061 DRIVER
>  M:	Stefan Popa <stefan.popa@analog.com>
>  L:	linux-pm@vger.kernel.org
