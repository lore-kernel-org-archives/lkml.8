Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CAC8C3F2D7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 19:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7329D21775
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 19:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q8e4s6WJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbgCDT05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 14:26:57 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43381 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgCDT05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 14:26:57 -0500
Received: by mail-lj1-f196.google.com with SMTP id e3so3314824lja.10;
        Wed, 04 Mar 2020 11:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=h9+gXDr2n+K6UTBw+RLqNH196xTwcF81lFAULEwi8EQ=;
        b=Q8e4s6WJu3XtnXYfQeM77+BGKy+WFz/181sCDmwYsOwoOqes9SXtdpGt8RqV2r6O4+
         4kI52Fnw3EnW9B5kAAj3RJ8rKxHdW1ufv30xtFzf4EJwuIyD8cWInDlSfc/84cvMLFl6
         WU7g39Hv5Kqj2xY8daAReOpV1CUJHATElj2VQCkw1b3zs0rbQeeerOQf7QeSYNpI9Sjr
         Xq2ice4LL1Q7sdh8Yr3Rt+8f1LtRmNWBa4iMlqM1l/tG0MoD7VsUGCAKdP4AEPWKgHih
         loVDysaIFBFoa7XDIC5OG54wPRzEUbCwxPCyLKzWMHVTqHXZARYBSGhcmY9cuKaKC2av
         a5pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=h9+gXDr2n+K6UTBw+RLqNH196xTwcF81lFAULEwi8EQ=;
        b=f3tgYN5SNJFmK1FP/ovA9xJ9obv+n8Q/ENzkX6sH+QnuB9CFhgls4ob1ZtuO+R/xvZ
         C0KhaxFvQKX5L1blZY3GfgARGjVhnDweFzL0jE3SmbSROZ0AHyMcKtws2GgeyGNxXjLn
         0trDGCAK1DCVrXlrPA8hjjxjumLQ2wi4HNjOxwlPzmC1wHkFhWtJHLyjoQ+O3RZn0zZ8
         MaXPq2sPzEZPBHyaCmZMqJLMjk/0iWS56pt8CSc8Qzc1bfq8oFYmDzitoyO/7yt8jo8D
         +ea1ky2X/huizmvpZ+aVbvDvZs9x/NJPKu/8Gvil23WPH9K5ZGziZIzFzL/KQEIzzype
         Sqsw==
X-Gm-Message-State: ANhLgQ3YkhgYitse//DNivRNCvIok/tDr7I3FXPm/7HMweimNuGboAjP
        IG4PbH33x1BbEsOReUfVmuqrofF3
X-Google-Smtp-Source: ADFU+vtMCiiz/effcIYjUGXEguNi4afmSupjt4869RyrttMpxSVz8amVJRj9+OE3AYZgwUTk81oMzw==
X-Received: by 2002:a2e:b8d3:: with SMTP id s19mr2882158ljp.222.1583350014666;
        Wed, 04 Mar 2020 11:26:54 -0800 (PST)
Received: from [192.168.2.145] (94-29-39-224.dynamic.spd-mgts.ru. [94.29.39.224])
        by smtp.googlemail.com with ESMTPSA id t7sm14401789ljo.7.2020.03.04.11.26.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2020 11:26:54 -0800 (PST)
Subject: Re: [PATCH v8 00/22] Move PMC clocks into Tegra PMC driver
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
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <96ed39c9-32d3-98a1-e9d8-ffe63307a556@gmail.com>
Date:   Wed, 4 Mar 2020 22:26:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200217095940.GE1345979@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

17.02.2020 12:59, Thierry Reding пишет:
...
> I've applied patches 1-10 and 13-16 to the Tegra tree, but I think it
> should be fine for Mark to pick up the ASoC patches into his tree,
> right?
> 
> As I mentioned in my reply to patch 20, I think we need to hold off on
> applying patches 20-22 until all the rest have been merged, otherwise
> we'll regress.

Hello Thierry and Sowjanya,

I was trying today's next-20200304 and found that WiFi / Bluetooth got
broken:

[   23.130017] ieee80211 phy0: brcmf_proto_bcdc_query_dcmd:
brcmf_proto_bcdc_msg failed w/status -110
[   23.130167] ieee80211 phy0: brcmf_cfg80211_get_channel: chanspec
failed (-110)
[   25.690008] ieee80211 phy0: brcmf_proto_bcdc_query_dcmd:
brcmf_proto_bcdc_msg failed w/status -110
[   30.811972] ieee80211 phy0: brcmf_dongle_scantime: Scan assoc time
error (-110)
[   33.370184] ieee80211 phy0: brcmf_netdev_open: failed to bring up
cfg80211
[   35.929994] ieee80211 phy0: brcmf_proto_bcdc_query_dcmd:
brcmf_proto_bcdc_msg failed w/status -110
[   35.930181] ieee80211 phy0: brcmf_cfg80211_get_channel: chanspec
failed (-110)

The fix is to replace TEGRA30_CLK_BLINK with TEGRA_PMC_CLK_BLINK in a
device-tree.

I'm not sure that the TEGRA30_CLK_BLINK breakage is expected to happen
because all clk/tegra/ PMC code is still in place. Please take a look,
thanks in advance.
