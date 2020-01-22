Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D89DC2D0CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 03:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DFAF24655
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 03:14:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="H4sA/hGQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ePEQPrjg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729149AbgAVDOF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 22:14:05 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:60751 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728779AbgAVDOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 22:14:05 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 1608021D28;
        Tue, 21 Jan 2020 22:14:04 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 21 Jan 2020 22:14:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm1; bh=u
        I2Jj83KkBM6GFpFG2YpA86VHpsZUXcAMazv7LmSF2o=; b=H4sA/hGQXNzw7lAfI
        6g8M+G30X90rGDdOhriTl6lfKMSyibearyIaSENDMJ4KfBmTi3W//lpLVoLyBm80
        UOGalG3SVYXghn9fNKzZxFyOmhkfC+DqDEDyYU2BS+RmlkJLO4PzyUKAsf9FWncx
        vKQuHyZVM1jjY5TkDdGiABe9WG99xpa7tSiM415HG9Kd3cT3wIkQJdEsmChRZcGL
        qCValxII3hurY0t7795yG56IsBo4/ftl8PCcDKaKQHVJhvRin5/XL9TfY83L7fHN
        TbyWpxo6SazvXbhLCzpPSQUGxca39uX1NQ7PitcoPFGNwxa3PK9dnMRQkT1qn7uO
        Py7aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=uI2Jj83KkBM6GFpFG2YpA86VHpsZUXcAMazv7LmSF
        2o=; b=ePEQPrjgAxvm/rZuNIapJYgIKYh6ezgRIaj0FvcdWp6+Yox+iPFU8908+
        hDzmZPU7n8fhLwppPXjcW/HouJwDBrWvO81gve01DzSmiSMAOjhEvC8ulOAz1n0s
        x1m4Cg98bUuVvtCPWEPBsE1adHpTnXhZVCaghtUF1C3W8kxo5/IU+i9ThO23IOwF
        fNBt9MC5ksoZW7m5I2bljiIHrPe7DoMd9k0TKRJBP24y830LNKRorW4QRbJ3OYxE
        1uuaTGMVsF8sLa2CCz5nwaMSqA2P5ovSzb7gQcdj6XzHr8SfX/LfaRzx6O2AAG2W
        LlSMmRg3+Qk5RcI+vLthNeOqIWncw==
X-ME-Sender: <xms:-70nXov04EV7GWVpWvSY_YVh2Na4NXReOG-VWYJZzZYRA36itEPoRA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrudelgdehtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucfkph
    epjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:-70nXogCFgddc89EpzTRXGf2cXiD1RZLWOZr-tl4KCv2BI-yIK26ig>
    <xmx:-70nXuYbI2weN6V5l2M19_97LUzbKVjMtCknTgzFWsaSYMHQcOqWZw>
    <xmx:-70nXnb8DZv0EMOMxL0zZErSnujLesCUFGKwskzyJvQ-hrNER2TyeA>
    <xmx:_L0nXj2kSPf2OyShrLWRpIw6HTWi360U_9TOLO_xpFPTUZmNipq2hA>
Received: from [192.168.50.169] (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id CAE1D328005C;
        Tue, 21 Jan 2020 22:14:02 -0500 (EST)
Subject: Re: [PATCH 3/9] arm64: dts: allwinner: pinebook: Remove unused AXP803
 regulators
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
References: <20200119163104.13274-1-samuel@sholland.org>
 <20200119163104.13274-3-samuel@sholland.org>
 <20200121090539.mgswdzfharrfy5ad@gilmour.lan>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <8006a501-733e-b998-edb3-378769cd3a4c@sholland.org>
Date:   Tue, 21 Jan 2020 21:14:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200121090539.mgswdzfharrfy5ad@gilmour.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/21/20 3:05 AM, Maxime Ripard wrote:
> On Sun, Jan 19, 2020 at 10:30:58AM -0600, Samuel Holland wrote:
>> The Pinebook does not use the CSI bus on the A64. In fact it does not
>> use GPIO port E for anything at all. Thus the following regulators are
>> not used and do not need voltages set:
>>
>>  - ALDO1: Connected to VCC-PE only
>>  - DLDO3: Not connected
>>  - ELDO3: Not connected
>>
>> Signed-off-by: Samuel Holland <samuel@sholland.org>
>> ---
>>  .../boot/dts/allwinner/sun50i-a64-pinebook.dts   | 16 +---------------
>>  1 file changed, 1 insertion(+), 15 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
>> index ff32ca1a495e..8e7ce6ad28dd 100644
>> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
>> @@ -202,9 +202,7 @@
>>  };
>>
>>  &reg_aldo1 {
>> -	regulator-min-microvolt = <2800000>;
>> -	regulator-max-microvolt = <2800000>;
>> -	regulator-name = "vcc-csi";
>> +	regulator-name = "vcc-pe";
>>  };
> 
> If it's connected to PE, I'd expect the voltage to be at 3.3v?

If we provide voltage constraints, the regulator core will enable the regulator
and set its voltage at boot. That seems like a bit of a waste.

I don't think the voltage really matters, since nothing is plugged in to the
port. ALDO1 can't go over 3.3V anyway, so even if it does get turned on for some
reason, nothing will get damaged.

Samuel
