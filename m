Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4419C54FCE
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 08:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC05B2072E
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 08:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbgCWIXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 04:23:03 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:45783 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727522AbgCWIXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 04:23:03 -0400
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1jGIMM-000414-26; Mon, 23 Mar 2020 09:22:58 +0100
Subject: Re: [PATCH] ARM: imx: build v7_cpu_resume() unconditionally
To:     Sasha Levin <sashal@kernel.org>
Cc:     festevam@gmail.com, s.hauer@pengutronix.de,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rouven Czerwinski <r.czerwinski@pengutronix.de>,
        shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org,
        Lucas Stach <l.stach@pengutronix.de>,
        Clemens Gruber <clemens.gruber@pqgruber.com>
References: <20200116141849.73955-1-r.czerwinski@pengutronix.de>
 <20200322185022.GA82867@workstation.tuxnet> <20200322202224.GQ4189@sasha-vm>
 <20200322230951.GA75142@workstation.tuxnet>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <f04cefeb-b94a-4c2a-7a3d-04db80d35934@pengutronix.de>
Date:   Mon, 23 Mar 2020 09:22:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200322230951.GA75142@workstation.tuxnet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Clemens

On 3/23/20 12:09 AM, Clemens Gruber wrote:
>> Is this a problem with Linus's tree as well?
> 
> Yes, it affects Linus's tree and linux-stable.
> 
> Reverting 512a928aff in mainline (7199cb65bb in linux-stable) fixes the
> build error for us.

Thanks for the report and sorry for the inconvenience.
I just sent out a patch[1] to fix the linker error.

[1]: https://lore.kernel.org/linux-arm-kernel/20200323081933.31497-1-a.fatoum@pengutronix.de/T/#u

Cheers
Ahmad

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
