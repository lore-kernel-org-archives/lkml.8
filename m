Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37CC6C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 15:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BD42206E6
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 15:20:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gpos+plQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729403AbgFDPUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 11:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729352AbgFDPUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 11:20:22 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE72AC08C5C0
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 08:20:22 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id y11so2286465plt.12
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 08:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=L5y9b1v4A4lBO5NWvkoBLQUmHew2ukXmcq/ClJT1w1w=;
        b=gpos+plQKfEIX7tzDBt/sI1M4cJ64HGjlcagV8I9ZM5vteH+aKUEUFO+edPS0/ec+W
         n5texbDTEFIsJZXY49B4p050y09qfwf2Tr4C+tZV/0UnDjeFumyzyatU66CMmkp++5ED
         4cdCY2TLNCYSpQvvfik1nroAPCGadhKstu8xo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=L5y9b1v4A4lBO5NWvkoBLQUmHew2ukXmcq/ClJT1w1w=;
        b=nBQFHsJi+zMG+jysJS6e9RZGE4uJyQisHRDfhmCNI1QngEcU8zO0hsES4853tGHMVv
         HqB4BZwlz4fcDJqJmlu8gD4GmCXwjyWFXBcjezZpXr8hQ4GfCAahzCowKunwiWFJkhF4
         d54CclMigVZkfD1FdQuM6EXq2tc0sf2MY+B8wiWhH5krV+CMblPmrl4nz5YogCtrtN4y
         fUXf6f/J1PQ9x6fqdEVAo/ZS01l3lCRqM/5CJWoAk/4XOtH3eOrsjTPZHuwAgYMr3RbX
         xzLiUiHpoD18dwDYS8JwvwRmRoaEBFjdcLiUjPGzqerK1jmtbXr1yxofP+GjdfCAY/FD
         VmDQ==
X-Gm-Message-State: AOAM5307zG/BYj36MyYOBxuzaqGvicuBpXMYYcgc1L3ZYNq834D8xEHr
        eP52BOd8xURMN/OetH2odVEQMKzkC1SRsarCtsTTXqRqj1G3QKcAMZ5v+wODhLGG2s6jYN0tbXx
        1E48iupMHhZvMLFH51BG8BReRpsNkvTOERoWkNQ02vrzdfR3IIIOJY/gTDzbvbqXiu53Dt3PWpJ
        t0htc=
X-Google-Smtp-Source: ABdhPJw9p8K0tPRXYb3Jjq/wmj3jBKcwtKglo8mpz4juTMEILBuyPkPUJXY3hMAlX2cld8lf4d2muw==
X-Received: by 2002:a17:90a:4ecb:: with SMTP id v11mr6588792pjl.75.1591284021628;
        Thu, 04 Jun 2020 08:20:21 -0700 (PDT)
Received: from [10.230.185.151] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id u7sm5095551pfu.162.2020.06.04.08.20.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2020 08:20:20 -0700 (PDT)
Subject: Re: [PATCH 1/1] nvme-fcloop: verify wwnn and wwpn format
To:     Dongli Zhang <dongli.zhang@oracle.com>,
        linux-nvme@lists.infradead.org
Cc:     hch@lst.de, sagi@grimberg.me, chaitanya.kulkarni@wdc.com,
        linux-kernel@vger.kernel.org
References: <20200526042118.17836-1-dongli.zhang@oracle.com>
From:   James Smart <james.smart@broadcom.com>
Message-ID: <60df6752-3512-f7a9-b0df-1096b93b8eda@broadcom.com>
Date:   Thu, 4 Jun 2020 08:20:18 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200526042118.17836-1-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/25/2020 9:21 PM, Dongli Zhang wrote:
> The nvme host and target verify the wwnn and wwpn format via
> nvme_fc_parse_traddr(). For instance, it is required that the length of
> wwnn to be either 21 ("nn-0x") or 19 (nn-).
>
> Add this verification to nvme-fcloop so that the input should always be in
> hex and the length of input should always be 18.
>
> Otherwise, the user may use e.g. 0x2 to create fcloop local port, while
> 0x0000000000000002 is required for nvme host and target. This makes the
> requirement of format confusing.
>
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
>   drivers/nvme/target/fcloop.c | 29 +++++++++++++++++++++++------
>   1 file changed, 23 insertions(+), 6 deletions(-)
>
>

Reviewed-by: James Smart <james.smart@broadcom.com>

Looks good. Sorry for the delay.

-- james


