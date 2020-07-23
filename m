Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 628F9C433F8
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 22:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D31920888
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 22:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595543679;
	bh=9iRLgISyLPKnSMl0PxHInqiFaxooa28HbJGzrm6kkws=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=SK989IVv8uwmx9wXTER6b59dJfbMj6mC86zvbr3Hy5QMCIDpWAoENytHDDNn7FHxC
	 NJPtX242J7iQmLYB/R9/qzaXsV2S9T+IYmzbrEG0hTThJ2ouJgWSc+4vTQ300yt7nq
	 XlCnHpWRyh+xLjsVcY1PnaAFqYNo3FbU1jN4oY04=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbgGWWeh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 18:34:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:46124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726855AbgGWWeh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 18:34:37 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA38220792;
        Thu, 23 Jul 2020 22:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595543677;
        bh=9iRLgISyLPKnSMl0PxHInqiFaxooa28HbJGzrm6kkws=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Ini3F5jRXRwoKuax4jhQQgxs7cNR50VPw0sZoeoqqTdJN9NCt26Phj5RnhwPgX19O
         rol5Wm+rDZqydVnn5ggnNdx+Mp+Mq0b8secjw9RYqPzJy4RdAwTWlF/IfSbBpuY32N
         /FWA5x+41iPxEVrSRwiSJ3c+0CWR7iRQRzo6H8bE=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200723072603.1795-1-luca@lucaceresoli.net>
References: <20200723072603.1795-1-luca@lucaceresoli.net>
Subject: Re: [PATCH v4] clk: vc5: use a dedicated struct to describe the output drivers
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Luca Ceresoli <luca@lucaceresoli.net>,
        linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Adam Ford <aford173@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>
To:     Luca Ceresoli <luca@lucaceresoli.net>, linux-clk@vger.kernel.org
Date:   Thu, 23 Jul 2020 15:34:36 -0700
Message-ID: <159554367631.3847286.15394463918985779147@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Luca Ceresoli (2020-07-23 00:26:03)
> Reusing the generic struct vc5_hw_data for all blocks is handy. However it
> implies we allocate space the div_int and div_frc fields even for the
> output drivers where they are unused, and the clk_output_cfg0 and
> clk_output_cfg0_mask fields for all components even though they are used
> only for the output drivers.
>=20
> Use a dedicated struct for the output drivers so that each block uses
> exactly the fields it needs, not more.
>=20
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
>=20
> ---

Applied to clk-next
