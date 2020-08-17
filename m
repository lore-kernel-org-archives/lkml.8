Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D97B2C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 02:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B59D12087D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 02:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbgHQC11 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 22:27:27 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3132 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726631AbgHQC10 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 22:27:26 -0400
Received: from dggeme701-chm.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id 94A693724C01031AED29;
        Mon, 17 Aug 2020 10:27:23 +0800 (CST)
Received: from dggeme753-chm.china.huawei.com (10.3.19.99) by
 dggeme701-chm.china.huawei.com (10.1.199.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Mon, 17 Aug 2020 10:27:23 +0800
Received: from dggeme753-chm.china.huawei.com ([10.7.64.70]) by
 dggeme753-chm.china.huawei.com ([10.7.64.70]) with mapi id 15.01.1913.007;
 Mon, 17 Aug 2020 10:27:23 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     David Miller <davem@davemloft.net>
CC:     "kuba@kernel.org" <kuba@kernel.org>,
        "martin.varghese@nokia.com" <martin.varghese@nokia.com>,
        "fw@strlen.de" <fw@strlen.de>, "pshelar@ovn.org" <pshelar@ovn.org>,
        "dcaratti@redhat.com" <dcaratti@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "steffen.klassert@secunet.com" <steffen.klassert@secunet.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "shmulik@metanetworks.com" <shmulik@metanetworks.com>,
        "kyk.segfault@gmail.com" <kyk.segfault@gmail.com>,
        "sowmini.varadhan@oracle.com" <sowmini.varadhan@oracle.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: handle the return value of pskb_carve_frag_list()
 correctly
Thread-Topic: [PATCH] net: handle the return value of pskb_carve_frag_list()
 correctly
Thread-Index: AdZ0OegSO4699KlmQ5GoHOd7zwB2lg==
Date:   Mon, 17 Aug 2020 02:27:23 +0000
Message-ID: <c5b7896a7eb34d499979430156ea7e08@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.176.142]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Miller <davem@davemloft.net> wrote:
>> +	/* split line is in frag list */
>> +	if (k == 0 && pskb_carve_frag_list(skb, shinfo, off - pos, gfp_mask)) {
>> +		/* skb_frag_unref() is not needed here as shinfo->nr_frags = 0. */
>> +		if (skb_has_frag_list(skb))
>> +			kfree_skb_list(skb_shinfo(skb)->frag_list);
>> +		kfree(data);
>> +		return -ENOMEM;
>
>On error, the caller is going to kfree_skb(skb) which will take care of the frag list.
>

I'am sorry for my careless. The caller will take care of the frag list and kfree(data) is enough here.
Many thanks for review, will send v2 soon.

