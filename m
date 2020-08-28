Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F1FC433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 18:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 932652098B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 18:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GhIte1Cy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbgH1SWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 14:22:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57391 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726677AbgH1SWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 14:22:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598638951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gQJ4JVAyZccb9LOsjk70ODp519hsCY75Xylx5YLbB0k=;
        b=GhIte1CydZ9vzvXAq4cn+Qgy536SbwkFzxsm2JDZCwSDEoyIXyDaz724PnJYgHfN7j7WZt
        eVHuKI420nQuvyzXB/HmQJ3cBIPXm12RTb09+DWmxM/j0hiUvmIwcDaFiQKQNGC9lSTWV6
        KGz2zW1SmlTJv7CFIuKQ8EJsv9CQyOk=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-531-p3-_o5sVMPGcnXC2OxnzCw-1; Fri, 28 Aug 2020 14:22:28 -0400
X-MC-Unique: p3-_o5sVMPGcnXC2OxnzCw-1
Received: by mail-qv1-f72.google.com with SMTP id r12so1430839qvx.20
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 11:22:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=gQJ4JVAyZccb9LOsjk70ODp519hsCY75Xylx5YLbB0k=;
        b=Qd0AUNPXqTT9Q3/uFS0h3cc56/GPwvIsVK03qrQla8aHMuHlTwoGhshig/ghjcc9zi
         LBiMQIGShCzgTvivc2fdoa4KZXCNzzBL3O1bi8Xs+KKdNh1dhBfv6/Xn7GTnfqn/Yjx5
         faWzYJXiGglG5G+GiwTMxR3RwNVTClAcIA4T6MXxNtg6TPGIiMOpmMpxhDJhdL2YEUzI
         1XPFpwx5YqKFc902t3rIMVIx4WgrGY5PhdJqeFaumDHYakHRmg1ToIL3p9+vRhN4INnI
         wZnwRanCsnpTROIy+4mzaw2CfPsU62aanqJitjJmjLH2FXXQqOsic6VgQcF4Sy5JpgLz
         hzxw==
X-Gm-Message-State: AOAM533VU+cYym9q5dH0kO4zbmmSOsVUrbXCW7tRfxzsvCcC7GJMJj2g
        LE6zyOf0tCmekIQm8TaC1V2TXoSIzlqXHE/K6nUTEXU7Z35IVgx6N+7xV89VDj8ogeb4sF0QsVk
        L3djD/e2PUpkiLFa9z1YaS45l
X-Received: by 2002:aed:3ac7:: with SMTP id o65mr2785405qte.11.1598638947612;
        Fri, 28 Aug 2020 11:22:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJykLX2F/H2IW7PTB/H8+bZSwyIhUyVPyE+96a4cP8IAUOS9HqGa9GMQaoq/oBu7k4aDd+yvRA==
X-Received: by 2002:aed:3ac7:: with SMTP id o65mr2785387qte.11.1598638947350;
        Fri, 28 Aug 2020 11:22:27 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id k185sm1399871qkc.77.2020.08.28.11.22.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Aug 2020 11:22:26 -0700 (PDT)
Subject: Re: [PATCH] driver code: print symbolic error code
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org
References: <ea3f973e4708919573026fdce52c264db147626d.1598630856.git.mirq-linux@rere.qmqm.pl>
From:   Tom Rix <trix@redhat.com>
Message-ID: <434ca0ab-1c9b-5c4f-c844-5e792725f9ab@redhat.com>
Date:   Fri, 28 Aug 2020 11:22:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <ea3f973e4708919573026fdce52c264db147626d.1598630856.git.mirq-linux@rere.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/28/20 9:14 AM, Michał Mirosław wrote:
> dev_err_probe() prepends the message with an error code. Let's make it
> more readable by translating the code to a more recognisable symbol.
recognizable
>
> Fixes: a787e5400a1c ("driver core: add device probe log helper")
is this change really to fix a bug?
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> ---
>  drivers/base/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index ac1046a382bc..1a4706310b28 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -4237,10 +4237,10 @@ int dev_err_probe(const struct device *dev, int err, const char *fmt, ...)
>  	vaf.va = &args;
>  
>  	if (err != -EPROBE_DEFER) {
> -		dev_err(dev, "error %d: %pV", err, &vaf);
> +		dev_err(dev, "error %pe: %pV", ERR_PTR(err), &vaf);
>  	} else {
>  		device_set_deferred_probe_reason(dev, &vaf);
> -		dev_dbg(dev, "error %d: %pV", err, &vaf);
> +		dev_dbg(dev, "error %pe: %pV", ERR_PTR(err), &vaf);

Should just use '-EPROBE_DEFER' directly instead of making printk do it.

or maybe reduce the original if-else to an just an if

if (err == -EPROBE_DEFER)

    device_set_deferred_probe_reason(...

dev_dbg(dev, "error %pe ...

Tom

>  	}
>  
>  	va_end(args);

