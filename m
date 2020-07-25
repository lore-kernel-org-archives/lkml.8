Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 113B1C433E8
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 03:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA2E52067D
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 03:12:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgGYDM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 23:12:57 -0400
Received: from out28-2.mail.aliyun.com ([115.124.28.2]:52190 "EHLO
        out28-2.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbgGYDMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 23:12:54 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1455954|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_news_journal|0.00769507-0.00104563-0.991259;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03275;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.I7EUJe-_1595646770;
Received: from 192.168.10.205(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.I7EUJe-_1595646770)
          by smtp.aliyun-inc.com(10.147.44.129);
          Sat, 25 Jul 2020 11:12:51 +0800
Subject: Re: [PATCH v5 0/4] Add USB PHY support for new Ingenic SoCs.
To:     Felipe Balbi <balbi@kernel.org>, gregkh@linuxfoundation.org,
        robh+dt@kernel.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, paul@crapouillou.net,
        prasannatsmkumar@gmail.com, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        yanfei.li@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com
References: <20200723061301.82583-1-zhouyanjie@wanyeetech.com>
 <87tuxyoafs.fsf@kernel.org>
From:   Zhou Yanjie <zhouyanjie@wanyeetech.com>
Message-ID: <49a76da8-5a42-5bfe-84f4-18b763ea9aa7@wanyeetech.com>
Date:   Sat, 25 Jul 2020 11:12:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <87tuxyoafs.fsf@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Felipe,

在 2020/7/23 下午5:19, Felipe Balbi 写道:
> 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com> writes:
>
>> 1.separate the adjustments to the code style into
>>    a separate patch.
>> 2.Modify the help message, make it more future-proof.
>> 3.Drop the unnecessary comment about hardware reset.
>> 4.Create 'soc_info' structures instead having ID_* as platform data.
> For v5.10, make sure to move your phy driver to drivers/phy.
>
Sure, I will move it to drivers/phy in next version.

Thanks and best regards!

