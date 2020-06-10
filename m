Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C0B7C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 06:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 574F92083B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 06:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591772166;
	bh=5STvsVX/pI2NfrFCiamfYh+BDyGD5ZoTDgeDDX/5rC0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BXcFG0rG9UxQgtfjEBOH3gz/3/jVs+S6kj477Rz55UvvFXxmtM58txLDK3A8bmyAk
	 /SS9sg3xGW4QM+pFp0hlREhGiKZxVPrhZNKoxz57f3ep5K0rUFO1v6V806fEW6K6ZE
	 v2PbhdLBDm4Uf3YhNJSeF8PfL0F196bVlRKCevdY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgFJG4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 02:56:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:50094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726095AbgFJG4C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 02:56:02 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA97720734;
        Wed, 10 Jun 2020 06:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591772162;
        bh=5STvsVX/pI2NfrFCiamfYh+BDyGD5ZoTDgeDDX/5rC0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e0MwBkvVTHUTmDVaH2vs5miGgN/MlrVKlfR/M/NyC6z80FCNSovuYF3uG+UTFzncx
         K0Jw9d2Q+Xdzc857h54ARg/fkhIfNgHko4RrdSNNo2BoMbGGOEBC/hqiAdlZEYOjoK
         vbM66H6VJhracJhCR5+CRIKHf0mcX3BfwTGCSD+c=
Date:   Tue, 9 Jun 2020 23:56:00 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     'Herbert Xu' <herbert@gondor.apana.org.au>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        wangzhou1 <wangzhou1@hisilicon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>
Subject: Re: [PATCH] crypto: hisilicon - fix strncpy warning with strlcpy
Message-ID: <20200610065600.GC6286@sol.localdomain>
References: <202006032110.BEbKqovX%lkp@intel.com>
 <1591241524-6452-1-git-send-email-zhangfei.gao@linaro.org>
 <20200604033918.GA2286@gondor.apana.org.au>
 <b6ad8af2-1cb7-faac-0446-5e09e97f3616@linaro.org>
 <20200604061811.GA28759@gondor.apana.org.au>
 <b23433f8-d95d-8142-c830-fb92e5ccd4a1@linaro.org>
 <20200604065009.GA29822@gondor.apana.org.au>
 <f8dceec5-6835-c064-bb43-fd12668c2dbb@linaro.org>
 <20200605121703.GA3792@gondor.apana.org.au>
 <8c0d8f4e21794d8b80d0a3852830debb@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c0d8f4e21794d8b80d0a3852830debb@AcuMS.aculab.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 07, 2020 at 01:03:45PM +0000, David Laight wrote:
> From: Herbert Xu
> > Sent: 05 June 2020 13:17
> ...
> > Better yet use strscpy which will even return an error for you.
> 
> It really ought to return the buffer length on truncation.
> Then you can loop:
> 	while(...)
> 		buf += strxxxcpy(buf, src, buf_end - buf);
> and only check right at the end.
> 
> 	David

scnprintf() can be used for that.

But that doesn't seem relevant to this patch.

- Eric
