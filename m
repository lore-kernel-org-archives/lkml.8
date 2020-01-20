Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A1EC2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 14:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA75820678
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 14:34:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbgATOeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 09:34:08 -0500
Received: from wp126.webpack.hosteurope.de ([80.237.132.133]:35330 "EHLO
        wp126.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726626AbgATOeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 09:34:07 -0500
Received: from [2003:a:659:3f00:1e6f:65ff:fe31:d1d5] (helo=hermes.fivetechno.de); authenticated
        by wp126.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1itY7v-0005Vi-Jo; Mon, 20 Jan 2020 15:34:03 +0100
X-Virus-Scanned: by amavisd-new 2.11.1 using newest ClamAV at
        linuxbbg.five-lan.de
Received: from [192.168.34.101] (p5098d998.dip0.t-ipconnect.de [80.152.217.152])
        (authenticated bits=0)
        by hermes.fivetechno.de (8.15.2/8.14.5/SuSE Linux 0.8) with ESMTPSA id 00KEY2M6025434
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Mon, 20 Jan 2020 15:34:03 +0100
Subject: Re: [Bug ?] usb :typec :tcpm :fusb302
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Linux USB Mailing List <linux-usb@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-rockchip@lists.infradead.org
References: <0ac6bbe7-6395-526d-213c-ac58a19d8673@fivetechno.de>
 <20200120115828.GC32175@kuha.fi.intel.com>
 <e05b6c1f-5e00-c000-23b9-1683230fd9f7@roeck-us.net>
From:   Markus Reichl <m.reichl@fivetechno.de>
Organization: five technologies GmbH
Message-ID: <546a5723-a974-ed0a-93e3-b46c919b0f7e@fivetechno.de>
Date:   Mon, 20 Jan 2020 15:34:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <e05b6c1f-5e00-c000-23b9-1683230fd9f7@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;m.reichl@fivetechno.de;1579530846;c0431718;
X-HE-SMSGID: 1itY7v-0005Vi-Jo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

Am 20.01.20 um 15:21 schrieb Guenter Roeck:
> On 1/20/20 3:58 AM, Heikki Krogerus wrote:
>> Hi Markus,
>>
>> On Thu, Jan 09, 2020 at 05:29:07PM +0100, Markus Reichl wrote:
>>> Hi,
>>>
>>> I'm working with a ROC-RK3399-PC arm64 board from firefly, circuit sheet [1].
>>> The board is powered from an USB-C type connector via an FUSB302 PD controller.
>>> With measured 15W+ power consumption it should use higher voltage PD modes than
>>> the standard 5V USB-C mode.
>>>
>>> When I add the related connector node in DTS [2] the FUSB302 initializes
>>> the right PD mode (e.g. 15V/3A).
>>>
>>> But during initialisation the PD is switched off shortly and the board has a blackout.
>>> When I inject a backup supply voltage behind the FUSB302 (e.g. at SYS_12V line) during boot
>>> I can remove the backup after succesfull setting up the PD and the board will run fine.
>>>
>>> Is it possible to change the behaviour of the fusb302 driver to not power down the PD supply
>>> during init?
>>
>> I guess it's also possible that the problem is with tcpm.c instead of
>> fusb302.c. tcpm.c provides the USB PD state matchines. Guenter! Can
>> you take a look at this?
>>
> 
> There was always a problem with handoff from the bootloader. tcpm_init() calls
> tcpm_reset_port() which turns vbus and vconn off, which I imagine can
> trigger the situation.
> 
> Unfortunately I was never able to solve the puzzle. The Type-C protocol does
> not support any kind of "hand-off" from one component in the system to another.
> If the state machine doesn't start from a clean state, there is pretty
> much no guarantee that it ever synchronizes.
> 
> Maybe someone can find a better solution, but when I wrote the code I just
> could not get it to work reliably without resetting everything during
> registration.
> 
> Note that v4.4 did not include the upstream tcpm code, suggesting the
> code in the vendor kernel was possibly using a different or backported
> state machine. Impossible to say what was done there without access
> to the code.

The vendor code for fusb302 is here:
https://github.com/FireflyTeam/kernel/tree/rk3399/firefly/drivers/mfd

Gruß,
-- 
Markus Reichl
> 
> Guenter
> 
>> Both tcpm.c and fusb302.c create debugfs entries that have a more
>> detailed log about things that are happening. Can you check what you
>> have in those (when you boot with the mains cable plugged it)?
>>
>>          % mount debugfs -t debugfs /sys/kernel/debug
>>          % cat /sys/kernel/debug/tcpm*
>>          % cat /sys/kernel/debug/fusb302/*
>>
>> Which kernel are you running by the way?
>>
>>> In vendor kernel (4.4) this is done somehow but the sources are too different for me to find
>>> out how.
>>>
>>> Gruß,
>>> -- 
>>> Markus Reichl
>>>
>>> [1]
>>> http://download.t-firefly.com/product/RK3399/Docs/Hardware/%E5%8E%9F%E7%90%86%E5%9B%BE%E5%92%8C%E8%B4%B4%E7%89%87%E5%9B%BE/ROC-RK3399-PC/ROC-3399-PC-V10-A-20180804_%E5%8E%9F%E7%90%86%E5%9B%BE.pdf
>>>
>>> [2]
>>> https://lkml.org/lkml/2019/12/10/517
>>
> 
