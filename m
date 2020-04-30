Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D3A7C83006
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 06:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C72E21775
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 06:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588228824;
	bh=vOUzJaKoj8W3E32Ycn+DJEeGWxxRmT88+dC7rbRzQKg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cY899ryX++HqaEze7Q7dHI/DjmEVDQThCW0Xm3wpPw3wDt7OpWjbgCf0a703q6SHm
	 gc4MISR7043JbJnOULP0Pls9Ll/MJdCrTTcuCYELJVFNKoRmQK3j2hF1LIgdusD34H
	 Nm2TY6Pfev7j/AOdYDFoiksPsod+Wodx+ZXB66Dc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgD3GkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 02:40:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:46510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726180AbgD3GkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 02:40:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA7D520784;
        Thu, 30 Apr 2020 06:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588228823;
        bh=vOUzJaKoj8W3E32Ycn+DJEeGWxxRmT88+dC7rbRzQKg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vsfo7fbam4iYeqzyBlPeD7Olne0JtTuWFGFz5Xf5a4QZAxqgkS3eD8w1NJ97BSwAh
         eW24Q+oZbCg1+eJBsrhjP5uMzenK770tcS3fSuzsIym4fc+6lZyp30qECBzKxeEtGa
         1G43p90RWstr4NW5mtcDBSNHupYy05GFjrhbf8pY=
Date:   Thu, 30 Apr 2020 08:40:21 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 5.6 000/167] 5.6.8-rc1 review
Message-ID: <20200430064021.GC2377651@kroah.com>
References: <20200428182225.451225420@linuxfoundation.org>
 <20200429140542.GC8469@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429140542.GC8469@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 07:05:42AM -0700, Guenter Roeck wrote:
> On Tue, Apr 28, 2020 at 08:22:56PM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.6.8 release.
> > There are 167 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Thu, 30 Apr 2020 18:20:42 +0000.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 155 pass: 155 fail: 0
> Qemu test results:
> 	total: 428 pass: 428 fail: 0

Thanks for testing all of them and letting me know.

greg k-h
