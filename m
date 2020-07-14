Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF81C43445
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 13:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 733D722280
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 13:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iYPkFdVN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbgGNNeG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 09:34:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23639 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726624AbgGNNeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 09:34:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594733642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nbYxWd2D4nHUUgDPltXRuvjC0SSKlTNEhd9CP0YMbwc=;
        b=iYPkFdVNZY4xcHPe4g3E+JLcLBNJW6yClvPAgKktSIPMR5rCQLetk0g+Tw1gCpU9PMGjvM
        Y6Gjl1ZZpY7ZSM+nFUIMPO0PnpUgw+Oy7Z8lU7Uo9vvE+A9I0df+8k+EKxGlPtBGnmo9R/
        4S6PV7RG1giS9bQ+I/RCbrOF/7+JJaI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-N8t5nUnzNTi9U2MCXNV23w-1; Tue, 14 Jul 2020 09:34:01 -0400
X-MC-Unique: N8t5nUnzNTi9U2MCXNV23w-1
Received: by mail-wr1-f70.google.com with SMTP id w4so21722658wrm.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 06:34:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nbYxWd2D4nHUUgDPltXRuvjC0SSKlTNEhd9CP0YMbwc=;
        b=pydlHNy0O5jhPkrtmgrhWJeEjw06RXVDCPcXKs2NIFjdVBNTzD64nc23NXAE8KhuyU
         5o+ya/f3kqOIvaoAxWUEhdvpgTKc7Ll+rDHmuJI3YIgT+PEKhjQ8IixQ6sSg/xIS/dnY
         vLLyAnuh1oLFMtilAQOgYm5n/wH9eIg+CHMdPjkNZp2oB7EYEZYg/oXCCpTWFUNKVcTv
         eA5SiCxnCOM4IrLm2jd+vHFbfRbpb1BrOpImNIzKJhWHR0k8HM++4HsfBy/yQpnrqTZU
         1qSWpUxiZAdXwU3K3drPrBA3Y9hfkBaqyjnINlRjST/c9OodoWJdcmt/oo1G0S92BifX
         jKpA==
X-Gm-Message-State: AOAM53051Vx3//g2AN1xwyF2qs56OqN3KFEthCihJdhnAXMD7nfPZ+Ot
        wm1D4zsLOd+83YS0xMxRE1R/3ux1kclRa5lflvBMGvj1Ok5HujnTbIDDrtnL9ryGW/v4XryK5Df
        yMn9Btoi8T72v0SQ1BQXM8XFN
X-Received: by 2002:a7b:c116:: with SMTP id w22mr4413279wmi.97.1594733639997;
        Tue, 14 Jul 2020 06:33:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxRuMChFkvfKKE/w1wbHZHIs87aQfuy0IINKhNsGaCWeLr1sl5q3sbqOzLFhiAFarAar7Nyng==
X-Received: by 2002:a7b:c116:: with SMTP id w22mr4413259wmi.97.1594733639844;
        Tue, 14 Jul 2020 06:33:59 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id m4sm4270892wmi.48.2020.07.14.06.33.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2020 06:33:59 -0700 (PDT)
Subject: Re: [PATCH] ASoC: Intel: bytcht_es8316: Add missed put_device()
To:     Jing Xiangfeng <jingxiangfeng@huawei.com>,
        cezary.rojewski@intel.com, pierre-louis.bossart@linux.intel.com,
        liam.r.girdwood@linux.intel.com, yang.jie@linux.intel.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        kuninori.morimoto.gx@renesas.com, paul@crapouillou.net
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20200714080918.148196-1-jingxiangfeng@huawei.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <25abce87-5572-a78a-f001-7776f07be4ac@redhat.com>
Date:   Tue, 14 Jul 2020 15:33:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200714080918.148196-1-jingxiangfeng@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/14/20 10:09 AM, Jing Xiangfeng wrote:
> snd_byt_cht_es8316_mc_probe() misses to call put_device() in an error
> path. Add the missed function call to fix it.
> 
> Fixes: ba49cf6f8e4a ("ASoC: Intel: bytcht_es8316: Add quirk for inverted jack detect")
> Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>

Patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>   sound/soc/intel/boards/bytcht_es8316.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/intel/boards/bytcht_es8316.c b/sound/soc/intel/boards/bytcht_es8316.c
> index 9e5fc9430628..ecbc58e8a37f 100644
> --- a/sound/soc/intel/boards/bytcht_es8316.c
> +++ b/sound/soc/intel/boards/bytcht_es8316.c
> @@ -543,8 +543,10 @@ static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
>   
>   	if (cnt) {
>   		ret = device_add_properties(codec_dev, props);
> -		if (ret)
> +		if (ret) {
> +			put_device(codec_dev);
>   			return ret;
> +		}
>   	}
>   
>   	devm_acpi_dev_add_driver_gpios(codec_dev, byt_cht_es8316_gpios);
> 

