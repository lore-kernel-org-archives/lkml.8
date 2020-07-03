Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA52C433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 19:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B15B420724
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 19:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fIN+tEcT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgGCTBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 15:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgGCTBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 15:01:51 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90C7C061794;
        Fri,  3 Jul 2020 12:01:51 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 207so14115683pfu.3;
        Fri, 03 Jul 2020 12:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4F8AEd8K/lUAINcNfD1mWsmL/PdMqbF0fV1/0PcAsxA=;
        b=fIN+tEcTrKUvokIjCCk3N47CLf/zbq+SCcnfnJ5tQpwTE5/MD1Yt5Ec5ZtxNOlrPiD
         I+IVAErC19T6xYIoL/x0ZN48eKD/pftnt6OR4i3QVCjaQ+CPXu568rNyQllqQWJ1/dig
         3eYk9QJxYLtU34SZQQ58m6SIpWMJti0zYEIzdP5nLULXRuGjGiLNGHH1KX+hsnUBVYMF
         he/6IFbtJyGqlGYXz85izizFoFvPF0D/graIfvYwYxc4qFTcARXkalFVtpx3dtczZKVy
         Rd2R5rtxNaRgYF8e2HD13oX7oQp7hpZt7ydYd6H81ERR5+c3M9HebU1SDMVRzJ+prClW
         y7dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=4F8AEd8K/lUAINcNfD1mWsmL/PdMqbF0fV1/0PcAsxA=;
        b=k91PbOb3OxX0EPv/xh0oUJ+RKWy6QsDBHHrlgZ84raR2Ypc5U3aYP0zArrSNuFrr7E
         TKhtiX23LwmvJl6mOS1t2yn+tX+jwAw++R4Az05SutNyFMTPLi1ptQdpPz2FtYpNKJVb
         4FH8jQiCXewcXScb29++EpjU/q3IO8vuh9tF8l5KvtyuxA8Z/K6hh/MX0IjTqB1CAIuS
         e5ubNbOkc5/MJeSQqzPd6XESufGRnG0mjoBPvaUt2XXOOkCH8yw4QrjpdEsdee1RXPc7
         GPHWY/hcp1J/P1lORKdgXJr+4Iv4ZTCVxaXBKBdWaRCJzRWSaTrvi0qGVL0kUYnBnORN
         uNmA==
X-Gm-Message-State: AOAM530hIeeM29M+lQHC/wDA0jkr0jx6Pf56c7XBLMWqYyB+G5GG7oBd
        L/fPPsO4tQi5YbkhhEiCRvQjH2CJ48g=
X-Google-Smtp-Source: ABdhPJwN5Acb90ISiv2fyyaPb75yEbY5EapPL61yfWAAIu+feirX6OxLh+Drlp7q+ikbZlVSFogOtg==
X-Received: by 2002:a62:ed02:: with SMTP id u2mr33689209pfh.283.1593802911260;
        Fri, 03 Jul 2020 12:01:51 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d7sm12156420pfh.78.2020.07.03.12.01.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2020 12:01:50 -0700 (PDT)
Subject: Re: [PATCH 22/30] usb: typec: tcpm: fusb302: Use 'gnu_printf' format
 notation
To:     Lee Jones <lee.jones@linaro.org>, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Yueyao Zhu <yueyao.zhu@gmail.com>
References: <20200703174148.2749969-1-lee.jones@linaro.org>
 <20200703174148.2749969-23-lee.jones@linaro.org>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <c1778e11-3fe4-2987-1d44-5cce0e5013f4@roeck-us.net>
Date:   Fri, 3 Jul 2020 12:01:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200703174148.2749969-23-lee.jones@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/3/20 10:41 AM, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/usb/typec/tcpm/fusb302.c: In function ‘fusb302_log’:
>  drivers/usb/typec/tcpm/fusb302.c:186:2: warning: function ‘fusb302_log’ might be a candidate for ‘gnu_printf’ format attribute [-Wsuggest-attribute=format]
>  186 | _fusb302_log(chip, fmt, args);
>  | ^~~~~~~~~~~~
> 
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: Yueyao Zhu <yueyao.zhu@gmail.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/usb/typec/tcpm/fusb302.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/fusb302.c
> index b28facece43c4..99562cc65ca69 100644
> --- a/drivers/usb/typec/tcpm/fusb302.c
> +++ b/drivers/usb/typec/tcpm/fusb302.c
> @@ -178,6 +178,7 @@ static void _fusb302_log(struct fusb302_chip *chip, const char *fmt,
>  	mutex_unlock(&chip->logbuffer_lock);
>  }
>  
> +__printf(2, 3)
>  static void fusb302_log(struct fusb302_chip *chip, const char *fmt, ...)
>  {
>  	va_list args;
> 

