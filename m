Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF83CC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 17:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7B0420857
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 17:22:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="TX8yNEUF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="u9iuXcN8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410900AbgDORW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 13:22:58 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:50063 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2410883AbgDORWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 13:22:48 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.nyi.internal (Postfix) with ESMTP id 5AE2958054D;
        Wed, 15 Apr 2020 13:22:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 15 Apr 2020 13:22:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=+9pS+Lww9pp81wlpMSHXf6JJJqt
        59DLNDjOv+mJX+Fo=; b=TX8yNEUFAVsOBedp5kU71xNy5+dKTRS3wK32rA9LmoR
        JkRDf3NgmwfdNo0HWR65mMXUGxEUpy+ehRRpGkQvQJQNCM1EbKxVoLD7qkwB5tXq
        foNdXnpB/cwC+MBwvD0uuUsZJ9ryvE8OsX6aDQY3kSD8+2+jCWkMysHt3hDjdmJ3
        HL2Rs+9Wgmhjlj27diaPrvX8h8MeSiGxuoIZ6qCVjubERN7zoQnUULn+hclNfzme
        ovM2AIZ0jKP7BWwUtDemy4YEAyHeD/tS4IVw3/ouAblZm08LIfkDWu+LHiacXZcB
        cfhhYMf/xsN63UgRJfWIX92odxu16b+73lzuRz+RsGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=+9pS+L
        ww9pp81wlpMSHXf6JJJqt59DLNDjOv+mJX+Fo=; b=u9iuXcN8qiB7ininjhOfQN
        L2ND+zrAz0I3vdOhLul7STU3IpQoYs6QxyfkILTWP3fzskU1Qj7qEFTSSg7QScsG
        50ffkwXcLUGAhTCeJTRgiT1fjbjhe7efz3l7f36YTDzIelWP95YQ3rJbbapkmf/A
        7UD2v8LycpqMC9S3t700yzC7A7RA7r9gXPHxHsR9wnpd+HcPCQdNGx0FjuWTQ1M0
        vhMaF6WQWgUduEksaJVBcWUhM3fh8AnD4sd9JATOBUQ/rLk8TqNukFafCz2Sbjf6
        4n3GjuXpXoqEvX0UH6m+QKm6Tih/2j1ASWRcTn3b6aAUw5ETS+h2xPmGJSr28oHw
        ==
X-ME-Sender: <xms:5UKXXsPHVwV25eeKv6wAPxK6kuYfWuK31vQSugDFMSR0v0asgCGdkw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrfeefgddutdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucfkphepkeefrdekiedrkeelrddutd
    ejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhr
    vghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:5UKXXkg8pC5dMvc1k9xcjLEOTDYYiJ13H6H3hqSshYYQ8_e7spMJDg>
    <xmx:5UKXXplBQuQaKW-VRAnippP3GHrkpTOcYeXqK3EveX-8p3RspPDNVA>
    <xmx:5UKXXgid11FN-OACi0LpvSrCMSrk9f-1G8GEGvqpIaZojX2nTGSjWA>
    <xmx:5kKXXsAbo-aeGlWQR78SNMQsgTTyyDCigVuQko-r6KC_H56Ev2dJOA>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id C69EA3280067;
        Wed, 15 Apr 2020 13:22:44 -0400 (EDT)
Date:   Wed, 15 Apr 2020 19:22:43 +0200
From:   Greg KH <greg@kroah.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Richard Palethorpe <rpalethorpe@suse.com>,
        Kees Cook <keescook@chromium.org>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, security@kernel.org, wg@grandegger.com,
        mkl@pengutronix.de, davem@davemloft.net
Subject: Re: [PATCH AUTOSEL 5.6 068/129] slcan: Don't transmit uninitialized
 stack data in padding
Message-ID: <20200415172243.GA3661754@kroah.com>
References: <20200415113445.11881-1-sashal@kernel.org>
 <20200415113445.11881-68-sashal@kernel.org>
 <87h7xkisln.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h7xkisln.fsf@x220.int.ebiederm.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 12:09:08PM -0500, Eric W. Biederman wrote:
> 
> How does this differ from Greg's backports of this patches?

His tool didn't catch that they are already in a merged tree, it's a few
steps later that this happens :)

greg k-h
