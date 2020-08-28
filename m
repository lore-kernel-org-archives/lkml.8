Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20218C433E7
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 07:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF21D2078A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 07:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598600896;
	bh=wRcVqBDYNzDuiSshPZs2cXM/gGy3dQf2olqwI/4YQWk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VfA+0/DwHOdBLlgEDMk8ZJVQsCh7dN/sToTU88kaWr+jNDLR7lyTxAHS+p7j5EC3J
	 c6Otht9pT2OGL3P+aAo9D5tLNvVxyfIkqYV6Gvgz4Ercb4CvJiAsRBsrUleo/hxxeS
	 JTltmmv38nhh4FYoCPeM03YmiU5uaaZ3LbV5WQHk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbgH1HsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 03:48:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:42250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728094AbgH1HsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 03:48:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC9BC2078A;
        Fri, 28 Aug 2020 07:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598600894;
        bh=wRcVqBDYNzDuiSshPZs2cXM/gGy3dQf2olqwI/4YQWk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KOvtTNpGyZ/bA7W7C4eRyBc3JDsu+jZEKA5Xp+3MiQMz8UOTMXiBjv5NQaTVfbPEz
         nYavUkuVh44jcDUJMJI/pxbf72uUckc/eGYsFhr+IDezg6t1gA1qudlKiINIoUCX9N
         Q49VPPAN2DQ3+WQ/7K289wo1vR1J7BH7CgIQ9pi0=
Date:   Fri, 28 Aug 2020 09:48:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     yanfei.xu@windriver.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: integrate macro definitions into include/linux/usb.h
Message-ID: <20200828074826.GA962117@kroah.com>
References: <20200825154421.5463-1-yanfei.xu@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825154421.5463-1-yanfei.xu@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 11:44:21PM +0800, yanfei.xu@windriver.com wrote:
> From: Yanfei Xu <yanfei.xu@windriver.com>
> 
> include/linux/usb.h also contains 'Hard limit' and 'Arbitrary limit'
> macro definitions in it, hence we can integrate these from config.c
> into include/linux/usb.h

Why?  No one uses these values outside of this .c file, so why put a
value in a global .h file?

Who else wants to use these values?  If something else needs it, then
sure, it could be moved, but until then, there's nothing wrong with the
existing code as-is from what I can tell.

thanks,

greg k-h
