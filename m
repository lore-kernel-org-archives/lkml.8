Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46AABC18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 00:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1802A2051A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 00:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733185AbgCQA0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 20:26:03 -0400
Received: from regular1.263xmail.com ([211.150.70.206]:50522 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733159AbgCQA0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 20:26:02 -0400
X-Greylist: delayed 456 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Mar 2020 20:26:02 EDT
Received: from localhost (unknown [192.168.167.13])
        by regular1.263xmail.com (Postfix) with ESMTP id 3ECB0229;
        Tue, 17 Mar 2020 08:18:17 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [172.16.22.134] (unknown [103.29.142.67])
        by smtp.263.net (postfix) whith ESMTP id P30134T140168394696448S1584404291121062_;
        Tue, 17 Mar 2020 08:18:17 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <f7953b93d16a9ead9ba0409d7217d0fa>
X-RL-SENDER: jeffy.chen@rock-chips.com
X-SENDER: cjf@rock-chips.com
X-LOGIN-NAME: jeffy.chen@rock-chips.com
X-FST-TO: sboyd@kernel.org
X-SENDER-IP: 103.29.142.67
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
Message-ID: <5E701742.60706@rock-chips.com>
Date:   Tue, 17 Mar 2020 08:18:10 +0800
From:   JeffyChen <jeffy.chen@rock-chips.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:19.0) Gecko/20130126 Thunderbird/19.0
MIME-Version: 1.0
To:     Stephen Boyd <sboyd@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        linux-clk@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Arnd Bergmann <arnd@arndb.de>, lkft-triage@lists.linaro.org,
        Anders Roxell <anders.roxell@linaro.org>,
        mturquette@baylibre.com,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Basil Eljuse <Basil.Eljuse@arm.com>
Subject: Re: WARNING: CPU: 0 PID: 1 at drivers/clk/clk.c:4156 __clk_put+0xfc/0x130
References: <CA+G9fYsTV66+PYY6LqHdjLx1L3i23ubDuWYg0ABoWuLQZTyL+g@mail.gmail.com> <158438237211.88485.8872594504996170580@swboyd.mtv.corp.google.com>
In-Reply-To: <158438237211.88485.8872594504996170580@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On 03/17/2020 02:12 AM, Stephen Boyd wrote:
> Looks like Greg picked up this patch[1] as commit b8fe128dad8f
> ("arch_topology: Adjust initial CPU capacities with current freq") from
> the list. Not sure it's correct though and I haven't looked in any more
> detail. At least, not calling clk_put() unless it is a valid pointer
> will work to quiet this warning.
>
> [1] https://lore.kernel.org/r/20200113034815.25924-1-jeffy.chen@rock-chips.com
>

Sorry, i made a stupid mistake... Sending the fix now, thanks for 
checking that.


