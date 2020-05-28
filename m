Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A6AC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EA7120814
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="rJX7Rg8h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728504AbgE1Okq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 10:40:46 -0400
Received: from mout.web.de ([212.227.17.11]:55281 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725795AbgE1Okp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 10:40:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1590676831;
        bh=HYU9sYcWSnsaVuYUbeTcXYC6woawYhMkBcGEBFM9d/s=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=rJX7Rg8hbtIRVcucubgY+UgTewnKFYAjU4vZ74g4KWP5lQGFks4SfmXZG9BLjjpHL
         qkrXeynwhw9kGbBRbWgqLGMREsaTaEqul98jMmhb/b0YTHbDd3W1U3m1SF85GrZLgZ
         BpOUZ9b1LCNxZsY/7OkLVeHg2ujLzMpOVeIrClVU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([2.244.30.242]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MRCrb-1jRLX60oAx-00Uawr; Thu, 28
 May 2020 16:40:31 +0200
Subject: Re: [v5] workqueue: Remove unnecessary kfree() call in rcu_free_wq()
From:   Markus Elfring <Markus.Elfring@web.de>
To:     Tejun Heo <tj@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Zhang Qiang <qiang.zhang@windriver.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20200527075715.36849-1-qiang.zhang@windriver.com>
 <284c7851-4e89-a00f-a2e6-aa8e2e1f3fce@web.de>
 <DM6PR11MB32573F3884A864ECD586235EFF8E0@DM6PR11MB3257.namprd11.prod.outlook.com>
 <DM6PR11MB3257D6E7E93A518392502809FF8E0@DM6PR11MB3257.namprd11.prod.outlook.com>
 <20200528095703.GH30374@kadam> <20200528103809.GK83516@mtj.thefacebook.com>
 <5e25fc22-fb61-46f8-a8ec-232bceee40b7@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <17ea4742-6fdb-c0a2-666d-a9c2b8f2bf4a@web.de>
Date:   Thu, 28 May 2020 16:40:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <5e25fc22-fb61-46f8-a8ec-232bceee40b7@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
X-Provags-ID: V03:K1:/Y1VGSyd9/aNLKYxfRXIALqLijS2Uw8DEKzJ8hQbHWwiwQOfEFq
 /SP60uA8Z1QeWwuncJ+O6flTO/+RjhQFUh5hwuE+BygQWSnt04p2HbH1/AXs2Y6LhNhBWfz
 ur+5TPLPx8hXnfEhuGAJevc3Ev1HhzjFlT0M1DahlLYMWUAQGlTjVjN13dl1F1HT1CS2V/J
 mkIY8wjIJNbvEdi7Q4QaQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LOk2aV/F0bs=:vVLvv8ygg/Upu1A0Z7RDi9
 HTg0BFRgg4ypvGbjXciKaLueN2fmH9WqtWYt/OXMRz9ceS4e1mUO7o4PPDxOqRUAuVUaFL9iQ
 zEgQyhh6SXQCnVumvDknsiUwmyyoZOBc8o0A21xioxHsUn527AtadLvaIOB4VAfsEHWI3cVIs
 mddN+zkoGCMMwFurjXx0wTl8JmfvcWhPBWarRZlVXtcLDhRlpL60mqy9rRH3wI/RGrdW/mfp6
 cgcuvvqiyqV1neN0JhLFmu6M3fHFiqAtIeb2Sobey/IQrEJTrGOShKrq5JcXhGQAYyrwbIzBw
 dl20O588FA9AdAQmCRxenZMyrdr3jM0buKkMFndZW6WbyyaQmxsHexcNkRNXKmZxR2vKAQcWW
 jWCglXMFbwcSmkYjXqlS0SFkoUbD6GU/atsWcnG3Pi9davrYDWjd7VneK3u8QGiBgwkD1blBG
 yIzXJqussSXqv1oWV7DO1MoiaoD6fLq1p//Zu5rjJHlfLlTndQTDd39zhY4sPahDaJ+S2Gq6/
 pVHS0p/gYqeNx9LWQ1W938XImjwM5IEpbBIItqgbpNm/6LcAqlkj82Zob65WKEsbfxmLBsXw2
 gDz16bfaeKjoRXRiCm/BC6x6ZRHHmkGpLRAr0Oc38aTpTL+1+yRqwlu7GS6Jif3f2aIDuT7V/
 igH5Y6aScrSWn44s2/p2PHBleTL70NjFdV8uDkMFFHVsLvSSKAMwHIfopvE+BaoKe+vBduxA3
 jLBydIhjfby+xeWzjNcwfMEKDAg/A/Foh8fTAl4q2efKxz3TZUz2O6wX/HzdjpRQ9fpB/7UK+
 31JUulitbH3Hb2+5/QTnJtdkOE2dXnjuhppXp6YKmUaZ5PtLRyqtP78X7AzNQNHcmMyiiLmMj
 zY5FQiTZo1L1b8FU1gMS6GIs14OKqAp8ZQl1gZ/pFUjFTB9O0KtMRY6mHFx3w1M0iE8tUqQc5
 ypZ74dFnzVAnMChrvWo0g1OsOWj45+ElhHBTpa+En3NvflWFhO8X9irhckbMQX4h24KMXFtQe
 nTNiLfxA9ql8cLGEqdjNRlKZiiSfgUer+PGAi9eent1vvYS+vkuh84v+AtDlPaXADm0O+b5bF
 3olsLP7F+SmkU3VMrI1jWeohd9EaekkNiXIckl1QzJZbnnlPitVyzZTMlXZil0b+WPldT6gw/
 tnC5FGUm4sXe0cVQdcMKDnjRuixrfzDri9ea4HDpc5+BNr9n/w0fwVwAfMDOkBp4Yt9ZuxQ/W
 gMnyFGanUVNgvR/3w
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Can it matter to use separate callback functions for these cases?
> https://elixir.bootlin.com/linux/v5.7-rc7/C/ident/rcu_free_pwq

See also:
https://elixir.bootlin.com/linux/v5.7-rc7/C/ident/rcu_free_wq

Regards,
Markus
