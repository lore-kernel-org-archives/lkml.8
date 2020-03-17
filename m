Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 763EAC10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 06:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5502620674
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 06:34:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgCQGea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 02:34:30 -0400
Received: from regular1.263xmail.com ([211.150.70.206]:43556 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbgCQGe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 02:34:29 -0400
Received: from localhost (unknown [192.168.167.8])
        by regular1.263xmail.com (Postfix) with ESMTP id 445632C7;
        Tue, 17 Mar 2020 14:34:11 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [172.16.22.134] (unknown [103.29.142.67])
        by smtp.263.net (postfix) whith ESMTP id P24781T140190873843456S1584426846845729_;
        Tue, 17 Mar 2020 14:34:11 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <74c5c1252da5ded59c6443458b98bdac>
X-RL-SENDER: jeffy.chen@rock-chips.com
X-SENDER: cjf@rock-chips.com
X-LOGIN-NAME: jeffy.chen@rock-chips.com
X-FST-TO: sudeep.holla@arm.com
X-SENDER-IP: 103.29.142.67
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
Message-ID: <5E706F5E.7020306@rock-chips.com>
Date:   Tue, 17 Mar 2020 14:34:06 +0800
From:   JeffyChen <jeffy.chen@rock-chips.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:19.0) Gecko/20130126 Thunderbird/19.0
MIME-Version: 1.0
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     linux-kernel@vger.kernel.org, anders.roxell@linaro.org,
        arnd@arndb.de, sboyd@kernel.org, gregkh@linuxfoundation.org,
        naresh.kamboju@linaro.org, daniel.lezcano@linaro.org,
        Basil.Eljuse@arm.com, mturquette@baylibre.com,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] arch_topology: Fix putting invalid cpu clk
References: <20200317001829.29516-1-jeffy.chen@rock-chips.com> <20200317062348.GA12791@e107533-lin.cambridge.arm.com>
In-Reply-To: <20200317062348.GA12791@e107533-lin.cambridge.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep,

On 03/17/2020 02:24 PM, Sudeep Holla wrote:
> On Tue, Mar 17, 2020 at 08:18:29AM +0800, Jeffy Chen wrote:
>> Add a sanity check before putting the cpu clk.
>>
>> Fixes: 2a6d1c6bcd1f (“arch_topology: Adjust initial CPU capacities with current freq")
>
> Fixing a non-existent commit ?
>
Sorry, wrong commit id, will resend it soon.

> --
> Regards,
> Sudeep
>



