Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA0DC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 18:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9500920674
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 18:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584122464;
	bh=0Atpr6ZtF5yQD78BdGzERxlwoaiekMUryGsAon4sBCc=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=vrLLRFfyH0KtVzEyiwQBXcmZm1Vfrkfpqk0tz84fg2PVw5ndMqUOUS0R2oFiEC3Kw
	 jiipfuXPUNHYOoCtbIzpIAeIOdbtqRG0CckXjLh2a1iVUGqhKXlhL8CtO091CCpE8/
	 x3AtGsZL/dW8ZiPISOGvYJ8fNOxTbT6ADHavauOE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbgCMSBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 14:01:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:41372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726414AbgCMSBD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 14:01:03 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F6FD20674;
        Fri, 13 Mar 2020 18:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584122462;
        bh=0Atpr6ZtF5yQD78BdGzERxlwoaiekMUryGsAon4sBCc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=He88vEq+9HRxEG4fEVgDj9kFX9XEaRGY5yIP3KzKueEJGC4wYnBfAMnAG19TNBDX5
         L2mRoHAyRvzp5Jq2dyN3l9hppcUVVTh1j2AvJhY9a6OKsLbLLghX9ocvMpcAc38c87
         CSO0YQKob5qwOqIIz+RU5E8fz3pNsSQbeOaMYIDU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200304170939.GR24720@google.com>
References: <1581423236-21341-1-git-send-email-tdas@codeaurora.org> <1581423236-21341-2-git-send-email-tdas@codeaurora.org> <20200303201629.GP24720@google.com> <f0529793-c51d-4baf-5217-173c552f4cbe@codeaurora.org> <20200304170939.GR24720@google.com>
Subject: Re: [PATCH v1 2/2] clk: qcom: dispcc: Remove support of disp_cc_mdss_rscc_ahb_clk
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>, robh@kernel.org,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        robh+dt@kernel.org, Doug Anderson <dianders@chromium.org>
To:     Matthias Kaehlcke <mka@chromium.org>,
        Taniya Das <tdas@codeaurora.org>
Date:   Fri, 13 Mar 2020 11:01:01 -0700
Message-ID: <158412246142.149997.5548337390525905687@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matthias Kaehlcke (2020-03-04 09:09:39)
> Hi Taniya,
>=20
> On Wed, Mar 04, 2020 at 09:05:20AM +0530, Taniya Das wrote:
> >=20
> > Hi Matthias,
> >=20
> > The display device node is not present and we encounter this crash, wou=
ld it
> > be possible to add ALWAYS_ON for the MDSS GDSC and give it a try.
>=20
> It still crashes when ALWAYS_ON is set for the MDSS GDSC.

Any updates here? I'm about to send this patch off to Linus and I'm
wondering if there will be a resolution besides reverting it.
