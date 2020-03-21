Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AFC4C43333
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 00:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32F1920663
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 00:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584749987;
	bh=8xvBxIIQydZTAAeg1xjxOXL/CZLRUP+mS861uvfSts8=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=HLglxR4XvpbphSuwbhxwDFki+fCDbjgUQkAsFi94TZNOKR/lQYYzcTOlK6OixGCtO
	 NPfVTcJePbaaKK8ZxMGBHU/6yXLEEiOE92i/hDXau/KhOJ/s7YDIO3OwYEZmyHUt+G
	 a67QYkD8Q3um/6yIKolUE/0lneeBue7OgAfX3C98=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbgCUATq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 20:19:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:53736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727304AbgCUATq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 20:19:46 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A64120658;
        Sat, 21 Mar 2020 00:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584749985;
        bh=8xvBxIIQydZTAAeg1xjxOXL/CZLRUP+mS861uvfSts8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=R6F8yDLDdPfFPiBQs2JnncDBfQbNyp5l8iea78ARUFuKoWXQ6m/e9lrIUxcTWs+vj
         IWuBOa7leMCrekmsK8xj3KRHH8vJXY02u76jNSJikwkzz8w0YJSLHSQzRY7itZKSeu
         88XrbwfFKUFqFFgbY7/8tYfKOOkaFLPyFshrvdSM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200214145934.53648-1-alexandre.belloni@bootlin.com>
References: <20200214145934.53648-1-alexandre.belloni@bootlin.com>
Subject: Re: [PATCH] clk: at91: add at91rm9200 pmc driver
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Date:   Fri, 20 Mar 2020 17:19:44 -0700
Message-ID: <158474998460.125146.8220232566389840354@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alexandre Belloni (2020-02-14 06:59:33)
> Add a driver for the PMC clocks of the at91rm9200.
>=20
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---

Applied to clk-next

But please migrate to new way of specifying clk parents at some point.
