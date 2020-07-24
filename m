Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5787C433EB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 09:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2676206EB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 09:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595583738;
	bh=V7A/o5n/thHVR0Jh3cVEK8asYmqpjL8PQcpFEQZrDJw=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=szAiJpQEHGKyM+tvpoRUyF0O9b55E/VKUBDAg6W2mvEwgbUTIFBlnRzwUSrSsNav0
	 GxJdKfr3Row8NtLWZucZ+zoFUKOLrYsGO87NY4w4lzSpbRIpNoB4sx3RFV2QQMi+p6
	 k02PSTOqY2+09aCau7c29BYZqILeM044EilT13J0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbgGXJmR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 05:42:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:34508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbgGXJmQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 05:42:16 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 958B2206EB;
        Fri, 24 Jul 2020 09:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595583736;
        bh=V7A/o5n/thHVR0Jh3cVEK8asYmqpjL8PQcpFEQZrDJw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=l83FDPV3GP4crX+jcN6gz3lN/Vmt6HULL8BdUEBvyU8Cg9PJtwMvvN+nw2Ikp6Plj
         fK/p1oE3Y8Bv6AwZhMQjyeSYGVUby8HV6+DavBE7Y7JR+Ff3v5KNvcu1LQnGj0hiAj
         1B36cpGm98Uv108prFAVgy+1ytsjLC8EKWkWN+ho=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200724094025.3261266-1-sboyd@kernel.org>
References: <20200724094025.3261266-1-sboyd@kernel.org>
Subject: Re: [PATCH] clk: qcom: Export gdsc_gx_do_nothing_enable() to modules
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Jonathan Marek <jonathan@marek.ca>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Date:   Fri, 24 Jul 2020 02:42:15 -0700
Message-ID: <159558373591.3847286.1121200734518245635@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2020-07-24 02:40:25)
> A clk driver can be a module but the gdsc code is in the common module.
> Export this symbol so that allmodconfig builds keep working.
>=20
> Cc: Jonathan Marek <jonathan@marek.ca>
> Fixes: 0638226dd095 ("clk: qcom: add common gdsc_gx_do_nothing_enable for=
 gpucc drivers")
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next
