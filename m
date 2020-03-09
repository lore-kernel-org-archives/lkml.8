Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BECC10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 22:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18F8A24654
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 22:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583792477;
	bh=gUvLUwCItndy6GwWeNbX49NkAds00h79NKdFa/beHz8=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=Gzxl0y2b/u5qjkB+6QGDOLPVdh/xoedQcWXMhrMjtkLlgUUJKbuVk+NWiH0+gqu7/
	 k55Mgrn35mmA+zUzjASCHoL60/rfdTZZ929sKpPtgk28qMcvZZNKQ/sAx0zOxaiue7
	 5JLxDBLDkdsb6RoU7nAMr5OP387xzhaiyacJPQRk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbgCIWVQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 18:21:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:57996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726536AbgCIWVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 18:21:14 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FC4324654;
        Mon,  9 Mar 2020 22:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583792474;
        bh=gUvLUwCItndy6GwWeNbX49NkAds00h79NKdFa/beHz8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=q5mCFFSCbicrFQl85ZkmWnaxEKjK1iyZcnuNjkxlLcioFjuQp49j9F+DKASmNVUQs
         AZOfDvPcjffOMW8j4cioBaLnufcVHUVfKaoOTBD8CLQgdxd+AobNxAxWBeg1D3Hms0
         HNnf59MLNqAUVTghpu9RGI/UgoFTTFVJBV8WzRu4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200224045003.3783838-5-vkoul@kernel.org>
References: <20200224045003.3783838-1-vkoul@kernel.org> <20200224045003.3783838-5-vkoul@kernel.org>
Subject: Re: [PATCH v4 4/5] dt-bindings: clock: Add SM8250 GCC clock bindings
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Taniya Das <tdas@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        psodagud@codeaurora.org, tsoni@codeaurora.org,
        jshriram@codeaurora.org, vnkgutta@codeaurora.org,
        Vinod Koul <vkoul@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Date:   Mon, 09 Mar 2020 15:21:13 -0700
Message-ID: <158379247352.66766.10093383562833216869@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vinod Koul (2020-02-23 20:50:02)
> From: Taniya Das <tdas@codeaurora.org>
>=20
> Add device tree bindings for global clock controller on SM8250 SoCs.
>=20
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> Signed-off-by: Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---

Applied to clk-next
