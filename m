Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7579C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 06:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C59BE20787
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 06:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590561699;
	bh=aV8A8sLjaDOj/7AanTn0RtlrOOIqsNKRPjRHYtq5vE0=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=ZFteWKDfw7gh72c8Z5uZX8LF2UrRN8ze2Xd2xLPk6XtTqT1R6ycTnFc5/OBLmi9CA
	 4kzmfagOFXCxuCBPb2FRz05ZBSlsjKuaS/JUTmDFLpUAzN4xjwAh2iRqDRZhTabVfP
	 YyshiABqh3vs66BvjlUqOFWmWkg5HJRyyulNK1EA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbgE0Glj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 02:41:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:58290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725613AbgE0Gli (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 02:41:38 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49DA920776;
        Wed, 27 May 2020 06:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590561698;
        bh=aV8A8sLjaDOj/7AanTn0RtlrOOIqsNKRPjRHYtq5vE0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=o2RaZcvLGicVzdZAfBKYyCE0fgf5suFvdUtUTwKyZ7ckeSIcUDkYS9LY7YIwgBIxD
         HUEfkBOEtQbsQUFQFiIMPyyA/6q4t89VaDVJPT0YyS8qLgImWsmCfqdHiP3OF0AvFA
         4ZAQGOB94XhgaH13WSXjll1GEF9o0BqY4Toy5CJ8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200527053638.31439-2-zhang.lyra@gmail.com>
References: <20200527053638.31439-1-zhang.lyra@gmail.com> <20200527053638.31439-2-zhang.lyra@gmail.com>
Subject: Re: [RESEND PATCH v2 1/4] clk: sprd: check its parent status before reading gate clock
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Tue, 26 May 2020 23:41:37 -0700
Message-ID: <159056169760.88029.12084641394538099454@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chunyan Zhang (2020-05-26 22:36:35)
> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
>=20
> Some clocks only can be accessed if their parent is enabled. mipi_csi_xx
> clocks on SC9863A are an examples. We have to ensure the parent clock is
> enabled when reading those clocks.
>=20
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> ---

Applied to clk-next
