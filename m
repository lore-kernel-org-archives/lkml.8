Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA635C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 05:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDEF920820
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 05:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591853668;
	bh=aY1GopfBuNs7Q05YVbYth7eeY4STdCsEuKuhQ+vwPhE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=p9c496ivySI9ijGBJceIV5YQ1hrJZkN2awAFKUn2bcWFzUt/16vojwbkS3CZn8yXT
	 CI0RDRaOX2WQOybkElgH90lFA22/l29EX7NrqGZ0JWWwxi/Rnap1uXYxydXdEVb3Mm
	 f8iRn6kHAMi2rz8ja+TopAGqiDwC8UGopLuQKcXc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgFKFe1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 01:34:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:52836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725300AbgFKFe1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 01:34:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 388CC20812;
        Thu, 11 Jun 2020 05:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591853666;
        bh=aY1GopfBuNs7Q05YVbYth7eeY4STdCsEuKuhQ+vwPhE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XDceuC5B53cEOWh9mb2VYGC8M8UJNB4Ep+v2/2aICfQjnyt+NBDmDiqMc7w5GIXTR
         GTBJlft4Ty1Ohy6ibJxxPCLKf6Yrwiy6CvYTvRYzfsoPq1dcOQ+5P849v0wxR6peS3
         UB6zR2IDHzsIUPjA1neNhogoKHmt6OjWjRCG1Xf8=
Date:   Thu, 11 Jun 2020 07:34:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kyung Min Park <kyung.min.park@intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, ak@linux.intel.com,
        dave.hansen@intel.com, tony.luck@intel.com,
        ravi.v.shankar@intel.com, ricardo.neri@intel.com
Subject: Re: [RFC PATCH 0/3] Add Documentation for /proc/cpuinfo flags
Message-ID: <20200611053424.GC2445528@kroah.com>
References: <20200610200701.16757-1-kyung.min.park@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610200701.16757-1-kyung.min.park@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 01:06:58PM -0700, Kyung Min Park wrote:
> This RFC series has been reviewed by Dave Hansen.

Then why isn't there a "Reviewed-by:" line with his name on it on the
patches?

Come on, you all know how to do this properly...

