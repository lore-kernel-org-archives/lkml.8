Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7905C35671
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 17:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADF39206ED
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 17:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582478751;
	bh=/XKa3BFRoBFcTCYsAFpSQqMrFFlg1SCddpWYBY2aSx0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=f4Lgt6tbFWzqdRO114uW7GzdMT/NEmuDHSU5k8QiK47mCe/A7Mtf+Pe0VHbOK7hFy
	 itP9UHnbWc+vJeKCR0AHeqFOioPyQviZx15yKWD21bsbHi+/7PyYWXruYiidUq5A9W
	 ISzAuSvnbV9BStRHIxrbHJEsPU1Mv6tZAPzyvR6M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbgBWRZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 12:25:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:60584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbgBWRZn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 12:25:43 -0500
Received: from localhost (95-141-97-180.as16211.net [95.141.97.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 948A92067D;
        Sun, 23 Feb 2020 17:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582478743;
        bh=/XKa3BFRoBFcTCYsAFpSQqMrFFlg1SCddpWYBY2aSx0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=paYladZMtZEgIYpny4kTreoohUj7Hk277otkGLZBd9Nsun6pst8BWdhM0nIHY2Zxs
         wLAaaDMZAhIhw1XIlHyFj0KYK3VNbFPnC7YT/CoA1CvfjQUdqosa6zOlMNVoAyQOQB
         XeJjeap9UkUAIBTwhc7hzE3joxAyxn9fVVbEg/J4=
Date:   Sun, 23 Feb 2020 18:25:40 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 5.5 000/399] 5.5.6-stable review
Message-ID: <20200223172540.GB349989@kroah.com>
References: <20200221072402.315346745@linuxfoundation.org>
 <20200223154024.GA131562@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200223154024.GA131562@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 23, 2020 at 04:40:24PM +0100, Greg Kroah-Hartman wrote:
> On Fri, Feb 21, 2020 at 08:35:25AM +0100, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.5.6 release.
> > There are 399 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sun, 23 Feb 2020 07:19:49 +0000.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.5.6-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.5.y
> > and the diffstat can be found below.
> 
> I've released -rc2 with a bunch of changes that I hope should resolve
> the issues reported:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.5.6-rc2.gz
> 

Ugh, -rc3 is coming soon...
