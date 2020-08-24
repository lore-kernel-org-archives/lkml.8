Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DECF3C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 11:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7EBE20706
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 11:58:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgHXL6g convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 07:58:36 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:47072 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726306AbgHXL6b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 07:58:31 -0400
Received: from dggeme702-chm.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id 8C6599F3F07CFCD09DF3;
        Mon, 24 Aug 2020 19:58:25 +0800 (CST)
Received: from dggeme753-chm.china.huawei.com (10.3.19.99) by
 dggeme702-chm.china.huawei.com (10.1.199.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Mon, 24 Aug 2020 19:58:25 +0800
Received: from dggeme753-chm.china.huawei.com ([10.7.64.70]) by
 dggeme753-chm.china.huawei.com ([10.7.64.70]) with mapi id 15.01.1913.007;
 Mon, 24 Aug 2020 19:58:25 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     "davem@davemloft.net" <davem@davemloft.net>,
        "johannes.berg@intel.com" <johannes.berg@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] netlink: remove duplicated nla_need_padding_for_64bit()
 check
Thread-Topic: [PATCH] netlink: remove duplicated nla_need_padding_for_64bit()
 check
Thread-Index: AdZ6DcED8mm92hDFTMquKaSxbpKTgQ==
Date:   Mon, 24 Aug 2020 11:58:24 +0000
Message-ID: <51bd2b4c5f4549488de08bdcf6daae23@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.176.176]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

friendly ping :)

>Miaohe Lin <linmiaohe@huawei.com> wrote:
>From: Miaohe Lin <linmiaohe@huawei.com>
>
>The need for padding 64bit is implicitly checked by nla_align_64bit(), so remove this explicit one.
>
>Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>---
> lib/nlattr.c | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)
>
>diff --git a/lib/nlattr.c b/lib/nlattr.c index bc5b5cf608c4..98f596bfbfd8 100644
>--- a/lib/nlattr.c
>+++ b/lib/nlattr.c
>@@ -816,8 +816,7 @@ EXPORT_SYMBOL(__nla_reserve);  struct nlattr *__nla_reserve_64bit(struct sk_buff *skb, int attrtype,
> 				   int attrlen, int padattr)
> {
>-	if (nla_need_padding_for_64bit(skb))
>-		nla_align_64bit(skb, padattr);
>+	nla_align_64bit(skb, padattr);
> 
> 	return __nla_reserve(skb, attrtype, attrlen);  }
>--
>2.19.1
>
