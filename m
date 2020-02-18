Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF2DC34031
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 01:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FA1B208C4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 01:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="CSF1Iph5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GVNTuwA5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgBRBow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 20:44:52 -0500
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:44041 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726107AbgBRBow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 20:44:52 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id CC3CE6CB1;
        Mon, 17 Feb 2020 20:44:51 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 17 Feb 2020 20:44:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm2; bh=k
        tP0xjLMEYow5iCaqBZHaqnwO8wceFlWoz7H7k4O0xM=; b=CSF1Iph5pp4vOyZeL
        LGmqeplv+4ylrO/x70YmMfcWggiReinVQ3yb90y947u4uncH8wP66FQrAaIcXRY1
        niPYqALKjfxthOU5BoK3N8KCBjjEuXdNrNJ7CUOHgax/mKCY4VtH/c4x8pwI+VEb
        IOj6YcK3bGb0rkkL1NWBTFZ4KveA1N6Nl35GVlfRj8ZOldCctkvhwFPSb6xgbdcN
        QaHgqAFk6QId33dp/3boQGeRuOJwmrDz8ZGi847KuAFi6n+d3jbq1VWOFcItMV/5
        Wfvy7PvqW7M4nmqo8D5rqxadkZ8ek2LnfVL0Wl0TvfAPB9rPZyLYitdcs6zKOadG
        kYaCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=ktP0xjLMEYow5iCaqBZHaqnwO8wceFlWoz7H7k4O0
        xM=; b=GVNTuwA5FHJB7rHrw/IlqU+ChDQVJwnXfOBzXIcglBuetJUkEzMBtyCk/
        hSLS6RKANUBT8bIibhU+2mhlyVHauVATvTEcxtN1UJxjZnYDpxMvVSyFjWraokB/
        Fduimjg06dChp9OeyqHfs/y38GTafH39Q6SNmaWmBJDb0jkMGYp+utesivcrRBre
        imap9PkskDGb6Ot6RDo4ZjlvNC50W21naaSXfh227bNdhH/sxpiQBSw6mPdE16sZ
        urL/zNgWFKYok8BYY+KH/O4jik7JjrDJjy3Wmp1Gp/6+KjhrSGv5ExrkT9GcmxRd
        wKPT+SrqFtqxpXVjOgvVioDlp/49g==
X-ME-Sender: <xms:kkFLXpFVoqimNSYPZ9i_OtN7A_2b2eQVo-jr8hcxqeEe16FtTMEE1w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrjeejgdefjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucfkph
    epjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:kkFLXp_ry0IomhF9gV77h-FQeJdENobIvLxdsoVEfGSdcG5fNB-KhA>
    <xmx:kkFLXlmj-llT9aC3l-_jsDWxPiPcgd_2vWob-w5npInW2CvSx2JfBA>
    <xmx:kkFLXs-b9KWeuSg9QslXBZhqkMGigL59cx7ZIhKs2042twxghnhAhA>
    <xmx:k0FLXoVLLKcqDWrf4DXnoRpIvRmxqIcjWWh3soQfruWpxMbN4fCH7A>
Received: from [192.168.50.169] (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 219B33060C28;
        Mon, 17 Feb 2020 20:44:50 -0500 (EST)
Subject: Re: [RFC PATCH 08/34] ASoC: sun8i-codec: Fix direction of AIF1
 outputs
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        =?UTF-8?Q?Myl=c3=a8ne_Josserand?= 
        <mylene.josserand@free-electrons.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@kernel.org
References: <20200217064250.15516-1-samuel@sholland.org>
 <20200217064250.15516-9-samuel@sholland.org>
 <20200217150935.GJ9304@sirena.org.uk>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <7108ff30-df7e-09bd-f895-2768347d45ba@sholland.org>
Date:   Mon, 17 Feb 2020 19:44:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200217150935.GJ9304@sirena.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/17/20 9:09 AM, Mark Brown wrote:
> On Mon, Feb 17, 2020 at 12:42:24AM -0600, Samuel Holland wrote:
>> The naming convention for AIFs in this codec is to call the "DAC" the
>> path from the AIF into the codec, and the ADC the path from the codec
>> back to the AIF, regardless of if there is any analog path involved.
> 
> This renames widgets but does not update any DAPM routes from those
> widgets which will break things if this patch is applied.

This commit doesn't change the widget name, only the widget type. My commit
message did not make that clear.

>> Cc: stable@kernel.org
> 
> Why is this suitable for stable?  It's a random textual cleanup.

This was one of the first patches I wrote. Now that I understand DAPM better, I
realize that it has no functional impact, and this shouldn't go to stable.
(snd_soc_dapm_aif_in and snd_soc_dapm_aif_out are handled exactly the same, so
fixing the widget type is, as you say, just a textual cleanup.)
