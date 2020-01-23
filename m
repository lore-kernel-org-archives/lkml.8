Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33363C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 23:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0171921D7E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 23:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="N7TA0gcQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729606AbgAWXGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 18:06:12 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:25192 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727056AbgAWXGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 18:06:11 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1579820771; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=hgQq6Cm2C8WFWwe4zjX8Nmm79ZjwTRrTKn+plFJyrz8=;
 b=N7TA0gcQ27QJ03RE3iQuHPQFObslW+B6B9HFg4Oqlrpo2k+0ZWIWtTPoT3PYThdYvmi5hBeD
 2wu6/QlurXm1Mfmyw0iRlmtiyUX0C+V5NFYZtEvEZ9SuTfv94ucNy6bGPhFL2DadVVOQ/HoE
 HG2qCyQFM68J8PF5SFxfPn+Rl1A=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e2a26de.7f30f685b110-smtp-out-n01;
 Thu, 23 Jan 2020 23:06:06 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7FAF5C447A3; Thu, 23 Jan 2020 23:06:04 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: abhinavk)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id ADB32C43383;
        Thu, 23 Jan 2020 23:06:03 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Thu, 23 Jan 2020 15:06:03 -0800
From:   abhinavk@codeaurora.org
To:     =?UTF-8?Q?Ville_Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>
Cc:     Laurentiu Palcu <laurentiu.palcu@nxp.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Uma Shankar <uma.shankar@intel.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        dl-linux-imx <linux-imx@nxp.com>, nganji@codeaurora.org,
        aravindh@codeaurora.org, adelva@google.com, seanpaul@chromium.org,
        jsanka@codeaurora.org
Subject: Re: [EXT] Re: [PATCH] drm: fix HDR static metadata type field
 numbering
In-Reply-To: <20191128111418.GP1208@intel.com>
References: <1574865719-24490-1-git-send-email-laurentiu.palcu@nxp.com>
 <20191127151703.GJ1208@intel.com> <20191128083940.GC10251@fsr-ub1664-121>
 <20191128111418.GP1208@intel.com>
Message-ID: <b9631ab9b7329e8307a3dccb00807972@codeaurora.org>
X-Sender: abhinavk@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ville and Laurentiu

On 2019-11-28 03:14, Ville Syrjälä wrote:
> On Thu, Nov 28, 2019 at 08:39:41AM +0000, Laurentiu Palcu wrote:
>> On Wed, Nov 27, 2019 at 05:17:03PM +0200, Ville Syrjälä wrote:
>> > Caution: EXT Email
>> >
>> > On Wed, Nov 27, 2019 at 02:42:35PM +0000, Laurentiu Palcu wrote:
>> > > According to CTA-861 specification, HDR static metadata data block allows a
>> > > sink to indicate which HDR metadata types it supports by setting the SM_0 to
>> > > SM_7 bits. Currently, only Static Metadata Type 1 is supported and this is
>> > > indicated by setting the SM_0 bit to 1.
>> > >
>> > > However, the connector->hdr_sink_metadata.hdmi_type1.metadata_type is always
>> > > 0, because hdr_metadata_type() in drm_edid.c checks the wrong bit.
>> > >
>> > > This patch corrects the HDMI_STATIC_METADATA_TYPE1 bit position.
>> >
>> > Was confused for a while why this has even been workning, but I guess
>> > that's due to userspace populating the metadata infoframe blob correctly
>> > even if we misreported the metadata types in the parsed EDID metadata
>> > blob.
>> >
>> > Hmm. Actually on further inspection this all seems to be dead code. The
>> > only thing we seem to use from the parsed EDID metadata stuff is
>> > eotf bitmask. We check that in drm_hdmi_infoframe_set_hdr_metadata()
>> > but we don't check the metadata type.
>> >
>> > Maybe we should just nuke this EDID parsing stuff entirely? Seems
>> > pretty much pointless.
>> 
>> I've been thinking about that but we may need the rest of the fields 
>> as
>> well, even though they're not currently used. I'm referring to sink's
>> min/max luminance data. Shouldn't we also check min/max cll, besides
>> eotf, to make sure the source does not pass higher/lower luminance
>> values, than the sink supports, for optimal content rendering?
>> 
>> However, CTA-861 is not very clear on how a sink should behave if
>> the CLL values exceed the allowed range... :/ Also, if the CLL range 
>> or
>> the FALL values passed in the DRM infoframe exceed the sink's 
>> advertised
>> min/max values, I guess the sink cannot go lower/higher than it can
>> anyway. In which case, we don't really need the rest of the HDR static
>> metadata block and nuking that part should be ok.
> 
> I'm thinking we should just conclude that such userspace is a
> buggy mess and deserves whatever it gets.

[Abhinav] The display driver for MSM chipsets relies on the drm_edid.c 
parsing for the CEA extension blocks. The parts which use this shall be 
posted later when we post our changes for HDR support for the display 
driver for MSM chipset. Meanwhile, if there are no further concerns on 
this, we would like to go ahead with this change and get it merged as 
its an important bug fix. Thanks.
