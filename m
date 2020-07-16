Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB828C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 11:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 910CB20760
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 11:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594900701;
	bh=9srEDBajR9p24JXNJ8Nyoxyn9WC5JbPe2lny+DUlt7Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=V/3pFIepRy6NCnWHsReONxt9kN8Lj1EMQFeGZd5El1BfBvMYTV0J0jvcmZbzAL8MN
	 HTcKvAAfeBlX6sCHVTMz7Z2gJ2Vf5pofarmwiqpNkw+Vx9Qs/23o7CWnAxTzpTMj4z
	 7sj2wIOqIO9EMJ1Qg/Vfe+EM2SjVwx97tQnP/svA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728418AbgGPL6U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 07:58:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:60570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbgGPL6U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 07:58:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C6B920739;
        Thu, 16 Jul 2020 11:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594900699;
        bh=9srEDBajR9p24JXNJ8Nyoxyn9WC5JbPe2lny+DUlt7Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pu8X5C/5QsnFhDYwgMhuZLTAmv5Iqm3pbpC4uVRJj4m4dpHIfW2d8aQoHWl7fesKX
         itxj2q3KFriY/jQchrDds7xvxv0ktKU2nIU4F5CXZKR/PsKumfdtf6bXm8/ob6ZYIr
         +5AlXeyoDa123hOfnJb1XjLL+QBv3w1oaKyQfYFo=
Date:   Thu, 16 Jul 2020 13:58:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     stable@vger.kernel.org, arnd@arndb.de, sashal@kernel.org,
        naresh.kamboju@linaro.org, Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [Stable-5.4][PATCH 0/3] arm64: Allow the compat vdso to be
 disabled at runtime
Message-ID: <20200716115813.GB1668009@kroah.com>
References: <20200715125614.3240269-1-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715125614.3240269-1-maz@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 01:56:11PM +0100, Marc Zyngier wrote:
> This is a backport of the series that recently went into 5.8. Note
> that the first patch is more a complete rewriting than a backport, as
> the vdso implementation in 5.4 doesn't have much in common with
> mainline. This affects the 32bit arch code in a benign way.
> 
> It has seen very little testing, as I don't have the HW that triggers
> this issue. I have run it in VMs by faking the CPU MIDR, and nothing
> caught fire. Famous last words.

These are also needed in 5.7.y, right?  If so, I need that series before
I can take this one as we don't want people moving to a newer kernel and
suffer regressions :(

thanks,

greg k-h
