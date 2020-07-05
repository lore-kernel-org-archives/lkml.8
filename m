Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA89C433E1
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 22:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCE0E20C56
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 22:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbgGEWJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 18:09:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:44718 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727894AbgGEWJl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 18:09:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EDD5DAF33;
        Sun,  5 Jul 2020 22:09:39 +0000 (UTC)
Subject: Re: [PATCH v1] arm64: dts: actions: Fix smp Bringing up secondary
 CPUs
To:     Matheus Castello <matheus@castello.eng.br>
Cc:     manivannan.sadhasivam@linaro.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-actions@lists.infradead.org
References: <20200705191944.404933-1-matheus@castello.eng.br>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Software Solutions Germany GmbH
Message-ID: <60c25ef8-761d-9108-a8b1-ea15678c496c@suse.de>
Date:   Mon, 6 Jul 2020 00:09:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200705191944.404933-1-matheus@castello.eng.br>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matheus,

Am 05.07.20 um 21:19 schrieb Matheus Castello:
> Change the enable-method to fix the failed to boot errors:
> 
> [    0.040330] smp: Bringing up secondary CPUs ...
> [    0.040683] psci: failed to boot CPU1 (-22)
> [    0.040691] CPU1: failed to boot: -22
> [    0.041062] psci: failed to boot CPU2 (-22)
> [    0.041071] CPU2: failed to boot: -22
> [    0.041408] psci: failed to boot CPU3 (-22)
> [    0.041417] CPU3: failed to boot: -22
> [    0.041443] smp: Brought up 1 node, 1 CPU
> [    0.041451] SMP: Total of 1 processors activated.
> 
> Tested on Caninos Labrador v3 based on Actions Semi S700.
> 
> Signed-off-by: Matheus Castello <matheus@castello.eng.br>
> ---
>   arch/arm64/boot/dts/actions/s700.dtsi | 33 +++++++++++++++++++--------
>   1 file changed, 23 insertions(+), 10 deletions(-)

NACK.

For starters, if this were an actual fix, it should have a Fixes header.

Don't do random changes in a single patch and call it a "fix". I don't 
see what changing the cell size has to do with smp, nor adding L2 cache. 
The latter could be a patch of its own, after fixes are applied (to 
avoid conflicts when backporting that fix to older branches). A cell 
size of two used to be perfectly valid, please checking the DT binding.

Finally, you're changing generic S700 code here - you can't just break 
Cubieboard7 just because your Labrador has too old BL31 firmware. Can't 
you just update its TF-A firmware and use the standard PSCI interface 
for Linux? If not, then you should add your workaround to your 
module's/board's .dts(i) instead of the SoC's .dtsi.

Thanks,
Andreas

-- 
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer
HRB 36809 (AG Nürnberg)
