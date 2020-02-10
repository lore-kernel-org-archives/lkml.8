Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED14CC352A5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE08E2085B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581342219;
	bh=Hquanu6Wy26mnQgUxpH/1ep5O2rHYKiKniqQZps8nnM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=W+FBieI8VhqA93UsDMvCuEYJsUirUny/ztL4E+a1N4rn54zKThwtjtes0w5TX10cv
	 SxMijE13pQBJDfR4dF/Ad+PxzMH5Zrp8H+V3SDe6frSIfd3g4oIgelFrJ1rNzuwpXx
	 4l5eJOakLHCeELaFLfhyT6NYDNG9Is9bjX+rK354=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbgBJNnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:43:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:37862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727369AbgBJNni (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 08:43:38 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36ECE2070A;
        Mon, 10 Feb 2020 13:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581342218;
        bh=Hquanu6Wy26mnQgUxpH/1ep5O2rHYKiKniqQZps8nnM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cClBx3Leb9P8qQChaWcVMqSJcd1q6imDi6n/67rpvTC5IIHefy7A3EwSDmnxt78cM
         7FxcH0fOcPL+WKF9l6Yw2RRazz5yA8XdDxN7LsR0Gwu1z+3Cf+1q+FWQxxTIFh5Hlb
         JdX8qSjOWvfZcR3xpOiORqxariYidls1Snxa3zSE=
Date:   Mon, 10 Feb 2020 05:43:37 -0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Peter Enderborg <peter.enderborg@sony.com>
Cc:     Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] HID: Extend report buffer size
Message-ID: <20200210134337.GA532350@kroah.com>
References: <20200210122147.GA413013@kroah.com>
 <20200210124054.1257-1-peter.enderborg@sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210124054.1257-1-peter.enderborg@sony.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 01:40:54PM +0100, Peter Enderborg wrote:
> In the patch "HID: Fix slab-out-of-bounds read in hid_field_extract"
> there added a check for buffer overruns. This made Elgato StreamDeck
> to fail. This patch extend the buffer to 8192 to solve this. It also
> adds a print of the requested length if it fails on this test.
> 
> Fixes: 8ec321e96e05 ("HID: Fix slab-out-of-bounds read in hid_field_extract")
> Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
> ---

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
