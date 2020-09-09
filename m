Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 728BCC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20A4E206D4
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tessares-net.20150623.gappssmtp.com header.i=@tessares-net.20150623.gappssmtp.com header.b="Yc1/H8ef"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729622AbgIIRPk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 13:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730212AbgIIP3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:29:05 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21494C0612F8
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 07:39:58 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z1so3254573wrt.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 07:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=11MI0KiTsfDovJmHLIZ6mGMd2aO/GNiEEd0QOHNHXg0=;
        b=Yc1/H8efLlur4NsZLckZuVxVv7eBKW+pOWMidUFk8KtU0BAoPVPXWk16J5mKnNrmIi
         oWB20T+Z2wVlAeFQT3uhLlx8nm1qKbo+/rKT870Cni1Y1rvHVkbmASg+/AfCDUB8dHFb
         TLVHSYXSJi6UFU0cTS/U9tEbHBhBLAjxYjnFM7MYgQNxIJtG4KvvC38iEKyftKrY9H+1
         HSx0E0vxEPJhDXm3VLoD5HTSk56PQ8Z3oow2H9NPpBHJXjDQQLsyXgx6lPJRPrPZoIQc
         adu/KyZfOH0QEy/Tx3fMUNsu8auumg3t/aka3gUOr2/dPsvtlMe+R4Te4NvYpDU6Qx1s
         Hzag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=11MI0KiTsfDovJmHLIZ6mGMd2aO/GNiEEd0QOHNHXg0=;
        b=fOuNhqOT2Q9vq2xown16l1V6FfgKvOTFSngkEaL0aPnzL47BJnTf6/oJk6PVm9kx37
         Ip5Zd3l22G89n9vblcg4+wIjE3UuIg0GcvICgQvY9cPCnXvNXR5r19q0uSGi605iPteK
         1prwtfHs76mB3OvZO+pCpgfqlj/G9ugIqjXdLjAHXk2s6DnP4Jo+q1TqvZj5ISknaq0i
         7z/Rljdr7xfApyVVMQvnpumLNLmSgqCrOUAdF+k2yZYCBW4Ed8dXKZxZhBdr56Q+KDRK
         GB1cz1fgCin6hta2Z5znOpJl3qJVhuPUyaKh3zux2ErNAeSohT6bHnIt2G/tKpYCa7lJ
         KdVQ==
X-Gm-Message-State: AOAM531eVe1f6iiX+4TtsdsHasDWV0K9j3mqAz6+dkjp74KQp4ejP4o0
        VLMpxLyfQJE4oq/jpsYST9c7zVYZNtMIAw==
X-Google-Smtp-Source: ABdhPJwg4KZor8Ulp7aL3kakuSHdnlGpdMIVAnOUc1hsbL6VzzEtJVLgSQ4Wqa+k6cfbfZJG5X8vFw==
X-Received: by 2002:adf:edcc:: with SMTP id v12mr4240797wro.240.1599662396424;
        Wed, 09 Sep 2020 07:39:56 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:8ddf:bedd:580e:7a7e])
        by smtp.gmail.com with ESMTPSA id z15sm4368511wrv.94.2020.09.09.07.39.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2020 07:39:55 -0700 (PDT)
Subject: Re: [MPTCP][PATCH v2 net 2/2] mptcp: fix subflow's remote_id issues
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
 <0127c08400bdf65c03438b0b6e90e4ab72ea1576.1599532593.git.geliangtang@gmail.com>
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <4c6c23fc-f493-ce9e-953f-679109de5fc8@tessares.net>
Date:   Wed, 9 Sep 2020 16:39:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <0127c08400bdf65c03438b0b6e90e4ab72ea1576.1599532593.git.geliangtang@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geliang,

On 08/09/2020 04:49, Geliang Tang wrote:
> This patch set the init remote_id to zero, otherwise it will be a random
> number.
> 
> Then it added the missing subflow's remote_id setting code both in
> __mptcp_subflow_connect and in subflow_ulp_clone.
> 
> Fixes: 01cacb00b35cb ("mptcp: add netlink-based PM")
> Fixes: ec3edaa7ca6ce ("mptcp: Add handling of outgoing MP_JOIN requests")
> Fixes: f296234c98a8f ("mptcp: Add handling of incoming MP_JOIN requests")
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>

Thank you for the v2!

Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
