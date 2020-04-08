Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 300B5C2BA1B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 07:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F39BF2074F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 07:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586329767;
	bh=BuhkXQ0s0C51NfwZIsfiuK5YSd7040TiHqdVwv80cDk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=17knmt1Rnc7uk6pC8QWjGF6fqyyGqZpN55VhOjaZUmRQYj8Ah0+0FctOCU33FdWdJ
	 laFdrVEdwkwnZZJk4OoKxvxQIBgmZcAhbfubBGz/9I/jSYKpqeF654GqgJAgbkA8hh
	 6JTKfphDlJz2wUyis8cpbwhkl4GUq8B7tSvRHlMg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbgDHHJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 03:09:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:60332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbgDHHJZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 03:09:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4F6620747;
        Wed,  8 Apr 2020 07:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586329765;
        bh=BuhkXQ0s0C51NfwZIsfiuK5YSd7040TiHqdVwv80cDk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KnRDYy8oyfy4vx6CQoNjBBsyP154IW3MM+mpgtrohE6OiWXwZCiILBOGw00dBqOys
         lvp/4rQj4MqanUImLtdEtJypDN47+9WxuLv5Ns3TsEGwkRGlRFXhTHrsN0Gu1lIEOu
         qUuifz7iWXqbj7M9qRmuG1evBTFfuBXB59fGSj8s=
Date:   Wed, 8 Apr 2020 09:09:22 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 5.6 00/30] 5.6.3-rc2 review
Message-ID: <20200408070922.GA1019278@kroah.com>
References: <20200407154752.006506420@linuxfoundation.org>
 <e30dcce7-93e7-801f-6cf4-72028bcbd56d@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e30dcce7-93e7-801f-6cf4-72028bcbd56d@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 07, 2020 at 07:44:54PM -0700, Guenter Roeck wrote:
> On 4/7/20 9:39 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.6.3 release.
> > There are 30 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Thu, 09 Apr 2020 15:46:32 +0000.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 155 pass: 155 fail: 0
> Qemu test results:
> 	total: 428 pass: 428 fail: 0

Thanks for testing all of these and letting me know.

greg k-h
