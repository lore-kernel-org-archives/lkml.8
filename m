Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4233C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 21:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A94B206F1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 21:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589491455;
	bh=kkl4GgxVhIrhp1xeD0omNcInNUALfVuNoVrrnC357uk=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=ZUp56dOttiFolMPbPqTs4tWOPlsUtA29lri73Ko3PBr2ANKmspqope56/nn9mNb9O
	 b0BqwblOgY+1BE4o+CovKwCiiyP2iZdxZiqSwieYoi+iinYDgRc9TTjo9ZBRbZghaR
	 8Hi/aekFJisUlhB1qz7HbrYUnFKRMmdr5l85iPg4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbgENVYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 17:24:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:47276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728138AbgENVYC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 17:24:02 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2F5820767;
        Thu, 14 May 2020 21:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589491442;
        bh=kkl4GgxVhIrhp1xeD0omNcInNUALfVuNoVrrnC357uk=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=qQPLIpyJzzK68ymfY0NhagI1nh0PfOxNAg5TRfixHOPL7wq8obCcaRUhiJrvCzQJT
         ZTFaa09PQvfW4G1Jo2mlbTTxEAJRuqwkp36hFjZHxGLdR/QR8jJNuJ9WIgqSBsPq90
         dlwUUUdsHLR+M/7aMInL6PdHqs3nvgUtdsBYAJR0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200417070044.1376212-3-bjorn.andersson@linaro.org>
References: <20200417070044.1376212-1-bjorn.andersson@linaro.org> <20200417070044.1376212-3-bjorn.andersson@linaro.org>
Subject: Re: [PATCH v2 2/4] clk: qcom: mmcc-msm8996: Properly describe GPU_GX gdsc
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
Date:   Thu, 14 May 2020 14:24:01 -0700
Message-ID: <158949144132.215346.9049429951567251868@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2020-04-17 00:00:42)
> The GPU_GX GDSC depends on both GPU GDSC being enabled and that the
> VDD_GX rail is powered, so update the description of the node to cover
> these requirements.
>=20
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

Applied to clk-next
