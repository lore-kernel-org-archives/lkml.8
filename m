Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00917C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 16:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1A4C2464B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 16:17:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbgCIQRn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 12:17:43 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:45555 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbgCIQRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 12:17:43 -0400
X-Originating-IP: 90.66.181.224
Received: from localhost (lfbn-lyo-1-2013-224.w90-66.abo.wanadoo.fr [90.66.181.224])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 8E91A1BF216;
        Mon,  9 Mar 2020 16:17:40 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     afzal mohammed <afzal.mohd.ma@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ARM: orion: replace setup_irq() by request_irq()
In-Reply-To: <20200308143755.GC6903@afzalpc>
References: <20200301122330.4296-1-afzal.mohd.ma@gmail.com> <20200301154435.GJ6305@lunn.ch> <20200308143755.GC6903@afzalpc>
Date:   Mon, 09 Mar 2020 17:17:40 +0100
Message-ID: <87mu8ppknv.fsf@FE-laptop>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello afzal mohammed,

> Hi Andrew, Jason, Sebastian, Gregory,
>
> Please let me know the way upstream for this patch

I am taking care of it.

Gregory

>
> On Sun, Mar 01, 2020 at 04:44:35PM +0100, Andrew Lunn wrote:
>
>> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>
> Thanks Andrew
>
> Regards
> afzal

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
