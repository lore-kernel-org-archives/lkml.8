Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B1EC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 11:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E857207BB
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 11:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598008497;
	bh=VjFOKpyizykEhMEdi0wvafG7ZePxzlXLRUFPfZopB68=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xyI8a5eDrnz+cI7wF0nSrpXwuwc7eweSbXavCrFr24jR1w+erj4GAjelvwGb0b8md
	 srEhImolSK8tDg8pl2XUcmS7/gOzIVpVeH8CQz589SQsrjRYf++963DEE+gMAtIQw5
	 xapYIKGnukndBnLRtgijbDMknair8zPvMaMcO4LM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbgHULOz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 07:14:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:58456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726872AbgHULOx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 07:14:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FACE2078D;
        Fri, 21 Aug 2020 11:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598008493;
        bh=VjFOKpyizykEhMEdi0wvafG7ZePxzlXLRUFPfZopB68=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wJOg65njMu/SZuOruuE+ZkIa2CoyU8LF2911jTIvoARh1p5NzWODFbEexgQoIKD4g
         IzEPaizGqfreoToqCczTyRU6nX7Tvh4IqSaZX+GHR7BrQlY9QESS0nNN5+TjaCOZ4N
         Ccf5B7pj6yHsGr3d7W0vYxaEuC76hU68qJWHo+Ps=
Date:   Fri, 21 Aug 2020 13:15:11 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 5.8 000/232] 5.8.3-rc1 review
Message-ID: <20200821111511.GB2222852@kroah.com>
References: <20200820091612.692383444@linuxfoundation.org>
 <20200820200631.GJ84616@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200820200631.GJ84616@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 01:06:31PM -0700, Guenter Roeck wrote:
> On Thu, Aug 20, 2020 at 11:17:31AM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.8.3 release.
> > There are 232 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sat, 22 Aug 2020 09:15:09 +0000.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 154 pass: 154 fail: 0
> Qemu test results:
> 	total: 430 pass: 430 fail: 0
> 
> Tested-by: Guenter Roeck <linux@roeck-us.net>

Thanks for testing all of these and letting me know.

greg k-h
