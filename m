Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_RHS_DOB
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D710C3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 11:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1E3124672
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 11:14:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbgAULO3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 06:14:29 -0500
Received: from mx.blih.net ([212.83.155.74]:43013 "EHLO mx.blih.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727255AbgAULO3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 06:14:29 -0500
X-Greylist: delayed 398 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 Jan 2020 06:14:27 EST
Received: from tails (ip-9.net-89-3-105.rev.numericable.fr [89.3.105.9])
        by mx.blih.net (OpenSMTPD) with ESMTPSA id 228fe892 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 21 Jan 2020 11:07:47 +0000 (UTC)
Date:   Tue, 21 Jan 2020 12:07:49 +0100
From:   Emmanuel Vadot <manu@bidouilliste.net>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Emmanuel Vadot <manu@freebsd.org>, wens@csie.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: allwinner: a64: Add gpio bank supply for
 A64-Olinuxino
Message-Id: <20200121120749.4ee4d0e23a289c52462c1f2d@bidouilliste.net>
In-Reply-To: <20200121091026.qfj2fv47f24wt2tp@gilmour.lan>
References: <20200118152459.17199-1-manu@FreeBSD.Org>
        <20200121091026.qfj2fv47f24wt2tp@gilmour.lan>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; amd64-portbld-freebsd13.0)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jan 2020 10:10:26 +0100
Maxime Ripard <mripard@kernel.org> wrote:

> Hi,
> 
> On Sat, Jan 18, 2020 at 04:24:59PM +0100, Emmanuel Vadot wrote:
> > From: Emmanuel Vadot <manu@freebsd.org>
> >
> > Add the regulators for each bank on this boards.
> > For VCC-PL only add a comment on what regulator is used. We cannot add
> > the property without causing a circular dependency as the PL pins are
> > used to talk to the PMIC.
> >
> > Signed-off-by: Emmanuel Vadot <manu@freebsd.org>
> 
> It seems that you sent it twice?

 Yes sorry mail server hickups.

> I applied the second. It was not applying properly though, make sure
> to base your patches on next.

 Ah right, sorry again, I've used master, will use next the next time.
 Thanks.

> Maxime


-- 
Emmanuel Vadot <manu@bidouilliste.com>
