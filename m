Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B6AC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 10:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D22CF20707
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 10:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tessares-net.20150623.gappssmtp.com header.i=@tessares-net.20150623.gappssmtp.com header.b="wE48gfOL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729436AbgFOK33 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 06:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729505AbgFOK3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 06:29:12 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09E9C05BD43
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 03:29:09 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id y6so5836370edi.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 03:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EDBJtBRObvqYYs/f61xomalWJ9+yhMx1xMFegJ9eNjM=;
        b=wE48gfOLCwqOAshvmqBH/8/8y0WCvNVReqYp623yAgynOYmEdTIz6kaBELo/5EeQ1n
         vIXG6609T/L62QkUzzEwqgojwXVYJLiOhbE3rDMzZA4d21xVYnuajt1RPQUe4FYFq/F6
         3A4Mg79a9KRcPELhZBLvc7QhKMPUn+PU7gA8K/r0cm4R/uOOIMfVmrmpyJDCgpVyGdYz
         1f1jM2fyPkgwc877L4JC13sjAVyjJw+kpN0O6xlehgmFTABZutnWLM0TNfLlkK/P96US
         Vn4rGnjLlk8v0AHGserqeSsvSiPAT7GELCpo7LgRcnSNNrt5L7XmsFXNUxcj4iZndy+m
         UR+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EDBJtBRObvqYYs/f61xomalWJ9+yhMx1xMFegJ9eNjM=;
        b=I/3LENhkgGjuy1Yf+0dVyB1GdnF5gKoGKN576l29+PPUH+oO30IJzy1HBd/hIApxjB
         G/O5332Pllw+EaEqefYb8M9ErexKFvNyLwo9vfljC4J+2VfNblvD243xDdj4Su3X0Fga
         EaUPg+zDRH0x9j9SFyrt35K5hgceOyx3LQvEw5CaMHrLuiWZ/gfMUctOw3sf20pbtQ1m
         DkJdF+pbxZ8v75TFllYR+8sLjcP4eRICzZbr9G0HhT+Nd4Hzg3cVENlAk4wSocEK6lDA
         P0RP3ktsB60JijV8kwp8LTudnRsy/aFfZ/oFDHOKNCdiFMMwqNBjW55kIgjrqnMbkXFs
         JVow==
X-Gm-Message-State: AOAM530Ll0VKbwjXorpxuICmD/DXywjxjqBw0Iy8uUXfAtAeITobOqdI
        dXsDhMgBQ3CWbNV98azBF7ZdCX68dXM=
X-Google-Smtp-Source: ABdhPJy7aATQdZ03Q4T7aEc/X/rIocX32vqMRexiuVPmN7o59z6IbFvRQdL+ytbyNTZTfNvW7IvbGA==
X-Received: by 2002:aa7:c2c4:: with SMTP id m4mr22600796edp.299.1592216947960;
        Mon, 15 Jun 2020 03:29:07 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([79.132.248.22])
        by smtp.gmail.com with ESMTPSA id y21sm8772378ejp.32.2020.06.15.03.29.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2020 03:29:07 -0700 (PDT)
Subject: Re: [PATCH net v2] mptcp: drop MPTCP_PM_MAX_ADDR
To:     Geliang Tang <geliangtang@gmail.com>,
        Mat Martineau <mathew.j.martineau@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, mptcp@lists.01.org,
        linux-kernel@vger.kernel.org
References: <8d8984e8f73e37c87e69459fdef12fe9bab80949.1592209282.git.geliangtang@gmail.com>
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <dace6dec-e908-4bf8-f98e-cbec6c2a0f62@tessares.net>
Date:   Mon, 15 Jun 2020 12:29:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <8d8984e8f73e37c87e69459fdef12fe9bab80949.1592209282.git.geliangtang@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geliang,

On 15/06/2020 10:28, Geliang Tang wrote:
> We have defined MPTCP_PM_ADDR_MAX in pm_netlink.c, so drop this duplicate macro.
> 
> Fixes: 1b1c7a0ef7f3 ("mptcp: Add path manager interface")
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> ---
>   Changes in v2:
>    - change Subject from "mptcp: unify MPTCP_PM_MAX_ADDR and MPTCP_PM_ADDR_MAX"

Thank you for this v2, it looks good to me!

Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
