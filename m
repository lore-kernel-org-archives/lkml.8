Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D76FCC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 17:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B80FA2067B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 17:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tessares-net.20150623.gappssmtp.com header.i=@tessares-net.20150623.gappssmtp.com header.b="AYxlnsBv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgFLRdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 13:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgFLRdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 13:33:16 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14488C08C5C1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 10:33:15 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id dr13so10866913ejc.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 10:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=riq8oZ0YmVJgRL3JUnUAQs/ESUHxcGfiGOYYzkUX5O8=;
        b=AYxlnsBvg3ciNGR1E/ZV3+KKfCnlMH/SzgcuP04PaGpjjC6k52kZtVZkh4m/ITJ+Zf
         Rm8zrZcN01Yzw92PPCjDeufQhBsWDUG+qngwqFdb+FooHy2xtPkOFHFmeGqlPuN9izF5
         5IKB2yEOjJM1kQrVRATM4tUuUgronSgbACTU26MbD4xozOPZKvbY08dkkUDMJ/DqdufL
         5j0ZL2vBpCUGmN3BcnK1nTqlSJJxFc+jClRVuqYZMjJw3Z4yA7jwPDDgXMTE19fIYlFu
         jwo9Lyc0ki8dV7R54SNKnlVUXdFhwrnXc7lg1O6IiaRpTtDyDuL+lMqK5gTocKmr5fZK
         x1TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=riq8oZ0YmVJgRL3JUnUAQs/ESUHxcGfiGOYYzkUX5O8=;
        b=hxTQgRysoYTtTCK6/warvxyqr/UA0DxQ2UN11mIoQ3LITSvcCSZJjqGazcCpQL0FH3
         r73lPyUNeUXJRXhR88GbdJ7ISvqa4c/ZmXII6KxpN4ehl4invpsSDpnQgXUBANzfYSz0
         Qh88VRjdxMdrlp9YQcWPiroARAI6yTVs4FHF7paRw2bqiYkPDaxtEIlim5gJUqjW+G+G
         5YQ/A0VL4gAkstRmlcW/6HSI9LYnlLZ/aYzsAMPo+5q/lvuZWvsvgPCxUJtxs+ltE2GY
         K9auV3XYoBNpsishCiLPhV5/csFHZzpmf98peoQ74c0oN8N2fP9APt59ujnYdf2K+y1w
         B3lw==
X-Gm-Message-State: AOAM532sO9RSP/jPmQbqzjL65jgrX8kfppY+gAMgCdcf2ohtS5SQwPC4
        hCAWV6YI5Q16qFkhJUuD12vF0qp8aMM=
X-Google-Smtp-Source: ABdhPJwlDJSLLm1eei1ZYYEczfbr65LnrIffTlsF8XlpG70TYl2jz2JOc++y8M2MsKVxGcGc4UAqUA==
X-Received: by 2002:a17:906:5283:: with SMTP id c3mr13395606ejm.22.1591983194136;
        Fri, 12 Jun 2020 10:33:14 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([79.132.248.22])
        by smtp.gmail.com with ESMTPSA id us3sm3962154ejb.31.2020.06.12.10.33.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2020 10:33:13 -0700 (PDT)
Subject: Re: [PATCH] mptcp: unify MPTCP_PM_MAX_ADDR and MPTCP_PM_ADDR_MAX
To:     Geliang Tang <geliangtang@gmail.com>
Cc:     Mat Martineau <mathew.j.martineau@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        mptcp@lists.01.org, linux-kernel@vger.kernel.org
References: <463f48a4f92aa403453d30a801259c68fda15387.1591939496.git.geliangtang@gmail.com>
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <2638593d-82bd-73be-8ff1-3a4a7d4d5968@tessares.net>
Date:   Fri, 12 Jun 2020 19:33:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <463f48a4f92aa403453d30a801259c68fda15387.1591939496.git.geliangtang@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geliang,

On 12/06/2020 07:27, Geliang Tang wrote:
> Unify these two duplicate macros into 8.

Thank you for this new patch!

(...)

> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 809687d3f410..86d265500cf6 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -135,7 +135,7 @@ static inline __be32 mptcp_option(u8 subopt, u8 len, u8 nib, u8 field)
>   		     ((nib & 0xF) << 8) | field);
>   }
>   
> -#define MPTCP_PM_MAX_ADDR	4
> +#define MPTCP_PM_ADDR_MAX	8

I think it would be better to drop MPTCP_PM_MAX_ADDR and keep 
MPTCP_PM_ADDR_MAX in pm_netlink.c where it is used. Each PM can decide 
what's the maximum number of addresses it can support.

MPTCP_PM_MAX_ADDR seems to be a left over from a previous implementation 
of a PM that has not been upstreamed but replaced by the Netlink PM later.

Also, please always add "net" or "net-next" prefix in the subject of 
your email to help -net maintainers. Do not hesitate to look at the 
netdev FAQ for more details.

Here this patch looks like a fix so you should have [PATCH net] and a 
"Fixes" tag. I guess for this patch you can use:

   Fixes: 1b1c7a0ef7f3 ("mptcp: Add path manager interface")

That's where MPTCP_PM_MAX_ADDR has been introduced. It was already not 
used and never used later.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
