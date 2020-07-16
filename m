Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81EDBC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 21:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 538A3207E8
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 21:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ELHdIoQM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbgGPVSp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 17:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgGPVSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 17:18:44 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870CCC061755;
        Thu, 16 Jul 2020 14:18:43 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id y13so4721879lfe.9;
        Thu, 16 Jul 2020 14:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JDpOgz79PdKTfBbtrL+hBKF1KYAVH8lCeYLO08tI5yc=;
        b=ELHdIoQMAPkeVrUAma/FmBDBziYW8FCBzSTUftbmOumlxAqqqpfTxBfy1nCuxNf0zs
         SIz9p1IUHWo3Ex4HnQl8J6BLHdteqSRCujTahBIA3CSy4qf5/pei4+Orq3nf1kD6EBiC
         Opi9qq4bl3ccQtsJngqLx7lRm76jQBpDh6x569sNhv+5jmjWdSi4B0phKJsrlTE58RLG
         CyCeXbCrIXsq4BlV0YzPJnzHW6bzXSidcsY9IIh2Li9jmuvl7L+wp1cR4CJSD8HV6NQx
         VPH1Djx8M+GDjDocVepfEcvbfjpMTKLNK9o7Z3rjpwVQPHStkd2yBHcHmdzBJ7lbvl75
         yCnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JDpOgz79PdKTfBbtrL+hBKF1KYAVH8lCeYLO08tI5yc=;
        b=j8ZNFmayFvJUsYdr7REaN5n3uWXoTo9zuCIQexbd3+62SvlATQc+WYhf0xHHmGW/Kr
         61En/tyqXar6UQ3w7agg/3XhW8YFV6Q4Av+jZ5UUmZTy0JEldPAcHY8nCdjU902kufmI
         knKGKzf3jJGKMe4JdFeWNCvzKxCUyMf+X/6KQRDNHqultUQkKZ/vtcxqtGqoeCc00spM
         zh9o9I8myUjMetI8KBFnS+PFfnt1MPVSGhhdnz6/oHC+djJWVr0VyOV6+KkgIw9BBqx6
         A+Xuyw+c3+VTKHV1+yBU8cjvLwwIeFCyQntrUla5EkR7PoSYKQwzANRv9KKOzDVz7ArC
         kTWg==
X-Gm-Message-State: AOAM531l/7T7ayE5e2NUR5LV/d7lGlnY5xgFMWR5EHd4joMruT4I3I/D
        nU/R94Hf8Ayu6/ef6kT/XFtYOi03
X-Google-Smtp-Source: ABdhPJyqIj6PIaMy9iN3qXK858pk6SghrG52+yiW6wTXuWiIKaavSwQtkH3d3WUrago++/UMsQjVPg==
X-Received: by 2002:ac2:5c49:: with SMTP id s9mr3124661lfp.90.1594934321683;
        Thu, 16 Jul 2020 14:18:41 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-76-4-184.pppoe.mtu-net.ru. [91.76.4.184])
        by smtp.googlemail.com with ESMTPSA id a20sm1415679lfl.20.2020.07.16.14.18.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2020 14:18:41 -0700 (PDT)
Subject: Re: [RFC PATCH v3 16/18] gpu: host1x: mipi: Split
 tegra_mipi_calibrate and tegra_mipi_wait
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com, frankc@nvidia.com,
        hverkuil@xs4all.nl, sakari.ailus@iki.fi, robh+dt@kernel.org,
        helen.koike@collabora.com
Cc:     sboyd@kernel.org, gregkh@linuxfoundation.org,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org
References: <1594786855-26506-1-git-send-email-skomatineni@nvidia.com>
 <1594786855-26506-17-git-send-email-skomatineni@nvidia.com>
 <a06dec8f-7042-767b-545b-048685a7683d@gmail.com>
 <20d63eca-4b2b-584e-a391-a4fb64a16b40@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <c4945c77-5de1-e9b1-9f4f-cdd78bca18c7@gmail.com>
Date:   Fri, 17 Jul 2020 00:18:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20d63eca-4b2b-584e-a391-a4fb64a16b40@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

17.07.2020 00:09, Sowjanya Komatineni пишет:
> 
> On 7/16/20 1:38 PM, Dmitry Osipenko wrote:
>> 15.07.2020 07:20, Sowjanya Komatineni пишет:
>>> SW can trigger MIPI pads calibration any time after power on
>>> but calibration results will be latched and applied to the pads
>>> by MIPI CAL unit only when the link is in LP-11 state and then
>>> status register will be updated.
>>>
>>> For CSI, trigger of pads calibration happen during CSI stream
>>> enable where CSI receiver is kept ready prior to sensor or CSI
>>> transmitter stream start.
>>>
>>> So, pads may not be in LP-11 at this time and waiting for the
>>> calibration to be done immediate after calibration start will
>>> result in timeout.
>>>
>>> This patch splits tegra_mipi_calibrate() and tegra_mipi_wait()
>>> so triggering for calibration and waiting for it to complete can
>>> happen at different stages.
>>>
>>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>>> ---
>> ...
>>>   int tegra_mipi_calibrate(struct tegra_mipi_device *device)
>>>   {
>>> @@ -370,12 +381,10 @@ int tegra_mipi_calibrate(struct
>>> tegra_mipi_device *device)
>>>       value |= MIPI_CAL_CTRL_START;
>>>       tegra_mipi_writel(device->mipi, value, MIPI_CAL_CTRL);
>>>   -    err = tegra_mipi_wait(device->mipi);
>> Doesn't MIPI clock need to be enabled during of the calibration process?
> MIPI clock is already enabled in tegra_mipi_calibrate
>>
>>>       mutex_unlock(&device->mipi->lock);
>>>       clk_disable(device->mipi->clk);

What keeps MIPI clock enabled after completion of the
tegra_mipi_calibrate() invocation?

>>>   -    return err;
>>> +    return 0;
>>>   }
>>>   EXPORT_SYMBOL(tegra_mipi_calibrate);

