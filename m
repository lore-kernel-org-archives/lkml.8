Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BDFAC433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 09:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E91692071B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 09:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599124784;
	bh=H4496jQJlww0VbuFNW8/a+0bvK0DyRAxKrsPTmpRgSg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=W+/3rCouGbNMLcD6VbPZIzsLSivGujtYzvkGNUUnXEJvWTCtICyxIFqYAVmAW2beW
	 C7nTTXfuJLNNV788Ixq0kz7chN8ep8vk7Wme1IDjJn58EJT7ho1RjB5ZTOfX8NXirM
	 Kgfn3P9GHXE3fGUSxcSwHOnzwdtyP9AG+2CsXA0c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbgICJTn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 05:19:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:34784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbgICJTm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 05:19:42 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D4DB206C0;
        Thu,  3 Sep 2020 09:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599124781;
        bh=H4496jQJlww0VbuFNW8/a+0bvK0DyRAxKrsPTmpRgSg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cOmKrFLaMIo5XeOleXQjdtEFJDaux5GXKmNN8e5L4LsfmAGhmxFPvO+hBXZVCaUQQ
         1oNKFMQBAKZzr3lAkUFFPdJ1lZOiBbUJM6MTJrSrU4SE5S/RsUpyk2c6o4zMijbDfN
         fdqWa22KOoXkjkjcn/aJy9dpHfZY0XoNQQCBylBk=
Date:   Thu, 3 Sep 2020 11:20:05 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pavel Machek <pavel@denx.de>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.19 000/125] 4.19.143-rc1 review
Message-ID: <20200903092005.GA2220117@kroah.com>
References: <20200901150934.576210879@linuxfoundation.org>
 <20200902100621.GA3765@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902100621.GA3765@duo.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 12:06:21PM +0200, Pavel Machek wrote:
> Hi!
> 
> > This is the start of the stable review cycle for the 4.19.143 release.
> > There are 125 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Thu, 03 Sep 2020 15:09:01 +0000.
> > Anything received after that time might be too late.
> 
> CIP testing did not find any problems (test:x86_siemens failure is
> because those boards are offline).
> 
> https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/184417281

Thanks for testing two of these and letting me know.

greg k-h
