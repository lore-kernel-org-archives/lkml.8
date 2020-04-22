Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E20C55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 15:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E66B2073A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 15:08:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="aKB0vNW7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgDVPIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 11:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbgDVPIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 11:08:41 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD264C03C1AC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 08:08:40 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id f13so2781742wrm.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 08:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JaYh26NahsPsqmz5/mIcVsKVgNpCY3mY3g+xU2LFLi8=;
        b=aKB0vNW7/kq0ElSbDwSF2785i3I+GaTy1V++wNlb7hIZQ5p2vqcHEIWXH6GkZQDp9l
         Kj7b0Lbf2iqTHK1rwlQb/TQuCm2Djb23qxG7Vxwe1aNMsky1khRafUEQfX7HOL79W7gR
         6FbHEIzG9WmFvdv/GBhi+GmZ5Cym5EFZfFpGscOIF5i+8tlKrWQoaubCjlnVsg5iCQy7
         oCmrl5jNK1z9ZJ/2Qpv86/Kxq22DhdqzCBx4TPW6fCldB8JmMbzMsf2rvAcJ3EbwF0m+
         KS+FGlnRisoD/FZ9k5Yj0boqOdgeQde74aw0VUKk+LPlUoyRR+pzRM2VoQPnMxl3w8n1
         +jjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=JaYh26NahsPsqmz5/mIcVsKVgNpCY3mY3g+xU2LFLi8=;
        b=fOnhu6awQ5FsrTIufZ3ApkHXSpH93ZLbwTiZ4tWtnRpsIygqVwcvgJr6VmfZLvNGNU
         0TxLdwPKHszsMvpzK+SKaCPZpg2F+dK1XEcVHwH+MdFNsfe/tk5DNRaW05ZQV1KrMASC
         rmUw28S7w0NsxhwaU172dOmhv0duZ+xnl/l2BK94XseeHrmKMsyVbm+CyCRDlTFtbCjw
         10dgJmfejYYy+OHq8St5cseguCDdCZYQebMseISYIZTEch/n1jK0SGVTIybEjYlnUY/d
         7Gqtrd52uKQVh2NOJjqFstiB5mrvkBZfvoMM1K7NAhYj/rBWVGhJ9++I9VIgGLaTsw/E
         8APQ==
X-Gm-Message-State: AGi0Pub7gyGwy+5AW5e6uwZzVU4zG0i+12kmejjiAB1MRHpI6y3Rh6sm
        ZQIGikT/9nYByzEq/NIPK4xHIA==
X-Google-Smtp-Source: APiQypK/twlGcfF73hUVp8JoAFD7eKNkUajdKLVINxkDU+LuowbMB1KsY5yy3OpG1Ew403dm8Imypg==
X-Received: by 2002:adf:efd1:: with SMTP id i17mr641626wrp.161.1587568119156;
        Wed, 22 Apr 2020 08:08:39 -0700 (PDT)
Received: from ?IPv6:2a01:e35:2ec0:82b0:39cc:a07:8b48:cc56? ([2a01:e35:2ec0:82b0:39cc:a07:8b48:cc56])
        by smtp.gmail.com with ESMTPSA id i17sm8282802wml.23.2020.04.22.08.08.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2020 08:08:38 -0700 (PDT)
Subject: Re: [v2] arm64: dts: meson: odroid-n2: extend cpu opp-points
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Tim Lewis <elatllat@gmail.com>
Cc:     khilman@baylibre.com, joy.cho@hardkernel.com, tobetter@gmail.com,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org
References: <20200418214223.GA4484@imac>
 <52230ECA-EA47-499D-B71C-FFCD374B75C3@gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 BSwxi7g3Mu7u5kUByanqHyA=
Organization: Baylibre
Message-ID: <949a5388-38ef-a170-a59e-3c54f0bab46a@baylibre.com>
Date:   Wed, 22 Apr 2020 17:08:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <52230ECA-EA47-499D-B71C-FFCD374B75C3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Could you add "[PATCH vX]" in the subject ?

