Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052E9C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 02:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D982822DA9
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 02:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592620005;
	bh=XyQRSgZK7Hy/N3rTtel5X2W9AMQrj2c4MSd9bF6kaF4=;
	h=In-Reply-To:References:Subject:From:To:Date:List-ID:From;
	b=ueGjGI6e3R6wclAaMg/e2qL6rTX+STg9s5ROhk5/FVQdH4sCMaJLfOqKWmOreJ4qh
	 l4vTMNRMuCyuhwgOEzPjFp80Mue8MiU9V3tEUspKojKwHjm9WrhWlyLyTyxC/QKlFi
	 0A3VMtBJPl/V/arBurqUzSLsBumeZGaAQtrlasZo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731877AbgFTC0o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 22:26:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:51700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731772AbgFTC0o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 22:26:44 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FD9A22DA7;
        Sat, 20 Jun 2020 02:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592620003;
        bh=XyQRSgZK7Hy/N3rTtel5X2W9AMQrj2c4MSd9bF6kaF4=;
        h=In-Reply-To:References:Subject:From:To:Date:From;
        b=OsjiYIhvl9qI7IbEaX7uMPFzZJYny1CHAStIzZN4c0TBfognrTgV6Hc/xTGEgr+5+
         mJW3TdtSpkxILBUkh1iC8Pl3l9X6HLqFsylBPV9nKQigst69OL8hT3VSbbj95ETiQQ
         x2uZtJgMFcu8EXWkodya8LW1CAQ9wJlpa2nitiw8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1591440907-20021-4-git-send-email-sivaprak@codeaurora.org>
References: <1591440907-20021-1-git-send-email-sivaprak@codeaurora.org> <1591440907-20021-4-git-send-email-sivaprak@codeaurora.org>
Subject: Re: [PATCH V7 3/4] clk: qcom: Add DT bindings for ipq6018 apss clock controller
From:   Stephen Boyd <sboyd@kernel.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com, robh+dt@kernel.org,
        sivaprak@codeaurora.org
Date:   Fri, 19 Jun 2020 19:26:42 -0700
Message-ID: <159262000293.62212.11609056599995521360@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sivaprakash Murugesan (2020-06-06 03:55:06)
> Add dt-binding for ipq6018 apss clock controller
>=20
> Signed-off-by: Sivaprakash Murugesan <sivaprak@codeaurora.org>
> ---

Please pick up Rob's tag when resending this.
