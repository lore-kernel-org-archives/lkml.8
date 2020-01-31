Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F06DC35240
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 00:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 050FF214D8
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 00:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580430727;
	bh=gpqvN0vXWHIpJ1jFZkNFzgzklrymhFi99BpN/wK5WX4=;
	h=In-Reply-To:References:Subject:To:From:Cc:Date:List-ID:From;
	b=AH454zcwpgDsCj2Q4GgmOIwrnWb/FAKxKr+KaJzGDFlBS1+eKZxxgJXhCpiKx11z4
	 rt7OY0WhPW3vKQ5fbjR77x2xrhaH0Iy4K1bPE/W7X7vty5pkblRERZWMqQ740SnH/a
	 m2MkI7MkrfmCnApZXFK7ai0Gr0jcnu/qdIywsVng=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbgAaAcG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 19:32:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:55202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727614AbgAaAcG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 19:32:06 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E5E620674;
        Fri, 31 Jan 2020 00:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580430725;
        bh=gpqvN0vXWHIpJ1jFZkNFzgzklrymhFi99BpN/wK5WX4=;
        h=In-Reply-To:References:Subject:To:From:Cc:Date:From;
        b=LhpN9V41Y1FuzvByOemeRKTX1NQZFKQaD2LZ0ZFVUvMFjEZV7JOqQ6JcLmJnklcJB
         YnnL0Kaz+O3bnt/C0YoDtl6JuRiwc1sTZoKEppW4rP+5AOhXPzSBtYhD4DIrQ/LEBK
         653kjx3j0nIcLpEEobm2xVmMtJnGKv4TzrCi4b9k=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191213083402.35678-1-wen.he_1@nxp.com>
References: <20191213083402.35678-1-wen.he_1@nxp.com>
Subject: Re: [v12 1/2] dt/bindings: clk: Add YAML schemas for LS1028A Display Clock bindings
To:     Li Yang <leoyang.li@nxp.com>, Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Michael Walle <michael@walle.cc>,
        Rob Herring <robh+dt@kernel.org>, Wen He <wen.he_1@nxp.com>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Wen He <wen.he_1@nxp.com>
User-Agent: alot/0.8.1
Date:   Thu, 30 Jan 2020 16:32:04 -0800
Message-Id: <20200131003205.4E5E620674@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Wen He (2019-12-13 00:34:01)
> LS1028A has a clock domain PXLCLK0 used for provide pixel clocks to Displ=
ay
> output interface. Add a YAML schema for this.
>=20
> Signed-off-by: Wen He <wen.he_1@nxp.com>
> Signed-off-by: Michael Walle <michael@walle.cc>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---

Applied to clk-next

