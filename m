Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF08C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 15:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E08E206D8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 15:11:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730704AbgG1PLo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 11:11:44 -0400
Received: from out28-146.mail.aliyun.com ([115.124.28.146]:44640 "EHLO
        out28-146.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730499AbgG1PLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 11:11:44 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07729437|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.125387-0.156531-0.718082;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03306;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=19;RT=19;SR=0;TI=SMTPD_---.I8t9.vR_1595949095;
Received: from 192.168.10.205(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.I8t9.vR_1595949095)
          by smtp.aliyun-inc.com(10.147.40.2);
          Tue, 28 Jul 2020 23:11:36 +0800
Subject: Re: [PATCH v6 3/5] USB: PHY: JZ4770: Add support for new Ingenic
 SoCs.
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Felipe Balbi <balbi@kernel.org>, gregkh@linuxfoundation.org,
        robh+dt@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        paul@crapouillou.net, prasannatsmkumar@gmail.com, kishon@ti.com,
        gor@linux.ibm.com, hca@linux.ibm.com,
        christophe.jaillet@wanadoo.fr, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        yanfei.li@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com
References: <20200725035159.31231-1-zhouyanjie@wanyeetech.com>
 <20200725035159.31231-4-zhouyanjie@wanyeetech.com>
 <87r1t0nmpr.fsf@kernel.org>
 <1727b5db-5cdf-b88a-4672-bfb4e9809bb0@wanyeetech.com>
 <20200727095355.GW12965@vkoul-mobl>
From:   Zhou Yanjie <zhouyanjie@wanyeetech.com>
Message-ID: <1c311f60-87e0-8120-79bd-addab8dc02b3@wanyeetech.com>
Date:   Tue, 28 Jul 2020 23:11:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20200727095355.GW12965@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

在 2020/7/27 下午5:53, Vinod Koul 写道:
> On 25-07-20, 15:34, Zhou Yanjie wrote:
>> Hi Felipe,
>>
>> 在 2020/7/25 下午2:16, Felipe Balbi 写道:
>>> Hi,
>>>
>>> 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com> writes:
>>>> Add support for probing the phy-jz4770 driver on the JZ4780 SoC,
>>>> the X1000 SoC and the X1830 SoC from Ingenic.
>>>>
>>>> Tested-by: 周正 (Zhou Zheng) <sernia.zhou@foxmail.com>
>>>> Co-developed-by: 漆鹏振 (Qi Pengzhen) <aric.pzqi@ingenic.com>
>>>> Signed-off-by: 漆鹏振 (Qi Pengzhen) <aric.pzqi@ingenic.com>
>>>> Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
>>> It would be better to move this driver to drivers/phy before adding
>>> support for new SoCs. We want to remove drivers/usb/phy/ in the near
>>> future, any help is welcome.
>>>
>> Seems my mailbox have something wrong, the [5/5] patch in this series is
>> used to move this river to drivers/phy, but seems that it has not been sent
>> out correctly, I already resend it.
> I have resend patches in my inbox but that seems missing patches too :(
>
I'm very sorry, but the problem with my mailbox has not been completely 
resolved. In the past week, it still has frequent mail delays and mail 
loss :(
