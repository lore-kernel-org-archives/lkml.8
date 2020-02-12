Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B60C9C3B187
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 23:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8493521734
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 23:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581550100;
	bh=mXmnHtVqBOZrVWtG0TaUlp+Khm0aInlASRcgsp7T02I=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=QvqA1CPDK00AZA9yN9ai/IKro9BIIeheVBY0/5j95ATPmBW4uFbwjWLb8Mx07WBGk
	 77AE9b1xalhP7CXLs50OywgsQPjgRKDlC2B8JqoBqWC8So4TYXxgb0jbKPejZBItkC
	 s+Kk+/0TXLec7WFPKwvaNiyWUlOHAnXI2sHllBDM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729329AbgBLX2U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 18:28:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:42322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727117AbgBLX2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 18:28:19 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCD6820848;
        Wed, 12 Feb 2020 23:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581550099;
        bh=mXmnHtVqBOZrVWtG0TaUlp+Khm0aInlASRcgsp7T02I=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=UyEO+8CWMTrYWOPdZVbl8dI8sUdSJmmBqKS+7DcaGfF1/iyPvLkprB90vX5sAnbV8
         oNc2ZWdk3BrpE0eJJCVMdfEGut3aDcE/MlhVVY3zLcnJFtDJFwZTkcSGfWb+dfnLuC
         tJBck1M/Uh+tWeKCfOc3Y1ogmHv7ZmgaeDiD4oks=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200205232802.29184-4-sboyd@kernel.org>
References: <20200205232802.29184-1-sboyd@kernel.org> <20200205232802.29184-4-sboyd@kernel.org>
Subject: Re: [PATCH v2 3/4] clk: Move rate and accuracy recalc to mostly consumer APIs
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jerome Brunet <jbrunet@baylibre.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Date:   Wed, 12 Feb 2020 15:28:18 -0800
Message-ID: <158155009817.184098.11949016504276688949@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2020-02-05 15:28:01)
> There's some confusion about when recalc is done for the rate and
> accuracy clk consumer APIs in relation to the prepare lock being taken.
> Oddly enough, we take the lock again in debugfs APIs so that we can call
> the internal "clk_core" APIs to get these fields with any necessary
> recalculations. Instead of having this confusion, let's introduce a
> recalc variant of these two consumer APIs as internal helpers and call
> them from the consumer APIs and the debugfs code so that we don't take
> the lock more than once.
>=20
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next
