Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A027C433EB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 09:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09F8620674
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 09:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595582516;
	bh=R4V1Rm3SHViFKAS2vijMF0PFdgMWSfa6cf9wKhmga2w=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=EAYRCR90EXsui17zFsdw+BmyT9TMoUZ+1bmR8u7o4wKCBOJXMUUCw31mprmCkgrZM
	 H6t3L4XE/fxQ0d+9HarFeDZqbr4zMiw8WgWiAn/YOSCJ5yBQ9rGU/BE8eK58IdoIfU
	 ANEPEVuHskHhkIlDrud82XsI2lShJ/je63KqcFAE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbgGXJVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 05:21:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:52236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726591AbgGXJVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 05:21:53 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7249A20767;
        Fri, 24 Jul 2020 09:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595582513;
        bh=R4V1Rm3SHViFKAS2vijMF0PFdgMWSfa6cf9wKhmga2w=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=IgzwN9z5ezMtOm+M+CqxRTHBHV8FZ0jzXGV0PAk0GAJGLaxBtHA8rkboa8L/G78IR
         VWzhpJDlxYt4lr+BBu8Jz9K+oGXeJC8dgW1II52vm/OugfNA6arUF6E1nD2tGKaa+K
         WF31w7CvmwgkQaVj18NQMDIES6/EVH4gg7AJ7Zqo=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1595403506-8209-15-git-send-email-claudiu.beznea@microchip.com>
References: <1595403506-8209-1-git-send-email-claudiu.beznea@microchip.com> <1595403506-8209-15-git-send-email-claudiu.beznea@microchip.com>
Subject: Re: [PATCH v2 14/18] clk: at91: clk-programmable: add mux_table option
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     bbrezillon@kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com,
        mturquette@baylibre.com, nicolas.ferre@microchip.com
Date:   Fri, 24 Jul 2020 02:21:52 -0700
Message-ID: <159558251281.3847286.12799327541994035061@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Claudiu Beznea (2020-07-22 00:38:22)
> Add mux table option. This is necessary for IP versions that has
> gaps in the range of available clock sources (e.g. SAMA7G5).
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---

Applied to clk-next
