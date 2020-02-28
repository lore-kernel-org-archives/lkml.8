Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5818C3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 18:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A96D7246A0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 18:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yta4/Xk0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgB1SGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 13:06:36 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:45738 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbgB1SGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 13:06:36 -0500
Received: by mail-il1-f195.google.com with SMTP id p8so3451959iln.12
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 10:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=q/u3S7XYfqg1NhqIgbh8eCbf32/eSCjaraTCABx9w4Q=;
        b=yta4/Xk00nxXXJJerA9pXGKHKj0QE/n8NsJR7d8qpVc3Oztd/mAVfk87XeoiceFH1j
         0CoMXAIFLpoU6cSkk7iMCQpTKNa3+8U/Q22Uw3r4Cp+hfZ8VtCeZbfGhh1CwXTbpkfKH
         sUQotmwz5eVnATs6IQvgW5HLL0diFuHQLdX0rZMBIx5Zdwp4xXcv7EyhuNL4Rb5ETf8t
         tdhkgsDOsMr79E72aIhZESWPRH5DWFQj+xTu7S5GbDxo0Z7NVQqMmoPWVnAl5YrvnQwt
         wXSYtES5N1FkpcVTJ5zasDAtJGWROIjmqVHXUXpT5F+QJSP7UbgqtcAyaq1DdhSOlQ6t
         BZsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q/u3S7XYfqg1NhqIgbh8eCbf32/eSCjaraTCABx9w4Q=;
        b=Oy592nG50+9GAxs1/LJ2zZp7gnG6wTJgdtM9lNqYQbw3LQl9KeQRLrTYvzFs88Oiea
         QHojtDnNOmbcc7woe/w67JT5Hxp+Z8W/TYibFdzGYxEXbazRikgL21QT+h/M6g5lrF8X
         nJ7ZIwohBkDrYSBxJmmg3+yCZp0NqCzAenVLlXSxQ9a9RiAFcP97rxRRv8qtjCoQ0kFX
         9Ai3whlL40IYWyEtcL+3x76kHlDsoKQb7PLtJMTsVOrchWFDiJxJYsjRjaqiGmiWNLrY
         2TtjWA+/YangeQEeEip1OJ0hQXAtGrHtemCWHB20rHnrQlksnMVFcWU+IXVp2N7Tho1/
         J+Pw==
X-Gm-Message-State: APjAAAVDecxhVyk4Po2Yx0My6bcBx9PK+mklRaF9+7najrFL3I7qxWWZ
        mD1hXJednMQYxS2cbj5L6RO7J09G+qQ=
X-Google-Smtp-Source: APXvYqzOpqwGZFVcW1gjeRtV6mM27enIksjXvRVdgTtJaXp9eDfpAzR47kq45BEUFZ2eTkkFo/7bJA==
X-Received: by 2002:a92:c04e:: with SMTP id o14mr5814460ilf.133.1582913195360;
        Fri, 28 Feb 2020 10:06:35 -0800 (PST)
Received: from [172.22.22.10] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id t19sm2381286ioc.38.2020.02.28.10.06.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2020 10:06:34 -0800 (PST)
Subject: Re: [PATCH] bitfield.h: add FIELD_MAX() and field_max()
From:   Alex Elder <elder@linaro.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <20200228165343.8272-1-elder@linaro.org>
 <20200228095611.023085fd@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <d6bf67ba-3546-c582-21a6-30cbd4edd984@linaro.org>
Message-ID: <16889e77-31cf-58f6-c27e-5b8a6b3e604d@linaro.org>
Date:   Fri, 28 Feb 2020 12:06:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <d6bf67ba-3546-c582-21a6-30cbd4edd984@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/28/20 12:04 PM, Alex Elder wrote:
> 
> 
> I find field_max() to be a good name for what I'm looking for.

Sorry I wanted to add this but clicked "send" too fast.

Yes it's the same as field_mask(), but that name only *implies*
it is the same as the maximum value.  I mean, they're the same,
but the name I'm suggesting conveys its purpose better.

					-Alex
