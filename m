Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E81C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 14:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C07212078E
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 14:53:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ZqJJE5M6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbgIBOx0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 10:53:26 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:56539 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbgIBOxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 10:53:10 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200902145308euoutp01d4323f2da9c9222e0ccef6cce1bb67f6~w-yG-mPKK2322523225euoutp01i
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 14:53:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200902145308euoutp01d4323f2da9c9222e0ccef6cce1bb67f6~w-yG-mPKK2322523225euoutp01i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1599058388;
        bh=I8tzZaSHmzQrb3lpLI3gSAOyMtkDQltk2GJ7POEp2LM=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=ZqJJE5M6bF46aawvnx5xuBBZNvxQmhSmHJWehYzPVvwDDl8i6y2We43858GPMMKaJ
         kPtzEHgKFbgzZEkv16wNjQWEmbp2AwXeCrXtDvV5vLrI1HaflF95xOpDVJTWz+SMEu
         w42Wml1746W0uhNhGnn291b0oB2kroGg9YD+S0RM=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200902145307eucas1p113e39d4d8f70e2f31f28baf90e0564b6~w-yGmtmaE2907529075eucas1p17;
        Wed,  2 Sep 2020 14:53:07 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 2F.B1.05997.3D1BF4F5; Wed,  2
        Sep 2020 15:53:07 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200902145307eucas1p197e0c9d8e1d1590928c14147c0411e16~w-yGWCKVo3031130311eucas1p1l;
        Wed,  2 Sep 2020 14:53:07 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200902145307eusmtrp1fb58dc1f95fa4282d0ed3ef7fa16bf4a~w-yGVcvo33208032080eusmtrp1X;
        Wed,  2 Sep 2020 14:53:07 +0000 (GMT)
X-AuditID: cbfec7f4-677ff7000000176d-e8-5f4fb1d3347a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id D5.6C.06017.3D1BF4F5; Wed,  2
        Sep 2020 15:53:07 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200902145307eusmtip293d16d9b10b56160db4c07e6e4a71d82~w-yGDJuRo0711207112eusmtip2j;
        Wed,  2 Sep 2020 14:53:07 +0000 (GMT)
