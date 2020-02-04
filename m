Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FBA1C3524D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 17:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2F3D20674
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 17:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580838452;
	bh=72dr/LEdcHEPBXBj3LbpRD0plzyPRcgc4RP0ntvVah8=;
	h=In-Reply-To:References:Subject:To:Cc:From:Date:List-ID:From;
	b=m6xM2+RBgTd/5fb8y7bgDoREjZntV0iif+m1qGqbNrcwQI13XZPiC0b+q6wA30UiH
	 /q3C9l1BfI4bG+8mELgHZ74O5EypNqUUXJnXpGBbf7Q4S7dWvSES+h78gD9BgpHC6x
	 wAPJiL+QWqp0ircgiKlW5od+tjc1kFUwq111ueuc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbgBDRrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 12:47:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:44766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727382AbgBDRra (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 12:47:30 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23AFD20674;
        Tue,  4 Feb 2020 17:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580838449;
        bh=72dr/LEdcHEPBXBj3LbpRD0plzyPRcgc4RP0ntvVah8=;
        h=In-Reply-To:References:Subject:To:Cc:From:Date:From;
        b=WunRN+SqAt54ESSwm577BfCLOqkgN+VEEwZPbZ4+YnV/6a9xFsywUznW9btnfD+xA
         iy2CPznReWS7iTphCKEt//78QNIHTfI+eDMX51/LRrMeON7GmOaq5STX53CiCHzJWC
         RKfEzfQ7PCIXZ56vOpbxsYVq5ai8lTG/GA7F9n8Y=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200203103049.v4.2.I0c4bbb0f75a0880cd4bd90d8b267271e2375e0d0@changeid>
References: <20200203183149.73842-1-dianders@chromium.org> <20200203103049.v4.2.I0c4bbb0f75a0880cd4bd90d8b267271e2375e0d0@changeid>
Subject: Re: [PATCH v4 02/15] dt-bindings: clock: Fix qcom,dispcc bindings for sdm845/sc7180
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Rob Herring <robh@kernel.org>
Cc:     Jeffrey Hugo <jhugo@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>, jeffrey.l.hugo@gmail.com,
        linux-arm-msm@vger.kernel.org, harigovi@codeaurora.org,
        devicetree@vger.kernel.org, mka@chromium.org,
        kalyan_t@codeaurora.org, Mark Rutland <mark.rutland@arm.com>,
        linux-clk@vger.kernel.org, hoegsberg@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Tue, 04 Feb 2020 09:47:28 -0800
Message-Id: <20200204174729.23AFD20674@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2020-02-03 10:31:35)
> The qcom,dispcc bindings had a few problems with them:
>=20
> 1. They didn't specify all the clocks that dispcc is a client of.
>    Specifically on sc7180 there are two clocks from the DSI PHY and
>    two from the DP PHY.  On sdm845 there are actually two DSI PHYs
>    (each of which has two clocks) and an extra clock from the gcc.
>    These all need to be specified.
>=20
> 2. The sdm845.dtsi has existed for quite some time without specifying
>    the clocks.  The Linux driver was relying on global names to match
>    things up.  While we should transition things, it should be noted
>    in the bindings.
>=20
> 3. The names used the bindings for "xo" and "gpll0" didn't match the
>    names that QC used for these clocks internally and this was causing
>    confusion / difficulty with their code generation tools.  Switched
>    to the internal names to simplify everyone's lives.  It's not quite
>    as clean in a purist sense but it should avoid headaches.  This
>    officially changes the binding, but that seems OK in this case.
>=20
> Also note that I updated the example.
>=20
> Fixes: 5d28e44ba630 ("dt-bindings: clock: Add YAML schemas for the QCOM D=
ISPCC clock bindings")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Applied to clk-next

