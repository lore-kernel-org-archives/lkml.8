Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E161C433F7
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34C1522CAE
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728621AbgHFGmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 02:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728583AbgHFGmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 02:42:06 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13330C061575
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 23:42:06 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=localhost)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <r.czerwinski@pengutronix.de>)
        id 1k3Zb9-0008CH-Qt; Thu, 06 Aug 2020 08:41:55 +0200
Message-ID: <f27d55ee29ad1f78e5ad47e3c63b6021d6df6895.camel@pengutronix.de>
Subject: Re: [PATCH 1/2] net: tls: add compat for get/setsockopt
From:   Rouven Czerwinski <r.czerwinski@pengutronix.de>
To:     David Miller <davem@davemloft.net>
Cc:     borisp@mellanox.com, aviadye@mellanox.com,
        john.fastabend@gmail.com, daniel@iogearbox.net, kuba@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 06 Aug 2020 08:41:50 +0200
In-Reply-To: <20200805.174546.1898874545402901800.davem@davemloft.net>
References: <20200805122501.4856-1-r.czerwinski@pengutronix.de>
         <20200805.174546.1898874545402901800.davem@davemloft.net>
Organization: Pengutronix e.K.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: r.czerwinski@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-08-05 at 17:45 -0700, David Miller wrote:
> Neither of these patches apply cleanly to net-next.  The compat handling
> and TLS code has been changed quite a bit lately.

Indeed, Patch 1 is no longer required on net-next. I'll drop the patch.

> ALso, you must provide a proper header "[PATCH 0/N] ..." posting for your
> patch series which explains at a high level what your patch series is doing,
> how it is doing it, and why it is doing it that way.

Since I'm now down to one patch I'll forgo the cover letter and expand
the commit message.

Thanks for the explanation,
Rouven

