Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9192CC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 22:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C40D22B4E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 22:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595283099;
	bh=mp7rqCoERPxKbSLsXNuvtXLRpOJK597vkiWFBuYTInI=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=NjkniBdE5HYl4Zrc9zGZtrkHqSTULEZmz0gEI1CpavAuKu8ZX5w+c4kCuvKXuwpu7
	 T1i+mehcA3kE99FEc99+xKPW7mZSGMct/N8pSXdPg2hOSI9aM6TNsYVN7OsKLkovOh
	 VTIbSzom+NcMiAeTw+gHoEdGqdRf9cfNMs1Jnyo0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbgGTWLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 18:11:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:35046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726021AbgGTWLh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 18:11:37 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2577720773;
        Mon, 20 Jul 2020 22:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595283097;
        bh=mp7rqCoERPxKbSLsXNuvtXLRpOJK597vkiWFBuYTInI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=NXl5R15rldenuSTEFUAn/sdxHNhTokqGAv2bj/X1vxxKbwQsUHXNgx2kMsCQtIgVj
         RelQDDEyDsUS0ANyRP9rdVI9DjBYeujQiIDIMXCjlSZEJSJO3mmAF68YUwHABwDpv+
         gkKwVte7wEHlreD/ZGxTuN3ebojffHr4LXEYoqko=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200719002830.20319-1-rdunlap@infradead.org>
References: <20200719002830.20319-1-rdunlap@infradead.org>
Subject: Re: [PATCH] clk: <linux/clk-provider.h>: drop a duplicated word
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Date:   Mon, 20 Jul 2020 15:11:36 -0700
Message-ID: <159528309635.1987609.2848027294515219304@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Randy Dunlap (2020-07-18 17:28:30)
> Drop the repeated word "not" in a comment.
>=20
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-clk@vger.kernel.org
> ---

Applied to clk-next
