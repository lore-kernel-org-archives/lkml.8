Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41BA8C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 17:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5C85205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 17:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=animalcreek.com header.i=@animalcreek.com header.b="UN+rcElJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FK/WjfGI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389973AbgEMRpe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 13:45:34 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:52707 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732670AbgEMRpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 13:45:33 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 7A5187C6;
        Wed, 13 May 2020 13:45:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 13 May 2020 13:45:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=animalcreek.com;
         h=date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=xZLKTP6SuAU2b/PNRLvKXDiRghb
        LAJbYlskK+OrvLV4=; b=UN+rcElJabEUoY417xGMlUTS0YmSpujr7WLSvuaN35b
        kVxTAJoY0uclFGlYCAWruoC//4GqH8QQzN9dD26y8KOn2cY9NSGtli6tOnOiV7nW
        /3TxXMCZBFSmnCLSp0hkm4kDb6qLfg9JyHfdnY5Trgm5aCKhDLm3xC6waafXn1Vl
        WxeaUsJp5WRwFlR8L3U+yxx3UuAO3HQYUGxK3ZQooJg/U19+tRV7DHtuUy+IkSXA
        w5adOAUgU6WbjgFyRZLoLiALe3V6tqN3tCxYqxmRq0CZ61sjNFVgYK1DqIN1LBJu
        BzFdjG84vR29GhNlOcp0lBB3iyuhXvby9mzdgantSXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=xZLKTP
        6SuAU2b/PNRLvKXDiRghbLAJbYlskK+OrvLV4=; b=FK/WjfGIQUh++ginhi6atC
        NC6dsTooU1rUXjU5Tom/GfmdDMkXSw7JG3XliFX+IKzy8+5XpVikfszaCvY78pdK
        ahklNeeqZA8xi+yAQz7okuiHGgtgZUNiZFOO9FGR6IeAeYd7wikjkO8bh5q9jj86
        MNcbr3ZV0goTdzYM1z3eu+n3G9sd2dEE17LmrOsMZYHCT8byVampHEJ44Tsd4XNC
        UfKCJ6GAgvH9E4HX1oN0Dp8DF/A52yGllXm6FdOYG+Fms860Szc4VbVaWQuCkQUz
        eHljigER6lDJGox2Nry5/3sKm2GlMTqqtWj9sZsvAYuXMppO7TPXywPljFeuwoHQ
        ==
X-ME-Sender: <xms:OzK8Xkvuw1T4NPdrAYzmREF7yFM_9jlkRJPPcAYK7_l0gmDNjoCLxA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrleeggdduudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjohgfsehttdertddtredvnecuhfhrohhmpeforghr
    khcuifhrvggvrhcuoehmghhrvggvrhesrghnihhmrghltghrvggvkhdrtghomheqnecugg
    ftrfgrthhtvghrnhepfeekfeejkeegleduvdduveetteeuueeiveeujeeijeelvdeiveek
    ieevkedvtdegnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepieekrddvrd
    ekvddrudejudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehmghhrvggvrhesrghnihhmrghltghrvggvkhdrtghomh
X-ME-Proxy: <xmx:OzK8Xhf0nR65uNaULO6efOwquN3A1Ah6ClhHaMT2kBvayvb2xtTMGA>
    <xmx:OzK8XvzvIeHSOlNITgSzP9NqG6m132Oqi5UikfgD1l-Q-7dKcAhtIg>
    <xmx:OzK8XnMCQ2LZQ4Wy61LleqOUCdxBmTJE_IpRiGk1Nn1GRoCnCElTlw>
    <xmx:PDK8XjlZkOstIWKTU1jRhu8y5LthaEmy9bsNpq_iELVujSWfjyGgNg>
Received: from blue.animalcreek.com (ip68-2-82-171.ph.ph.cox.net [68.2.82.171])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0F179328005A;
        Wed, 13 May 2020 13:45:31 -0400 (EDT)
Received: by blue.animalcreek.com (Postfix, from userid 1000)
        id 23EC5A21E97; Wed, 13 May 2020 10:45:30 -0700 (MST)
Date:   Wed, 13 May 2020 10:45:30 -0700
From:   Mark Greer <mgreer@animalcreek.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vaibhav Agarwal <vaibhav.sr@gmail.com>,
        Mark Greer <mgreer@animalcreek.com>,
        linux-kernel@vger.kernel.org, greybus-dev@lists.linaro.org,
        devel@driverdev.osuosl.org
Subject: Re: [PATCH] greybus: audio: remove unused code
Message-ID: <20200513174530.GA32096@animalcreek.com>
References: <20200507212912.599433-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507212912.599433-1-alexandre.belloni@bootlin.com>
Organization: Animal Creek Technologies, Inc.
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 11:29:11PM +0200, Alexandre Belloni wrote:
> GREYBUS_AUDIO_MSM8994 is not an existing configuration option and as
> reported in September 2016, it depends on an "out-of-tree qualcomm audio
> driver". This driver never made it upstream.
> 
> https://lore.kernel.org/lkml/20160921073905.GA31263@kroah.com/
> 
> Moreover, there doesn't seem to be any interest in actually fixing the
> driver as it uses ASoC APIs that have been removed from the kernel in 2018
> as shown by its use of snd_soc_register_codec and
> snd_soc_codec_get_drvdata, removed in commit 999f7f5af8eb ("ASoC: remove
> Codec related code").
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---

Everything you say is true but it is still kinda sad to see this go.
But that is life...  If and when someone has the motivation to get this
working again they can take a look at the git history.

Thanks for this, Alexandre.

Acked-by: Mark Greer <mgreer@animalcreek.com>
