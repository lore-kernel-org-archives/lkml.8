Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E24EC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 17:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 060FA20758
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 17:54:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XE7hzgI4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbgIBRyC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 13:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgIBRx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 13:53:59 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2B1C061244;
        Wed,  2 Sep 2020 10:53:59 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id mm21so166262pjb.4;
        Wed, 02 Sep 2020 10:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2c5F6S3X96hyhdqG4dHZ2yS+M0WB1TvN9cfvaXXm7WQ=;
        b=XE7hzgI4u1UxO+RUCpIrm6WyqeFvJIAkd0NMJhMPvnZLkcTZb8I+PNOiNWqNkUVarF
         QyXEOdtLRlGW5uLGCkz2+2k5A5snx3aMphGS4OnwnJCpuXJPIU8/ZFvcJWcPkiG9LICu
         V3ICoo08udx/Lx3gNL/P7lEBKSPMKbrDeNfk9d3xbwYxIA+3b98i/4r1oPAMzK8BUiIr
         5qTzjz925QvMYWl2UxTs8P/D+pbKmN6qVQSMC47SV45nN+pAbwxm/7bfn+CEsTlr1ePE
         SEHbeM5iZgAvQMtqzb5vzBA1sfGo+eWD1Qg3n2AXA4+nbriwMMxlJinovKnlN9exeoQy
         L67w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2c5F6S3X96hyhdqG4dHZ2yS+M0WB1TvN9cfvaXXm7WQ=;
        b=QEjvpr/rP4hbPmN7dnDdNrHw7JwyOk5zsXbOYXi30Ij8GqUdAOnguYtcn0Z/AqZcdL
         5JxmSuwJr995Hb2Cdw+tT2qlNmNnHCvwwwGgkRP7YO5tmfXSm6oM+4HFbZRZmZDr6o5D
         WWRegG/iuN/HDPRd2ENph4gP/RIZ/RywbGfYoK//6dWvd3sSzAQkSozehQAhZWMOmw9Z
         c4iHqzbWboVCPi6C67YxLejPmY2lX6UeiGnOxVMftpcN6Lstp2j2Cj4VBN34CqUptuMY
         bkmzeZdlwsTIVt+jOWMLYIAao1Prreu6BRcaKsakPBBtTUKrhGpZMnvvA5WEBdLOwuYW
         fvgA==
X-Gm-Message-State: AOAM532H1K/LZvEzyHegzMMMZ5XkD9UtDU8uQHINOB36lc6rew2MZW7p
        EmXFJ874bYuSlLwHeeD/Sr0XVEzLoiA=
X-Google-Smtp-Source: ABdhPJyLcGBW8spXoDF8OgVqTNVgZxXgwqHtUhnbdMkv+OlmbCt43BHMuh69We2fm9QsFQqwzhFGzA==
X-Received: by 2002:a17:90b:364c:: with SMTP id nh12mr3090546pjb.182.1599069238388;
        Wed, 02 Sep 2020 10:53:58 -0700 (PDT)
Received: from [10.230.30.107] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id j19sm151578pfi.51.2020.09.02.10.53.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2020 10:53:57 -0700 (PDT)
Subject: Re: [PATCH] net: bcmgenet: fix mask check in bcmgenet_validate_flow()
To:     Denis Efremov <efremov@linux.com>, Doug Berger <opendmb@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20200902111845.9915-1-efremov@linux.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <34fb3dbf-9715-967a-1151-0b096327c97b@gmail.com>
Date:   Wed, 2 Sep 2020 10:53:54 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <20200902111845.9915-1-efremov@linux.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/2/2020 4:18 AM, Denis Efremov wrote:
> VALIDATE_MASK(eth_mask->h_source) is checked twice in a row in
> bcmgenet_validate_flow(). Add VALIDATE_MASK(eth_mask->h_dest)
> instead.
> 
> Fixes: 3e370952287c ("net: bcmgenet: add support for ethtool rxnfc flows")
> Cc: stable@vger.kernel.org
> Signed-off-by: Denis Efremov <efremov@linux.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
