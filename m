Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7DE8C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 19:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B43F12065C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 19:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589486214;
	bh=QinRF7lFuzXkqKYYMRSqHylif3Ajb8axCX27KSPLc5E=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=g+kFaLlEuyKUU4/QcJIeFpnIL4/jpMNq6+uRA0ec4Rh5d6l/sCNDbUt3c5U5+lezs
	 bijLHHUPgp0isAJt/c27Cqv0dh2QVUQNttSnfzDUa8+lGt/4xZileNsiey2S3sVte8
	 RzXhzMdnFJsm/WlxI6JIjNfy4qeF5aZILC9Fjnxc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbgENT4x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 15:56:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:48332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727117AbgENT4w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 15:56:52 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 833172065C;
        Thu, 14 May 2020 19:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589486211;
        bh=QinRF7lFuzXkqKYYMRSqHylif3Ajb8axCX27KSPLc5E=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=XDB0THWlVg4HbJAqhb6PEy9tUYdBUS+mSlOLIZYkxztc+MMsw/pvtBDF1l0JTRuXg
         gFxwJ5+9sM4Y0SJmL3nsQ8tKURhOEBckF05q1+PoKYIMK7ursBmgzAyyTzVK5FDQUw
         19lCuslv+GSiRpeQKDJjCxMPQMz+TrQj83maoQHk=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200409064416.83340-6-sboyd@kernel.org>
References: <20200409064416.83340-1-sboyd@kernel.org> <20200409064416.83340-6-sboyd@kernel.org>
Subject: Re: [PATCH v2 05/10] MIPS: Remove redundant CLKDEV_LOOKUP selects
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Date:   Thu, 14 May 2020 12:56:50 -0700
Message-ID: <158948621086.215346.8453818467277535567@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2020-04-08 23:44:11)
> The ATH79 config selects COMMON_CLK already, and the COMMON_CLK config
> option already selects CLKDEV_LOOKUP, and CLKDEV_LOOKUP already selects
> HAVE_CLK so it's redundant to have these selected again.
>=20
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: <linux-mips@vger.kernel.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next
