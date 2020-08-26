Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0BD9C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 13:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73A1D20707
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 13:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XHJVO8Qm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730163AbgHZNCS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 09:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730145AbgHZNBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 09:01:51 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 533B7C061574;
        Wed, 26 Aug 2020 06:01:51 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id n18so1281230qtw.0;
        Wed, 26 Aug 2020 06:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qMvYEDeiSbnOhgtPNg0miqtr2M/qecacoqZoySra/pk=;
        b=XHJVO8QmzjKKjmw/EYpEKsONJyfpKooco0CE3OGx6Jf4IYBu74HKWmTq6SWo78ns6V
         q0K9g7nBr/UGfsippnFYhWPotRmAKAairvquUJX3mHojRVuCdUQb7syN4eka094pQRhd
         pqlq440OIekHL9GFTLFU2vcei5c6bxo3jXSdZq2jEG9HDoSr8pGiWEeHU7dCu4/NVUKh
         WI+C8NCq36ExWLNuNcL2S+yzIPwm49m2inXaRU56CHw1hmyYLEnvfPH8OiQP5qTM+qg+
         nUamudlTnGEYH+UwYN68tpjv96LTgNkTdIiMeCFyRiGu8L/FQp05ledRJiTniOV/7oPR
         bS/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qMvYEDeiSbnOhgtPNg0miqtr2M/qecacoqZoySra/pk=;
        b=KN2JRGy7VmyHv6L8jf1GY2FxnN+HPRObTmU0sFiSTGkW2KT1X5Hi6CBkKlrIR+PQDE
         Da88XNKe+x1rRFnlGHaY5LuraoepxKTPy82UILhhmYY8KY4kSBGCu866pE2g9fJQVUdR
         yVVbrOgRXRPdyehXF8I+oUMH1ppKrZMBLG8tjNdK5T1C3vSxtORagFmYktpdU18XhxHr
         AnnLcWkxraCoamCkscf6vETj6lYg3UHFgQw7aYFTEZYXuVKV21iKHa6imf9PrsOUjtgW
         7YwPiKyS83hHzlE7cQlkLS7eKPjVOB/IzaBxxE7U3AKhWl1VlYu1jr9QkrWFmLD07OZ3
         4HGA==
X-Gm-Message-State: AOAM533jqh+yADXz99lk2saBR/b4khGC9tr5Ku2YPU32jfQ+mHYlCs3p
        AUYo9HEcG/biwGvT8VLoA9ZOv4u8TO4K0A==
X-Google-Smtp-Source: ABdhPJwxHfbMHpa7HkpnJcjx55MDVEdhI/f1ua38mzX3T0BYfZiUsPS8SvJmKdr+rCOig8/RJhreOw==
X-Received: by 2002:ac8:60c5:: with SMTP id i5mr14285987qtm.268.1598446910606;
        Wed, 26 Aug 2020 06:01:50 -0700 (PDT)
Received: from [192.168.1.46] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id x88sm1971364qtd.1.2020.08.26.06.01.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2020 06:01:49 -0700 (PDT)
Subject: Re: [PATCH] of: skip disabled CPU nodes
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200826120254.8902-1-matthias.schiffer@ew.tq-group.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <4dd06b79-1402-d7cf-9676-1f9a9526da12@gmail.com>
Date:   Wed, 26 Aug 2020 08:01:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200826120254.8902-1-matthias.schiffer@ew.tq-group.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-26 07:02, Matthias Schiffer wrote:
> Allow disabling CPU nodes using status = "disabled".
> 
> This allows a bootloader to change the number of available CPUs (for
> example when a common DTS is used for SoC variants with different numbers
> of cores) without deleting the nodes altogether (which may require
> additional fixups where the CPU nodes are referenced, e.g. a cooling
> map).
> 
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---
>  drivers/of/base.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index ea44fea99813..d547e9deced1 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -796,6 +796,8 @@ struct device_node *of_get_next_cpu_node(struct device_node *prev)
>  		of_node_put(node);
>  	}
>  	for (; next; next = next->sibling) {
> +		if (!__of_device_is_available(next))
> +			continue;
>  		if (!(of_node_name_eq(next, "cpu") ||
>  		      __of_node_is_type(next, "cpu")))
>  			continue;
> 

The original implementation of of_get_next_cpu_node() had
that check, but status disabled for cpu nodes has different
semantics than other nodes, and the check broke some systems.
The check was removed by c961cb3be906 "of: Fix cpu node
iterator to not ignore disabled cpu nodes".

It would be useful to document that difference in the
header comment of of_get_next_cpu_node().

-Frank
