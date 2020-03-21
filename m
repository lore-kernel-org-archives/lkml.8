Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FEE6C4332B
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 01:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3285620732
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 01:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584753935;
	bh=1Vmk98r+1+9CpKtOEkJxrKetQAoT5sDw0wndpO6+Cc8=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=LUSDy9jJL5tvwyyWEpQp9XY6QbtjbUigRwykZSM/fXDZZqXUX1YMId4upsNy1Eyus
	 7cn3FZTN9JhPLdFIjdXRpwNca40zJ35kGeklGzkvHRJ16L38Cui1XTrO0XzUYuTN1p
	 xz7VLsrY55x7FDxV4CPbuS+HKjmgpPZcr9I/tE+I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbgCUBZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 21:25:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:46658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727922AbgCUBZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 21:25:32 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A7A720752;
        Sat, 21 Mar 2020 01:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584753932;
        bh=1Vmk98r+1+9CpKtOEkJxrKetQAoT5sDw0wndpO6+Cc8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=l80SPIDNWaBqXBy8EePjY4aVF87sv5TbXd/F6U5JQwF2zehLbfqs+1dEm6Uz/YGcT
         kPCpB4KLhK1tR/vMbnrQJjV7KmrHBJQdd6n2nArFBh24In8RoeBLIQAycQeXP1Of/o
         rVfXII2qEXbnQ9yId54saijihdFxrpZ4o7SaPc7k=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200309194254.29009-17-lkundrak@v3.sk>
References: <20200309194254.29009-1-lkundrak@v3.sk> <20200309194254.29009-17-lkundrak@v3.sk>
Subject: Re: [PATCH v2 16/17] clk: mmp2: Add clock for fifth SD HCI on MMP3
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lubomir Rintel <lkundrak@v3.sk>
To:     Lubomir Rintel <lkundrak@v3.sk>
Date:   Fri, 20 Mar 2020 18:25:31 -0700
Message-ID: <158475393138.125146.321885213603398585@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lubomir Rintel (2020-03-09 12:42:53)
> There's one extra SDHCI on MMP3, used by the internal SD card on OLPC
> XO-4. Add a clock for it.
>=20
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
>=20
> ---

Applied to clk-next
