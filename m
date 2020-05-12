Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F481C2D0F7
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 19:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DAAB20731
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 19:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730976AbgELTat (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 15:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgELTat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 15:30:49 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C616C061A0C;
        Tue, 12 May 2020 12:30:49 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477:9e51:a893:b0fe:602a])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 8452F128325B0;
        Tue, 12 May 2020 12:30:47 -0700 (PDT)
Date:   Tue, 12 May 2020 12:30:46 -0700 (PDT)
Message-Id: <20200512.123046.2245363690581586050.davem@davemloft.net>
To:     brgl@bgdev.pl
Cc:     robh+dt@kernel.org, matthias.bgg@gmail.com, john@phrozen.org,
        sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com, kuba@kernel.org,
        arnd@arndb.de, fparent@baylibre.com, hkallweit1@gmail.com,
        edwin.peer@broadcom.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        stephane.leprovost@mediatek.com, pedro.tsai@mediatek.com,
        andrew.perepech@mediatek.com, bgolaszewski@baylibre.com
Subject: Re: [PATCH v2 05/14] net: core: provide priv_to_netdev()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <CAMRc=MdUCkgCo8UndDbhQRZt_tXJJjtR4uM2g05N5ti7Hw1f2w@mail.gmail.com>
References: <20200511150759.18766-6-brgl@bgdev.pl>
        <20200511.134117.1336222619714836904.davem@davemloft.net>
        <CAMRc=MdUCkgCo8UndDbhQRZt_tXJJjtR4uM2g05N5ti7Hw1f2w@mail.gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 12 May 2020 12:30:48 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 12 May 2020 08:04:39 +0200

> I will if you insist but would you mind sharing some details on why it
> was removed? To me it still makes more sense than storing the pointer
> to a structure in *that* structure.

Flexibility in implementation of where the private data is located
and how it is allocated.

And yes, I do insist.
