Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03DC7C83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 13:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D39122074A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 13:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="KcORmTwB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="glTvmjbh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgD2Nrc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 09:47:32 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:56939 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727097AbgD2Nrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 09:47:31 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 4BB505C0362;
        Wed, 29 Apr 2020 09:47:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 29 Apr 2020 09:47:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=ZtmyBzh7bLCldw/wlH0J/tpDJSm
        05VenlMtaCxkWbDY=; b=KcORmTwBygMOezk0wTZoraVHmCMIDRZuIfZgQCN2l84
        3c15BFoNpgTv4Sl2sx9exjhfNL/VVjOl7Z7aVPljDmWr84APlOZWJRnWg8gRXE9e
        obVBDC1mckRPXBG2PThHelQbnvpa5N8FiOkN+4tJyHh43je5zFH1PPVZJTyVGUXD
        Yd5cmAaOkUsqw+ECJbY2n+80x78GgglX8pK07P+KXDho8mdv9/6gi9Cbq3KiKzgf
        Odh6Msn7EhEk8C+S3E6CqzIyNgTLD5BmHCiGYvRAt3pZqV3guRFVRCbqNg5r3OO2
        v9GmNe6cmXitAc01zZMJ/hQN4XEfY5MtmJhjqCOoQcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=ZtmyBz
        h7bLCldw/wlH0J/tpDJSm05VenlMtaCxkWbDY=; b=glTvmjbhYSz2TuEcQUMSLo
        GNtV6+K1nJp9LdCyKMWpmgxrakXqz5cd1xYADonx9YYSx3R2RY1mPoRgvJLjP/R5
        V+QWg99izGrb8V6nJIancrPQyo6Ps9sgp5vezXU2fAYrH0cE+tKhTp1bKIf2f1Gt
        5z5o8KyPbw7VTm2mgtgPteqttzy+BUMO4aTa7mUcyCQ3qVxN6jg7kP98BlApMP9U
        i3P8BGNsZFlOb4FQhhBER3F8g1auvRjVpzomgWisgzojRrAFNoZK5jJgPMH0jGmd
        aCvwyHmzSH7ZsNLzFKrzyyeM7DlQBgkazFnfxQHvKy2NTho0psv3wyePq9RGY64w
        ==
X-ME-Sender: <xms:cYWpXtSDNRYQkfeQuLvW3ydx_eAudWCT8CcTVjIk69NhEAhEeNs6PA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrieefgdeijecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeen
    ucggtffrrghtthgvrhhnpeevueehjefgfffgiedvudekvdektdelleelgefhleejieeuge
    egveeuuddukedvteenucfkphepkeefrdekiedrkeelrddutdejnecuvehluhhsthgvrhfu
    ihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtoh
    hm
X-ME-Proxy: <xmx:cYWpXvgvJ8dxWfIUVFYWwqY64Zr05v_DcRVRyYBtpiY8p2OSgo7VGA>
    <xmx:cYWpXoQ9s7jgbau7OlskkbKttOtcRvBgbX4LyjLnobeb1EYyFKO0-w>
    <xmx:cYWpXotRLve3jfGv_zHHVjCo3hZcY9zYAlZBpqZs8bL0AhZMX3Cnlg>
    <xmx:coWpXsRvG9AA4YfYGgD90uAzmGgeQ8ogYJ-AaswW6J9gF0priU_fdg>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 889BE3280064;
        Wed, 29 Apr 2020 09:47:29 -0400 (EDT)
Date:   Wed, 29 Apr 2020 15:47:28 +0200
From:   Greg KH <greg@kroah.com>
To:     Akira Shimahara <akira215corp@gmail.com>
Cc:     zbr@ioremap.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/5] w1_therm: Optimizing read timing by checking
 device resolution. Updating documentation
Message-ID: <20200429134728.GC2132814@kroah.com>
References: <20200429133320.140458-1-akira215corp@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429133320.140458-1-akira215corp@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 03:33:20PM +0200, Akira Shimahara wrote:
> Patch for enhacement of w1_therm module. Added features :
>  - Optimized conversion time regarding to device resolution
>  - Dedicated sysfs entry for, resolution set/get, eeprom save/restore,
> 	and additionnal temperature entry to ease user data collect.
>  - Code optimization to mitigate bus traffic

When you have to list different things you did in a single patch, that's
a huge sign it needs to be multiple patches.  Please break this up into
one-logical-change-per-patch.

thanks,

greg k-h
