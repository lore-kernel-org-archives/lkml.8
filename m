Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6524C3524D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 17:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A243B2087E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 17:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580838475;
	bh=BHdRLG+auPvYn1nQ2NsbGSGabOZ4o2YS45rnpJuJvHU=;
	h=In-Reply-To:References:Subject:To:Cc:From:Date:List-ID:From;
	b=wgpYXsoS+HvHK30rjDoOgoBuj1SS/pajXVuoalFD95civx0qrwWvUEDZi5GPACP9c
	 IWj/MUfO2/BYgsy+/YqPgACU9VLGeF8DH2xp0ik/eEm2Rf0vbM0ODZE/T1cRN4VsE1
	 f3DyPGb4LaAfvRqWAZfp8ifkSVANutuPz/lqlPSU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbgBDRrz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 12:47:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:44992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727363AbgBDRry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 12:47:54 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE34120674;
        Tue,  4 Feb 2020 17:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580838474;
        bh=BHdRLG+auPvYn1nQ2NsbGSGabOZ4o2YS45rnpJuJvHU=;
        h=In-Reply-To:References:Subject:To:Cc:From:Date:From;
        b=Y0R3Q007vWalAD0Ru1q2UbI+m/9c69jN8hr0+9IVLDqk8/saZJA1N2zbx7KJ/Tjin
         9yko+v7wLzhulCRAzQ8dQ3cmBkfdZxzA4cZhxa+f9GvlQsGYuzsEzDvAenp4Zn1TPy
         /bvc0eC9ll2WjyOBAqnMA+F4f9KK5C4btPtCx5zE=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200203103049.v4.5.I28ac8f801456f1b950f7da10ed0f74a1344d4a35@changeid>
References: <20200203183149.73842-1-dianders@chromium.org> <20200203103049.v4.5.I28ac8f801456f1b950f7da10ed0f74a1344d4a35@changeid>
Subject: Re: [PATCH v4 05/15] clk: qcom: Get rid of the test clock for dispcc-sc7180
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
        Stephen Boyd <swboyd@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Tue, 04 Feb 2020 09:47:53 -0800
Message-Id: <20200204174753.DE34120674@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2020-02-03 10:31:38)
> The test clock isn't in the bindings and apparently it's not used by
> anyone upstream.  Remove it.
>=20
> Suggested-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Applied to clk-next

