Return-Path: <SRS0=fzvl=3P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF638C35240
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 07:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A647C214DB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 07:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580024594;
	bh=mt/U4+Qr0SXK8v00UaF5AGakylUWPrvs1+Kl7n4zEU8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lyodZqimBORobbRMu24qAgBtF2XHBO0rg4sYJMvXwxYNIYggSibCMSe0+SKvV2QlC
	 di2soDtYaiqpAaZ1t1+qpyr4SjllySakFiBH+ym93wUOnULJNvpkBUxGLT1A1qHxwp
	 W/ewdzxkRk0NIFTF8BActiGNZbOM1Q5lN7mCJSKI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729351AbgAZHnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jan 2020 02:43:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:48590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726426AbgAZHnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 02:43:11 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C520F2083E;
        Sun, 26 Jan 2020 07:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580024591;
        bh=mt/U4+Qr0SXK8v00UaF5AGakylUWPrvs1+Kl7n4zEU8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vG/C1b28R4Z3X7u0U0SRju6WWCoLoDcrpfPOyjvWMIYZyjjNEA+9Wy7RCOgKu3I46
         XnOUAkHFNmNkpn/blY2i92HkwM+Xf6AaIkFAXZsDQR4MS9Z3u6eUd8qK5P8D38gYRO
         r+1elbK6nz6a2EXhcXsdWMMW7F1VCNBI7LzvsnIs=
Date:   Sat, 25 Jan 2020 14:52:56 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 5.4 000/102] 5.4.15-stable review
Message-ID: <20200125135256.GC3519301@kroah.com>
References: <20200124092806.004582306@linuxfoundation.org>
 <20200124235648.GC3467@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200124235648.GC3467@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 24, 2020 at 03:56:48PM -0800, Guenter Roeck wrote:
> On Fri, Jan 24, 2020 at 10:30:01AM +0100, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.4.15 release.
> > There are 102 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sun, 26 Jan 2020 09:26:29 +0000.
> > Anything received after that time might be too late.
> > 
> 
> For v5.4.14-102-g5b29268443c0:
> 
> Build results:
> 	total: 158 pass: 158 fail: 0
> Qemu test results:
> 	total: 389 pass: 389 fail: 0

Great, thanks for testing all of these and letting me know.

greg k-h
