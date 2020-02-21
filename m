Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 620D4C35657
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39D18206EF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NO1zhZOh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728970AbgBUPSH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 10:18:07 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33686 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727352AbgBUPSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 10:18:07 -0500
Received: by mail-wr1-f68.google.com with SMTP id u6so2500326wrt.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 07:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Xs/pMjB7/UAvSRgUz3vf1voZfhwMsJXveHYGhWrFdvo=;
        b=NO1zhZOhc4ARAQOoDIEF4wqjZjFyeXwv4Q9EpWeiulrTX4z0YI9oOGa++ikmL9YdJJ
         O/9SNaMQxkwKlI8g9bQJjhf3ES/rFORqa2ih6KaT2njQrNKM5UjaNb4oInmF3p3T2f1I
         /ySfV94lkY+9aK2rOyZ0Ap8BG9NmrFYTrL6mBxH8ch7Wx+HMUWNEAZnt0fCL0oAXdLCD
         /E7fqFePw81uyJWTQ/sYKovEFEvmo5LJZC8nEGn/T0hSrQ7JqX0rlEHkqedBdm7AT5YO
         qFQjtb2TPO667cv6xQ+/akFDyilzU4b4EZXUuknHiN0Ha3iG2wPqQQvCVzd4KZ1LDRjZ
         YINw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Xs/pMjB7/UAvSRgUz3vf1voZfhwMsJXveHYGhWrFdvo=;
        b=FH3Jkzw7d/3p0Fin9jo3FTz+AO33SlctgUi1q0YY1X/N23vhnHRlcZI704bIiAlGWF
         6CApXMZl8lg1wA4J6cxu4bfT+2wCzd2/dv7VZNY6XfOqHjtp5OVxHFVPDG3Z3qjjjE6h
         Gm3lVrlYn4VNiHr//JlrnIb4eK69fzuk7/U/VlsOYNr7yJVCC+I5mc4cDEcEveHo4d0S
         RkT7JT2bxreCd/nYi11JO5cXfRDN3+Us8UxlVWy414fFJinGD9frcbpNprskSthZLz9K
         nTpqpk3eiITdwNrY1SoK0V1riTBjbhVmRbe/6AtgIZBKzLm8LgxtGdeIvNNDAYAaiSnq
         39sA==
X-Gm-Message-State: APjAAAVa0280xEkcWMIzP6bYb6aVhRK+22gglU+r4iUrEdprBeV9nBO5
        6hcw3lg0+5AhiNZeSd0tJEm4sA==
X-Google-Smtp-Source: APXvYqwsPdNWWNY83b7chQBTdWo7WqG2J+ICUWV8+47fBy1kGKEOcw6OoXUj2py6PednFjj5sxl96w==
X-Received: by 2002:adf:eb48:: with SMTP id u8mr48640392wrn.283.1582298285067;
        Fri, 21 Feb 2020 07:18:05 -0800 (PST)
Received: from linaro.org ([2a01:e34:ed2f:f020:903b:a048:f296:e3ae])
        by smtp.gmail.com with ESMTPSA id s15sm4277441wrp.4.2020.02.21.07.18.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Feb 2020 07:18:04 -0800 (PST)
Date:   Fri, 21 Feb 2020 16:18:02 +0100
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Jasper Korten <jja2000@gmail.com>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 06/17] ARM: tegra: Expose PM functions required for
 new cpuidle driver
Message-ID: <20200221151802.GK10516@linaro.org>
References: <20200212235134.12638-1-digetx@gmail.com>
 <20200212235134.12638-7-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200212235134.12638-7-digetx@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 02:51:23AM +0300, Dmitry Osipenko wrote:
> The upcoming unified CPUIDLE driver will be added to the drivers/cpuidle/
> directory and it will require all these exposed Tegra PM-core functions.
> 
> Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> Tested-by: Peter Geis <pgwipeout@gmail.com>
> Tested-by: Jasper Korten <jja2000@gmail.com>
> Tested-by: David Heidelberg <david@ixit.cz>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

[ ... ]


-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
