Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67057C3524A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 07:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFBC22087E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 07:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ukDjaArn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgBDHai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 02:30:38 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:46105 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbgBDHah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 02:30:37 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200204073035euoutp025251800b78e19daad799b3d806a7d9c8~wIoerzBjk3029330293euoutp02b
        for <linux-kernel@vger.kernel.org>; Tue,  4 Feb 2020 07:30:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200204073035euoutp025251800b78e19daad799b3d806a7d9c8~wIoerzBjk3029330293euoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1580801435;
        bh=hVBwk3Pao9MFfxPcAeK7mkzxnvI4qkMd8hSOtk5wrc0=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=ukDjaArnhaG4XpUSpLAskllDC+y4r9+mz8VBoMmM0Xx58KDahVTZbcUOJ5KeWyHIs
         peFM+1ptb52GKE2m4YpkG5mkAZh0x1M7Bw9b1nwlxCjIcMG0wtyc+S4yHCkndlSxVZ
         BjL76hEw53DjajQ1KNyIK7dMLmr0ynsFxU/UU63w=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200204073034eucas1p25f491d92bee4cddeaf2928e975b2609f~wIoeLdEXE2261622616eucas1p2K;
        Tue,  4 Feb 2020 07:30:34 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id D1.57.61286.A9D193E5; Tue,  4
        Feb 2020 07:30:34 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200204073034eucas1p1592fa2436b5567c2d15cf2935c3a8804~wIod5bIXu1783117831eucas1p1W;
        Tue,  4 Feb 2020 07:30:34 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200204073034eusmtrp1bf20e63d676d971c561211264505b5cb~wIod4t0c90982209822eusmtrp1J;
        Tue,  4 Feb 2020 07:30:34 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-fe-5e391d9a654e
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 74.25.07950.A9D193E5; Tue,  4
        Feb 2020 07:30:34 +0000 (GMT)
