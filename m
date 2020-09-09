Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E21CC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9F23206E6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tessares-net.20150623.gappssmtp.com header.i=@tessares-net.20150623.gappssmtp.com header.b="fyF++iAh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731285AbgIIRO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 13:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730115AbgIIPa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:30:27 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61427C0612F4
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 07:39:56 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id k15so3211246wrn.10
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 07:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bkORLZG3u3dzhotZjzrL2NcwPRVYSyfBeouqNvnhcek=;
        b=fyF++iAhOrN2HEuFApmRjksJO4k6V6b/TEDM7ifrpowYJyMF583aiPiVeZeaLz4n01
         aXIplHyi5iH2rHBH8P3SJ0nfUp/MqUruFrLdz3Qvqp6fN/c3fp6nOD1QNSZRhCD4CTbw
         3E8dIp+bQUOiHnO8ua9OK42LV54gFGtqzb+47n9xeBlU67pBcM+6xd0Q80bKRBqp7hvF
         t363NYLHUXSlHpHQngLMGMpGXKBlqFjiRJVNCGODxKJJ03sinIREuTAjEFxKDfbpJH2c
         Tudwpd6NYqeES0APQoE9eGbWqzIZYYTlXirPT+Lb13tgcARg2eGNQJbNYZ/k+2+FyMS7
         TssQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bkORLZG3u3dzhotZjzrL2NcwPRVYSyfBeouqNvnhcek=;
        b=Y7y25q+RNlHUMd6Mq9I8xl7wxvdyxbyO7IWzFT2LXNFAFWkz5HzilSvB/3rwFVdfzt
         NsLswoqPXiKNsJ30IvywzHtJrjgEc9B6KRGmCAKvVe2V3BFTmWFwXLuQpaZTbJX6cqlE
         MvemESmc1IWZwicT7+PWsAuBvu+yMFFxiK/4UnMQhW+tjyokenKmiLf3pr/r6EltxBG8
         fqwtL284/XGBRd91F3E+as40Rsd3sdH9FL7723qGU3RDDwQI5lDa8W062bY15LWTR+5n
         GBsYlfu1s7/5f+SBRcjLWd9Ug8qbGOkPZF/rUQgvXv7lbnKd47xvseotDjonQDM3YaBY
         1xsA==
X-Gm-Message-State: AOAM533a1BCwp4uOrpvhFlyrEpP+uCvopOc/S4uMxXe2UmT3Q4/hF1By
        CkC1FUVkgZw/0iG2eVn/Jn9xkPTKTldfYQ==
X-Google-Smtp-Source: ABdhPJxsySl+jiMG3NFQaWU08dYy2xTnHvxYnOWZzgh2yN0TVSMchxfChJNOhS8s5Nqo0JfFQH5Fww==
X-Received: by 2002:adf:f846:: with SMTP id d6mr4712246wrq.56.1599662393458;
        Wed, 09 Sep 2020 07:39:53 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:8ddf:bedd:580e:7a7e])
        by smtp.gmail.com with ESMTPSA id a10sm4144731wmj.38.2020.09.09.07.39.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2020 07:39:52 -0700 (PDT)
Subject: Re: [MPTCP][PATCH v2 net 1/2] mptcp: fix subflow's local_id issues
To:     Geliang Tang <geliangtang@gmail.com>,
        Mat Martineau <mathew.j.martineau@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Florian Westphal <fw@strlen.de>,
        Peter Krystad <peter.krystad@linux.intel.com>
Cc:     netdev@vger.kernel.org, mptcp@lists.01.org,
        linux-kernel@vger.kernel.org
References: <cover.1599532593.git.geliangtang@gmail.com>
 <110eaa273bf313fb1a2a668a446956d27aba05a8.1599532593.git.geliangtang@gmail.com>
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <c1537a78-c2b6-383b-f2fb-817c35bbfdaa@tessares.net>
Date:   Wed, 9 Sep 2020 16:39:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <110eaa273bf313fb1a2a668a446956d27aba05a8.1599532593.git.geliangtang@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geliang,

On 08/09/2020 04:49, Geliang Tang wrote:
> In mptcp_pm_nl_get_local_id, skc_local is the same as msk_local, so it
> always return 0. Thus every subflow's local_id is 0. It's incorrect.
> 
> This patch fixed this issue.
> 
> Also, we need to ignore the zero address here, like 0.0.0.0 in IPv4. When
> we use the zero address as a local address, it means that we can use any
> one of the local addresses. The zero address is not a new address, we don't
> need to add it to PM, so this patch added a new function address_zero to
> check whether an address is the zero address, if it is, we ignore this
> address.
> 
> Fixes: 01cacb00b35cb ("mptcp: add netlink-based PM")
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>

Thank you for the v2!

Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
