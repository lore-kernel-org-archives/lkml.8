Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6234AC2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 04:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3435620718
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 04:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQCqQLsM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729942AbgAXErh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 23:47:37 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:36514 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729497AbgAXErh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 23:47:37 -0500
Received: by mail-pj1-f67.google.com with SMTP id gv17so255648pjb.1;
        Thu, 23 Jan 2020 20:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+yNIg/fNH7fj0+LMHt+OynbzsULIsDrVWuMrkX06UAo=;
        b=UQCqQLsM7YneywJvqhmHP90qigtji1VVlPwoTx47i4pqJwd16HQov9t/YhECEoe/Tn
         1ST+36lATC5qNOen9gvU+swLSLTffbeCWhXoxmPJtXxyglHwX6E43nKESsuLrHod3ASD
         mHxGQV0QFG9F5qa/CJiv4OXIe4I54Ow7YRurz1aJ6ePlLO37eM1D1oLRsV6zWTVD4xKj
         ZH+rdgIPKsEJ5/0j0/Nu7NdXZ83Y1INVgPUyniSVICjkmxqFYIbkVw45k0Ov+9iprpXc
         rR+Z99q89ES5GgFISVrhrZ4PxDijcJRvgFWtPBQacXUq+hgugA11CNNXl2MdYjzidZIq
         rRag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+yNIg/fNH7fj0+LMHt+OynbzsULIsDrVWuMrkX06UAo=;
        b=c1PHC/WOsaLtNaSDvaLou8F9VBoBlzTYIW7NFzX/jel8AKbha5Z+jUq8ZXdqN2W14s
         Pd92sPDBwcxJ+GwxjZDVakwOpndQSSb/jLe2LQaCZJfjq+hPtaB2yFzkSbHCaF3FhRwW
         eb45L+gDsiK2qUT3LAD/4GfCkKJZpLoKM70E8zjbfCfS0DXdHKTLQ3iCZ2nxo2LdL/3t
         k56qmMjzfpMF+y1pZ7FbZIxgswC7FSLg2252I6Q8os38Ky41de2FN16RGoa8q/GaQlfv
         TkPzqxjIzJPk87P+2GP91gbKDVUtQKqX+IQOxojtCcdHA3Jc+mIhFehIDhazdJdfarG7
         wYzw==
X-Gm-Message-State: APjAAAX7bG3lQGjTa4gEARK3dwrhYsfoYEyc1MtVGE0fLycx9i5NqRPo
        FmU9sQKK2TziSwV2sMtE5Jlx4ow6
X-Google-Smtp-Source: APXvYqxVvh2tPC5HthLG0EplcFYQJzl/hgL6WQ+DCgOrQvUI991oGq3iJnPaCV5KGZPDmokZ3b3MKw==
X-Received: by 2002:a17:902:59cd:: with SMTP id d13mr1745420plj.146.1579841255481;
        Thu, 23 Jan 2020 20:47:35 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z16sm4293566pff.125.2020.01.23.20.47.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2020 20:47:34 -0800 (PST)
Subject: Re: [PATCH v4 6/6] hwmon: (k10temp) Add debugfs support
To:     Ken Moffat <zarniwhoop73@googlemail.com>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Clemens Ladisch <clemens@ladisch.de>,
        Jean Delvare <jdelvare@suse.com>,
        Brad Campbell <lists2009@fnarfbargle.com>,
        =?UTF-8?Q?Ondrej_=c4=8cerman?= <ocerman@sda1.eu>,
        Bernhard Gebetsberger <bernhard.gebetsberger@gmx.at>,
        Holger Kiehl <Holger.Kiehl@dwd.de>,
        Michael Larabel <michael@phoronix.com>,
        Jonathan McDowell <noodles@earth.li>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Darren Salt <devspam@moreofthesa.me.uk>
References: <20200122160800.12560-1-linux@roeck-us.net>
 <20200122160800.12560-7-linux@roeck-us.net>
 <CANVEwpbeT_O=4TZu7RuRupwOGTNEVWSnHXvMsEqEmeKqmu92jw@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <e1d351d3-ffc4-9241-c5fd-0703637d9eee@roeck-us.net>
Date:   Thu, 23 Jan 2020 20:47:32 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CANVEwpbeT_O=4TZu7RuRupwOGTNEVWSnHXvMsEqEmeKqmu92jw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ken,

On 1/23/20 4:01 PM, Ken Moffat wrote:
> Hi Guenter,
> 

Thanks a lot for the additional information. The following
is interesting.

> -0x059960: 00000000 08400001 00004623 00000039
> +0x059960: 00000000 08400001 00008241 00000045

The last two blocks also temperatures. In the AMD thermal code,
we find definitions for CG_MULT_THERMAL_STATUS and
CG_THERMAL_RANGE. The first consists of 2 x 9 bit (0x23
and 0x43 above for idle and under load), the second is just
a value. On Zen2, the address for those values is 20 higher
(0x05997c instead of 0x059968), but the numbers are pretty
much the same. The AMD thermal code reads those values for
some graphics chips and displays it directly in degrees C.

I am just not sure what exactly it represents. I see those
temperatures on 3900X as well. Actually, it looks like all
chips report them, including server chips, so it is not the
graphics temperature. But it is definitely worth keeping an eye
on it; maybe someone can figure out what it is.

> Hope this is not a waste of your time.

No, it is definitely worth it. It will give me data to work with
in the future.

> Would you like similar for the 2500u ?
> 
Yes, that would be great.

Thanks,
Guenter

