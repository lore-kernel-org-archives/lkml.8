Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B980C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 20:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BA082071B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 20:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mpRSn2J6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728434AbgIAUdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 16:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbgIAUdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 16:33:37 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33ADC061244;
        Tue,  1 Sep 2020 13:33:36 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id w11so1548640lfn.2;
        Tue, 01 Sep 2020 13:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uMvjAk+nxWvX0I1JzrW7E+XD7v7r9ADHqj5mbd2nFMw=;
        b=mpRSn2J6rpmefoS47GinejDgOe0o4tFYROf0zGDNdrXymbIMz2e4MZ9O7IYRr2wtpp
         nXajYm5X8UbPqH40Wn9kFH+BjcKDB3Zs8jVZeXOICjm+7kUoczvaXSgjB+0TMNFYXv2P
         /4GoRdV66dtLP4y62+uGKyJ1jGetlF395Td1CZyE14bzf4Ovu6I/H7z4G9lD/ZHNVoA+
         sgARA2jxGYPuXJK+1HaiMqEVbMWb/AInhjkanLUSfik9XYvlX2XupX/Hs8EHR2Em4MzF
         IcrzecD7l62jWxgMBeDMM1wUdWuDO9rKPv0utBSJGfuShqvcl6vdkxB/QhqPIDDdkZMR
         PV+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uMvjAk+nxWvX0I1JzrW7E+XD7v7r9ADHqj5mbd2nFMw=;
        b=HmZXry+R/p7cdTC5NmL343fdPlIuMaJADFxGHTMnmjleV1nDO2JL3WQuDyEb7tXAPK
         mnDd1r5H2/tXDfqYMZ71oB3sJM9RqNWd2qkV4V7a1Cn2ngnG4V+NotaVEm4WNO2S3fag
         NILnsQhy+NHBLvx+beNije4LPxnw38S/k1EFdzXsGAZIfOFGY931uNItlEmTbj94oZlR
         1Y+7qdB++VpJtIRMsT7ZY1hBQI9iW5hvcC9emCcNW03ksCH2oVvFXbheA7xS4Is7Z/iS
         BSeoKyJEP+PzEmbeGqGKI00SbFWjJ+dKIyDs5s5CVIeNG7jG5XEHwkPOXa1/uwEH7/tv
         UwXA==
X-Gm-Message-State: AOAM532Tu7iLY/4vsLRs2e6ELHUOe32DybGvH7tTnSPxtcqGunDxEpuo
        KYFesVbpTygrFiBEeF+rSVCenE6RiQA=
X-Google-Smtp-Source: ABdhPJzYXisUBNsWhl7gcSu7elDpSD8O5RhRgjJz0HR9QFRL6thZ4jx9YAEQIizHmwO4wJ9qYIq1PA==
X-Received: by 2002:ac2:5547:: with SMTP id l7mr1507860lfk.153.1598992415179;
        Tue, 01 Sep 2020 13:33:35 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.googlemail.com with ESMTPSA id t19sm485622ljc.137.2020.09.01.13.33.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2020 13:33:34 -0700 (PDT)
Subject: Re: [PATCH v2 12/12] xhci: tegra: enable ELPG for runtime/system PM
To:     JC Kuo <jckuo@nvidia.com>, gregkh@linuxfoundation.org,
        thierry.reding@gmail.com, robh@kernel.org, jonathanh@nvidia.com,
        kishon@ti.com
Cc:     linux-tegra@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        nkristam@nvidia.com
References: <20200831044043.1561074-1-jckuo@nvidia.com>
 <20200831044043.1561074-13-jckuo@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <68b57be4-a924-6b0a-a853-9cced2eead60@gmail.com>
Date:   Tue, 1 Sep 2020 23:33:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200831044043.1561074-13-jckuo@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

31.08.2020 07:40, JC Kuo пишет:
> +	err = devm_request_threaded_irq(&pdev->dev, tegra->padctl_irq,
> +		NULL,
> +		tegra_xusb_padctl_irq,
> +		IRQF_ONESHOT |

> +		IRQF_TRIGGER_HIGH,

Specifying trigger levels is meaningless for interrupts coming from a
device-tree because DT levels always take precedence.
