Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D29C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 09:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F6B221D91
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 09:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IP59XrEs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgDIJnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 05:43:13 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45046 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbgDIJnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 05:43:11 -0400
Received: by mail-wr1-f65.google.com with SMTP id c15so11106216wro.11
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 02:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GOxv76VTNJn0re7QfDmZ3EwQKAGpjmry3VNCaBN+aEQ=;
        b=IP59XrEseUrCjteD617L7bdHWtqsEZx8Lje5p2DC45Lafpf/q/phhPrG3hBxueq9Ag
         mFiuXzx5ii8IdBh8hvy21u1TxyLVcX0UHUlQQgQhzKwkUv5/qSlMKzJ6BQK6/ahmvV0K
         Ir9Uq+fOX4Z8TgsnRGv7fRCz2LaXFVDwAYdOHZztVpYY/zf/batqId6+Adzxf2oYB5oR
         kYc2dTbk+T761BuKJFa5qohcQ6l7yDLjEYFjTeURoq+WkkuBYEWoMKWIcmX6Jy3ttCKJ
         YTSTwkxhg2LqycUBJgIzGn+FMiBUutTRjSNI1g0uaD58HLt9VD7ITU4D8ywEDfFAL6iM
         gJPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GOxv76VTNJn0re7QfDmZ3EwQKAGpjmry3VNCaBN+aEQ=;
        b=HnMX/CZ8sc0wzCV+sQQzCPX6MIRCDg5Ft2DgbPn/KE2DYSQfHmFAG1iLrBVr437te/
         v6uxZCkaEghnjWdD9Pa2jRvbXHx9+scnPxn+/hyEvXPHzhbXdWgwaZjOzZmVtQ7CoUj/
         bPeoxrgdbt6rGCyLrAdnq/ot7ioQIflktqG05cT9J89wvsDV9R1GxPachUMLDgusjt95
         ST/B5Qsu0x8khhMQvwfbG+poGpZk27YoWOaupVsocPq3OY/Cvw+oYVUKaSIAiWZ/yZJ4
         QzD9AgDWyqY3Hn7ukFu/4vv5+3rqoj9vGqmu6dcQ5qQ7Jn3uW4VZtSKCoJhg3P8y6g8B
         6u8Q==
X-Gm-Message-State: AGi0PuaCV/QfEsYAV//lBZh4AnxfL/9Tmm9TLGfyF+4yjQMipm5e40AO
        myN/XpdEHG+5ZYbYBSAgqSxozWO33ww=
X-Google-Smtp-Source: APiQypIIn+KJTOqwwGo0FkMWMplK9DMO0NpY4o/cCriwOi5mFiBWE9LHKwJ1GNBC8+FkmGeRaP0qew==
X-Received: by 2002:adf:fa51:: with SMTP id y17mr14071155wrr.358.1586425390597;
        Thu, 09 Apr 2020 02:43:10 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:e1dc:4371:fecd:8292? ([2a01:e34:ed2f:f020:e1dc:4371:fecd:8292])
        by smtp.googlemail.com with ESMTPSA id f1sm41701387wrv.37.2020.04.09.02.43.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2020 02:43:09 -0700 (PDT)
Subject: Re: [PATCH] clocksource: davinci: avoid trailing '\n' hidden in
 pr_fmt()
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20200409092543.14727-1-christophe.jaillet@wanadoo.fr>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <54def81a-5065-93d6-3397-5086f2d86994@linaro.org>
Date:   Thu, 9 Apr 2020 11:43:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200409092543.14727-1-christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04/2020 11:25, Christophe JAILLET wrote:
> pr_xxx() functions usually have '\n' at the end of the logging message.
> Here, this '\n' is added via the 'pr_fmt' macro.
> 
> In order to be more consistent with other files, use a more standard
> convention and put these '\n' back in the messages themselves and remove it
> from the pr_fmt macro.
> 
> While at it, remove a useless message in case of 'kzalloc' failure,
> especially with a __GFP_NOFAIL flag.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied, thanks

> ---
> Not sure that the __GFP_NOFAIL is relevant here.

No, it is not relevant.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