Subject: Re: [PATCH v1] regmap: Add can_sleep configuration option
To:     Dmitry Osipenko <digetx@gmail.com>, Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <8dfcf671-d76a-4833-3fe9-2d0505d1b0d3@samsung.com>
Date:   Wed, 2 Sep 2020 16:53:07 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200902141843.6591-1-digetx@gmail.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphleLIzCtJLcpLzFFi42LZduznOd3LG/3jDZ491rCY+vAJm8Xqj48Z
        LS7vmsPmwOyxc9Zddo9NqzrZPD5vkgtgjuKySUnNySxLLdK3S+DK6Pp8g7WgU6Fi4ezrTA2M
        XyS6GDk5JARMJDbtWsTaxcjFISSwglFi/f57bBDOF0aJ7Wt+MkI4nxklJj3fDZThAGvpW2kG
        EV/OKLHs6DFmCOc9o8SeluOMIHOFBZwkfpy9wwJiiwi4S3zYfoQJxGYWUJD4dW8TK4jNJmAo
        0fW2iw3E5hWwkzjWuo4ZxGYRUJFY/H4xWFxUIE7i2KlHLBA1ghInZz4BszkFTCUu9t9hg5gp
        L7H97RxmCFtc4taT+UwgB0kINLNLvL35nx3iUReJ9Xfes0LYwhKvjm+BistInJ7cwwLVwCjx
        8Nxadginh1HictMMRogqa4k7536B/c8soCmxfpc+JCgcJc7uT4Mw+SRuvBWEuIFPYtK26cwQ
        YV6JjjYhiBlqErOOr4PbevDCJeYJjEqzkHw2C8k3s5B8Mwth7QJGllWM4qmlxbnpqcVGeanl
        esWJucWleel6yfm5mxiBaeT0v+NfdjDu+pN0iFGAg1GJh3dGvF+8EGtiWXFl7iFGCQ5mJRFe
        p7On44R4UxIrq1KL8uOLSnNSiw8xSnOwKInzGi96GSskkJ5YkpqdmlqQWgSTZeLglGpg1Dz7
        evX+B/M+PNjy+lKjT7fQ40rRbC9e9oszD60yvu2ozfrni1HewikLli2KdpjyIG2D7kLnl9t4
        nJ88fM/MfUbiNbPbqoaKNp/tWQ0272PczMo+rPlh3RfB0vveMl7Npdhua1ZR26MpFTfXMM+d
        t8J/2/OT756+lGD12TxVUYihhMV0rXyTqhJLcUaioRZzUXEiABPzQpcfAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPIsWRmVeSWpSXmKPExsVy+t/xe7qXN/rHGzRuFrWY+vAJm8Xqj48Z
        LS7vmsPmwOyxc9Zddo9NqzrZPD5vkgtgjtKzKcovLUlVyMgvLrFVija0MNIztLTQMzKx1DM0
        No+1MjJV0rezSUnNySxLLdK3S9DL6Pp8g7WgU6Fi4ezrTA2MXyS6GDk4JARMJPpWmnUxcnEI
        CSxllNiwaD1zFyMnUFxG4uS0BlYIW1jiz7UuNoiit4wSy2e+BksICzhJ/Dh7hwXEFhFwl/iw
        /QgTiM0soCDx694mVoiGDkaJI+8mM4Ik2AQMJbregkzi5OAVsJM41roObBuLgIrE4veLweKi
        AnESZ3peQNUISpyc+QRsAaeAqcTF/jtsEAvMJOZtfsgMYctLbH87B8oWl7j1ZD7TBEahWUja
        ZyFpmYWkZRaSlgWMLKsYRVJLi3PTc4uN9IoTc4tL89L1kvNzNzECI2fbsZ9bdjB2vQs+xCjA
        wajEwzsj3i9eiDWxrLgy9xCjBAezkgiv09nTcUK8KYmVValF+fFFpTmpxYcYTYGem8gsJZqc
        D4zqvJJ4Q1NDcwtLQ3Njc2MzCyVx3g6BgzFCAumJJanZqakFqUUwfUwcnFINjPyHdjzVfb5X
        smHpjZDzmWd9l5a6LdpQc4wtgIl7+d4M9bsZNr6tFzo4Kj5drvjP86RD7yVXySQmeZEZMS/v
        uB6qMgvYlLGgiitJxLbi/KplXlzh86YVZS52fsp1cHqDYYbyqZ/S665ovRBlfbhcwNPlimKp
        vOqHz28vbEo/K79iyws+lkqJ10osxRmJhlrMRcWJAHJHQ1yyAgAA
X-CMS-MailID: 20200902145307eucas1p197e0c9d8e1d1590928c14147c0411e16
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200902142057eucas1p245e94459d5adcd9cc4c38617da1abfc8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200902142057eucas1p245e94459d5adcd9cc4c38617da1abfc8
References: <CGME20200902142057eucas1p245e94459d5adcd9cc4c38617da1abfc8@eucas1p2.samsung.com>
        <20200902141843.6591-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On 02.09.2020 16:18, Dmitry Osipenko wrote:
> Regmap can't sleep if spinlock is used for the locking protection.
> This patch fixes regression caused by a previous commit that switched
> regmap to use fsleep() and this broke Amlogic S922X platform.
>
> This patch adds new configuration option for regmap users, allowing to
> specify whether regmap operations can sleep and assuming that sleep is
> allowed if mutex is used for the regmap locking protection.
>
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Fixes: 2b32d2f7ce0a ("regmap: Use flexible sleep")
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>

This fixes the issue I've reported. Thanks!

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

