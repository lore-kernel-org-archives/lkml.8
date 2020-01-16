Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B4B7C33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 13:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1CBA20661
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 13:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rUTSUnWa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgAPNYO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 08:24:14 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41728 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbgAPNYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 08:24:14 -0500
Received: by mail-wr1-f68.google.com with SMTP id c9so19135435wrw.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 05:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=v7jTUW5+K2kVIgC/NaO+mYPYmuJ/iTO8BIN9AU9m/uY=;
        b=rUTSUnWaH07o4mUO0LGTW9RL0tRTdeuWojYZwMsF6jAj3a/Avh0lYtdm3R8y5kQ/b2
         MCg0DzT1mH7htZREPfDgGG/uuxpQhg9T1d+Y7QfjsYwwoWf6qEO4fYupt91WNFIsoAXI
         nxV8m7zqHDsJc/fREMsFCiL9FI6hKlKkMgPyIv6rFOd2TBE1HMa0sNBbFafmBJZK/zzP
         icYVguk1MmkWmMH36X/bpncwqB3qYHZwrW2X0NQdhUgoEZ7UBo1oSCW1OFM+tnW68uYO
         DyXQpH6EMjCPBp3WQWzd0GYxfa8QpyX+DfeuCWxGTLhv4DxLkwJTYP+OVk9GaNjcG2+u
         Oy+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=v7jTUW5+K2kVIgC/NaO+mYPYmuJ/iTO8BIN9AU9m/uY=;
        b=E3SXw2N3UlCrRMgJ82jaDX4sq1iZNoOEQgPWmQB7jTQphBwvjVIDPlhTSLPCcAkFyn
         ifOPzy3SFEm+iyK5cTIGe7FC3KLx5BwKPF0tbPlvSwoIp2DYcqqQcoJp8SIQMCVfncgg
         yE57K37XJ/dzJ1pnPuCdLQUVHHQKRL6VqCQg9dSj0KbBifMc2mX+pfPKKCX4jDNTQqmL
         24U8C7Fz9IyWT+w7lhRKkgKGw0P5GYaL8c3AYvIzfdNiM+tsAA+C7K676i7AkMUwItWI
         D4Licew3yAcDGBcNGkP4iX5arQvV9L3lUO+MinC189/s6+31gX5lDN2cRmCbTmqP8/Ci
         z4Ug==
X-Gm-Message-State: APjAAAV1dn4vcceMQN+74Vn6qA8++oXJ8MfgylQt5Vpxz/TvEhSEl+yx
        rtp4DkJ+OVhuiuKA03T1r2V0XWZI/bA=
X-Google-Smtp-Source: APXvYqzhIE2dzL87Z0imRwZ2sUjwcxm7xvVwDPc4vuryCj8p20u6TZY0w1HGNi49nZ+ioTsKG+qXbQ==
X-Received: by 2002:a5d:540f:: with SMTP id g15mr3241050wrv.86.1579181053002;
        Thu, 16 Jan 2020 05:24:13 -0800 (PST)
Received: from dell ([2.27.35.221])
        by smtp.gmail.com with ESMTPSA id c17sm29103415wrr.87.2020.01.16.05.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 05:24:12 -0800 (PST)
Date:   Thu, 16 Jan 2020 13:24:29 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH v2 3/3] mfd: madera: Allow more time for hardware reset
Message-ID: <20200116132429.GL325@dell>
References: <20200114151048.20282-1-ckeepax@opensource.cirrus.com>
 <20200114151048.20282-3-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200114151048.20282-3-ckeepax@opensource.cirrus.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jan 2020, Charles Keepax wrote:

> Both manual and power on resets have a brief period where the chip will
> not be accessible immediately afterwards. Extend the time allowed for
> this from a minimum of 1mS to 2mS based on newer evaluation of the
> hardware and ensure this reset happens in all reset conditions. Whilst
> making the change also remove the redundant NULL checks in the reset
> functions as the GPIO functions already check for this.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
> 
> Changes since v1:
>  - Switch from a helper function to defines for the delay
> 
> This patch can be applied separately from the other patches in the series,
> if needed.
> 
> Thanks,
> Charles
> 
>  drivers/mfd/madera-core.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
