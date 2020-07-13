Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 634A5C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 09:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31AA4206F0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 09:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594630904;
	bh=nJLPgcuBwhmSHu4F6XNXgD70YkFDj7kDupRQGsTzmzw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GSj15sgEq/dsQEhY8ewOGj6GIvCiuHpabdMUeT0ppNn7mx4yI534vHtddRQG951Vc
	 At6wTiJ7LE6Yl0eAXzpU0+gDX81uLv17SapHoyDPxX8nnhlSprZQaEctfKcwz7Rn8C
	 1XGjcWVF3MviQcAoShJAbfrDrIrj7tzbJowE51c4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbgGMJBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 05:01:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:47624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726077AbgGMJBm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 05:01:42 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 902C52068F;
        Mon, 13 Jul 2020 09:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594630902;
        bh=nJLPgcuBwhmSHu4F6XNXgD70YkFDj7kDupRQGsTzmzw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zZOuTy9w9sQ+De4o5izVaycdKlvIVnBrIerDgJApJx9WZM6Znfm0njloYjHwG/cFc
         vooDuM/wpMmSsA7xcErjLMA5lMebeR1R9S8JDjQO009HtqFDfDSBJUIrmGqfl3lzVV
         iaEaaiPpysgglgC4eHvf+CKwF5Qo44CCSpFvlzHU=
Date:   Mon, 13 Jul 2020 17:01:36 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Philippe Schenker <philippe.schenker@toradex.com>
Cc:     devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] ARM: dts: colibri-imx6: remove pinctrl-names orphan
Message-ID: <20200713090136.GI15718@dragon>
References: <20200710132423.497230-1-philippe.schenker@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710132423.497230-1-philippe.schenker@toradex.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 03:24:21PM +0200, Philippe Schenker wrote:
> This is not necessary without a pinctrl-0 statement. Remove this
> orphan.
> 
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>

Applied all, thanks.
