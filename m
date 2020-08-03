Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC5CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 09:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6980B2076C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 09:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="FHGHZXbv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gpplXFCE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgHCJsQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 05:48:16 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:48863 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725965AbgHCJsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 05:48:16 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.west.internal (Postfix) with ESMTP id AC4E94CE;
        Mon,  3 Aug 2020 05:48:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 03 Aug 2020 05:48:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm1; bh=P
        Ah/QgnU8giEcq5Q8p8XRD4UtgQHwSy9znrXba7ez8g=; b=FHGHZXbvuwoHIHiEm
        yBK203NMEXR4zbhmF1L8LqU6mRJWKb20OdkvpsqVCis3pz0fVgb86CB5tYx4WB3W
        HeVF4keWM1UUqTTLwJbK5tKjAWy5b9XSDzqN8K8FZDwWRySXf0ddoOfWUboA98nm
        3fxq7Ex3bUG8JFkkrnHITBz5NNZ4mqQzpH1iVLYC2mvU81X0wzojhBaSTcM1fvnB
        24k75Odte6QLKpv2FeT0ZOVOHQLWbwW14xf/BKMblybG7Yg5Qrm0peBQAD9E+dUK
        PgHyvk3SyXvNyhXUR/Ti9S3QH57+/f4YMQLMWkf6oIH2SzgwZMbB2/fA2EIH0qs8
        5qcLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=PAh/QgnU8giEcq5Q8p8XRD4UtgQHwSy9znrXba7ez
        8g=; b=gpplXFCEsMdYjTg8q4hJusCfUq0RytmTceJI5f1TCdheqbLqRTExXQCP+
        E+63GpND7VkaboPBd3q2uqx3C/0vaUiM8Gnv1sDOsWOOeRLqYZbT44cjVouf+4al
        YK4QVpQEQmeileh8HUvyJUaKRcM/41GzamU1ecaABMJ5jcDqddyjZNxBCnmSqxyQ
        Ra4Z1JySM1deGz+f36AccEYp1XmVf4iLKKsJU4ZdkqjreG+PzPKiwHPV8omSu8if
        8JGhCHQPPDURz4JUkclcDj7QYHzX7k5wmozrWyab5jvHoQpIG0ZFF8JHuRdtuNwZ
        OQTQXwaK6oV9rdTjsMmNH5Pl4Mmxw==
X-ME-Sender: <xms:Wt0nXw1OoauseHtgsCTfV0xiHeHau_4PaIoo97iBnP9R4NAIxAt8Sg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrjeeggddvtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeeuheekhe
    elffefieduteefkeejffdvueehjeejffehledugfetkedvleekudduvdenucfkphepkeef
    rdekiedrkeelrddutdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:Wt0nX7EFwIHLGFYlu0YLmiX00eeaAiOhRil13wHTkLj6OXCvckaEPQ>
    <xmx:Wt0nX47Ka3jQMVSBjFVIWUKw-_HvMNvyAvxAR-v2Th82wZWXNjxlwQ>
    <xmx:Wt0nX50-rEGku_Uaa_ygaSQXqFZ20P9dmSU7g5aEjAi18UJ6DCRBhg>
    <xmx:Xt0nX787BykcRoC2KEHCZaItB0cJDiShGwLXgsQXmMD1m50OJ4c3RNNmge0>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0B44230600A9;
        Mon,  3 Aug 2020 05:48:10 -0400 (EDT)
Date:   Mon, 3 Aug 2020 11:47:53 +0200
From:   Greg KH <greg@kroah.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Kyungtae Kim <kt0755@gmail.com>,
        Anthony Liguori <aliguori@amazon.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        DRI devel <dri-devel@lists.freedesktop.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        Solar Designer <solar@openwall.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        xiao.zhang@windriver.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        =?utf-8?B?5byg5LqR5rW3?= <zhangyunhai@nsfocus.com>
Subject: Re: [PATCH] vgacon: fix out of bounds write to the scrollback buffer
Message-ID: <20200803094753.GC635660@kroah.com>
References: <659f8dcf-7802-1ca1-1372-eb7fefd4d8f4@kernel.org>
 <dbcf2841-7718-2ba7-11e0-efa4b9de8de1@nsfocus.com>
 <9fb43895-ca91-9b07-ebfd-808cf854ca95@nsfocus.com>
 <9386c640-34dd-0a50-5694-4f87cc600e0f@kernel.org>
 <20200803081823.GD493272@kroah.com>
 <CAKMK7uEV+CV89-L1Y=dijOEy8DKE=juRfQDnNnbhbAJhFh1fYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKMK7uEV+CV89-L1Y=dijOEy8DKE=juRfQDnNnbhbAJhFh1fYw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 03, 2020 at 10:45:07AM +0200, Daniel Vetter wrote:
> On Mon, Aug 3, 2020 at 10:26 AM Greg KH <greg@kroah.com> wrote:
> >
> > On Mon, Aug 03, 2020 at 10:08:43AM +0200, Jiri Slaby wrote:
> > > Hi,
> > >
> > > On 31. 07. 20, 7:22, 张云海 wrote:
> > > > Remove whitespace at EOL
> > >
> > > I am fine with the patch. However it should be sent properly (inline
> > > mail, having a PATCH subject etc. -- see
> > > Documentation/process/submitting-patches.rst). git send-email after git
> > > format-patch handles most of it.
> > >
> > > There is also question who is willing to take it?
> > >
> > > Bart? Greg? Should we route it via akpm, or will you Linus directly? (I
> > > can sign off and resend the patch which was attached to the mail I am
> > > replying to too, if need be.)
> >
> > I can take it, if Bart can't, just let me know.
> 
> Yeah vt stuff and console drivers != fbcon go through Greg's tree past
> few years ...
> 
> Greg, should we maybe add a MAINTAINERS entry that matches on all
> things console? With tty/vt you definitely have the other side of that
> coin already :-)

Sure, that would be good as things do fall through the cracks at times.

If you write the patch, I'll merge it :)

greg k-h
