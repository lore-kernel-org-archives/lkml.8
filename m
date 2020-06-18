Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FCC3C433E5
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 15:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B30920732
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 15:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbgFRPwx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 11:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727911AbgFRPwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 11:52:53 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0067C06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 08:52:52 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=localhost)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1jlwqR-00064n-GH; Thu, 18 Jun 2020 17:52:51 +0200
Message-ID: <4b717455032b5409754dffb71acc82c5fc0fc755.camel@pengutronix.de>
Subject: Re: [RESEND PATCH v2 0/4] drm/etnaviv: Tidy up clocks handling
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     linux-kernel@vger.kernel.org,
        Christian Geiner <christian.gmeiner@gmail.com>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        dri-devel@lists.freedesktop.org, etnaviv@lists.freedesktop.org
Date:   Thu, 18 Jun 2020 17:52:50 +0200
In-Reply-To: <20200616212127.986410-1-lkundrak@v3.sk>
References: <20200616212127.986410-1-lkundrak@v3.sk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, den 16.06.2020, 23:21 +0200 schrieb Lubomir Rintel:
> Hi,
> 
> please consider applying patches that are chained to this message.

Thanks, I've applied all of them to etnaviv/next.

Regards,
Lucas

> They make getting/enabling the clocks in the etnaviv driver slightly nicer,
> first two also fix potential problems.
> 
> Compared to v1, patch 2/4 was fixed and patch 3/4 was added.
> 
> As it was pointed out in response to v1, the clocks documented as
> mandatory by the binding document are different from what the driver
> enforces. Moreover, there is no agreement on which clocks must be
> present in the device tree, so I'm leaving the binding document until
> it's cleared up.
> 
> In any case, the "core" clock is always present so it's safe to make it
> mandatory and regardless of what ends up happening to the binding
> documentation, the other clocks can't be enforced without regressions.
> At most a comment or a warning could be added. I'm leaving it as it is.
> 
> Thank you
> Lubo
> 
> 
> _______________________________________________
> etnaviv mailing list
> etnaviv@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/etnaviv

