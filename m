Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D98C35671
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 17:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7545B206ED
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 17:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582479086;
	bh=5i0U8sgiX8pQ2irMcJ9O+2yTxtd6mHMFlG0tkGVqrR8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ofvky8HhwXZx5tX+8XaW10sJMHqSRQU6nY5WIWihDgEWMfsrl8kaLLV7O3dcnbNzs
	 9ExSLGHeRLxvEWNSlIBptNzzhQZWhx4KwopRZQ+pDxuSGcZTPyZtTYaWcKwsRNLqle
	 ELeiPVU7VrGMSazVj5wOpXAsJzycrmIWioV2RVgw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbgBWRbZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 12:31:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:35376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727027AbgBWRbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 12:31:25 -0500
Received: from localhost (95-141-97-180.as16211.net [95.141.97.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B8A62067D;
        Sun, 23 Feb 2020 17:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582479084;
        bh=5i0U8sgiX8pQ2irMcJ9O+2yTxtd6mHMFlG0tkGVqrR8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N49dyhcwvJe5owYiNejYQKnTbjGH94rATEDgzERw7575PU1CAA+vE0eG25WLsUtZg
         zoc9HJZnRMIlLAr8k+qd17Hn5WaPPKI6L9Kd+Yhq5e2DOfwgnceKcgnqaWQ+hVzBMq
         ODPQdL9dMVnTHdqSWpb1mwzP9n+5pgNbzgIcA5Yk=
Date:   Sun, 23 Feb 2020 18:31:22 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.19 000/191] 4.19.106-stable review
Message-ID: <20200223173122.GA485503@kroah.com>
References: <20200221072250.732482588@linuxfoundation.org>
 <20200223154121.GC131562@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200223154121.GC131562@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 23, 2020 at 04:41:21PM +0100, Greg Kroah-Hartman wrote:
> On Fri, Feb 21, 2020 at 08:39:33AM +0100, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.19.106 release.
> > There are 191 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sun, 23 Feb 2020 07:19:49 +0000.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.106-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> > and the diffstat can be found below.
> 
> -rc2 is out to hopefully resolve the reported problems with -rc1:
>  	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.106-rc2.gz

Ok, -rc3 is now out, hopefully now things will work:
 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.106-rc3.gz

