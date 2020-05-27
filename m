Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB754C433EC
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB9F420C09
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590593498;
	bh=FYlTjZDDWzv75K1cm++7jCZ9U5TmYAzARky7QAXahI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mYZTrAR7yBIDe+nTtm+z7vjmBV+T+zHC6mYHJ/3fI24zZLAndN7CSZxOJJ2aupRAw
	 gssYg6IpToy+G747dsJxASKNLzpXQoS2ze7zbMTgzh7Imwdy7S61f6HPyDmLUASihY
	 kXnYH+0GQ/x40iW5Ux++BidaYANwLTKILw2BnxhM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbgE0Pbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:31:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:43968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728829AbgE0Pbd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:31:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CA63208E4;
        Wed, 27 May 2020 15:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590593492;
        bh=FYlTjZDDWzv75K1cm++7jCZ9U5TmYAzARky7QAXahI0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jXXSlSss9GQcJwOVQ18QpEkpPQ0UHggQ0gnw7GFrNNzCuPWE5+rTO8d+c6uVeB6Cs
         78bnb0WIkRzmYIS3AQo7EY1dOw9IStfAv5KBXtOZEmWdm4DU6tsewCwDtPxhwIJtUo
         seapiYMExTH/ZC9Us+4q6KTSv6ZC6Zm+15xcQP3E=
Date:   Wed, 27 May 2020 17:31:30 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ashwin H <ashwinh@vmware.com>
Cc:     "x86@kernel.org" <x86@kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@kernel.org" <stable@kernel.org>,
        Srivatsa Bhat <srivatsab@vmware.com>,
        "srivatsa@csail.mit.edu" <srivatsa@csail.mit.edu>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        Steven Rostedt <srostedt@vmware.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v4.19.x] make 'user_access_begin()' do 'access_ok()'
Message-ID: <20200527153130.GA525531@kroah.com>
References: <d29f87f3f3abb4e496866253bd170faad976f687.1589305630.git.ashwinh@vmware.com>
 <20200513055548.GA743118@kroah.com>
 <89DE19F6-4CB0-4324-A630-C8574C8D591C@vmware.com>
 <20200513063455.GA752913@kroah.com>
 <MN2PR05MB63814CDAAF6828285929736ACDBF0@MN2PR05MB6381.namprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR05MB63814CDAAF6828285929736ACDBF0@MN2PR05MB6381.namprd05.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 05:08:19PM +0000, Ashwin H wrote:
> > Ok, but what does that mean for us?
> > 
> > You need to say why you are sending a patch, otherwise we will guess wrong.
> 
> In drivers/gpu/drm/i915/i915_gem_execbuffer.c, ioctl functions does user_access_begin() without doing access_ok(Checks if a user space pointer is valid)  first.
> A local attacker can craft a malicious ioctl function call to overwrite arbitrary kernel memory, resulting in a Denial of Service or privilege escalation (CVE-2018-20669)
> 
> This patch makes sure that user_access_begin always does access_ok. 
> user_access_begin has been modified to do access_ok internally.

I had this in the tree, but it broke the build on alpha, sh, and maybe a
few others :(

See:
	https://lore.kernel.org/r/20200527140225.GA214763@roeck-us.net
for the details.

Can you dig out all of the needed follow-on patches as well, and send
them all as a patch series for 4.19.y so that I can queue them all up at
once?

thanks,

greg k-h
