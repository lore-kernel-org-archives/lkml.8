Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F5FC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 14:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D0102224E
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 14:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A+xuqe5h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730061AbgIIO2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 10:28:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35168 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728264AbgIIM66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 08:58:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599656343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1/8nQXqMfzr63L9sc34nY6dq0v4DgYlu4G8KpQeRN64=;
        b=A+xuqe5hb5AtgwmYcC62b6Yax4TN5N791ICesrqUsPT1y9UJHHFoImamZPzi6XEZ9whykJ
        ojQr8BthJ5Wc12YaM/TFCrCHc70nQaDdzUwTQTrSGATKpj280tsv94wJ0eUv8u12LRQd3k
        JDNTrd2MAPv+Nc5rSFOxPetd5hyhLHo=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-523-YxP5y-8UOtWaeOY0qj_obQ-1; Wed, 09 Sep 2020 08:59:01 -0400
X-MC-Unique: YxP5y-8UOtWaeOY0qj_obQ-1
Received: by mail-qv1-f71.google.com with SMTP id de12so1278756qvb.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 05:59:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=1/8nQXqMfzr63L9sc34nY6dq0v4DgYlu4G8KpQeRN64=;
        b=iQKwXaBdw1RAu5c9kvKo42xCgMrhYH2/l0H3K6yyt/IC1fWCgCnJTsJMQ0saqc/ZP2
         ZRttW/Y+Up7eBy6OSzypxDLE1F5u9BYvkG94FLkPhDLdMveULcwhzh9ce84oJS+gaAIa
         aQqUneX5NpNEYYy7g28U6Zv19v+0viyTVzeGpoMH+RMjnEQfrFSxTLnCyRe5Yz3rb0Ep
         ByrF+TiTXj5fPhYYKRTI7OeBX3/dEidiZWhVV3Fm7wtzQkhtkgRqv2NGo1+OBf2122M6
         NGFhMCZEnXUu9KmskwD5DbdiSbkBY53fhD0oHSF8SOlUNnLFtraAgtPbDns5FFEjo5sd
         EtCw==
X-Gm-Message-State: AOAM531MoG7Cr5YfPh/s2FZKvukJQ5G8FTi6jHWR4hv0Ve9M3uu+7oKy
        ffxxFSZcWvjdPNnII+wnD8tIgc23iGpI6KjbOwrVoKO4GB2NjILi0HmCuZs4qXI10RxpzV/bcd/
        VbiWu/6h9lOp5UDOPOFWl72pk
X-Received: by 2002:aed:35c4:: with SMTP id d4mr2989778qte.151.1599656341210;
        Wed, 09 Sep 2020 05:59:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw4qqVvyKXPZHWb/Vt+ESzI0NqJrnhykvAageDbUvqZgLaFMO1gRVF6I1UCUh0UGu9Ofe529A==
X-Received: by 2002:aed:35c4:: with SMTP id d4mr2989765qte.151.1599656340954;
        Wed, 09 Sep 2020 05:59:00 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id i7sm2553075qkb.131.2020.09.09.05.58.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2020 05:59:00 -0700 (PDT)
Subject: Re: [PATCH 2/3] dfl: add dfl bus support to MODULE_DEVICE_TABLE()
To:     Xu Yilun <yilun.xu@intel.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        masahiroy@kernel.org
Cc:     lgoncalv@redhat.com, Wu Hao <hao.wu@intel.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>
References: <1599544129-17594-1-git-send-email-yilun.xu@intel.com>
 <1599544129-17594-3-git-send-email-yilun.xu@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <31cffdc2-ed70-8f96-5501-08965d701535@redhat.com>
Date:   Wed, 9 Sep 2020 05:58:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1599544129-17594-3-git-send-email-yilun.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/7/20 10:48 PM, Xu Yilun wrote:
> Device Feature List (DFL) is a linked list of feature headers within the
> device MMIO space. It is used by FPGA to enumerate multiple sub features
Do you mean a linked list in the pci config space ?
> within it. Each feature can be uniquely identified by DFL type and
> feature id, which can be read out from feature headers.
>
> A dfl bus helps DFL framework modularize DFL device drivers for different
> sub features. The dfl bus matches its devices and drivers by DFL type and
> feature id.
>
> This patch add dfl bus support to MODULE_DEVICE_TABLE() by adding info
> about struct dfl_device_id in devicetable-offsets.c and add a dfl entry
> point in file2alias.c.
>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> ---
>  scripts/mod/devicetable-offsets.c |  4 ++++
>  scripts/mod/file2alias.c          | 13 +++++++++++++
>  2 files changed, 17 insertions(+)
>
> diff --git a/scripts/mod/devicetable-offsets.c b/scripts/mod/devicetable-offsets.c
> index 27007c1..d8350ee 100644
> --- a/scripts/mod/devicetable-offsets.c
> +++ b/scripts/mod/devicetable-offsets.c
> @@ -243,5 +243,9 @@ int main(void)
>  	DEVID(mhi_device_id);
>  	DEVID_FIELD(mhi_device_id, chan);
>  
> +	DEVID(dfl_device_id);
> +	DEVID_FIELD(dfl_device_id, type);
> +	DEVID_FIELD(dfl_device_id, feature_id);
> +
>  	return 0;
>  }
> diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
> index 2417dd1..0753fc2 100644
> --- a/scripts/mod/file2alias.c
> +++ b/scripts/mod/file2alias.c
> @@ -1368,6 +1368,18 @@ static int do_mhi_entry(const char *filename, void *symval, char *alias)
>  	return 1;
>  }
>  
> +/* Looks like: dfl:tNfN */
> +static int do_dfl_entry(const char *filename, void *symval, char *alias)
> +{
> +	DEF_FIELD(symval, dfl_device_id, type);
> +	DEF_FIELD(symval, dfl_device_id, feature_id);
> +
> +	sprintf(alias, "dfl:t%01Xf%03X", type, feature_id);

Is it necessary to constrain the output here ?

If you do not want to use the full width of the types,

a comment would be helpful.

Tom

> +
> +	add_wildcard(alias);
> +	return 1;
> +}
> +
>  /* Does namelen bytes of name exactly match the symbol? */
>  static bool sym_is(const char *name, unsigned namelen, const char *symbol)
>  {
> @@ -1442,6 +1454,7 @@ static const struct devtable devtable[] = {
>  	{"tee", SIZE_tee_client_device_id, do_tee_entry},
>  	{"wmi", SIZE_wmi_device_id, do_wmi_entry},
>  	{"mhi", SIZE_mhi_device_id, do_mhi_entry},
> +	{"dfl", SIZE_dfl_device_id, do_dfl_entry},
>  };
>  
>  /* Create MODULE_ALIAS() statements.

