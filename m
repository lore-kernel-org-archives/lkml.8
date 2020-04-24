Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3081C54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 13:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEF0420700
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 13:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cumulusnetworks.com header.i=@cumulusnetworks.com header.b="PFmeDn82"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbgDXNtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 09:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726813AbgDXNtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 09:49:16 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA31C09B045
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 06:49:16 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id m2so7732978lfo.6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 06:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=sDwVLjRBMPWU6wEqJr0n/7TaaBKOSB8AM8QuUjXpRFg=;
        b=PFmeDn82LqDvfQ32uAq3qNbtzdFMdsCBiPHffUqPmJU35TDpn6p3vUhwu4z9ydA+1w
         bOCnHg07doepYRJy1qQfHA8PfJfz32xzpmPG8epQ8gKLESNSrZIpLVh1OGxeZrRzmyUs
         Akipi/z1KazdqSXjtV6JSC9rJJfEXqhyGF7Tw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sDwVLjRBMPWU6wEqJr0n/7TaaBKOSB8AM8QuUjXpRFg=;
        b=QdNm21nE4RPm5sFwkL+dr9skSsgjOPnf8D3vAGISvjzJfx6yoJSxgYCw8Zmbt+rv99
         zPAewbR8D+Vx4oYD3+5yCCW2KyMpE+AyXoFMkyGYH02AnKGm3zLrx5cTNuZPpSVBIBy+
         4X3R5yjRvRBF9sxKO93LXAUdFcf7SwwwpNwFiLIQ8+tNSRm5M0dHGrABAPZUYidBujS3
         9wTEJs3soFHIKpl7Qn+++M91HN4rRLwlIV5kqBTAR4Q6kbcJH2kXulUZuweN/K+y8XE3
         vUqqHAg4fZbbPpNdG5xmwgEzdYtlS5DZ2GxNUNo9uiHpU4yiQ3XiCDCTK2GgSgzyT2Aw
         hTZQ==
X-Gm-Message-State: AGi0PuYlUbwP5D40vaZvcrvHZuWmItgBaXJUfung2bH1g+R5v3Fmmj34
        UBpaSLs0MMJEcDWGi9AjnS6zGQ==
X-Google-Smtp-Source: APiQypK0WfE0K8h4OMIWzRhDwx1eUUgoHfJYt5KeqpvgHE+uplakMIQw54Kb+bQu6g5+TtSK95qO8w==
X-Received: by 2002:ac2:5dcf:: with SMTP id x15mr6231405lfq.3.1587736154353;
        Fri, 24 Apr 2020 06:49:14 -0700 (PDT)
Received: from [192.168.0.109] (84-238-136-197.ip.btc-net.bg. [84.238.136.197])
        by smtp.gmail.com with ESMTPSA id b2sm4504085lfi.14.2020.04.24.06.49.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2020 06:49:13 -0700 (PDT)
Subject: Re: [PATCH net-next v3 10/11] bridge: mrp: Integrate MRP into the
 bridge
To:     Horatiu Vultur <horatiu.vultur@microchip.com>, davem@davemloft.net,
        jiri@resnulli.us, ivecera@redhat.com, kuba@kernel.org,
        roopa@cumulusnetworks.com, olteanv@gmail.com, andrew@lunn.ch,
        UNGLinuxDriver@microchip.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bridge@lists.linux-foundation.org
References: <20200422161833.1123-1-horatiu.vultur@microchip.com>
 <20200422161833.1123-11-horatiu.vultur@microchip.com>
From:   Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <4c2200b5-5173-eac3-1cf5-14538a0b5d71@cumulusnetworks.com>
Date:   Fri, 24 Apr 2020 16:49:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200422161833.1123-11-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/2020 19:18, Horatiu Vultur wrote:
> To integrate MRP into the bridge, the bridge needs to do the following:
> - detect if the MRP frame was received on MRP ring port in that case it would be
>   processed otherwise just forward it as usual.
> - enable parsing of MRP
> - before whenever the bridge was set up, it would set all the ports in
>   forwarding state. Add an extra check to not set ports in forwarding state if
>   the port is an MRP ring port. The reason of this change is that if the MRP
>   instance initially sets the port in blocked state by setting the bridge up it
>   would overwrite this setting.
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>  net/bridge/br_device.c  |  3 +++
>  net/bridge/br_if.c      |  2 ++
>  net/bridge/br_input.c   |  3 +++
>  net/bridge/br_netlink.c |  5 +++++
>  net/bridge/br_private.h | 31 +++++++++++++++++++++++++++++++
>  5 files changed, 44 insertions(+)
> 

Reviewed-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>


