Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79BE0C33CAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 01:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EB5220684
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 01:27:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729043AbgATB1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 20:27:19 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9204 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728927AbgATB1T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 20:27:19 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 287561784A998670AE7A;
        Mon, 20 Jan 2020 09:27:17 +0800 (CST)
Received: from [127.0.0.1] (10.74.149.191) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Mon, 20 Jan 2020
 09:27:04 +0800
Subject: Re: [PATCH -next] net: hns3: replace snprintf with scnprintf in
 hns3_update_strings
To:     Chen Zhou <chenzhou10@huawei.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200119124053.30262-1-chenzhou10@huawei.com>
From:   tanhuazhong <tanhuazhong@huawei.com>
Message-ID: <3762cced-2a4a-7d54-787f-751c6fde2148@huawei.com>
Date:   Mon, 20 Jan 2020 09:27:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20200119124053.30262-1-chenzhou10@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.149.191]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/1/19 20:40, Chen Zhou wrote:
> snprintf returns the number of bytes that would be written, which may be
> greater than the the actual length to be written. Here use extra code to
> handle this.
> 
> scnprintf returns the number of bytes that was actually written, just use
> scnprintf to simplify the code.
> 
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> ---
>   drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
> index 6e0212b..fa01888 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
> @@ -423,9 +423,8 @@ static void *hns3_update_strings(u8 *data, const struct hns3_stats *stats,
>   			data[ETH_GSTRING_LEN - 1] = '\0';
>   
>   			/* first, prepend the prefix string */
> -			n1 = snprintf(data, MAX_PREFIX_SIZE, "%s%d_",
> +			n1 = scnprintf(data, MAX_PREFIX_SIZE, "%s%d_",
>   				      prefix, i);

not align?

> -			n1 = min_t(uint, n1, MAX_PREFIX_SIZE - 1);
>   			size_left = (ETH_GSTRING_LEN - 1) - n1;
>   
>   			/* now, concatenate the stats string to it */
> 