Received: from [106.120.51.15] (unknown [106.120.51.15]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200204073033eusmtip2391c4206262660c4b346dcf3e797f1ee~wIodYwupy0781607816eusmtip2g;
        Tue,  4 Feb 2020 07:30:33 +0000 (GMT)
Subject: Re: [PATCH v6] platform/chrome: cros_ec: Query EC protocol version
 if EC transitions between RO/RW
To:     Yicheng Li <yichengli@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     bleung@chromium.org, enric.balletbo@collabora.com,
        groeck@chromium.org, lee.jones@linaro.org, gwendal@chromium.org,
        andriy.shevchenko@linux.intel.com, Jonathan.Cameron@huawei.com,
        evgreen@chromium.org, rushikesh.s.kadam@intel.com,
        tglx@linutronix.de
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <54cbade6-c552-4877-a8d7-d2be9930cefd@samsung.com>
Date:   Tue, 4 Feb 2020 08:30:32 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200203225356.203946-1-yichengli@chromium.org>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEKsWRmVeSWpSXmKPExsWy7djP87qzZC3jDHqPa1v0Nk1nspj+5DKL
        xZrbhxgtWu8DuadeLWO2mL34KIvFqoXX2Czufz3KaHF51xw2i8dHDzBZbN40ldli7vE77A48
        HrMbLrJ47Li7hNGj5chbVo/Fe14yedy5tofN4925c+we804GenzeJBfAEcVlk5Kak1mWWqRv
        l8CV8eXpb+aChaoVZy79YW9gbJTrYuTgkBAwkfi2ObmLkYtDSGAFo8Tta++YIJwvjBLf97ay
        QjifGSVmrT7P3sXICdbxf/ZrqKrljBJrZt0FSwgJvGWUuPglCMQWFsiVOLzrFDOILSLgI/G8
        /y8LSAOzQDOTRNPH6ywgCTYBQ4mut11sIDavgJ3Ek4d/WUFsFgEViaYZC8HiogKxEmeOfWeF
        qBGUODnzCVgvp4CtxMmjr8FqmAXkJba/ncMMYYtL3HoyH+w6CYGX7BJrL7xjhjjbRWJJ4yOo
        F4QlXh3fAmXLSJye3MMC0dDMKPHw3Fp2CKeHUeJy0wxGiCpriTvnfrGBgoxZQFNi/S59iLCj
        xIUbN9ghIcknceOtIMQRfBKTtk1nhgjzSnS0CUFUq0nMOr4Obu3BC5eYJzAqzULy2iwk78xC
        8s4shL0LGFlWMYqnlhbnpqcWG+allusVJ+YWl+al6yXn525iBKa00/+Of9rB+PVS0iFGAQ5G
        JR7eC3YWcUKsiWXFlbmHGCU4mJVEeOusTOOEeFMSK6tSi/Lji0pzUosPMUpzsCiJ8xovehkr
        JJCeWJKanZpakFoEk2Xi4JRqYMxfeGfW5IfKyjK8yywD53X9XV1hf50vvvCuJiv/t2UrygJq
        Jmx/8ScpZPE+2zsXnyepaPFxC/TpG8Rcrau31LFc8fbOwd+Hq/uCZ6QlXRDVe9je/ot1RaH3
        RNEfkrbR8987q7y9dViiXjH3hOvirp7yBj255E0vnh09zL7vzHrT4ra6bbXRZkosxRmJhlrM
        RcWJABRBz0RlAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCIsWRmVeSWpSXmKPExsVy+t/xe7qzZC3jDDb2S1r0Nk1nspj+5DKL
        xZrbhxgtWu8DuadeLWO2mL34KIvFqoXX2Czufz3KaHF51xw2i8dHDzBZbN40ldli7vE77A48
        HrMbLrJ47Li7hNGj5chbVo/Fe14yedy5tofN4925c+we804GenzeJBfAEaVnU5RfWpKqkJFf
        XGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mWWqRvl6CX8eXpb+aChaoVZy79YW9g
        bJTrYuTkkBAwkfg/+zVTFyMXh5DAUkaJy6232CESMhInpzWwQtjCEn+udbGB2EICrxkl3q4B
        qxEWyJVYtGMTI4gtIuAj8bz/LwvIIGaBZiaJiX/eM0E02Eg8mLUNbBCbgKFE11uIQbwCdhJP
        Hv4Fi7MIqEg0zVgIFhcViJU4tr2NHaJGUOLkzCcsIDangK3EyaOvwWqYBcwk5m1+yAxhy0ts
        fzsHyhaXuPVkPtMERqFZSNpnIWmZhaRlFpKWBYwsqxhFUkuLc9Nzi430ihNzi0vz0vWS83M3
        MQJjeNuxn1t2MHa9Cz7EKMDBqMTDq+FoESfEmlhWXJl7iFGCg1lJhLfOyjROiDclsbIqtSg/
        vqg0J7X4EKMp0HMTmaVEk/OB6SWvJN7Q1NDcwtLQ3Njc2MxCSZy3Q+BgjJBAemJJanZqakFq
        EUwfEwenVAPj6R1Luc93hrsm2dRtz5aQlPi9r3P2zO7t1w5tCru8KzKO/6HlD5fl8h5Ch2Y+
        mFaa6dOpzLJjaUqQSOj0NXZzXH9lKV+/dFji3eoJar1z73xk/3Dr/cfeX6wil9gyLbxnVV42
        5wzlfaQjrVQ38/LKfmOBBZE5THsny+5SK7oV2awe2h+qIHdViaU4I9FQi7moOBEAu8bmFvcC
        AAA=
X-CMS-MailID: 20200204073034eucas1p1592fa2436b5567c2d15cf2935c3a8804
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200204073034eucas1p1592fa2436b5567c2d15cf2935c3a8804
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204073034eucas1p1592fa2436b5567c2d15cf2935c3a8804
References: <20200203225356.203946-1-yichengli@chromium.org>
        <CGME20200204073034eucas1p1592fa2436b5567c2d15cf2935c3a8804@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 03.02.2020 23:53, Yicheng Li wrote:
> RO and RW of EC may have different EC protocol version. If EC transitions
> between RO and RW, but AP does not reboot (this is true for fingerprint
> microcontroller / cros_fp, but not true for main ec / cros_ec), the AP
> still uses the protocol version queried before transition, which can
> cause problems. In the case of fingerprint microcontroller, this causes
> AP to send the wrong version of EC_CMD_GET_NEXT_EVENT to RO in the
> interrupt handler, which in turn prevents RO to clear the interrupt
> line to AP, in an infinite loop.
>
> Once an EC_HOST_EVENT_INTERFACE_READY is received, we know that there
> might have been a transition between RO and RW, so re-query the protocol.
>
> Signed-off-by: Yicheng Li <yichengli@chromium.org>

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Works fine on Samsung Exynos-based Chromebooks: Snow, Peach-Pit and 
Peach-Pi.

> ---
> Hi Enric and Marek,
>
>> This patch landed recently in linux-next as commit
>> 241a69ae8ea8e2defec751fe55dac1287aa044b8. Sadly, it causes following
>> kernel oops on any key press on Samsung Exynos-based Chromebooks (Snow,
>> Peach-Pit and Peach-Pi):
>
>> Many thanks for report the issue, we will take a look ASAP and revert
>> this commit meanwhile.
>
>> Simply removing the BUG_ON() from cros_ec_get_host_event() function
>> fixes the issue, but I don't know the protocol details to judge if this
>> is the correct way of fixing it.
> The issue was those Samsung Chromebooks (Snow, Peach-Pit and Peach-Pi)
> do not support mkbp events, yet we applied the same thing to them, which
> we shouldn't. This v6 should fix it: I Just added a check
>
> 	if (ec_dev->mkbp_event_supported)
>
> in cros_ec_register().
>
>
>
> drivers/platform/chrome/cros_ec.c           | 29 +++++++++++++++++++++
>   include/linux/platform_data/cros_ec_proto.h |  3 +++
>   2 files changed, 32 insertions(+)
>
> diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
> index 9b2d07422e17..f16804db805b 100644
> --- a/drivers/platform/chrome/cros_ec.c
> +++ b/drivers/platform/chrome/cros_ec.c
> @@ -104,6 +104,23 @@ static int cros_ec_sleep_event(struct cros_ec_device *ec_dev, u8 sleep_event)
>   	return ret;
>   }
>   
> +static int cros_ec_ready_event(struct notifier_block *nb,
> +	unsigned long queued_during_suspend, void *_notify)
> +{
> +	struct cros_ec_device *ec_dev = container_of(nb, struct cros_ec_device,
> +						     notifier_ready);
> +	u32 host_event = cros_ec_get_host_event(ec_dev);
> +
> +	if (host_event & EC_HOST_EVENT_MASK(EC_HOST_EVENT_INTERFACE_READY)) {
> +		mutex_lock(&ec_dev->lock);
> +		cros_ec_query_all(ec_dev);
> +		mutex_unlock(&ec_dev->lock);
> +		return NOTIFY_OK;
> +	}
> +
> +	return NOTIFY_DONE;
> +}
> +
>   /**
>    * cros_ec_register() - Register a new ChromeOS EC, using the provided info.
>    * @ec_dev: Device to register.
> @@ -201,6 +218,18 @@ int cros_ec_register(struct cros_ec_device *ec_dev)
>   		dev_dbg(ec_dev->dev, "Error %d clearing sleep event to ec",
>   			err);
>   
> +	if (ec_dev->mkbp_event_supported) {
> +		/*
> +		 * Register the notifier for EC_HOST_EVENT_INTERFACE_READY
> +		 * event.
> +		 */
> +		ec_dev->notifier_ready.notifier_call = cros_ec_ready_event;
> +		err = blocking_notifier_chain_register(
> +			&ec_dev->event_notifier, &ec_dev->notifier_ready);
> +		if (err)
> +			return err;
> +	}
> +
>   	dev_info(dev, "Chrome EC device registered\n");
>   
>   	return 0;
> diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
> index 0d4e4aaed37a..a1c545c464e7 100644
> --- a/include/linux/platform_data/cros_ec_proto.h
> +++ b/include/linux/platform_data/cros_ec_proto.h
> @@ -121,6 +121,8 @@ struct cros_ec_command {
>    * @event_data: Raw payload transferred with the MKBP event.
>    * @event_size: Size in bytes of the event data.
>    * @host_event_wake_mask: Mask of host events that cause wake from suspend.
> + * @notifier_ready: The notifier_block to let the kernel re-query EC
> + *      communication protocol when the EC sends EC_HOST_EVENT_INTERFACE_READY.
>    * @ec: The platform_device used by the mfd driver to interface with the
>    *      main EC.
>    * @pd: The platform_device used by the mfd driver to interface with the
> @@ -161,6 +163,7 @@ struct cros_ec_device {
>   	int event_size;
>   	u32 host_event_wake_mask;
>   	u32 last_resume_result;
> +	struct notifier_block notifier_ready;
>   
>   	/* The platform devices used by the mfd driver */
>   	struct platform_device *ec;

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

