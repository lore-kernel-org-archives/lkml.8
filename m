Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F979C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 18:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACF2422C9F
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 18:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596739178;
	bh=ZrgeGz2eQCzY3et54NjiihndUZVStwHlqyFDNY4ncaU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GmS7ibWa6L0Wxqk4CIRQEYhDm2+xECgrrlMMGGxu+4xXlAwMzBaciUq0NzoLbQ9fc
	 F2hSCyFOcVCaYL/kD/vjmaHgWJRIsLES9oyvjRMJoM/2ZY0H5TuzqHynZ/AriLZV8N
	 G7nsy2L+3AXNY6HrkulDYHRYc+Vwyi6Kkkyzv/OI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729098AbgHFSjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 14:39:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:32860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729885AbgHFSjT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 14:39:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6438221E3;
        Thu,  6 Aug 2020 18:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596739159;
        bh=ZrgeGz2eQCzY3et54NjiihndUZVStwHlqyFDNY4ncaU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uJteJ4kYFz3S0hlJGMQXf/Ngjd7dsaLoheNZVjaSkDcbqYZTuH3mZqbQZQvuLX3Tx
         CPyXdm9BlKeFgU8cBxqfyKY/glgT1TlxF/XnfXmThAxzlnSwjXjQr90O2dNlKjpSHH
         nzoSmKUv6q4c9v1jEY/bI9801Infb1Xdoj+LD5gI=
Date:   Thu, 6 Aug 2020 20:39:33 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Cengiz Can <cengiz@kernel.wtf>
Cc:     andy.shevchenko@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, sakari.ailus@linux.intel.com,
        mchehab@kernel.org, dan.carpenter@oracle.com,
        linux-media@vger.kernel.org
Subject: Re: [PATCH v6] staging: atomisp: move null check to earlier point
Message-ID: <20200806183933.GA2939128@kroah.com>
References: <20200731083856.GF3703480@smile.fi.intel.com>
 <20200801220101.2783-1-cengiz@kernel.wtf>
 <173c50d7bb0.2bfa.85c738e3968116fc5c0dc2de74002084@kernel.wtf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173c50d7bb0.2bfa.85c738e3968116fc5c0dc2de74002084@kernel.wtf>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 06, 2020 at 09:34:22PM +0300, Cengiz Can wrote:
> Hello Andy,
> 
> Can I get some feedback on v6 please?


It's been 4 days, in the middle of a merge window, please give people a
chance to catch up on other things...

and do not top post please.

thanks,

greg k-h
