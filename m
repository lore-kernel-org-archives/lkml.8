Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69BBCC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 00:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 401C32080D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 00:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="f1ROkizO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgGUAwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 20:52:25 -0400
Received: from gateway21.websitewelcome.com ([192.185.45.250]:40359 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726425AbgGUAwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 20:52:24 -0400
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id ED50740175BDB
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 19:52:21 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id xgW5jAgUtwgQAxgW5jFUkH; Mon, 20 Jul 2020 19:52:21 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=qXXnuyugAj0CxbikFnZtaAad162hlkPdrwWBrGHiC+8=; b=f1ROkizOA3uczfGV/hoC9UCD3m
        01d5IcdTgp1V3THs6SldNLRN3UfyDG3Exzwhr+Aqbfleb7N+r7YfYML3zgaynrjT3CyRa4GpJZegD
        j4zE10JXVNbpr3umAqe3zcuntiALosOrMy9JdI79hIxtE6ucCP0TjGxKO1ZPNyYWIAWS5rqZl0SAh
        KkRyEEUyTsZFp/s3tRrXxkHqdZEfyxmw2dsvqWXaaZrzuQ0m6ztje+syhOtFz5/1wF49cP/8Mfox7
        nprDkocQyOWjdlISPG6jYaTvK5btgiE9tIJyMFK7WsZhdMt/czkUnZxRvB/YXKNPYdUy4hYRDatUK
        JP0Xv2+w==;
Received: from [200.68.140.17] (port=10763 helo=[192.168.43.132])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <gustavo@embeddedor.com>)
        id 1jxgW5-000CaQ-I6; Mon, 20 Jul 2020 19:52:21 -0500
Subject: Re: [PATCH v2][next] phy: samsung-ufs: Fix IS_ERR argument
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        "'Gustavo A. R. Silva'" <gustavoars@kernel.org>,
        'Kishon Vijay Abraham I' <kishon@ti.com>,
        'Vinod Koul' <vkoul@kernel.org>,
        'Seungwon Jeon' <essuuj@gmail.com>,
        'Kiwoong Kim' <kwmad.kim@samsung.com>
Cc:     linux-kernel@vger.kernel.org
References: <CGME20200720132147epcas5p14aba715032bcda00fad2147cac8b354b@epcas5p1.samsung.com>
 <20200720132718.GA13413@embeddedor>
 <042d01d65ef8$6c683f80$4538be80$@samsung.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Autocrypt: addr=gustavo@embeddedor.com; keydata=
 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
 AP7RWS474w==
Message-ID: <165b7af1-eb5c-7819-48e8-4ce322756587@embeddedor.com>
Date:   Mon, 20 Jul 2020 19:58:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <042d01d65ef8$6c683f80$4538be80$@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 200.68.140.17
X-Source-L: No
X-Exim-ID: 1jxgW5-000CaQ-I6
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.43.132]) [200.68.140.17]:10763
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 7
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/20/20 19:46, Alim Akhtar wrote:
> Hi Gustavo,
> 
>> -----Original Message-----
>> From: Gustavo A. R. Silva <gustavoars@kernel.org>
>> Sent: 20 July 2020 18:57
>> To: Kishon Vijay Abraham I <kishon@ti.com>; Vinod Koul <vkoul@kernel.org>;
>> Seungwon Jeon <essuuj@gmail.com>; Alim Akhtar
>> <alim.akhtar@samsung.com>; Kiwoong Kim <kwmad.kim@samsung.com>
>> Cc: linux-kernel@vger.kernel.org; Gustavo A. R. Silva
> <gustavoars@kernel.org>
>> Subject: [PATCH v2][next] phy: samsung-ufs: Fix IS_ERR argument
>>
>> Fix IS_ERR argument in samsung_ufs_phy_symbol_clk_init(). The proper
>> argument to be passed to IS_ERR() is phy->rx1_symbol_clk.
>>
>> This bug was detected with the help of Coccinelle.
>>
>> Fixes: bca21e930451 ("phy: samsung-ufs: add UFS PHY driver for samsung
> SoC")
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>> ---
> Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
> 

Thanks, Alim.

--
Gustavo

>> Changes in v2:
>>  - Update subject line and changelog text.
>>
>>  drivers/phy/samsung/phy-samsung-ufs.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/phy/samsung/phy-samsung-ufs.c
>> b/drivers/phy/samsung/phy-samsung-ufs.c
>> index 43ef77d1d96c..9832599a0283 100644
>> --- a/drivers/phy/samsung/phy-samsung-ufs.c
>> +++ b/drivers/phy/samsung/phy-samsung-ufs.c
>> @@ -147,7 +147,7 @@ static int samsung_ufs_phy_symbol_clk_init(struct
>> samsung_ufs_phy *phy)
>>  	}
>>
>>  	phy->rx1_symbol_clk = devm_clk_get(phy->dev, "rx1_symbol_clk");
>> -	if (IS_ERR(phy->rx0_symbol_clk)) {
>> +	if (IS_ERR(phy->rx1_symbol_clk)) {
>>  		dev_err(phy->dev, "failed to get rx1_symbol_clk clock\n");
>>  		return PTR_ERR(phy->rx1_symbol_clk);
>>  	}
>> --
>> 2.27.0
> 
> 
