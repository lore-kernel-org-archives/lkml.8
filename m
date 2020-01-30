Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A6AC35240
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 08:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D1092083E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 08:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580372805;
	bh=PNkPSwdJQbySAJzRp9xVNQkgJtkqcubS7xriykYfYnk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bRO3/tbHhXUsCDBjEdfo/+KP5EYK/JJj90WWeH+ti7wakoru2gqN904yK/YHUBr8C
	 hBfRZxrstUXAQKWK/7DIuB6132mIgvS7KsK4ArdUMULNkE7i4v1THzfauWYnzHDHUq
	 wpnTFePYB2Cdx4Yn5jC9UB2niV/bgzAOzp6YI/AI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbgA3I0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 03:26:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:55132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726464AbgA3I0o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 03:26:44 -0500
Received: from localhost (unknown [117.99.87.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D306206D5;
        Thu, 30 Jan 2020 08:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580372804;
        bh=PNkPSwdJQbySAJzRp9xVNQkgJtkqcubS7xriykYfYnk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uj4iPoBln9edjloZ4nT58Z5bRZbPhm0c8bE2eraniQPadGNV05+6F9W3SGhPVs/7g
         cDvCc9IWLL/gsQbz/SQ+++iWw1GpVQlI7bJwSzWgJQdXcp7W/mA4yQ6WIsO6HQpZEb
         katJ6biF3BtF/UCOLXRGPxuLOISr82YjyFJwUn4A=
Date:   Thu, 30 Jan 2020 13:56:40 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>, dmaengine@vger.kernel.org,
        mgalka@collabora.com, enric.balletbo@collabora.com,
        broonie@kernel.org, khilman@baylibre.com,
        tomeu.vizoso@collabora.com, linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: mainline/master bisection: baseline.login on odroid-xu3
Message-ID: <20200130082640.GE2841@vkoul-mobl>
References: <5e320e71.1c69fb81.e97dd.2bf5@mx.google.com>
 <71ae1017-2077-87c9-d140-cac181017fb7@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71ae1017-2077-87c9-d140-cac181017fb7@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-01-20, 23:13, Guillaume Tucker wrote:
> Please see the bisection report below about a boot failure.
> 
> Reports aren't automatically sent to the public while we're
> trialing new bisection features on kernelci.org but this one
> looks valid.

Thanks, the fix has been pushed out to dmaengine-next and should be in
linux-next tomorrow.

-- 
~Vinod
