Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD655C3F2D7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 21:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9355D20828
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 21:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rdRc9kTs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388370AbgCDVW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 16:22:57 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41436 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388337AbgCDVW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 16:22:57 -0500
Received: by mail-lf1-f67.google.com with SMTP id y17so2728530lfe.8;
        Wed, 04 Mar 2020 13:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=91pQ9hJXrzxABBV4Ff80CFHiJGifmgVQhImUB6I8nyM=;
        b=rdRc9kTsvR9Z6XTv805rReh6SfrEuiMQ5Q0Vml8v5wr3lfGCoA8ECi3XmoOTIInmqE
         4mH6l9rHXMY4erzVsHEMboGq45Rf/FiDGHWHd4aiQZFPM7Y/57g4eGqu7DPPQ/uRF856
         hx8bJ9TLGNO+RgFJjYr+Y3jIuLcsIZk3ns3jvojcJeRRMHGFjDoNtPnVahytbJ9ssdjM
         s2GkpbBm7kuYZLV1YCjs61DrFCdcITfJknuWlzWKnb2KMEQGJpJGdfHWvWjbMHSKl2J4
         E+HDUaupHTWw5tI4KpsM2om0OSGUdWalGZ6LETJ1bGukAK5XuGUUZUusZN3hly4RqsPT
         d9aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=91pQ9hJXrzxABBV4Ff80CFHiJGifmgVQhImUB6I8nyM=;
        b=GvaETFyq8cCEajpzluy+9he6qSZToALCs+Vqd5UPymcMh7O6wjMF30MSxt8LWJIqG7
         XawwbNHzK2shfEQXL+oY87V5c/nrc1xyjiBlKtfnD7j02BmjNM0BaIHfimkNAJQ754ID
         e5/aWJF9pP2JYp9TbfzpBr6F2mbySoap11WHqczRtE5fsBD8LP+H4tTcdtmJ9HC9sq20
         Q05aDGu2xjx1tQYrVvclNCLoYKTz3KJivW7yRTujXL6Jye5jOVgIuCmN1CtN7hYJyUiU
         5C9lRdwtYn61KnrQGNXXPU8Vo56QHL/NXYq6l+4VZjWJOhZZA/1dNzSvzlwE1/tWXaKX
         HE6A==
X-Gm-Message-State: ANhLgQ0i1YvyJvWzhmZtWGz9MBlT5uhK3gcM3ngk1nj3cdq3SZbTAK/A
        MlmSV+7S1fF/Nu6wVkADzGw+0dQO
X-Google-Smtp-Source: ADFU+vv5+JOfNQoShXbxXJvnWKVTQeFFdQJeRcd+SMgQYxKizXbBREoopsfDidBF8W6Kj0helBCH6A==
X-Received: by 2002:ac2:5609:: with SMTP id v9mr3187088lfd.17.1583356974237;
        Wed, 04 Mar 2020 13:22:54 -0800 (PST)
Received: from [192.168.2.145] (94-29-39-224.dynamic.spd-mgts.ru. [94.29.39.224])
        by smtp.googlemail.com with ESMTPSA id g18sm13037795ljn.32.2020.03.04.13.22.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2020 13:22:53 -0800 (PST)
Subject: Re: [PATCH v8 00/22] Move PMC clocks into Tegra PMC driver
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     jonathanh@nvidia.com, broonie@kernel.org, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, mperttunen@nvidia.com,
        gregkh@linuxfoundation.org, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, pdeschrijver@nvidia.com, pgaikwad@nvidia.com,
        spujar@nvidia.com, josephl@nvidia.com, daniel.lezcano@linaro.org,
        mmaddireddy@nvidia.com, markz@nvidia.com,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1578986667-16041-1-git-send-email-skomatineni@nvidia.com>
 <20200217095940.GE1345979@ulmo>
 <96ed39c9-32d3-98a1-e9d8-ffe63307a556@gmail.com>
Message-ID: <7722b7b8-82df-c450-a94c-704d15819af0@gmail.com>
Date:   Thu, 5 Mar 2020 00:22:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <96ed39c9-32d3-98a1-e9d8-ffe63307a556@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

04.03.2020 22:26, Dmitry Osipenko пишет:
> 17.02.2020 12:59, Thierry Reding пишет:
> ...
>> I've applied patches 1-10 and 13-16 to the Tegra tree, but I think it
>> should be fine for Mark to pick up the ASoC patches into his tree,
>> right?
>>
>> As I mentioned in my reply to patch 20, I think we need to hold off on
>> applying patches 20-22 until all the rest have been merged, otherwise
>> we'll regress.
> 
> Hello Thierry and Sowjanya,
> 
> I was trying today's next-20200304 and found that WiFi / Bluetooth got
> broken:
> 
> [   23.130017] ieee80211 phy0: brcmf_proto_bcdc_query_dcmd:
> brcmf_proto_bcdc_msg failed w/status -110
> [   23.130167] ieee80211 phy0: brcmf_cfg80211_get_channel: chanspec
> failed (-110)
> [   25.690008] ieee80211 phy0: brcmf_proto_bcdc_query_dcmd:
> brcmf_proto_bcdc_msg failed w/status -110
> [   30.811972] ieee80211 phy0: brcmf_dongle_scantime: Scan assoc time
> error (-110)
> [   33.370184] ieee80211 phy0: brcmf_netdev_open: failed to bring up
> cfg80211
> [   35.929994] ieee80211 phy0: brcmf_proto_bcdc_query_dcmd:
> brcmf_proto_bcdc_msg failed w/status -110
> [   35.930181] ieee80211 phy0: brcmf_cfg80211_get_channel: chanspec
> failed (-110)
> 
> The fix is to replace TEGRA30_CLK_BLINK with TEGRA_PMC_CLK_BLINK in a
> device-tree.
> 
> I'm not sure that the TEGRA30_CLK_BLINK breakage is expected to happen
> because all clk/tegra/ PMC code is still in place. Please take a look,
> thanks in advance.

This happens because the unused "pmc_blink" is getting auto-disabled by
the CCF. Which means that it's wrong to apply this series partially.

@Thierry, please re-apply it all properly. All patches, excluding patch
#11, should be applied. Thanks in advance.
