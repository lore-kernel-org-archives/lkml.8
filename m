Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07726C1975A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 22:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C574B20722
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 22:05:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbgCVWFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 18:05:01 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:57515 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbgCVWFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 18:05:01 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jG8i0-00007B-Ur; Sun, 22 Mar 2020 23:04:40 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jG8hy-00076s-Hl; Sun, 22 Mar 2020 23:04:38 +0100
Date:   Sun, 22 Mar 2020 23:04:38 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Nicholas Krause <xerofoify@gmail.com>,
        Duan Jiong <duanj.fnst@cn.fujitsu.com>,
        Sachin Kamat <sachin.kamat@linaro.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] err.h: remove deprecated PTR_RET for good
Message-ID: <20200322220438.2phluryjzno777w2@pengutronix.de>
References: <20200322165702.6712-1-lukas.bulwahn@gmail.com>
 <nycvar.YFH.7.76.2003222240500.19500@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.YFH.7.76.2003222240500.19500@cbobk.fhfr.pm>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 22, 2020 at 10:42:56PM +0100, Jiri Kosina wrote:
> On Sun, 22 Mar 2020, Lukas Bulwahn wrote:
> 
> > Initially, commit fa9ee9c4b988 ("include/linux/err.h: add a function to
> > cast error-pointers to a return value") from Uwe Kleine-König introduced
> > PTR_RET in 03/2011. Then, in 07/2013, commit 6e8b8726ad50 ("PTR_RET is
> > now PTR_ERR_OR_ZERO") from Rusty Russell renamed PTR_RET to
> > PTR_ERR_OR_ZERO, and left PTR_RET as deprecated-marked alias.
> > 
> > After six years since the renaming and various repeated cleanups in the
> > meantime, it is time to finally remove the deprecated PTR_RET for good.
> > 
> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > ---
> > Rusty, if you are still around, Acked-by is appreciated.
> > Uwe, Acked-by is appreciated.
> > Kudos to Gustavo, Nicholas, Duan & Sachin for previous cleanups.
> > 
> > applies cleanly on current master and on next-20200320
> > Jiri, please pick this trival patch for the next merge window. Thanks.
> 
> I am queuing it right away; it's been marked deprecated back in 2013, and 
> it doesn't have any in-tree users anyway.

Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

in case it's not in a tree already that is not supposed to be changed
any more.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
