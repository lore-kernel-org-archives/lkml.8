Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D13C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 06:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9040920787
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 06:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590561712;
	bh=FcPwro708JAQxfwjtGT0lHjZkn35qfyICm3GqDRqE2U=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=xj93ZBcPKLilIb9B2jMN2FNODt9UQZchbd5cg8iTiU9GOxbpEDz04ZcsN4X0cCnW7
	 gPKSt7sC1ge3gSfey9VHuXvo+kSBGeLp74A68e1BwLwS4Gcudi4/ugklMimCn0VMOm
	 4HtrI4pvxGlRYpi5pgHV4dvFj/g3FIJYbcxq0j34=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728820AbgE0Glv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 02:41:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:58520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728803AbgE0Glt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 02:41:49 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D12AA20776;
        Wed, 27 May 2020 06:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590561708;
        bh=FcPwro708JAQxfwjtGT0lHjZkn35qfyICm3GqDRqE2U=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=xSdNL81lANV76K5IRc8zUHIrWvbxSR3VSTujQ0YA30WU6trsKuUpkv+cAlsyz4Ja5
         GJZ71ThpmpG78FvWSS2HzqWRvoWvf5oyBSw4sQLP5D/bQh/vM+b/RFKObMYZgAy3j1
         SDRuA4HNWMe8tUrmeKK7ZY9lzFSDIEwEfOdwMqbU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200527053638.31439-5-zhang.lyra@gmail.com>
References: <20200527053638.31439-1-zhang.lyra@gmail.com> <20200527053638.31439-5-zhang.lyra@gmail.com>
Subject: Re: [RESEND PATCH v2 4/4] clk: sprd: add mipi_csi_xx gate clocks
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Tue, 26 May 2020 23:41:48 -0700
Message-ID: <159056170805.88029.407778737144391406@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chunyan Zhang (2020-05-26 22:36:38)
> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
>=20
> mipi_csi_xx clocks are used by camera sensors.
>=20
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> ---

Applied to clk-next