On 22/04/2020 16:54, Christian Hewitt wrote:
> 
>> On 19 Apr 2020, at 1:42 am, Tim Lewis <elatllat@gmail.com> wrote:
>>
>> Odroid N2 has a large heatsink and HardKernel supports overclock
>> through the addition to extra opp points in their official kernel
>> sources [1]. Add these to the N2 dts only, as other S922X devices
>> may not have suitable heatsinks.
>>
>> [1] https://github.com/hardkernel/linux/commit/f86cd9487c7483b2a05f448b9ebacf6bd5a2ad2f
>> Signed-off-by: Tim Lewis <elatllat@gmail.com>
> 
> Kodi is not a demanding workload, but the extra opp points are being used:
> 
> N2:~ # cat /sys/devices/system/cpu/cpufreq/policy0/stats/trans_table 
>    From  :    To
>          :    100000    250000    500000    667000   1000000   1200000   1398000   1512000   1608000   1704000   1896000   1992000 
>    100000:         0     20465       294        81        47         0         1         0         0         0         0       183 
>    250000:     20388         0       161        52        59         0         0         0         1         0         1       169 
>    500000:       199       256         0         9        47         1         2         0         0         0         0        57 
>    667000:       177        50        10         0       284         1         1         0         0         0         0       136 
>   1000000:       230        12        15       284         0         1         2         0         0         0         0       285 
>   1200000:         0         0         0         1         0         0         0         0         0         1         0         2 
>   1398000:         1         1         0         2         0         0         0         0         1         1         0         3 
>   1512000:         0         0         0         0         0         0         0         0         0         1         0         2 
>   1608000:         0         0         0         0         0         0         0         1         0         0         0         2 
>   1704000:         0         1         0         0         0         0         1         0         0         0         0         2 
>   1896000:         0         0         1         0         0         0         0         0         0         0         0         1 
>   1992000:        76        47        90       230       392         0         2         2         1         1         1         0 
> 
> N2:~ # cat /sys/devices/system/cpu/cpufreq/policy2/stats/trans_table 
>    From  :    To
>          :    100000    250000    500000    667000   1000000   1200000   1398000   1512000   1608000   1704000   1800000   1908000 
>    100000:         0      1698       130        76        87         0         0         0         1         0         1       199 
>    250000:      1655         0        25        15       357         1         2         0         1         0         0        12 
>    500000:       258        54         0     50102        30         3         1         0         0         0         1        32 
>    667000:       267       151     49708         0        77         3         0         0         0         0         0        11 
>   1000000:         3         5       525        15         0         3         2         0         1         1         0         6 
>   1200000:         0         2         1         2         2         0         3         0         0         0         1         4 
>   1398000:         1         0         1         1         4         0         0         1         1         0         2         2 
>   1512000:         0         0         0         0         0         0         1         0         0         0         0         1 
>   1608000:         1         0         0         1         0         1         0         0         0         0         0         3 
>   1704000:         0         0         0         0         0         1         0         1         0         0         0         1 
>   1800000:         0         0         1         1         0         0         1         0         1         0         0         1 
>   1908000:         8       158        90         4         3         3         3         0         1         2         0         0 
> 
> Board boots in under 4 seconds, Kodi home-screen in about 7 seconds. I haven’t seen the N2 rise over 44ºC.
> 
> I’ve also tested some S922X box devices (moving the change to meson-g12b-s922x.dtsi) and no obvious issues.
> 
> Tested-by: Christian Hewitt <christianshewitt@gmail.com>
> 
>> ---
>> .../boot/dts/amlogic/meson-g12b-odroid-n2.dts | 19 +++++++++++++++++++
>> 1 file changed, 19 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
>> index 42f154057..6f32ac83f 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
>> +++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
>> @@ -260,6 +260,25 @@
>> 			};
>> 		};
>> 	};
>> +
>> +	cpu_opp_table_0: opp-table-0 {
>> +		opp-1992000000 {
>> +			opp-hz = /bits/ 64 <1992000000>;
>> +			opp-microvolt = <1001000>;
>> +		};
>> +	};
>> +
>> +	cpub_opp_table_1: opp-table-1 {
>> +		opp-1800000000 {
>> +			opp-hz = /bits/ 64 <1800000000>;
>> +			opp-microvolt = <981000>;
>> +		};
>> +
>> +		opp-1908000000 {
>> +			opp-hz = /bits/ 64 <1908000000>;
>> +			opp-microvolt = <1022000>;
>> +		};
>> +	};
>> };
>>
>> &arb {
>> -- 
>> 2.17.1
>>
> 
I think it could be moved to all s922x devices since we have dvfs and thermal management enabled by default,
so other devices with inferior cooling will use lower OPPs automatically.

Neil
