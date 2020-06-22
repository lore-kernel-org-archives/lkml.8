Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDBFC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 08:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DDFB20708
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 08:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592815763;
	bh=nqEHgJ/8zmmb+slp1bSk06vjVO02xSDQ92E2cQ0WCu4=;
	h=In-Reply-To:References:Subject:From:To:Date:List-ID:From;
	b=a2BJlKzUU+/JcsdY8hOb9XK7+9UtPRx6Pi93vCABpa4n86uIeBdc5lGP+e0WGHoDw
	 mwg73wrtBgkbHJFNMJWxUJ+4qjm3JpBjehIFBvgh5tYZ7VL7wWWJ6rTPXXnH/VBHqE
	 MiEMSW7nStcFfh6qWkNev3edhPPFRl8nkKnGRoZw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbgFVItW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 04:49:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:34740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbgFVItV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 04:49:21 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 069E620578;
        Mon, 22 Jun 2020 08:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592815761;
        bh=nqEHgJ/8zmmb+slp1bSk06vjVO02xSDQ92E2cQ0WCu4=;
        h=In-Reply-To:References:Subject:From:To:Date:From;
        b=dRtGB3B4q9cxOd8MTr4qujLsF6cHhJ93qEa/sbiWi5ixp2NySc8agWhHVgrnNYDtg
         I8UrfDCOVchUbM8RNKSGrlS2uM5EBGsuU7nHGG2PUPSbp70eHeS2eMB9KI3/uwzwoE
         zUBVlFU802PHsllDuuwcECRYgMyS4IL+oykhu860=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1592800092-20533-5-git-send-email-sivaprak@codeaurora.org>
References: <1592800092-20533-1-git-send-email-sivaprak@codeaurora.org> <1592800092-20533-5-git-send-email-sivaprak@codeaurora.org>
Subject: Re: [PATCH V8 4/4] clk: qcom: Add ipq6018 apss clock controller
From:   Stephen Boyd <sboyd@kernel.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com, robh+dt@kernel.org,
        sivaprak@codeaurora.org
Date:   Mon, 22 Jun 2020 01:49:20 -0700
Message-ID: <159281576034.62212.7529127708731581039@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sivaprakash Murugesan (2020-06-21 21:28:12)
> The CPU on Qualcomm ipq6018 devices are clocked primarily by a aplha PLL
> and xo which are connected to a mux and enable block.
>=20
> Add support for the mux and enable block which feeds the CPU on ipq6018
> devices.
>=20
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> Signed-off-by: Sivaprakash Murugesan <sivaprak@codeaurora.org>
> ---

Applied to clk-next
