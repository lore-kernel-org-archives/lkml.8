Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A73C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 19:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CB1E2065C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 19:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589486210;
	bh=UPMu/ze+3YW1sf/pHTTM8hVo0CvruuE9rdxfoWDOzvc=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=vZTDOX+cbn9hVPqFs6cNP8psJK54sH+y8QhkXF87XaBBMHZHSoVzFpx4jfWrxRNJ4
	 ANF2y3tzBj41oZHBTcH0WK49b91LJSDCzltluDYPayyazOr90fitcVc2ut0cEmrEMV
	 RRCDBin8nS0c7jiyHLgiHuPIefHEhyQf/hS5yAGM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728773AbgENT4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 15:56:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:48236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727117AbgENT4r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 15:56:47 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 568FA2065D;
        Thu, 14 May 2020 19:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589486207;
        bh=UPMu/ze+3YW1sf/pHTTM8hVo0CvruuE9rdxfoWDOzvc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=S3xJXmM8CAmGpqJmbsSeTpDBkk4fLch1ucBrobCY5jUXmTy1ozdU3ETrqNZvtDgoL
         OPYc2iIwRvLIF8EdAOgTL5ypPjP9j5b1Tsn3dNZOIin7n4T2fOfP8Jcj94XheXrJoK
         qhEq6S8RJF5PEPU3WY6kKWblodTBLSFKnvcJJVG8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200409064416.83340-5-sboyd@kernel.org>
References: <20200409064416.83340-1-sboyd@kernel.org> <20200409064416.83340-5-sboyd@kernel.org>
Subject: Re: [PATCH v2 04/10] h8300: Remove redundant CLKDEV_LOOKUP selects
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        uclinux-h8-devel@lists.sourceforge.jp,
        Arnd Bergmann <arnd@arndb.de>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Date:   Thu, 14 May 2020 12:56:46 -0700
Message-ID: <158948620650.215346.8397958112058519634@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2020-04-08 23:44:10)
> The h8300 architecture selects COMMON_CLK already, and the COMMON_CLK
> config option already selects CLKDEV_LOOKUP so it's redundant to have
> this selected again.
>=20
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: uclinux-h8-devel@lists.sourceforge.jp
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next