> ---
>   drivers/base/regmap/internal.h |  3 +++
>   drivers/base/regmap/regmap.c   | 19 +++++++++++++++----
>   include/linux/regmap.h         |  3 +++
>   3 files changed, 21 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/base/regmap/internal.h b/drivers/base/regmap/internal.h
> index 3d80c4b43f72..8a59359e145f 100644
> --- a/drivers/base/regmap/internal.h
> +++ b/drivers/base/regmap/internal.h
> @@ -161,6 +161,9 @@ struct regmap {
>   	void *selector_work_buf;	/* Scratch buffer used for selector */
>   
>   	struct hwspinlock *hwlock;
> +
> +	/* if set, the regmap core can sleep */
> +	bool can_sleep;
>   };
>   
>   struct regcache_ops {
> diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
> index a417cb1a11dc..2807e544658e 100644
> --- a/drivers/base/regmap/regmap.c
> +++ b/drivers/base/regmap/regmap.c
> @@ -697,11 +697,13 @@ struct regmap *__regmap_init(struct device *dev,
>   
>   	if (config->disable_locking) {
>   		map->lock = map->unlock = regmap_lock_unlock_none;
> +		map->can_sleep = config->can_sleep;
>   		regmap_debugfs_disable(map);
>   	} else if (config->lock && config->unlock) {
>   		map->lock = config->lock;
>   		map->unlock = config->unlock;
>   		map->lock_arg = config->lock_arg;
> +		map->can_sleep = config->can_sleep;
>   	} else if (config->use_hwlock) {
>   		map->hwlock = hwspin_lock_request_specific(config->hwlock_id);
>   		if (!map->hwlock) {
> @@ -737,6 +739,7 @@ struct regmap *__regmap_init(struct device *dev,
>   			mutex_init(&map->mutex);
>   			map->lock = regmap_lock_mutex;
>   			map->unlock = regmap_unlock_mutex;
> +			map->can_sleep = true;
>   			lockdep_set_class_and_name(&map->mutex,
>   						   lock_key, lock_name);
>   		}
> @@ -2230,8 +2233,12 @@ static int _regmap_range_multi_paged_reg_write(struct regmap *map,
>   				if (ret != 0)
>   					return ret;
>   
> -				if (regs[i].delay_us)
> -					fsleep(regs[i].delay_us);
> +				if (regs[i].delay_us) {
> +					if (map->can_sleep)
> +						fsleep(regs[i].delay_us);
> +					else
> +						udelay(regs[i].delay_us);
> +				}
>   
>   				base += n;
>   				n = 0;
> @@ -2267,8 +2274,12 @@ static int _regmap_multi_reg_write(struct regmap *map,
>   			if (ret != 0)
>   				return ret;
>   
> -			if (regs[i].delay_us)
> -				fsleep(regs[i].delay_us);
> +			if (regs[i].delay_us) {
> +				if (map->can_sleep)
> +					fsleep(regs[i].delay_us);
> +				else
> +					udelay(regs[i].delay_us);
> +			}
>   		}
>   		return 0;
>   	}
> diff --git a/include/linux/regmap.h b/include/linux/regmap.h
> index d865d8fea535..0c49d59168b5 100644
> --- a/include/linux/regmap.h
> +++ b/include/linux/regmap.h
> @@ -342,6 +342,7 @@ typedef void (*regmap_unlock)(void *);
>    * @hwlock_id: Specify the hardware spinlock id.
>    * @hwlock_mode: The hardware spinlock mode, should be HWLOCK_IRQSTATE,
>    *		 HWLOCK_IRQ or 0.
> + * @can_sleep: Optional, specifies whether regmap operations can sleep.
>    */
>   struct regmap_config {
>   	const char *name;
> @@ -398,6 +399,8 @@ struct regmap_config {
>   	bool use_hwlock;
>   	unsigned int hwlock_id;
>   	unsigned int hwlock_mode;
> +
> +	bool can_sleep;
>   };
>   
>   /**

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

