Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EDC5C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 23:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14A8220706
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 23:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mRB51f8d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgHYXd0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 19:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbgHYXd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 19:33:26 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E809AC061574;
        Tue, 25 Aug 2020 16:33:25 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id n3so252933pjq.1;
        Tue, 25 Aug 2020 16:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2FNoKN0kaYc5PEMF/7OkH/69aeo+O5crzxwYWBe7l/8=;
        b=mRB51f8dmL9rWfcKDVGREdgeS94KkEpoCj1ZfOTjHF22suF5rmr2Xpq8QrOthz4pvd
         Km90MiILM2NhaxXXMYaoTSyVIzn6KVVYTYYTKbgrTRzyltStY2NbxL+n2pc3yadrpsOm
         OGJVV2mtci2n0lWGr1bFPf5168mjoEOJZ4cSjYBn7wkmOzdkWswNWG3F6WFU3gjWj5q1
         Citjl3fBVrDkZ7twXiAXus5LcO06kmvRNiUflrhnWoU7C6ZOdjT3aUmhglgHJczjGjlQ
         1Mr1HPmsiRmuBlFw8eAbSHt0agxiS7zIHz+HCZZyxTox1YI2D62k0cJggqSMxGqpWAm4
         igWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=2FNoKN0kaYc5PEMF/7OkH/69aeo+O5crzxwYWBe7l/8=;
        b=qp3IBcihyBfvS5i059s3YH6KRNTamSjsU6OZWbIinWIIq+PvmzRXRqULaTADwA0DhL
         shsNSC696DgnD7l7Y/2cdugCnyrz9EvQkOPhJisqNxQi0xiuff0348ym5yVdrwN5AOl1
         Sn2OQQY6ySQXcx4UXL8V4ii9M1EdcahYqF65YqVrJKqUvq/ofh3j/B8pPq1T2qNZMEHa
         85ihqNTz1LJOAS/LdCyOyEGqG6x5JFxEMpLHLhyRtcugdF8JwZDCUJpy+bhZtpXDo14x
         rBZu931SQjBLkFEDINOKF9zaMv8BAgN4ksQOtC6/jEFV3MGm7hO/a1mr1EiIsnIjV6Jq
         O/6w==
X-Gm-Message-State: AOAM533XBBEqwx/uh28Qw8Ndhz1aVfP1p8MqgzfEwbP0ddzlyq9vxExw
        uUn1Rsjrs8DeUTMMn/5iX3Dzdx6CPiI=
X-Google-Smtp-Source: ABdhPJwGw/Z5ArzPamde04jc7fUQiAw5EXM8GGHqGXKxjBb7+3cSk4h16+h9laio5cduQfdUy5p6EQ==
X-Received: by 2002:a17:902:9883:: with SMTP id s3mr9582714plp.271.1598398405513;
        Tue, 25 Aug 2020 16:33:25 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v128sm369465pfc.14.2020.08.25.16.33.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Aug 2020 16:33:24 -0700 (PDT)
Date:   Tue, 25 Aug 2020 16:33:23 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Joe Perches <joe@perches.com>
Cc:     Jiri Kosina <trivial@kernel.org>, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/29] hwmon: (scmi-hwmon): Avoid comma separated
 statements
Message-ID: <20200825233323.GA127894@roeck-us.net>
References: <cover.1598331148.git.joe@perches.com>
 <5e1ca60df261e3bfd0e6510e388581a1d1f52c77.1598331149.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e1ca60df261e3bfd0e6510e388581a1d1f52c77.1598331149.git.joe@perches.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 24, 2020 at 09:56:08PM -0700, Joe Perches wrote:
> Use semicolons and braces.
> 
> Signed-off-by: Joe Perches <joe@perches.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/scmi-hwmon.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/scmi-hwmon.c b/drivers/hwmon/scmi-hwmon.c
> index d421e691318b..09ce30cba54b 100644
> --- a/drivers/hwmon/scmi-hwmon.c
> +++ b/drivers/hwmon/scmi-hwmon.c
> @@ -202,8 +202,10 @@ static int scmi_hwmon_probe(struct scmi_device *sdev)
>  		}
>  	}
>  
> -	if (nr_count[hwmon_temp])
> -		nr_count[hwmon_chip]++, nr_types++;
> +	if (nr_count[hwmon_temp]) {
> +		nr_count[hwmon_chip]++;
> +		nr_types++;
> +	}
>  
>  	scmi_hwmon_chan = devm_kcalloc(dev, nr_types, sizeof(*scmi_hwmon_chan),
>  				       GFP_KERNEL);
