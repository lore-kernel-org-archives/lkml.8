Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14354C35670
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 03:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE0AD2067D
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 03:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="eH3O+Uht";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GyuP/YCv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbgBWDyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 22:54:25 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:44435 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726983AbgBWDyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 22:54:25 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id D30BD141E;
        Sat, 22 Feb 2020 22:54:23 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 22 Feb 2020 22:54:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm2; bh=U
        tQ4ZCxViuOYrkl32VfE2T3Vc4NBhu7cH68gein0hZ8=; b=eH3O+UhtcNk39WqG7
        7++FXGFTX+4Z2PcXe3xjcwJsOODd4hxFQavwi0/mUwTIoxG9JBuAOmvs5HQJt990
        QIgs1pI/FaTRd3ev0T4IL+aTvVevCQh7OFSFWKaP/KY94r+EE9D8RHkP90X8PxFC
        oBLmR6XHSy54HBa/H14DQ7lYQ0J/Ydfp27ocjSVODTDsMZjhEZb10ccofds6YtNi
        oaCndzsfnBoKSmoY5aRfQXCd4KQVTdffKFdF/fHmCrQVYwGy8OLV2MowadGuAqHn
        YIqEA+IgJP8fQu88VichUhpYSu9m/bVcLBBWNImzHZQ0a/ObPiE6NmPeg6oxGd8W
        K6ySQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=UtQ4ZCxViuOYrkl32VfE2T3Vc4NBhu7cH68gein0h
        Z8=; b=GyuP/YCv6RLhHx+tybgAMZbAWarsj8Ii4R+BOab0Cw4iOfoJaifZtVc/6
        5Fd1ZIpBORlLHlM5LdItWCbg4TqjJbGHEkASpjlrm+3gGzqj/BwAaZuqBOH0YZxx
        XM34+pmlF976U4TwYysQcVWaDYNCrA75o/b6cM0a0sM3lmw8zmvMMPJXYX3Fpv4I
        yYjTsV717azlzXouTRBaux6jcJMDECw07ZfLymaJ80a20T9FvQsSwAYXw9m6V4Vd
        pFLgMxSD48vcLM7SooibOaf/fbhrA+Hv9V84TE7nSgj9bXlkh7UwPQfclWjLbRGz
        K9IGLkbdVO+s8xbaE9j7kamSgE9ZQ==
X-ME-Sender: <xms:avdRXiuiOsH3o0DSLtQ5DE1m9D-9YuzK8izj4qTuqAIMxZEQ3TuaEQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrkeejgdeiudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucfkph
    epjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:avdRXn51utho87JkjiCEVKsYSyaYUpq6F3T40tibOEYao28SHO_3Bw>
    <xmx:avdRXjN-2TXP4CKuwakTE1BqjwcSJb_74ylsLvfxdtvCfcsv01adtw>
    <xmx:avdRXrLkOPwWjIuYPLMnhvX-YnhSwzeK0a3As4WIj5J_T5iK2msXFw>
    <xmx:b_dRXgzcsgknp-tn_3NniTdvYlav4zzWm91Lza6tirW8ghCKDJ3peg>
Received: from [192.168.50.169] (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4E23C3280059;
        Sat, 22 Feb 2020 22:54:18 -0500 (EST)
Subject: Re: [PATCH 5/8] ASoC: sun50i-codec-analog: Enable DAPM for headphone
 switch
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxime Ripard <mripard@kernel.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Luca Weiss <luca@z3ntu.xyz>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20200217021813.53266-1-samuel@sholland.org>
 <20200217021813.53266-6-samuel@sholland.org>
 <CAGb2v65v=wPJNxPfOzp2bcevk0qoDiW-+KFBO1MKHz6gE86DPQ@mail.gmail.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <f0037c9d-e3b5-3fa9-1f1a-d52d26de3ed7@sholland.org>
Date:   Sat, 22 Feb 2020 21:54:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAGb2v65v=wPJNxPfOzp2bcevk0qoDiW-+KFBO1MKHz6gE86DPQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/17/20 1:17 AM, Chen-Yu Tsai wrote:
> On Mon, Feb 17, 2020 at 10:18 AM Samuel Holland <samuel@sholland.org> wrote:
>>
>> By including the headphone mute switch to the DAPM graph, both the
>> headphone amplifier and the Mixer/DAC inputs can be powered off when
>> the headphones are muted.
>>
>> The mute switch is between the source selection and the amplifier,
>> as per the diagram in the SoC manual.
>>
>> Signed-off-by: Samuel Holland <samuel@sholland.org>
> 
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> 
> BTW, have you also considered tying in the headphone volume control?
> It also has a mute setting.

As far as I can tell, setting a volume control to its "mute" level has no effect
on the DAPM power state. So I didn't add PGA widgets for the volume controls on
either codec. I can add them if there's some benefit to doing so.

> ChenYu
> 

Regards,
Samuel
