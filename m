Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5BC5C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 04:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CC4020738
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 04:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594613389;
	bh=G3ufv/0TnSQy0nWwDMS87xkscK2HM01BBbfjjOrugek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bQNUxBdCuTJognoHjudHUYhmCYt9ZT1ZMzqcQanvFMZlHOmdxmBu5iwwb8RUHNXA1
	 jorLD+4VvWxFu3KSIPtRrQpWTWXQAvplsPpbQuJ5bQqiTgC9Bqh00uY62jWaSrLM20
	 ISw3QdyswpmLEFE1S5id78hEFyCAMaMmF3EOY/lE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbgGMEJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 00:09:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:38264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbgGMEJs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 00:09:48 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDBD12070B;
        Mon, 13 Jul 2020 04:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594613387;
        bh=G3ufv/0TnSQy0nWwDMS87xkscK2HM01BBbfjjOrugek=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zGJmyWEGXYUGowm7ICCDBzD+VuTnaMSQOC4UcAgMrdP1nmBukgL6iuWMaFM8UG9gF
         eIlXa9JvgbAN94e2neyWiUYjusMb/EzgvM5U0wAo547FNl9IO8hV1XA1dp1sEY7p6I
         tiOUJZovbxaqMKxDaSAqKumIRjnPlzMXoMBaia8w=
Date:   Mon, 13 Jul 2020 12:09:42 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        frieder.schrempf@kontron.de, catalin.marinas@arm.com,
        will@kernel.org, anson.huang@nxp.com, festevam@gmail.com,
        s.hauer@pengutronix.de, john.lee@nxp.com, kernel@pengutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com
Subject: Re: [PATCH v2 3/4] arm64: dts: imx8mn-evk: add pca9450 for
 i.mx8mn-evk board
Message-ID: <20200713040941.GB12113@dragon>
References: <1593793178-9737-1-git-send-email-yibin.gong@nxp.com>
 <1593793178-9737-4-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1593793178-9737-4-git-send-email-yibin.gong@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 04, 2020 at 12:19:37AM +0800, Robin Gong wrote:
> Add pca9450 pmic driver for i.mx8mn-evk board.
> 
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>

Applied, thanks.
