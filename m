Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F00C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 04:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37A9E20738
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 04:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594613277;
	bh=ejHWS99iEEHSjQVTIhlMEgtZRGyaaFODIq5arWHElTs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UhIepYu9pqcg180V8wkNgAfYeG+uh+60pLtbwJhCH2MN/QM3JIv7p67wrAjFRBCc7
	 CjSpPU3CVExK/LzB4OGlM7QIkEmNImL68VnCjKCOAQohjchA6n8i4Jd89DjQy9UA19
	 q2Mx8R4joVVZCkuTfonik/x3zkkDPJlks9kI3idA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgGMEHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 00:07:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:37808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbgGMEHz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 00:07:55 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E9162070B;
        Mon, 13 Jul 2020 04:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594613275;
        bh=ejHWS99iEEHSjQVTIhlMEgtZRGyaaFODIq5arWHElTs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qMRky2EF0+s1MYuktOpuzwqbOHFfV888W0AMabjYGdu6pIQ5Vl0YaMszC5rGWBcrB
         k30A25pvuexHe7mn9ZHC9TrKWh0PDLGR6wqeigKcx11owSM4mHXOuvIVdTqRDxLGB7
         sbTl/C090td2NSEXoX/Z055KR9RG8+CbQr2dgkHk=
Date:   Mon, 13 Jul 2020 12:07:48 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: imx6qp-sabreauto: enable sata
Message-ID: <20200713040746.GA12113@dragon>
References: <1594369848-28627-1-git-send-email-hongxing.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594369848-28627-1-git-send-email-hongxing.zhu@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 04:30:47PM +0800, Richard Zhu wrote:
> Enable SATA on iMX6QP SABREAUTO board.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>

Applied both, thanks.
