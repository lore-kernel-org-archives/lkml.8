Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90581C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 21:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A349D208C7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 21:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596490045;
	bh=SEWW09/i+04+jjvVuA9NB1iGYFQ/+Gb2zPeEc9SAtPI=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=cxxD/QwKEM8WIrdJBDrTxOS9iGVudNI4dObBLwap2kInMYBdCkYr7zOXwR4I0Eg8l
	 ScVTD5LWirHNbvyUoBOHrZPh9cgt8oSdx5g8vPnjAjNNBTNApUTAuHhvO+jSLeFxiR
	 C2feZJVNH/Rp7TxFMN+UIyfoGpwDxXiWOh/Qphf0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729113AbgHCV1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 17:27:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:47468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726398AbgHCV1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 17:27:23 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACF2C207DF;
        Mon,  3 Aug 2020 21:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596490043;
        bh=SEWW09/i+04+jjvVuA9NB1iGYFQ/+Gb2zPeEc9SAtPI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=fKraf1DqTK0sVAU2Wtz2SmkZ8NLOotp3LiIuxM3o3RlO6RPHjb25lL4EmJ4Klx/rT
         TNxFCNmgzFyC7a6fKwBaVGUPHU4sHqw3J9DCkXSMrNi2k4fiO8OJcLyoLrp26e/+0L
         i2jpkTYD8p0EVnDCgqcjs8Dt6NYUqq2NR9tOs+9o=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200730182619.23246-1-nsaenzjulienne@suse.de>
References: <20200730182619.23246-1-nsaenzjulienne@suse.de>
Subject: Re: [PATCH v2] clk: bcm2835: Do not use prediv with bcm2711's PLLs
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     pbrobinson@gmail.com, kernel-list@raspberrypi.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To:     Eric Anholt <eric@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Matthias Brugger <mbrugger@suse.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Stefan Wahren <wahrenst@gmx.net>,
        bcm-kernel-feedback-list@broadcom.com
Date:   Mon, 03 Aug 2020 14:27:22 -0700
Message-ID: <159649004236.1360974.8603728575729464532@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Nicolas Saenz Julienne (2020-07-30 11:26:19)
> Contrary to previous SoCs, bcm2711 doesn't have a prescaler in the PLL
> feedback loop. Bypass it by zeroing fb_prediv_mask when running on
> bcm2711.
>=20
> Note that, since the prediv configuration bits were re-purposed, this
> was triggering miscalculations on all clocks hanging from the VPU clock,
> notably the aux UART, making its output unintelligible.
>=20
> Fixes: 42de9ad400af ("clk: bcm2835: Add BCM2711_CLOCK_EMMC2 support")
> Reported-by: Nathan Chancellor <natechancellor@gmail.com>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---

Applied to clk-next
