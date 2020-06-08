Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C7DCC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 11:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 515352074B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 11:19:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tessares-net.20150623.gappssmtp.com header.i=@tessares-net.20150623.gappssmtp.com header.b="C3n5QzrX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729590AbgFHLTG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 07:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729487AbgFHLTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 07:19:05 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66AA6C08C5C3
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 04:19:05 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id m32so7909815ede.8
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 04:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4xfA41RF7LMfRQKRnVMDXuzv0Fq5jkQXyGGuULSz9PU=;
        b=C3n5QzrXpqqu4lMi7DZ1ifSqTYvef4TqFhQlqbzjLtSRBwxaz0Hyx0vBe+SxiduLcG
         +rbQpGQJI/XuIU3us35k9SO9bIFEWmXkH0Z5Ve7+/vZPC97F8tkrjwf9XT0filJkeg/N
         nDsoExyEmh/gW8uICQYNLnWZ8gpoM0NZE5PuWTIwa3BtKdibUkVLBNbG3wJ1FfzZpG4O
         mXenZBuhHgSomsuYcOBzxa+vavjPzPdQ9FlV07ulitgVBtfhJjQz0kzwd1LLoHQUYLb9
         eP7+0wWIxw2Mafs9IbnwHemFTQ3I6NnuJaGtILgsJhi49Nc+C3rqMy3Fk97ZAgN0ioHw
         AMXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4xfA41RF7LMfRQKRnVMDXuzv0Fq5jkQXyGGuULSz9PU=;
        b=tWyeRl34uqjThTKsN5fSaqdR0i6DACy+zfa1RNOHWyW8ro3IZvp+ksdHlGI+itnNAU
         e6xzmMRoFWwULBp4UYPaun29FvVslBnE4ZtCEHkGjAKNiKCHrnTyjHqTAzQd5jxS+sku
         vmfIU1/AqPi4wnXVsCXJLR15qYIHz4S/JuJsSPDb8SOSuCXo87FktJmmeD7LUw4MLSV9
         LtljtluBa5VPC5pCSKTxpwHmvQETTxNOZVovxT6VYjMWDMsjP7I+T3opb9+eZn0ov1PV
         8Ktkbn1B81yZlbcPdTw/Y7T+2wjFNVBZxFuYd5a7HFI5qNxYrnFAdMnVm/OI8Dp7zou5
         YuWg==
X-Gm-Message-State: AOAM530ETmjiH4rjWT4zCDsnEt2nUWyGoivGjjMKdG++JpUyG/W66f4q
        jcvhxu/2FcIi34QpflOsa+U4Qkytf/M=
X-Google-Smtp-Source: ABdhPJyZHaAfFAODcpmnhSe+6/nyareVtjYJA5+jXfGDl8rLkWsH6C6XtuRxaYZVCfLq+JKuRDph8Q==
X-Received: by 2002:aa7:d158:: with SMTP id r24mr21077281edo.272.1591615143840;
        Mon, 08 Jun 2020 04:19:03 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([79.132.248.22])
        by smtp.gmail.com with ESMTPSA id bg21sm10684985ejb.90.2020.06.08.04.19.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2020 04:19:03 -0700 (PDT)
Subject: Re: [PATCH net v2] mptcp: bugfix for RM_ADDR option parsing
To:     Geliang Tang <geliangtang@gmail.com>,
        Mat Martineau <mathew.j.martineau@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Peter Krystad <peter.krystad@linux.intel.com>
Cc:     netdev@vger.kernel.org, mptcp@lists.01.org,
        linux-kernel@vger.kernel.org
References: <5ec9759a19d4eba5f7f9006354da2cfeb39fa839.1591612830.git.geliangtang@gmail.com>
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <983bab97-ed03-c84b-5bbb-b79b5dc5afb0@tessares.net>
Date:   Mon, 8 Jun 2020 13:19:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <5ec9759a19d4eba5f7f9006354da2cfeb39fa839.1591612830.git.geliangtang@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geliang,

On 08/06/2020 12:47, Geliang Tang wrote:
> In MPTCPOPT_RM_ADDR option parsing, the pointer "ptr" pointed to the
> "Subtype" octet, the pointer "ptr+1" pointed to the "Address ID" octet:
> 
>    +-------+-------+---------------+
>    |Subtype|(resvd)|   Address ID  |
>    +-------+-------+---------------+
>    |               |
>   ptr            ptr+1
> 
> We should set mp_opt->rm_id to the value of "ptr+1", not "ptr". This patch
> will fix this bug.
> 
> Fixes: 3df523ab582c ("mptcp: Add ADD_ADDR handling")
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> ---
>   Changes in v2:
>    - Add "-net" subject and "Fixes" tag as Matt suggested.

Thanks for this v2! LGTM!

Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>

Cheers,
Matt
-- 
Matthieu Baerts | R&D Engineer
matthieu.baerts@tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
