Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B51C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 15:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 877AA2075B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 15:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="CTzbyprJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbgH1PIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 11:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbgH1PI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 11:08:26 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2760C061232
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 08:08:23 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id c18so1601464wrm.9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 08:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google;
        h=reply-to:subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ona2SramZlOzoBjP/aJ5NnGGdz2GwYgLuTlQT94U0hE=;
        b=CTzbyprJ6gg7Ng1f7JKIYOiw19rZ8MsC9LXJxlx1AUjvXqxdfbD7dUGt3IY+jvLe6/
         w7naHbgmd77NXUXb4Vfa+purkaMUDniQwUQXNIKfDhV81NR3364+sIm5RLgTZzLgWlwI
         ojDrAV+OcPffbUyPYUIK1Zxt3Ty08sUiirCXxPAWVdz6svj2Q5BkWrvd0qjcCbQ4MJvD
         k7b03bFx/7Ovmf+ESu1OU1HPF9nSDa6Uhlvw27gxmlGiFvyL1xZnSqDwcmzk9jAhbv0Q
         DI62eXPsDO1pV6eBdjcGLp23bZNQJbPK90UdQ/w7qiE5gWZ/0mxLikOR4vzljPUUaTy6
         kMDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ona2SramZlOzoBjP/aJ5NnGGdz2GwYgLuTlQT94U0hE=;
        b=W/ewwq8u+p2hAi4gAApJQDoB/V3bRIcf4wQcRebzFCeBzAc3y/f9p2kjzDPHcWYIW3
         3xUgr1k5NSvr/CuSQ/RnuFOhe0wvsDaSYEwJyyU2SJL0lEt1aEtTW1QyvDk91QI7nN1T
         J6YIBnHVYWxlYuO4nTQdqo40wzS/ACUyNY77BCAbz3TKOBKgCDfqgEyN7Kao84oFXvqW
         GL07DGPiPOGd2EHt0eaT3P+qIp4cs88iEubILk/cFN2Xzp9/OlNg0pDK5mvs73rHHNMK
         bOBEJFgYwmNsypbT061bgvSKE4e5XIFptdshowD9yB4VIu2fc5xxcOSInb96Jtp3OV2+
         XOuQ==
X-Gm-Message-State: AOAM530IY9TsT+qCEmNCRwJo0frcyIUq3AQClgh/xm8Qmts+rgpgr1yh
        ok59dJPlMQU1PtRlffV/kTgd0XuHjbCbuBe0
X-Google-Smtp-Source: ABdhPJyqK2T9Ry68896tVj6D58pAxeSIYSJcpFTiLME6ybN+vbrbFEM19hvPratI33Gdch0THPDEzw==
X-Received: by 2002:a5d:5352:: with SMTP id t18mr1851532wrv.407.1598627302028;
        Fri, 28 Aug 2020 08:08:22 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:410:bb00:584b:67d:d1b3:7399? ([2a01:e0a:410:bb00:584b:67d:d1b3:7399])
        by smtp.gmail.com with ESMTPSA id 5sm2731995wmz.22.2020.08.28.08.08.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Aug 2020 08:08:21 -0700 (PDT)
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH] Remove ipvs v6 dependency on iptables
To:     Lach <iam@lach.pw>, ja@ssi.bg
Cc:     "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Wensong Zhang <wensong@linux-vs.org>,
        Simon Horman <horms@verge.net.au>,
        Jakub Kicinski <kuba@kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org,
        lvs-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org
References: <alpine.LFD.2.23.451.2008272357240.4567@ja.home.ssi.bg>
 <20200827220715.6508-1-iam@lach.pw>
From:   Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
Message-ID: <e4765a73-e6a1-f5ba-dd8b-7c1ee1e5883d@6wind.com>
Date:   Fri, 28 Aug 2020 17:08:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200827220715.6508-1-iam@lach.pw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 28/08/2020 à 00:07, Lach a écrit :
> This dependency was added in 63dca2c0b0e7a92cb39d1b1ecefa32ffda201975, because this commit had dependency on
> ipv6_find_hdr, which was located in iptables-specific code
> 
> But it is no longer required, because f8f626754ebeca613cf1af2e6f890cfde0e74d5b moved them to a more common location
> ---
Your 'Signed-off-by' is missing, the commit log lines are too long, a commit
should not be referenced like this.
Please run checkpatch on your submissions.


Regards,
Nicolas
