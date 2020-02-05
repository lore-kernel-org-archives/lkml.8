Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B84C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 15:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABA512192A
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 15:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cock.li header.i=@cock.li header.b="CrlkeOUt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbgBEPsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 10:48:42 -0500
Received: from mx1.cock.li ([185.10.68.5]:36725 "EHLO cock.li"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726661AbgBEPsm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 10:48:42 -0500
Date:   Wed, 5 Feb 2020 18:48:29 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cock.li; s=mail;
        t=1580917711; bh=YpQAOhC6zw8KkgDRwc/Chjw22SjapGWj8KZDT6YUh08=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CrlkeOUt2vM5TosW5QTQIUNJkNFcAgcUy78QQI55D0r9c/GTV8eOZ4wRe68i1xwe5
         hDO6dATizGy1uUQLiAtFrkxa+DuGVwJHF4r92yjzRQDVnn+zAJfRHvJh5AUal8cFQU
         ICfzGOy6mJaePLx3l/YRO+3kOXHF4A2Ox4HEBdG7IBGSPNsJf5rkScU1jhbC+UG1fy
         g07PjICV/5Ygf8uvwrMGvP7WpYr2J09wRuHCpaN9WHwRrlFpEfT/cTK+u2z9i4d9l7
         8a4eZrntBmoQOP2WdCrcwB9KZCMvLNPm7a7CFyt6nIp8TNWXnLy9YPs0Qdh0+JmMW6
         kep5BFc6A/2rA==
From:   l29ah@cock.li
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     v9fs-developer@lists.sourceforge.net,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] 9pnet: allow making incomplete read requests
Message-ID: <20200205154829.wbgdp2r4gslnozpa@l29ah-x201.l29ah-x201>
References: <20200205003457.24340-1-l29ah@cock.li>
 <20200205073504.GA16626@nautica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205073504.GA16626@nautica>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2020 at 08:35:04AM +0100, Dominique Martinet wrote:
> Sergey Alirzaev wrote on Wed, Feb 05, 2020:
> > A user doesn't necessarily want to wait for all the requested data to
> > be available, since the waiting time is unbounded.
> 
> I'm not sure I agree on the argument there: the waiting time is
> unbounded for a single request as well. What's your use case?

I want to interface with synthetic file systems that represent arbitrary data streams.
The one where i've hit the problem is reading the log of a XMPP chat client that blocks if there's no new data available.

-- 
()  ascii ribbon campaign - against html mail
/\  http://arc.pasp.de/   - against proprietary attachments
