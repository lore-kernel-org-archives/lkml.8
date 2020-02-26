Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13EFC4BA0A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 08:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 847FD2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 08:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582704820;
	bh=Jc4KiNe4cGsOZ/mXK2zjduTE0d6loaPYU5Q5ADoI4bg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UbmLhF9/nNkuQK3pWJXF4yYr8Th28tZBxWjY+Gcl41QRQIxWfzOyfoyr3BZAOTj/f
	 64R+p6cV/UFRJzb7nsMASv8czeyDA7naXU4mYCyrGp9oHvKRtZRAnTrqq1xGIYMLZN
	 U3lB9NEnWnFiih9FUflFHeLuqifbXHQmWOWcR3D8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbgBZINj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 03:13:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:39026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727335AbgBZINi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 03:13:38 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A46D120714;
        Wed, 26 Feb 2020 08:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582704818;
        bh=Jc4KiNe4cGsOZ/mXK2zjduTE0d6loaPYU5Q5ADoI4bg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YqLbp6pj5Nj2p7AU9F5ywlTWOYjyx0m8WJZ4ffje7253Aaw8Jzrwy6orNz9L6t5Lx
         bN0z/xePKMNmjrGsxT4YtM0f8pYEY5HUaOZXiBkdf3udUSISEXJGNy08DKqQVpk17o
         OpKHketkBbbECCrk2o43xIq7EFKjpJr2UjFzox6Y=
Date:   Wed, 26 Feb 2020 09:13:35 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v6 1/9] sysfs: add sysfs_file_change_owner()
Message-ID: <20200226081335.GA24447@kroah.com>
References: <20200225131938.120447-1-christian.brauner@ubuntu.com>
 <20200225131938.120447-2-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225131938.120447-2-christian.brauner@ubuntu.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 02:19:30PM +0100, Christian Brauner wrote:
> Add helpers to change the owner of a sysfs files.
> This function will be used to correctly account for kobject ownership
> changes, e.g. when moving network devices between network namespaces.
> 
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
