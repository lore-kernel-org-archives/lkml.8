Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D460FC433E4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 01:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B26182076E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 01:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595985824;
	bh=ZEQ8acauTeo/vlplG6VpP6uu8XrzCrepryaFriXIl0k=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=XpvGxrS//rXiNE+nyEOjHKUqbTBvNdfXPqAPGQVlEaSWT3KMsQYrlVLJvyjZwKpsy
	 ZoHFYunVzD8/bqMAXBMfonyOeRFeBaDkVmQKLGVxYQZezR4JShAGAXCHliwG2IrHLS
	 AkYLrGSznLiEW+NL0sX1k1iuiyVTW7IEJuc40xqY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730211AbgG2BXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 21:23:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:45300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728364AbgG2BXn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 21:23:43 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4B632076E;
        Wed, 29 Jul 2020 01:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595985822;
        bh=ZEQ8acauTeo/vlplG6VpP6uu8XrzCrepryaFriXIl0k=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=aTca3T4g86Fi3svMdHBkdbhLG31p0iZ2AFbMr4vpOCWD+bkgMPXF+bLxj7mk6jFTx
         RMYlBPiQihob+CN4wF3jlLfcmHdD8Oy5gnv7zelMHgZJf7Jp+X/o+ep8UYWDuXyhLe
         Zn2+daSsB8GNtc3pgCkZEvk88IE4ELvibBIxptnI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200728120049.90632-7-konradybcio@gmail.com>
References: <20200728120049.90632-1-konradybcio@gmail.com> <20200728120049.90632-7-konradybcio@gmail.com>
Subject: Re: [PATCH 6/9] clk: qcom: gcc-msm8994: Add missing clocks, resets and GDSCs
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     lauren.kelly@msn.com, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
To:     konradybcio@gmail.com
Date:   Tue, 28 Jul 2020 18:23:41 -0700
Message-ID: <159598582154.1360974.14382448860412146673@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Konrad Dybcio (2020-07-28 05:00:45)
> This change adds GDSCs, resets and most of the missing
> clocks to the msm8994 GCC driver. The remaining ones
> are of local_vote_clk and gate_clk type, which are not
> yet supported upstream. Also reorder them to match the
> original downstream driver.
>=20
> Signed-off-by: Konrad Dybcio <konradybcio@gmail.com>
> ---
> I plan on converting this to use parent_data later on,
> but I think we could merge it as-is for now..?

Why not convert to parent_data now? Otherwise we can wait given that the
merge window is near anyway.
