Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D65C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 06:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F30E22B47
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 06:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="RXzLhjxM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgH0GmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 02:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbgH0GmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 02:42:11 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 564A8C061264
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 23:42:10 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id 12so2317751lfb.11
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 23:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=s+hgvzWkolB0cW+3qV7g0DekmVFJtookw1vL+Sw6Usw=;
        b=RXzLhjxMFcl4to2PONurI277x23q9RaODZqkcXjoY2O8xBAVFeyHJWNU/jsOh9wQH/
         DE0Hio9ywPOnvEfn4MdLrwOWNgkq1WSCpRC/rAcoijAhhBNp+e/V9MzmlBHd31CA5FdU
         3Mx+ncOUKS4yjoQDq9rn0rb9H5M2+l5F1FAp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s+hgvzWkolB0cW+3qV7g0DekmVFJtookw1vL+Sw6Usw=;
        b=FHAkrLfwSM0k59vV8vdhcJ8Q+pcNc9NkvXSHQR4BwudJwviLj7+taK6jDwx5lHvwM3
         pYKHumWBAJ533YYnq5oDid/HVzvlcvhGqRh5eMQ0Emb9xa8VLghOT8e8zWXy4sqjbNO9
         9xGOUj4XCLEKUKOvaWjm/8V87AEjRFJok3R3qUa1Z3ZLKyTaa0DnlyVzUVkqofhivhnj
         jXYmUjAHpmpZq/VjcnC+2wjxA6J54JDDwoADgMBExhQS8jkgEb4SBQEMzx9KNc19/v7T
         VxQ8UbEKw4ed0znNtSH9toXK/U9xoJ9fhYhD/8+HS5Imb8Gx/pyr+gNeUF5hL2uZQDVf
         qdQA==
X-Gm-Message-State: AOAM5319eCQROkBz+J/ndnwmVNhZc5Or0le70uG0/SUHiEqVgzRRW0Bv
        VezxSJ7HLWM61ZsziP0Rw/zyaZuxJtocL4JGGJo=
X-Google-Smtp-Source: ABdhPJz51JpiZS+VpQgNXGnTdjN0vJVizic22+7Wax906SaXrhHyADNSGWW1B3gL88D0VrRQl/EGyQ==
X-Received: by 2002:a19:915b:: with SMTP id y27mr1713158lfj.134.1598510528332;
        Wed, 26 Aug 2020 23:42:08 -0700 (PDT)
Received: from [172.16.11.132] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id m8sm273770lfj.88.2020.08.26.23.42.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2020 23:42:07 -0700 (PDT)
Subject: Re: [PATCH] usb: atm: don't use snprintf() for sysfs attrs
To:     Alex Dewar <alex.dewar90@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        accessrunner-general@lists.sourceforge.net,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200824222322.22962-1-alex.dewar90@gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <48f2dc90-7852-eaf1-55d7-2c85cf954688@rasmusvillemoes.dk>
Date:   Thu, 27 Aug 2020 08:42:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200824222322.22962-1-alex.dewar90@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/08/2020 00.23, Alex Dewar wrote:
> kernel/cpu.c: don't use snprintf() for sysfs attrs
> 
> As per the documentation (Documentation/filesystems/sysfs.rst),
> snprintf() should not be used for formatting values returned by sysfs.
>

Sure. But then the security guys come along and send a patch saying
"sprintf is evil, always pass a buffer bound". Perhaps with a side of
"this code could get copy-pasted, better not promote the use of sprintf
more than strictly necessary".

Can we have a sysfs_sprintf() (could just be a macro that does sprintf)
to make it clear to the next reader that we know we're in a sysfs show
method? It would make auditing uses of sprintf() much easier.

>  static ssize_t cxacru_sysfs_showattr_LINE(u32 value, char *buf)
> @@ -275,8 +275,8 @@ static ssize_t cxacru_sysfs_showattr_LINE(u32 value, char *buf)
>  		"waiting", "initialising"
>  	};
>  	if (unlikely(value >= ARRAY_SIZE(str)))
> -		return snprintf(buf, PAGE_SIZE, "%u\n", value);
> -	return snprintf(buf, PAGE_SIZE, "%s\n", str[value]);
> +		return sprintf(buf, "%u\n", value);
> +	return sprintf(buf, "%s\n", str[value]);
>  }

Not this patch in particular, but in some cases the string being printed
is not immediately adjacent to the sprintf call, making it rather hard
to subsequently verify that yes, that string is certainly reasonably
bounded. If you really want to save the few bytes of code that is the
practical effect of eliding the PAGE_SIZE argument, how about a
sysfs_print_string(buf, str) helper that prints the string and appends a
newline; that's another argument saved. And again it would make it
obvious to a reader that that particular helper is only to be used in
sysfs show methods.

Rasmus
