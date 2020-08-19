Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE180C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 05:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D1A1207FF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 05:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597816371;
	bh=eDYPmryot5vJDEr3Oa+VhUcnmO1H55HLBUwMGfZDMQE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mdVi65XRED86HOHMmQG+UVdUV7phSiuMnfOuCjQW50f/BVuRbD6ekChhGKXfTUTah
	 VA+MwrhgZ044oUGhTKSI0s+YDqlVJdVFEzhSmroiwSahgJqm+LqKTO/wZx0BIkyYGa
	 89nT9wsfWhdJx41efw2WobvJuk4QkKReFNQF4u+Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgHSFwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 01:52:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:56048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbgHSFwt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 01:52:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 271F9207DA;
        Wed, 19 Aug 2020 05:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597816369;
        bh=eDYPmryot5vJDEr3Oa+VhUcnmO1H55HLBUwMGfZDMQE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qyp9M/VjLa/uZ+FA7mKFQ/n0NCtR4ezHk+Oldywlz/o7NBeLE16Y0WrK1rU1NmQ6D
         MotSV9JCrq6FrLR0RJX9U4yWHsjFVB43wTDKuq8WFDY5+E2N/BbU7kkMl0Q5ixVbz8
         jv2BixQUMd+XBPj3ODo6oFEFvWSCJ0uq4SW1a4pk=
Date:   Wed, 19 Aug 2020 07:53:10 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Scott Branden <scott.branden@broadcom.com>,
        linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH v2 0/3] Add Broadcom VK driver
Message-ID: <20200819055310.GA853200@kroah.com>
References: <20200806004631.8102-1-scott.branden@broadcom.com>
 <202008181251.1CA80429@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202008181251.1CA80429@keescook>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 12:52:54PM -0700, Kees Cook wrote:
> On Wed, Aug 05, 2020 at 05:46:28PM -0700, Scott Branden wrote:
> > This patch series drops previous patches in [1]
> > that were incorporated by Kees Cook into patch series
> > "Introduce partial kernel_read_file() support" [2].
> > 
> > Remaining patches are contained in this series to add Broadcom VK driver.
> > (which depends on request_firmware_into_buf API addition in
> > other patch series [2] being applied first).
> > 
> > Please note this patch series will not compile without [2].
> > 
> > [1] https://lore.kernel.org/lkml/20200706232309.12010-1-scott.branden@broadcom.com/
> > [2] https://lore.kernel.org/lkml/20200729175845.1745471-1-keescook@chromium.org/
> 
> Greg, is your intention to take [2] into your tree? AFAICT, it's got the
> appropriate Acks, etc.

Yes, it is in my queue to do so, hopefully soon, digging out now from
the big -rc1 patch-submission-pile...

greg k-h
