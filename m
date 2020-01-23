Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B7BC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 09:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAC0E22522
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 09:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579772198;
	bh=gyt2Y4k10a3KJebAv2MMSWVNSPdTsVts58bB8fCDjL8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fha4jxFwf9hnvbZnTrIh9qX40iUvXL1rzjUc8uZJ2lMvXjNUkJcaPGElUzlWTakNn
	 NwuUGRM2hTVvUIF28LXNuqOcegnPkiwCP9zJy76EUTkQ12dt18RKLvwZiY8LUwXoLd
	 1S1DOTyjFbBD5Ms8T4jCxiMSQYOzCuRC0YSwWmgk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgAWJgi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 04:36:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:45370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726234AbgAWJge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 04:36:34 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F44F22522;
        Thu, 23 Jan 2020 09:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579772193;
        bh=gyt2Y4k10a3KJebAv2MMSWVNSPdTsVts58bB8fCDjL8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tf4QUMKz4/iknb74dTGe//f79onqkHHOGUngMEcibhz+JKsK+yfhUP5cOxiln+/UX
         aD9Vdm7G6BwbcU5K4jvPMh1ZBsUjXgWEn7X2xyKquMAw1Sio6ZDnJN+AlJ22RcK7CZ
         1+NwCRTz9RlboaYose8yTkUgmZHncZ1d8PrpRjPM=
Date:   Thu, 23 Jan 2020 09:36:28 +0000
From:   Will Deacon <will@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jason Baron <jbaron@akamai.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v4] dynamic_debug: allow to work if debugfs is disabled
Message-ID: <20200123093628.GA18991@willie-the-truck>
References: <20200122074343.GA2099098@kroah.com>
 <20200122080352.GA15354@willie-the-truck>
 <20200122081205.GA2227985@kroah.com>
 <20200122135352.GA9458@kroah.com>
 <8d68b75c-05b8-b403-0a10-d17b94a73ba7@akamai.com>
 <20200122192940.GA88549@kroah.com>
 <20200122193118.GA88722@kroah.com>
 <ef1172ac-ea78-146e-575e-93e2d65b4606@infradead.org>
 <20200123084847.GA435637@kroah.com>
 <20200123085015.GA436361@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200123085015.GA436361@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 23, 2020 at 09:50:15AM +0100, Greg Kroah-Hartman wrote:
> With the realization that having debugfs enabled on "production" systems is
> generally not a good idea, debugfs is being disabled from more and more
> platforms over time.  However, the functionality of dynamic debugging still is
> needed at times, and since it relies on debugfs for its user api, having
> debugfs disabled also forces dynamic debug to be disabled.
> 
> To get around this, move the "control" file for dynamic_debug to procfs IFF
> debugfs is disabled.  This lets people turn on debugging as needed at runtime
> for individual driverfs and subsystems.
> 
> Reported-by: many different companies
> Cc: Jason Baron <jbaron@akamai.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> v4: tweaks to the .rst text thanks to Randy's review
> v3: rename init function as it is now no longer just for debugfs, thanks
>     to Jason for the review.
>     Fix build warning for debugfs_initialized call.
> v2: Fix up octal permissions and add procfs reference to the Kconfig
>     entry, thanks to Will for the review.
> 
>  .../admin-guide/dynamic-debug-howto.rst       |  3 +++
>  lib/Kconfig.debug                             |  7 ++++---
>  lib/dynamic_debug.c                           | 21 ++++++++++++++-----
>  3 files changed, 23 insertions(+), 8 deletions(-)

I had a brief "oh crap" moment when I thought you were exposing both the
procfs and debugfs interfaces at the same time, but thankfully that's not
the case. Whilst it's a bit of a shame that it's come to this, the code
looks pretty decent to me, so:

Acked-by: Will Deacon <will@kernel.org>

Thanks,

Will
