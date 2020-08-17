Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8485EC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 12:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 632D52072D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 12:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597668244;
	bh=jVzU+QI/ys+RIOWMYaLR4j+zEZXuCKR6ULaqdtkwbiM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=zdLLE0VNXIHZfew4VyDW9p51xKT2MKaeBZ7Du0otNDKydVbY1q2b1Y5Wot//zsryH
	 jm2TrA1/berL5DrPOhkJHJFccREeRKjQy7s2ZmKu6cwrk+dJR9SCGqinxeTQvBQt8j
	 Ec7kLA7WP9lG4NxUpwCurTvUjuzRs9hnUKOYr6QM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728504AbgHQMoD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 08:44:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:57388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728464AbgHQMnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 08:43:49 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FE342072D;
        Mon, 17 Aug 2020 12:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597668228;
        bh=jVzU+QI/ys+RIOWMYaLR4j+zEZXuCKR6ULaqdtkwbiM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NRz/bP0lJDXOQpw3C0MOSAVz/meHd71Q/Bj/trpsWtNq3haGujLAVHpSZWOiroKYE
         3d/XHZeBjT/9FFL6y6+gMRAof/ypmIDKfv1aKzYZ13yBOlmrDo70HwCa0Y52DRwWmI
         nMLyA7zFyko0EJlsoSemO/W4+bQtbiXsRD+PrZ7w=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1k7eUL-003ZBx-P4; Mon, 17 Aug 2020 13:43:45 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 17 Aug 2020 13:43:45 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     Hanks Chen <hanks.chen@mediatek.com>,
        Saravana Kannan <saravanak@google.com>,
        kernelci-results@groups.io, Jason Cooper <jason@lakedaemon.net>,
        kernel@collabora.com, linux-arm-kernel@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: Re: mainline/master bisection: baseline.login on mt8173-elm-hana
In-Reply-To: <e1e21bc9-75a8-e0f7-7b87-57b147962115@collabora.com>
References: <5f391c17.1c69fb81.ef475.be70@mx.google.com>
 <e1e21bc9-75a8-e0f7-7b87-57b147962115@collabora.com>
User-Agent: Roundcube Webmail/1.4.7
Message-ID: <d9b04fa244fb2b3e4db64e6b833bcdb6@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: guillaume.tucker@collabora.com, hanks.chen@mediatek.com, saravanak@google.com, kernelci-results@groups.io, jason@lakedaemon.net, kernel@collabora.com, linux-arm-kernel@lists.infradead.org, tglx@linutronix.de, matthias.bgg@gmail.com, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, enric.balletbo@collabora.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-17 11:20, Guillaume Tucker wrote:
> Please see the bisection report below about a boot failure.
> 
> Reports aren't automatically sent to the public while we're
> trialing new bisection features on kernelci.org but this one
> looks valid.
> 
> The log doesn't appear to be showing anything from the kernel, so
> it's likely to be crashing very early.  Please let us know if you
> need some help with investigating this issue, to try booting with
> earlyprintk or anything.
> 
> Hope this helps.
> 
> Thanks,
> Guillaume
> 
> On 16/08/2020 12:44, KernelCI bot wrote:
>> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
>> * This automated bisection report was sent to you on the basis  *
>> * that you may be involved with the breaking commit it has      *
>> * found.  No manual investigation has been done to verify it,   *
>> * and the root cause of the problem may be somewhere else.      *
>> *                                                               *
>> * If you do send a fix, please include this trailer:            *
>> *   Reported-by: "kernelci.org bot" <bot@kernelci.org>          *
>> *                                                               *
>> * Hope this helps!                                              *
>> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
>> 
>> mainline/master bisection: baseline.login on mt8173-elm-hana
>> 
>> Summary:
>>   Start:      a1d21081a60d Merge 
>> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
>>   Plain log:  
>> https://storage.kernelci.org/mainline/master/v5.8-13249-ga1d21081a60d/arm64/defconfig+CONFIG_RANDOMIZE_BASE=y/gcc-8/lab-collabora/baseline-mt8173-elm-hana.txt
>>   HTML log:   
>> https://storage.kernelci.org/mainline/master/v5.8-13249-ga1d21081a60d/arm64/defconfig+CONFIG_RANDOMIZE_BASE=y/gcc-8/lab-collabora/baseline-mt8173-elm-hana.html
>>   Result:     f97dbf48ca43 irqchip/mtk-sysirq: Convert to a platform 
>> driver

Please have a go at this[1] patch, which should solve the issue.

Thanks,

         M.

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/commit/?h=irq/irqchip-next&id=7828a3ef8646fb2e69ed45616c8453a037ca7867
-- 
Jazz is not dead. It just smells funny...
