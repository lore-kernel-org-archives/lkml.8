Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F3FEC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 22:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C0482076A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 22:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paritcher.com header.i=@paritcher.com header.b="rGNS6zOb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WzPLVroi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgFHWxj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 18:53:39 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:60967 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726741AbgFHWxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 18:53:39 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id DA89239F;
        Mon,  8 Jun 2020 18:53:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 08 Jun 2020 18:53:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=paritcher.com;
         h=subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm2; bh=3
        jh/hXqtwrVde4hwUMJcqaoBBkboOW+sBG60pKPoYUE=; b=rGNS6zOb0vRoTk7eH
        xE8QhyjOMN2aqxxIkO4mZcml4MX1FGAReo10yTqpd9mImlgBTs7MdSBmZqdmVB4V
        NUR3qX4rel1Vo4xm64RPzb5ywqeSGjXE8ddwsCY1ZLtq68p8HDQqrg6kKfGNIHtN
        aTViHunKLH4JkhUA3D78FGEF1DFiVyOYOn5+Qo2vFrmck5stcbEWfGWjj6ZOzqa6
        jIJ5AIBBFtuDg0d+h12aiwBRpLHxwA+0YbG2se0tK3bM+/XGodRvGZxB3cyRuliq
        m/PQd+999yfEXmXUuFndnVPj9LN9oH2coiz2Fadbd8hu6YGijZtHGk+Aj9Reu3DR
        SqgPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=3jh/hXqtwrVde4hwUMJcqaoBBkboOW+sBG60pKPoY
        UE=; b=WzPLVroiiKX2va7udeV3luWIulkly7vsRm07B0C5t959NPON9issoe7Ch
        8j+B+kg/7KnycpbeGoa5HwXFonmxn8Cbz58vYWC46rZQIT1VuMuCwVPGFb2hJl5n
        gzBz3ckZePFHoVvPnHBiVp9iqT+8zRRO0+DWQnFQQ2v7W75gw5SRSCOhAgqGEeXs
        nXLPPEqIs0UnkrDsjInP8fAhCD38QT9zxWtE8PAEUEytdtYcIgX+F3RvpZqg9p2Y
        nzeo7FcQ1DCoKvKJIX+FVg5Klg9YSXa7xedPGK+hXCXPxDugGfon4EZRAoUatYy3
        9nUj2xBE1/3ULkwskOb073+MyFfqg==
X-ME-Sender: <xms:cMHeXq9i42UWmqlFTFqO1T83GG3rd5SqvD1cbt8sDMqdgvumyFOLoA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudehfedgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefuvfhfhffkffgfgggjtgfgsehtje
    ertddtfeejnecuhfhrohhmpegjucfrrghrihhttghhvghruceohidrlhhinhhugiesphgr
    rhhithgthhgvrhdrtghomheqnecuggftrfgrthhtvghrnhepieettefgffetfefhfedtve
    duffeltdeujeehveehteefheeludeijeegudekteeinecuffhomhgrihhnpehgihhthhhu
    sgdrtghomhenucfkphepieejrdekgedrudelgedrudejheenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeihrdhlihhnuhigsehprghrihhttghh
    vghrrdgtohhm
X-ME-Proxy: <xmx:cMHeXqtaxK_cgVAkOF6xOrKDsvikxb5iBcgaeg-J83o2LiyTfUbw6g>
    <xmx:cMHeXgCVFBff5JLIZFLaYt10_WVwfiPXvb7fxLZ28jd5ItX_UM-Euw>
    <xmx:cMHeXifdhPJkSY3a3UthGPclt6AgPp4rHeBKXF6vf2vFiuDYwC5Jzg>
    <xmx:ccHeXobww17DDzAUpOaerii8XIHgRemH9NcbnWnBQ4jzSRoL7oH-ew>
Received: from [192.168.0.106] (ool-4354c2af.dyn.optonline.net [67.84.194.175])
        by mail.messagingengine.com (Postfix) with ESMTPA id 52A69328005E;
        Mon,  8 Jun 2020 18:53:36 -0400 (EDT)
Subject: Re: [PATCH 2/3] platform/x86: dell-wmi: add new keymap type 0x0012
To:     Mario.Limonciello@dell.com, hdegoede@redhat.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        mjg59@srcf.ucam.org, pali@kernel.org
References: <cover.1591584631.git.y.linux@paritcher.com>
 <0dc191a3d16f0e114f6a8976433e248018e10c43.1591584631.git.y.linux@paritcher.com>
 <83fe431cacbc4708962767668ac8f06f@AUSX13MPC105.AMER.DELL.COM>
 <79bd59ee-dd37-bdc5-f6b4-00f2c33fdcff@paritcher.com>
 <7f9f0410696141cfabb0237d33b7b529@AUSX13MPC105.AMER.DELL.COM>
 <01169d6e-1bb1-6fc5-0690-0e8f44941cce@paritcher.com>
 <6cfba0ce42a74b39b5b80e9c621e2601@AUSX13MPC105.AMER.DELL.COM>
From:   Y Paritcher <y.linux@paritcher.com>
Message-ID: <53ad1d28-91d1-5dd0-3430-e2ee752df06f@paritcher.com>
Date:   Mon, 8 Jun 2020 18:53:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <6cfba0ce42a74b39b5b80e9c621e2601@AUSX13MPC105.AMER.DELL.COM>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/20 6:00 PM, Mario.Limonciello@dell.com wrote:
>>
>> this is the WMI event from pressing the Fn lock key.
>> this indicates which mode it is switching to.
>>
>> this changes if the default for pressing the F[1-12] should be Function or
>> media.
>> the scancodes of the Fn keys are properly transmitted, this just inverts
>> which
>> ones are sent by default and which are sent when pressing the Fn+F[1-12]
>>
>> In other words, there are 24 scancode the only difference is which 12 are
>> default
>> and which 12 are when pressing with the Fn key
>>>>
>>>> Therefore i agree this should have it's own case in
> 
> To me this sounds like it makes most sense to either be an evdev switch which indicates
> which mode the fn key is set to when an event comes in.  You can populate the starting
> mode by looking up from a token.
> https://github.com/dell/libsmbios/blob/master/doc/token_list.csv#L987
> 
> Any other thoughts from others?
> 

beware that sometimes the key will do the unexpected.

If the Fn lock is turned off in the bios pressing the Fn lock key
will send an event with the current mode again, as switching is disallowed.
