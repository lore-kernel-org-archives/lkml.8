Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBAA3C2BB1D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 16:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 075DC20736
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 16:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583945750;
	bh=L1VQcWtMDnovMPfvhIyZ66zckUdhiFbZR4tczKs/UN4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=q1GgR3rc45WynumfvqB6QzFw3AQzRlWIG0TU4lpp2gvyLam5URjwUa1PPEQ5BjFE7
	 U4KcX14GOAXyJBg3YvLZZmb/11B5fXmGkGAtzBhT4P3MOxIouAXxuV6f8gY4gP43FS
	 0pirTm6AbC/9sQoYIP2XNuXGXy8XvWE64IKCqIV4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730245AbgCKQzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 12:55:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:59142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730019AbgCKQzs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 12:55:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E48F520735;
        Wed, 11 Mar 2020 16:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583945748;
        bh=L1VQcWtMDnovMPfvhIyZ66zckUdhiFbZR4tczKs/UN4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o3Lv07Y1UvkLUi3owP604eFAfu9CfV8iVXYUnYLf7YXFQA7MFCkul9uThwQzg2gWL
         CeHXftWI7NZNFycBPeTpTV20pdNRzMdam9TFjx6ZrArzyfLcc1FG+88Lctv4DAIz0y
         xu0/fuPAwKcjkKxWKDOsySiBOZQnKzUeQcO2Rw+o=
Date:   Wed, 11 Mar 2020 17:55:44 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.14 000/126] 4.14.173-stable review
Message-ID: <20200311165544.GA3944429@kroah.com>
References: <20200311130904.819648693@linuxfoundation.org>
 <93f0b56a-f11c-5c29-5a80-041103273e41@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93f0b56a-f11c-5c29-5a80-041103273e41@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 09:27:25AM -0700, Guenter Roeck wrote:
> On 3/11/20 6:11 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.14.173 release.
> > There are 126 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Fri, 13 Mar 2020 13:08:24 +0000.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.173-rc2.gz
> 
> For v4.14.172-127-gc23e0b0dc693:
> 
> Build results:
> 	total: 172 pass: 172 fail: 0
> Qemu test results:
> 	total: 401 pass: 401 fail: 0
> 
> It would be helpful to have a more prominent indication that this is -rc2.

Yeah, I just now noticed it wasn't in the subject line, but it's in the
X- headers.  I'll fix that up on my end, sorry.

And thanks for testing.

greg k-h
