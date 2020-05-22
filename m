Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A9F5C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 21:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7951820679
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 21:36:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731150AbgEVVg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 17:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731033AbgEVVg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 17:36:58 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51BF3C061A0E;
        Fri, 22 May 2020 14:36:58 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D6961127298FB;
        Fri, 22 May 2020 14:36:56 -0700 (PDT)
Date:   Fri, 22 May 2020 14:36:56 -0700 (PDT)
Message-Id: <20200522.143656.1986528672037093503.davem@davemloft.net>
To:     matthias.bgg@gmail.com
Cc:     brgl@bgdev.pl, robh+dt@kernel.org, john@phrozen.org,
        sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com, kuba@kernel.org,
        arnd@arndb.de, fparent@baylibre.com, hkallweit1@gmail.com,
        edwin.peer@broadcom.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        stephane.leprovost@mediatek.com, pedro.tsai@mediatek.com,
        andrew.perepech@mediatek.com, bgolaszewski@baylibre.com
Subject: Re: [PATCH v5 00/11] mediatek: add support for MediaTek Ethernet
 MAC
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1f941213-7ca2-c138-3530-85c34ebf0d53@gmail.com>
References: <20200522120700.838-1-brgl@bgdev.pl>
        <20200522.142031.1631406151370247419.davem@davemloft.net>
        <1f941213-7ca2-c138-3530-85c34ebf0d53@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 22 May 2020 14:36:57 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Brugger <matthias.bgg@gmail.com>
Date: Fri, 22 May 2020 23:31:50 +0200

> 
> 
> On 22/05/2020 23:20, David Miller wrote:
>> From: Bartosz Golaszewski <brgl@bgdev.pl>
>> Date: Fri, 22 May 2020 14:06:49 +0200
>> 
>>> This series adds support for the STAR Ethernet Controller present on MediaTeK
>>> SoCs from the MT8* family.
>> 
>> Series applied to net-next, thank you.
>> 
> 
> If you say "series applied" do you mean you also applied the device tree parts?
> These should go through my branch, because there could be conflicts if there are
> other device tree patches from other series, not related with network, touching
> the same files.

It's starting to get rediculous and tedious to manage the DT changes
when they are tied to new networking drivers and such.

And in any event, it is the patch series submitter's responsibility to
sort these issues out, separate the patches based upon target tree, and
clearly indicate this in the introductory posting and Subject lines.
