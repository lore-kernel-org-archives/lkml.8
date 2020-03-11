Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=RDNS_NONE,SPF_HELO_NONE,
	SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org ([198.145.29.99]:35932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729716AbgCKPpA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 11:45:00 -0400
MIME-Version: 1.0
References: <20200117170352.16040-1-olivier.moysan@st.com> <20200121220022.GA12737@bogus>
 <6a49bf6c-8851-a65c-5606-563776e07c08@st.com>
In-Reply-To: <6a49bf6c-8851-a65c-5606-563776e07c08@st.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 11 Mar 2020 10:44:45 -0500
Message-ID: <CAL_JsqKGy6Ec57RC_N-KZfKgGij4nn-BEdNQqXCd9dH_yPY6ew@mail.gmail.com>
Subject: Re: [PATCH v3] ASoC: dt-bindings: stm32: convert spdfirx to json-schema
To: Olivier MOYSAN <olivier.moysan@st.com>
Cc: "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-stm32@st-md-mailman.stormreply.com"
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Jan 22, 2020 at 3:20 AM Olivier MOYSAN <olivier.moysan@st.com> wrote:
>
> Hi Rob,
>
> I did not report your reviewed-by tag, as I have made a extra change in v2.
> This change is related to dmas property reported in v2 change log.
> Sorry, this extra change was indeed not clearly highlighted in log comments.

Indeed you did mention it, I just missed it. Anyways, it's a minor
change and my R-by still stands.

I'd resend this to make sure it's in Mark's inbox again.

Rob

