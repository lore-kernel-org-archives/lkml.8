Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10922C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 19:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5AA3206D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 19:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589486272;
	bh=g05tfB9G4p9SFqp+K3wpztWoaWX3/kKj1dAoMgYrlxc=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=OPqCjmLG53yUj7tbLf7M6Q769lBl3FoJYYLIsZF3BV5HNuSYjDfl2YCkJYfrKmKPX
	 QWulodOQfME+KhrqZu44cHwPLXYPVi0qcOoq0LO7B1uN121FVQnudnBymZQfyHlRYT
	 zDAWuIi3oV2kXithGm0d8kMzKzAGy9SPNrKn0QEI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbgENT5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 15:57:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:49102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727117AbgENT5v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 15:57:51 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B0072065C;
        Thu, 14 May 2020 19:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589486271;
        bh=g05tfB9G4p9SFqp+K3wpztWoaWX3/kKj1dAoMgYrlxc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=0F3fEf2vwBEHwgFk4sb03BOWEuKMY8Xl+Gh1gv9oAoSOs1qOGir58zxujvPKM8EJd
         XfXdyI6LjqagJ0dtbFpIQ+CuHqkEPVjnPW04qLVuqDPAPbHaWV2WY0Dd/4pqyvYKQN
         D1kUEQEcW0XPjw94ZSFj29F5FzLFJo/xp0GA9lZw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200409064416.83340-11-sboyd@kernel.org>
References: <20200409064416.83340-1-sboyd@kernel.org> <20200409064416.83340-11-sboyd@kernel.org>
Subject: Re: [PATCH v2 10/10] clk: Move HAVE_CLK config out of architecture layer
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Date:   Thu, 14 May 2020 12:57:50 -0700
Message-ID: <158948627064.215346.9493279707055125868@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2020-04-08 23:44:16)
> The implementation of 'struct clk' is not really an architectual detail
> anymore now that most architectures have migrated to the common clk
> framework. To sway new architecture ports away from trying to implement
> their own 'struct clk', move the config next to the common clk framework
> config.
>=20
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next
