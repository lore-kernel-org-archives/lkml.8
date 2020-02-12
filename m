Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B898FC3B186
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 16:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 877252168B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 16:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581526629;
	bh=HvA/ML/Omfs30/zhqugDYZSwbALNZwB6X9pzQSaY9kI=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=g3ZLWSc2tNzDgrbKwwxHjFhj4Dig9TrCditYGFgwSWfYLNjas45dqI4A0cYtLxTZI
	 tBox0+cQDFadFMv86nLM6km7mumg6LrO6LXiu+CQmDBMm2CQfks/9yZ9pouL1LHWHy
	 ijQcvc5qyAk2XFYTP1p+485nwjY08tKqC3F8UMhg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728745AbgBLQ5J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 11:57:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:52816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727111AbgBLQ5I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 11:57:08 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F233F206D7;
        Wed, 12 Feb 2020 16:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581526628;
        bh=HvA/ML/Omfs30/zhqugDYZSwbALNZwB6X9pzQSaY9kI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=q0Wp1kJhLaYJujZ8m0pKAkmUKIL42ikJ5Si4+romiCycXOsr/ldghFqSjKA5m0tY+
         hqXF2JxMBsZ0xUp/ZYReJ6Z2es7sf8APROTNXYsAEGNMU8ENsAmoLkkmoGPw1apXjr
         EbfEVPuJboX0r8TXS1kkB/CLBaeosOcgif9HGC/o=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200212101853.9349-1-geert+renesas@glider.be>
References: <20200212101853.9349-1-geert+renesas@glider.be>
Subject: Re: [PATCH] usb: dwc3: qcom: Replace <linux/clk-provider.h> by <linux/of_clk.h>
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Wed, 12 Feb 2020 08:57:07 -0800
Message-ID: <158152662716.121156.7398920527948899150@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Geert Uytterhoeven (2020-02-12 02:18:53)
> The DWC3 USB driver is not a clock provider, and just needs to call
> of_clk_get_parent_count().
>=20
> Hence it can include <linux/of_clk.h> instead of <linux/clk-provider.h>.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

Maybe it can be migrated to the "get all the clks" API so that it
doesn't have to count anything too.
