Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 150A7C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 19:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9A3820714
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 19:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RGPVxSi9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbgH0Taf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 15:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbgH0Taa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 15:30:30 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203D9C061232
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 12:30:30 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id l191so4074180pgd.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 12:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=jbkAfuhZAKMTavUGq6kzae8BdLlY/pw7F8TdORnXsqQ=;
        b=RGPVxSi9400bcoNYxMs9hsfmQ4rchGqtdHPGG1HmzfnO/mDEdAuT5tnT9cnXgHUnky
         TVm59Zd6m8r3qRLSdXB4SkR6JL22i1ikeXaD9WMwU1P1CzwLXRnhMhX603ZL+Y0cxYSe
         TfSsX5C/0ae+pAAAQobQNbrfGMxlLm8VNVb94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=jbkAfuhZAKMTavUGq6kzae8BdLlY/pw7F8TdORnXsqQ=;
        b=bfCQs8bs7l4AoQ1jBfd2kZHQYtV99sP78nCMpZo0EVucXn+MDcL7ZCB25MrQL6Lpsa
         Cn9MWrd6rm+BcC+CkcXearJsBkQtSlFJFMBplZd1vIAwOIcvkIsDIs1PgCckh9gpzU30
         ufv9mUYK7196YLNUXGS9rVvG09oTGunxpjmoi1Z7fhMQJOKZL5s9VizpoFDLUv0zuMHO
         TXa4R1q3Tdc0Co5I6lZWNWLb4JWl3mZE5uxRS7HLq2U4x0HBIZ/99QrvhdHlTViojdG/
         Sl/yo9REI3VYoMkr8ASkqgCg8zhu8mtiUom4tqPbsyd8H4io5A+FXHo/AnOehJ+5kPKx
         QXWg==
X-Gm-Message-State: AOAM5336xHcYiKPeUwI7RTiZDDLf9CH76Mtw1M9BbfUoqb9aWK0nbROm
        5s4RCoRzKseRpFyT4eRAmTI8s+JHlQ1i3txwKct4XVuIiB975wTZ7Y79PjSpWzEoJNNzs4ZftUJ
        1HYpqZcOmJatI/ZYDxbhQK9iadiSdLNfMH7kkg6eQOTgs6dRkkRG8ffsDXqHe7YH2DltFmCgekp
        O1Vj9tqvqXRgw=
X-Google-Smtp-Source: ABdhPJwCOi62uMlXfcPonmuVECt3/Iv2jH+EgupKyrvs9JK9fe/kDGN2+VGdJJMTP/OzZaxkjeSwnA==
X-Received: by 2002:a05:6a00:228f:: with SMTP id f15mr18055805pfe.222.1598556628896;
        Thu, 27 Aug 2020 12:30:28 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id f13sm3633868pfd.215.2020.08.27.12.30.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2020 12:30:28 -0700 (PDT)
Subject: Re: [PATCH 0/5] qspi binding and DTS fixes
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Kamal Dasu <kdasu.kdev@gmail.com>,
        "maintainer:BROADCOM SPI DRIVER" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Yendapally Reddy Dhananjaya Reddy 
        <yendapally.reddy@broadcom.com>,
        "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200827181842.1000451-1-f.fainelli@gmail.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <5afe8762-c0a3-ff10-5946-0eb2e7ddc0e5@broadcom.com>
Date:   Thu, 27 Aug 2020 12:30:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200827181842.1000451-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-CA
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch series looks good.

Acked-by: Scott Branden <scott.branden@broadcom.com>

On 2020-08-27 11:18 a.m., Florian Fainelli wrote:
> Hi all,
>
> This patch series fixes incorrectly defined compatible strings for the
> Broadcom QSPI controller which resulted in the strings not being
> ordered from most to least compatible.
>
> We will need to apply some changes to the spi-bcm-qspi.c driver in
> the future to assume no revision register exist, and these patches
> are a preliminary step towards that goal.
>
> Florian Fainelli (5):
>   dt-bindings: spi: Fix spi-bcm-qspi compatible ordering
>   ARM: dts: bcm: HR2: Fixed QSPI compatible string
>   ARM: dts: NSP: Fixed QSPI compatible string
>   ARM: dts: BCM5301X: Fixed QSPI compatible string
>   arm64: dts: ns2: Fixed QSPI compatible string
>
>  .../bindings/spi/brcm,spi-bcm-qspi.txt           | 16 ++++++++--------
>  arch/arm/boot/dts/bcm-hr2.dtsi                   |  2 +-
>  arch/arm/boot/dts/bcm-nsp.dtsi                   |  2 +-
>  arch/arm/boot/dts/bcm5301x.dtsi                  |  2 +-
>  arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi |  2 +-
>  5 files changed, 12 insertions(+), 12 deletions(-)
>

