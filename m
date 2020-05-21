Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F74AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 08:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BF0320721
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 08:39:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="AttJ7FDh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbgEUIjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 04:39:23 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:13339 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728374AbgEUIjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 04:39:22 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ec63deb0000>; Thu, 21 May 2020 01:38:03 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 21 May 2020 01:39:22 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 21 May 2020 01:39:22 -0700
Received: from [10.26.75.55] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 21 May
 2020 08:39:20 +0000
Subject: Re: [PATCH] spi: tegra20-slink: Fix runtime PM imbalance on error
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Dinghao Liu <dinghao.liu@zju.edu.cn>
CC:     Kangjie Lu <kjlu@umn.edu>, Laxman Dewangan <ldewangan@nvidia.com>,
        "Mark Brown" <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <20200521074946.21799-1-dinghao.liu@zju.edu.cn>
 <CAHp75VfOeUaqRW2vRwyWaz3JJw41hX5jTgE+kZ8pB8E_HtHwqw@mail.gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <af91d97e-6367-996b-a925-a5c81f6fb182@nvidia.com>
Date:   Thu, 21 May 2020 09:38:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VfOeUaqRW2vRwyWaz3JJw41hX5jTgE+kZ8pB8E_HtHwqw@mail.gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1590050283; bh=9uLtQsPxoNaJRi8sxPLkhckPw0g+X+KrcTIUZx4NfZk=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=AttJ7FDh44xMD7mI+iREGssNXw5zU2RVPvmo4Jo4ltPG/DR1bVvMQSflel+JQtEB3
         9ouUrhSJcQTZivK8eciplgY5/OBeSp/QwmICHQkJGCcWudtezMyCZZIGrhxtDzXj0o
         cvPyfBpqR3uYqEn2+u5lB+jfxZ5MqDMgoRkSKaD0p1xpLifRAXpGDLHOPlkrodSqCU
         DXgmf9ZIOjyKrRYzU8bvC2SdD2WS4lPDV37oqxBvpLJtTPFSq71EVYzALjRka2F09b
         vx4J5CQqlFQ9kCQDQValw/tGeTORLnoftuZB0KQ4yEFTyx8a0aGL7xMgNVzXIPDvE/
         32dORs7OSfnVg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 21/05/2020 09:04, Andy Shevchenko wrote:
> On Thu, May 21, 2020 at 10:50 AM Dinghao Liu <dinghao.liu@zju.edu.cn> wrote:
>>
>> pm_runtime_get_sync() increments the runtime PM usage counter even
>> when it returns an error code. Thus a pairing decrement is needed on
>> the error handling path to keep the counter balanced.
> 
> ...
> 
>>         ret = pm_runtime_get_sync(&pdev->dev);
>>         if (ret < 0) {
>>                 dev_err(&pdev->dev, "pm runtime get failed, e = %d\n", ret);
> 
>> +               pm_runtime_put(&pdev->dev);
> 
> For all your patches, please, double check what you are proposing.
> 
> Here, I believe, the correct one will be _put_noidle().
> 
> AFAIU you are not supposed to actually suspend the device in case of error.
> But I might be mistaken, thus see above.
> 
>>                 goto exit_pm_disable;
>>         }


Is there any reason why this is not handled in pm_runtime_get itself?
Jon

-- 
nvpublic
