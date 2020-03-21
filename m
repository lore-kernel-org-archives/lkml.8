Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA49DC4332B
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 00:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EFBF20732
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 00:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584751449;
	bh=ZMNS9Vcri4AEpW6rcNqodcFPTHKCyMBNpdd0Dq4G9W0=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=iCb2VEYAex4XRNcPGNf2R5BF/8Kjp4EF5JJw0UXBs60BwDkioPGC2vAlrOQKWu3Y6
	 iHsuLYzyUexhJHlqBivzan5OEo1cBir37de1PTlckRj08aNDCl1MB2CIAyYNGLZxHw
	 KA12pLCw/fkHmQPOmej0f05a4CgF4ybv/PDTJ/uQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbgCUAoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 20:44:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:59270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726773AbgCUAoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 20:44:06 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AC0D20753;
        Sat, 21 Mar 2020 00:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584751446;
        bh=ZMNS9Vcri4AEpW6rcNqodcFPTHKCyMBNpdd0Dq4G9W0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=XSPkj0VBd9Ugt2BA+SaJplHfUGCHq092vs9sYUpML/EthYqIxQerBKgCxuAosC9Gc
         q2O48XDokrFqf164YBZcmShNXOgYY90UqaaNk46YMaUng2wp0MIvf9P8O4QnHQHTVq
         ghwVpvOD0g51NQA/AvxZ7ajulFUXVhVS+LL29kP4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1584661443-12032-1-git-send-email-Anson.Huang@nxp.com>
References: <1584661443-12032-1-git-send-email-Anson.Huang@nxp.com>
Subject: Re: [PATCH V2] clk: imx: clk-pllv3: Use readl_relaxed_poll_timeout() for PLL lock wait
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Linux-imx@nxp.com
To:     Anson Huang <Anson.Huang@nxp.com>, abel.vesa@nxp.com,
        festevam@gmail.com, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        s.hauer@pengutronix.de, shawnguo@kernel.org, tglx@linutronix.de
Date:   Fri, 20 Mar 2020 17:44:05 -0700
Message-ID: <158475144559.125146.12057905431193979940@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Anson Huang (2020-03-19 16:44:03)
> Use readl_relaxed_poll_timeout() for PLL lock wait which can simplify the
> code a lot.
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Reviewed-by: Abel Vesa <abel.vesa@nxp.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
