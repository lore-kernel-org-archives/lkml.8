Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 617AFC3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 08:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DAAD2465B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 08:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580201531;
	bh=us07uZW8EJ9u1Hp+jw1ztONC0owP/dKwna4F23Rp9O0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=d+FikogSO5Xy8bXnS++KEqQx+XzZkkj4VTI3zobP0EA9mtTEINusjFbYEXhL8/saT
	 oRXxv1ednTgEbmmH3RMF0Wgu3ns6uPuudRNPfFwbJwEl1lhcGKr9ISOwBy+f2JEpek
	 V/TlC2fhdi0bRw9sidTNQ64rESab27cL1HfCzNcQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgA1IwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 03:52:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:55170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbgA1IwK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 03:52:10 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CEA9207FD;
        Tue, 28 Jan 2020 08:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580201529;
        bh=us07uZW8EJ9u1Hp+jw1ztONC0owP/dKwna4F23Rp9O0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nmf9FvANumFL5eGxuQ8NuY1/ZqMRyB2zwsiS2IQm709O1XK4uwudz1OEZv3ZeB1Gr
         m2m3EG2wDYyApgJcZ9Imicra1rnIwXxtbRNjOCVjX3E+KApQm8c3r41K4ybGFMncKW
         bCe0nhntIpSTjt39JSsUe228SXqH6mYSomPFjqwI=
Date:   Tue, 28 Jan 2020 09:05:40 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     stable@vger.kernel.org, jeremy.linton@arm.com, sashal@kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH stable-4.9] Documentation: Document arm64 kpti control
Message-ID: <20200128080540.GH2105706@kroah.com>
References: <20200128015415.2276-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200128015415.2276-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2020 at 05:54:14PM -0800, Florian Fainelli wrote:
> From: Jeremy Linton <jeremy.linton@arm.com>
> 
> commit de19055564c8f8f9d366f8db3395836da0b2176c upstream
> 
> For a while Arm64 has been capable of force enabling
> or disabling the kpti mitigations. Lets make sure the
> documentation reflects that.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> Reviewed-by: Andre Przywara <andre.przywara@arm.com>
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> [florian: patch the correct file]
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Thanks for the backport, now applied.

greg k-h
