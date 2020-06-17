Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA18C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 21:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65A822088E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 21:39:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aF/8h7u7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbgFQVjV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 17:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726835AbgFQVjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 17:39:20 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422DDC06174E;
        Wed, 17 Jun 2020 14:39:20 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id k2so1593025pjs.2;
        Wed, 17 Jun 2020 14:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=YpnqnZExMs/Z6HNOkWMebiRuhctIId69Ekks444x5Ec=;
        b=aF/8h7u7Celm2ERr+dAkejqjfgIWrYnCJYIFziOQ4Cr8pg3z9las6lyRy8hFjY4JvV
         JZ5sOQGWcB8hUk4eNPOlv+27S8Qu+8rT/tRV2twMIxZBAq8ezoBTtZGvcgVPfXw2Q8pH
         uzIFDvqlhdwh3AyDd4kcEtTHyBo2OvBse16aogRl2GojTKAoFspvfy6SAgmZdeXwo7Iy
         FNp2ESsA4bioVq62WafTueo1vSqB23ybviV8Q1H/wcEqzOj8Vv0cSgAGFGetaihPc3hS
         75d6kxz6RP159JP/lOqBF32FIu8xBec8SFOE010Y+A+WCHKqtdMvZo61b8T6BLb01vyy
         ivWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YpnqnZExMs/Z6HNOkWMebiRuhctIId69Ekks444x5Ec=;
        b=YSav9R6pkfVjgq0STek27VR+hiKX9IZ/RBYFShou/5Z272KOox3KKzwpfMjMWG2WG1
         hlw4s70eLCamtjvl9qHDLVNoYsOpHRHCmj+Zowq1rA/mYTEUT4dg4tFMaF9YbYzGA1sk
         JfnNEGDkJuTFVDnpkbcmXyHEPt7FiQxCf/4dbUFVrmv9YUB86pmyWv3k/nThAkiZ4k3P
         8KRGKXl7nXos3EK2PrjrOY4rwVefh/15YRWMDVd6TfxZH0SseBccO5fzJnxRvD5tZq74
         TOtC+OxqKVQ+JUhd+FwoKb7E7+DQMVCOYx10FBdYsLbh521s+3RmHVCJlvNdx5cse/q9
         h6pQ==
X-Gm-Message-State: AOAM533pWHxdeOYavZSTF+xRdGH7cU7H3GSnjGddooj/613xUv1q/4Y/
        4jOpQ0FPEcdQUu4//dDI/x1naRU/
X-Google-Smtp-Source: ABdhPJzZPwfKezxO/XZUXIZYPSi00Xz40VGOHk2PaRDuvE/FzYdjsl3RdOdmWUdzcNV09TtZRDZSog==
X-Received: by 2002:a17:90a:f414:: with SMTP id ch20mr947017pjb.97.1592429959478;
        Wed, 17 Jun 2020 14:39:19 -0700 (PDT)
Received: from [10.230.188.43] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id i7sm663789pgr.86.2020.06.17.14.39.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2020 14:39:18 -0700 (PDT)
Subject: Re: [PATCH 2/8] mips: bmips: add BCM6318 clock definitions
To:     =?UTF-8?Q?=c3=81lvaro_Fern=c3=a1ndez_Rojas?= <noltari@gmail.com>,
        mturquette@baylibre.com, sboyd@kernel.org, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, robh+dt@kernel.org,
        julia.lawall@lip6.fr, jonas.gorski@gmail.com, lkp@intel.com,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
References: <20200615090231.2932696-1-noltari@gmail.com>
 <20200615090231.2932696-3-noltari@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <6e2372d4-7404-c8a0-b92c-414166e89f78@gmail.com>
Date:   Wed, 17 Jun 2020 14:39:17 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200615090231.2932696-3-noltari@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/15/2020 2:02 AM, Álvaro Fernández Rojas wrote:
> Add header with BCM6318 definitions in order to be able to include it from
> device tree files.
> 
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
