Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0472C4BA0E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 08:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7736C20714
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 08:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582704657;
	bh=b4WNO08j3CpteKtJyCgXEieJzjysEvoALEM8S6HNPII=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1MSttoFQxHpTAXhU2G2PJaZ/8c8c5TVDzI7j2TsRTvSGzbVFYoG1cObuh+Z5qWN2g
	 /u0GVHun07KXMFlgkBPClHQqdRYvrlMu5ahUJB3VTXYZ/d+LnkW4LXySGhm62z4qNB
	 e90IcZ9gFniGjyZkMvfKobeddKu3PKW2w5hVdVz8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbgBZIK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 03:10:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:37296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727709AbgBZIKw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 03:10:52 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDE2A24650;
        Wed, 26 Feb 2020 08:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582704651;
        bh=b4WNO08j3CpteKtJyCgXEieJzjysEvoALEM8S6HNPII=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jAQDAQNjQtfWzSk5WI9lp4qS6LFd8fSlh4NLanUuVcD45OWhPPEXh6oht7DP7wOjR
         XjMh7+dmN6id5qBuy0UXkBwdeXj52eqMndxpPxBM2IUCkoNBZY2/aIBRs+6ZJkDkTH
         Tkn6q91v45WwXRAsD1xM/c0BNxNsXtM75v7vOocs=
Date:   Wed, 26 Feb 2020 09:10:48 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Luigi Rizzo <lrizzo@google.com>
Cc:     linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        akpm@linux-foundation.org, naveen.n.rao@linux.ibm.com,
        changbin.du@intel.com, ardb@kernel.org, rizzo@iet.unipi.it,
        pabeni@redhat.com, toke@redhat.com, hawk@kernel.org
Subject: Re: [PATCH 0/2] quickstats, kernel sample collector
Message-ID: <20200226081048.GC22801@kroah.com>
References: <20200226023027.218365-1-lrizzo@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226023027.218365-1-lrizzo@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 06:30:25PM -0800, Luigi Rizzo wrote:
> This patchset introduces a small library to collect per-cpu samples and
> accumulate distributions to be exported through debugfs.

Shouldn't this be part of the tracing infrastructure instead of being
"stand-alone"?

thanks,

greg k-h
