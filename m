Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED9F3C4332B
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 01:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B52DC20752
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 01:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584753899;
	bh=num4XEzGirTSkx4N684gppE8VZeumz6uRRs3h4mg/gY=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=ApGNb9io9znjXCBiXnLtDScmzX5KrMwwKfO7VnIt9KlQMk/7V+Jip9nHxmbGqIFlN
	 eKPjQYmiWKa1vDl06jILMgvz05KFUsqBPd76LPApFQ1edglnVNfXx+T3qZJw2ojIXy
	 LeY2GYGoPC1tYMaDfoWS7cWeHKr9t6Igwmj12fVw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgCUBY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 21:24:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:45924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726773AbgCUBY4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 21:24:56 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E35B420752;
        Sat, 21 Mar 2020 01:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584753896;
        bh=num4XEzGirTSkx4N684gppE8VZeumz6uRRs3h4mg/gY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=E0DzMpkW0l7jwYBTdIq81IYZlvMjU1hOg5YDWx79Cn2knepkxmLEQAQFpAOx0y6Tc
         oErbOKKxd29Be8RCQ7YFoOPGcSSh3MSwi8oZMiCq2/U8V8V6DvMMpp8tq41j1FnOv3
         ZFe0VFx5vcS0oFDNdNqActACjG/6/9v92uioL7Wk=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200309194254.29009-8-lkundrak@v3.sk>
References: <20200309194254.29009-1-lkundrak@v3.sk> <20200309194254.29009-8-lkundrak@v3.sk>
Subject: Re: [PATCH v2 07/17] clk: mmp2: Check for MMP3
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lubomir Rintel <lkundrak@v3.sk>
To:     Lubomir Rintel <lkundrak@v3.sk>
Date:   Fri, 20 Mar 2020 18:24:55 -0700
Message-ID: <158475389516.125146.6283805958516666940@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lubomir Rintel (2020-03-09 12:42:44)
> The MMP3's are similar enough to MMP2, but there are differencies, such
> are more clocks available on the newer model. We want to tell which
> platform are we on.
>=20
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---

Applied to clk-next
