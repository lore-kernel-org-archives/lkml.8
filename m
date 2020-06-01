Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 026A0C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 10:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD8F220679
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 10:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbgFAKxg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 06:53:36 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:43350 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbgFAKxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 06:53:35 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 49bBqJ207Wz1qrLx;
        Mon,  1 Jun 2020 12:53:32 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 49bBqJ14fyz1shfN;
        Mon,  1 Jun 2020 12:53:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id aFtZFDiMJmbA; Mon,  1 Jun 2020 12:53:30 +0200 (CEST)
X-Auth-Info: l/oYRMv7y9pqOSx5W6Sqvo4l2JQ1usSr0rxpE0x1BuE=
Received: from [127.0.0.1] (unknown [195.140.253.167])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon,  1 Jun 2020 12:53:30 +0200 (CEST)
Subject: Re: [PATCH v3 0/2] usb: xhci: Load Raspberry Pi 4 VL805's firmware
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, mbrugger@suse.com,
        u-boot@lists.denx.de, bmeng.cn@gmail.com,
        linux-kernel@vger.kernel.org
Cc:     sjg@chromium.org, m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        mark.kettenis@xs4all.nl
References: <20200505162607.334-1-nsaenzjulienne@suse.de>
 <2a8f0190c9d418cee89451c7dc3a227b9d0b5f45.camel@suse.de>
From:   Marek Vasut <marex@denx.de>
Message-ID: <bf73b73e-c251-7ac8-c245-a3b3d2be2420@denx.de>
Date:   Mon, 1 Jun 2020 12:53:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <2a8f0190c9d418cee89451c7dc3a227b9d0b5f45.camel@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/20 12:47 PM, Nicolas Saenz Julienne wrote:
> On Tue, 2020-05-05 at 18:26 +0200, Nicolas Saenz Julienne wrote:
>> Newer revisions of the RPi4 need their xHCI chip, VL805, firmware to be
>> loaded explicitly. Earlier versions didn't need that as they where using
>> an EEPROM for that purpose. This series takes care of setting up the
>> relevant infrastructure and run the firmware loading routine at the
>> right moment.
>>
>> Note that this builds on top of Sylwester Nawrocki's "USB host support
>> for Raspberry Pi 4 board" series.
>>
>> ---
> 
> Please don't forget about this series. The new 8GB RPi4 contains this HW design
> change and USB will not work without it. See this discussion on the downstream
> kernel github, where other OS/bootloaders are hitting the issue:
> 
> https://github.com/raspberrypi/firmware/issues/1402
> 
> Otherwise, the Linux version of this is already in linux-next:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/usb/host/pci-quirks.c?h=next-20200529&id=c65822fef4adc0ba40c37a47337376ce75f7a7bc

We're already at 2020.07-rc3 , so unless this is a bugfix (does not look
that way), this will have to wait for next release cycle. Also, it seems
there was a lengthy ongoing discussion, is that already sorted out ?
