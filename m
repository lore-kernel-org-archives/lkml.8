Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF194C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 02:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73AB421941
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 02:39:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pMxYK2/P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730650AbgIJCjV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 22:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730870AbgIJCgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 22:36:18 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90ADC061573
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 19:36:17 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id j7so175622plk.11
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 19:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Qi/C9aaUBtjbfZdmUnacP7NMqMiArkbulm9um4Od9hw=;
        b=pMxYK2/Pkb0EZMXzFIXZUb6i3ZFLn1ko9Syhefb9p3U0eQsJxrLTbXusA8P70M5CT1
         8OaC7qRD2zdgicdwfeVKJlgVkWTlRsAH0SdhHr0hIR5zwzLmPGuCpl2IuZNHv0Pc9xj3
         BOC0fSJHik5f1LzVopnGUaF/QLaXqno0bZRRXC3gwpKHEwAlEzehzkS7voGPGxTqqnnh
         tifUkmYJgkLubTgcQbn/Acy9Xq71HDbvKid54UCDspt6u7L/Qf/Nw7NMvAo+5PC+FfPt
         GXQnCvAde4Mvz2b9/OjnzIgnhwKg2SktKcz40RdDNw+TI9PSCQXMazxo8P4GYADd2tk+
         aWvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Qi/C9aaUBtjbfZdmUnacP7NMqMiArkbulm9um4Od9hw=;
        b=EJ4BrRWyFJFD3E+GjAZqOZY91p5PKiqMQxnOa6HVpwdmhAwrLG8ZSzpuZSezm1gQFf
         oyvHzUKDAJguFtl2xs2FoQgVX5rgEIQq36u6i/t3crW5mm0bEljfL0CNXr1Apf9nuQ0g
         cGqGm9WL94UXien+kW7pewGkLFd9GotVrkegzoovK2yRYDQ7src1u/qjoyyBwhVb2y3J
         QM+aERDR0tVj6j/mHBYDyLSMiqnPdKdq6BkhhCzCGg9/DeRjoGt1gTX4UCMiioew6cWg
         gyysjXqQI/U77qwABpSKEcHe5pdl83CEG7XGctEfWH8la4Ph7DfkEBQJdAmR0dtCs+HO
         1tjw==
X-Gm-Message-State: AOAM533nFpO3prRPgfkXXjudRSRvkRk4kwPUnizRRPdN93Ut53q2trUk
        O2VFlJMICIxJfxDt1UhfWOo=
X-Google-Smtp-Source: ABdhPJyB/gDClpFCWVlduVuK4BaWMjZ2z2J8E2w9T/1NXHxm4i56LLkl2BnupOFpqNKNYfWvC7cqsQ==
X-Received: by 2002:a17:902:7d92:: with SMTP id a18mr3549422plm.68.1599705377388;
        Wed, 09 Sep 2020 19:36:17 -0700 (PDT)
Received: from [10.230.30.107] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id x9sm3975288pfj.96.2020.09.09.19.36.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2020 19:36:16 -0700 (PDT)
Subject: Re: [GIT PULL 1/1] bcm2835-dt-next-2020-09-08
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20200908185427.4196-1-nsaenzjulienne@suse.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <6ce1010d-b3e5-d795-5702-41590eb1bb67@gmail.com>
Date:   Wed, 9 Sep 2020 19:36:15 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <20200908185427.4196-1-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/8/2020 11:54 AM, Nicolas Saenz Julienne wrote:
> Hi Florian,
> 
> The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:
> 
>    Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)
> 
> are available in the Git repository at:
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/nsaenz/linux-rpi.git tags/bcm2835-dt-next-2020-09-08
> 
> for you to fetch changes up to 4564363351e2680e55edc23c7953aebd2acb4ab7:
> 
>    ARM: dts: bcm2711: Enable the display pipeline (2020-09-08 18:28:23 +0200)
> 
> ----------------------------------------------------------------
> Maxime Ripard enables vc4 on BCM2711 (RPi4), which among other things
> adds HDMI functionality (no 4K yet).
> 
> ----------------------------------------------------------------

Merged into devicetree/next, thanks Nicolas.
-- 
Florian
