Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E76C3402F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 03:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB8CF206EF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 03:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="XXy/h+U7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="38X4/aeX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbgBRDRw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 22:17:52 -0500
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:33963 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726237AbgBRDRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 22:17:52 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 30F0976A3;
        Mon, 17 Feb 2020 22:17:51 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 17 Feb 2020 22:17:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm2; bh=h
        UYsN1IRDrlEB0uxQHQLvlcqoA9TjcxIRinpfgTMp/0=; b=XXy/h+U7Wwb/BSG4D
        c8PjcyCWsIk1Rd13jAQgegM4xS8fOuN1ov2gdbsDYSNy3PXrinTXzEOlNIhWl+ob
        un5b2GXDYVNl64Es23moKifHR0MjNBL4v6MDG8FZjg1duzgXsFucD+vnBtPBt94n
        M23cQMMLEkEA56G5wdrGE+8j9aOQvlwEhEpXWRDcbFazgRv7rdVNtpZRGslF4Myl
        yiUTFrCsXYN4NNYqiukFm/vDMQPOJSsVrrhiQAIuB7xoS5xoVlcwJJSzwgQp/jrv
        0m3iLuLz8I1cXPCal4cRao6mDzDr6xbFA1id3ARsf8XfgJzXAG/Eh84sb5khKF+B
        VCSQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=hUYsN1IRDrlEB0uxQHQLvlcqoA9TjcxIRinpfgTMp
        /0=; b=38X4/aeX+nSPkX0b9fiZoBrJWYH9eI9uEF8FN1BFksP9/rsJem6MHsxSL
        F8x7GQC9eeREFWkrrAhSSA1+HBkfTV6QzlZcF9639EN/cf4hSqb2UxMEVKCShgR6
        UXAYdctO48dhTuc7WK+4KGofzFNe4IeeOI6S014tAwc+pRm4dZp1rKp7sh0JkcBA
        KhJjV6/E7dID+oIovF2K5iaby8ulG42ufVYy7h8aJxOEgXFbbP8o5zGOx+fBCOYU
        cCUkMsaAAFgzgTVYmM6ST/TCviNXMJl07IynIwg8gjLw5gPb8fXzmd5VC0uNoPOT
        UoI89h1udYGvevalQVArvAU8Tmz2A==
X-ME-Sender: <xms:XFdLXht9B8Qf5zYb3xiI2zwpmUFEzQ_AwfRipbb5OJYd8IQsFTwoJQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrjeejgdehiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucfkph
    epjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:XFdLXq48HAIvPM1mp-Ncum_3QC8Cp3v8gEMTmhYP55RjHEsWhLQDFA>
    <xmx:XFdLXlcm-eHBGK7WMd39T5ufO0O9TzhXWHtvO1vX4jErP67b6qZD9g>
    <xmx:XFdLXvxjh1FuEw3fH6fVfDNKP9bo31pdbQrXgSY48QANmUqSTf0-JA>
    <xmx:X1dLXnbMkM62scKMPNlWn66hA7xHTC3iHvsuvMuZo9ZB_dbfbk1tYg>
Received: from [192.168.50.169] (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 96BD13060BD1;
        Mon, 17 Feb 2020 22:17:47 -0500 (EST)
Subject: Re: [RFC PATCH 01/34] ASoC: dt-bindings: Add a separate compatible
 for the A64 codec
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ondrej Jirman <megous@megous.com>
References: <20200217064250.15516-1-samuel@sholland.org>
 <20200217064250.15516-2-samuel@sholland.org>
 <CAGb2v670SH1Ra26eKgOhLYAeRTV719a3TDAfCyMr49bKU8Z=PA@mail.gmail.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <dab9cbc2-c0ad-4f12-e792-a900c13f083f@sholland.org>
Date:   Mon, 17 Feb 2020 21:17:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAGb2v670SH1Ra26eKgOhLYAeRTV719a3TDAfCyMr49bKU8Z=PA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/17/20 3:49 AM, Chen-Yu Tsai wrote:
> On Mon, Feb 17, 2020 at 2:42 PM Samuel Holland <samuel@sholland.org> wrote:
>>
>> The digital codec in the A64 is largely compatible with the one in the
>> A33, with two changes:
>>  - It is missing some muxing options for AIF1/2/3 (not currently
>>    supported by the driver)
> 
> Is this at the pinctrl level or mixer level? If it's at the pinctrl level
> then it's out of the scope of this driver/binding. It could very well have
> those signals, just that they aren't routed outside the SoC.

This is in reference to the muxes shown at the top of the A33 diagram, above the
I2S/PCM interfaces. These appear to map to bits 0-6 of AIF3_SGP_CTRL, which are
marked as reserved on the A64 and the AC100.

Comparing the three datasheets in a bit more detail (but by no means exhaustively):
 - The A64 has a second DRC block, unlike the A33 and AC100.
 - The jack detection registers (0x310-0x318) are present on the A64
   and AC100, but undocumented/missing on the A33.

So there are enough differences to warrant a new compatible, but since none of
the unique functionality is used by the driver (even after this series), a
fallback should work.
