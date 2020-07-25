Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D27CC433E3
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 04:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10E8620786
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 04:01:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgGYEBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 00:01:43 -0400
Received: from out28-50.mail.aliyun.com ([115.124.28.50]:41438 "EHLO
        out28-50.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbgGYEBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 00:01:43 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.346888|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0230035-0.00189042-0.975106;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03273;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.I7FJ-0A_1595649699;
Received: from 192.168.10.205(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.I7FJ-0A_1595649699)
          by smtp.aliyun-inc.com(10.147.40.26);
          Sat, 25 Jul 2020 12:01:39 +0800
Subject: Re: [PATCH v3 0/3] Add functions to operate USB PHY related clock.
From:   Zhou Yanjie <zhouyanjie@wanyeetech.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, sboyd@kernel.org,
        paul@crapouillou.net, mturquette@baylibre.com,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, yanfei.li@ingenic.com,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com
References: <20200630163852.47267-1-zhouyanjie@wanyeetech.com>
Message-ID: <d4899cde-ac7c-e7a4-5819-59fcacbd3745@wanyeetech.com>
Date:   Sat, 25 Jul 2020 12:01:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20200630163852.47267-1-zhouyanjie@wanyeetech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gentle ping.

在 2020/7/1 上午12:38, 周琰杰 (Zhou Yanjie) 写道:
> v2->v3:
> 1.Remove the wrong "WARN()".
> 2.Remove extra blank line.
> 3.Fix wrong parameters in recalc_rate/set_rate functions.
>
> 周琰杰 (Zhou Yanjie) (3):
>    clk: JZ4780: Add functions for enable and disable USB PHY.
>    clk: JZ4780: Reformat the code to align it.
>    clk: X1000: Add support for calculat REFCLK of USB PHY.
>
>   drivers/clk/ingenic/jz4780-cgu.c | 153 ++++++++++++++++++++-------------------
>   drivers/clk/ingenic/x1000-cgu.c  |  84 ++++++++++++++++++++-
>   2 files changed, 162 insertions(+), 75 deletions(-)
>
