Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B7DC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 12:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EBDD20838
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 12:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MH05/iQO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgFLM1h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 08:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbgFLM1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 08:27:35 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B566DC03E96F;
        Fri, 12 Jun 2020 05:27:35 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id q8so8693788qkm.12;
        Fri, 12 Jun 2020 05:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tLsYfW4RvheYw9CTrX8bz1lS4lnmm2tAaCXBCxYWoEQ=;
        b=MH05/iQOWHCHtXEzT/j87+oMOe4Ehszd4i8qMJaU6IlFrgT0hhW5I3HK1PrbLC/Qck
         aAv/hhZ8afPHNSDyMGRD2r88qciFMfDNjbugPS7sBf2RsxvRNjInlBnlVqqqzDIiI7Rh
         1zXeabBiBZuftgS4wow31QmOGoT1lczlwEtPi0YoYwGZH65tgoGk3nium8hrEtYYrEuj
         RjvWysY3mmxHSxNZ2DOJZLhOhyEJh9MHpIx6OsWIpOUGIi5XY53/miD1Ib714okQUse5
         0u4n7rfBHd09G/wHg7WdoN42B2qJ9LVpxJDEg2nhv36TDAaS3g+90/f7pZz2cydGNeRu
         tE3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tLsYfW4RvheYw9CTrX8bz1lS4lnmm2tAaCXBCxYWoEQ=;
        b=paydBjKjcWPnDOVAMSS0E5KRlnKd6yRebKAdpl32j9iEGeGDIS/1zgxoexkFPzJyxg
         vT/56Touj3ssotVV5QQL0yvGZULf7TH/vhkvMHi4vI1/I27Xt1I7Er/9gp4nH0p14xEU
         5R6GM9Fhk6vLjgLkbX4tbysfIyCbQlZOfXRMQciOa+WRyiZaJ8BWlAesB+Ayry5ElMZ4
         Wv6lzPnutIMCgzXfY643nB/WcXOH4hh3iYnTGifOf79zcFEdlCBsS867Ngc2LUTVKpaP
         p+cgtMIXxMEFLwCZ9dYmVrCzu4wLQwxvQmteqRWL5akS9HtRs0UBgIqXFqbr9Bqr2K1F
         PBxQ==
X-Gm-Message-State: AOAM5314mhi7zFfdXmjAwPuz2Wbzql6dF/ykw+pTNrUIqWMVxv1mdcwd
        JbFhg+jvkEx85U/boC/PX+o=
X-Google-Smtp-Source: ABdhPJzQrd9/sO1InrMTv8fzLY+uBcD1JYvMHAmp8wEARA5eSwbGqDdAQI7YwopBMXTQ4OfmSLiqtA==
X-Received: by 2002:a37:be43:: with SMTP id o64mr2658766qkf.322.1591964855029;
        Fri, 12 Jun 2020 05:27:35 -0700 (PDT)
Received: from [192.168.1.46] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id o66sm4306188qka.60.2020.06.12.05.27.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2020 05:27:34 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] mfd: core: Fix formatting of MFD helpers
To:     Lee Jones <lee.jones@linaro.org>, andy.shevchenko@gmail.com,
        michael@walle.cc, robh+dt@kernel.org, broonie@kernel.org,
        devicetree@vger.kernel.org, linus.walleij@linaro.org,
        linux@roeck-us.net, andriy.shevchenko@linux.intel.com,
        robin.murphy@arm.com, gregkh@linuxfoundation.org,
        Frank Rowand <frowand.list@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200611191002.2256570-1-lee.jones@linaro.org>
 <20200611191002.2256570-2-lee.jones@linaro.org>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <e46a0d3f-80c4-dc36-8002-96740316b442@gmail.com>
Date:   Fri, 12 Jun 2020 07:27:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200611191002.2256570-2-lee.jones@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Frank (me)

On 2020-06-11 14:10, Lee Jones wrote:
> Remove unnecessary '\'s and leading tabs.
> 
> This will help to clean-up future diffs when subsequent changes are
> made.
> 
> Hint: The aforementioned changes follow this patch.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  include/linux/mfd/core.h | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/mfd/core.h b/include/linux/mfd/core.h
> index a148b907bb7f1..ae1c6f90388ba 100644
> --- a/include/linux/mfd/core.h
> +++ b/include/linux/mfd/core.h
> @@ -26,20 +26,20 @@
>  		.id = (_id),						\
>  	}
>  
> -#define OF_MFD_CELL(_name, _res, _pdata, _pdsize,_id, _compat)		\
> -	MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, _compat, NULL)	\
> +#define OF_MFD_CELL(_name, _res, _pdata, _pdsize,_id, _compat) \
> +	MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, _compat, NULL)
>  
> -#define ACPI_MFD_CELL(_name, _res, _pdata, _pdsize, _id, _match)	\
> -	MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, NULL, _match)	\
> +#define ACPI_MFD_CELL(_name, _res, _pdata, _pdsize, _id, _match) \
> +	MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, NULL, _match)
>  
> -#define MFD_CELL_BASIC(_name, _res, _pdata, _pdsize, _id)		\
> -	MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, NULL, NULL)	\
> +#define MFD_CELL_BASIC(_name, _res, _pdata, _pdsize, _id) \
> +	MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, NULL, NULL)
>  
> -#define MFD_CELL_RES(_name, _res)					\
> -	MFD_CELL_ALL(_name, _res, NULL, 0, 0, NULL, NULL)		\
> +#define MFD_CELL_RES(_name, _res) \
> +	MFD_CELL_ALL(_name, _res, NULL, 0, 0, NULL, NULL)
>  
> -#define MFD_CELL_NAME(_name)						\
> -	MFD_CELL_ALL(_name, NULL, NULL, 0, 0, NULL, NULL)		\
> +#define MFD_CELL_NAME(_name) \
> +	MFD_CELL_ALL(_name, NULL, NULL, 0, 0, NULL, NULL)
>  
>  struct irq_domain;
>  struct property_entry;
> 

