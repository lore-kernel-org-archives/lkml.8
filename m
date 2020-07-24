Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07188C433E8
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 09:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8F1520674
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 09:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595582496;
	bh=TrB5W+xtG0lIm466sSH6ktYgtUfkZfXERLt/+iQxx1M=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=x0bXk+EEvtFWraU2/hkWejlAWcx+PPs8JrJd8SI6BEeNgJgfWetnE9dfhVgw9b2jb
	 xMLvNzhqR6DoLUpPDrPcam62uYDcfbhH2r6o0Es6Rm/lKLgrlz2JrnpHt3dUQsHVeo
	 Bn6eggDmE19DHUqe0BUne4wIuHEKZ0D36SQJHu74=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbgGXJVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 05:21:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:51842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726591AbgGXJVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 05:21:35 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A93E62063A;
        Fri, 24 Jul 2020 09:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595582494;
        bh=TrB5W+xtG0lIm466sSH6ktYgtUfkZfXERLt/+iQxx1M=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=d6FO4U5aU2UbRYnNmXWysrVm9I8uVuN55ht/rPXt73HbuQJXN2VzdrSI/9avN6/ev
         +dsacKyNGSG/IZXET0ASJZTu6UUI4hNG2MbqsDSHF2eNivioLatK1okBZ4kOeGm8aD
         EGICPnzskK3oqt70k5Mjj71ybFbjhdu+dW6D34jM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1595403506-8209-11-git-send-email-claudiu.beznea@microchip.com>
References: <1595403506-8209-1-git-send-email-claudiu.beznea@microchip.com> <1595403506-8209-11-git-send-email-claudiu.beznea@microchip.com>
Subject: Re: [PATCH v2 10/18] clk: at91: clk-generated: pass the id of changeable parent at registration
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     bbrezillon@kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com,
        mturquette@baylibre.com, nicolas.ferre@microchip.com
Date:   Fri, 24 Jul 2020 02:21:34 -0700
Message-ID: <159558249407.3847286.9638237361253973166@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Claudiu Beznea (2020-07-22 00:38:18)
> Pass the ID of changeable parent at registration. This will allow
> the scalability of this clock driver with regards to the changeable
> parent ID for versions of this IP where changeable parent is not the
> last one in the parents list (e.g. SAMA7G5). With this the clock flags
> are set to zero in case we have no changeable parent. Also in
> clk_generated_best_diff() the *best_diff variable is check against
> tmp_diff variable using ">=3D" operator instead of ">" so that in case
> the requested frequency could be obtained using fix parents + gck
> dividers but the clock also supports changeable parent to be able
> to force the usage of the changeable parent.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---

Applied to clk-next
