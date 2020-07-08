Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 737EBC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 15:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CB892078D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 15:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594221346;
	bh=+meKQ7SoWp36a2tTwmJZDGpmK3beQge2e7ehiVwU+Kw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pc1fW99pWmri1krI1Hu0KJTldM5jGfRcb5PnygNE4xjhFmME6k95hRL76KP9sWfda
	 r7EOREvbfbY1y1lhxzhwfln7OuRn5u7r8PgMrj4gDqdygELs50cYVvnby+Lo8CbCi4
	 zZemz/Fmjv9kMshxfKnfF69N2eUsn6zHwXrivHUw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730142AbgGHPPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 11:15:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:38766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729815AbgGHPPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 11:15:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37715206DF;
        Wed,  8 Jul 2020 15:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594221343;
        bh=+meKQ7SoWp36a2tTwmJZDGpmK3beQge2e7ehiVwU+Kw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TwXGPQ9NH7HhP0Q2R3iwZMpfhUQEM7ZmJ9r9d6iO0hYQMfVi8Of5zxm6m4j8FIXil
         SBN+uW047eTk6UET6B8P7n1RkGxjfv1SeNXxozmEVuTndry3RS0Wnq4RaZRP9xHvjc
         efmhEIq4Cw2ga3L2/aJH9DUGdJQxmpRHxYNq2bM0=
Date:   Wed, 8 Jul 2020 17:15:39 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chris Paterson <Chris.Paterson2@renesas.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "patches@kernelci.org" <patches@kernelci.org>,
        "ben.hutchings@codethink.co.uk" <ben.hutchings@codethink.co.uk>,
        "lkft-triage@lists.linaro.org" <lkft-triage@lists.linaro.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 4.19 00/36] 4.19.132-rc1 review
Message-ID: <20200708151539.GB710412@kroah.com>
References: <20200707145749.130272978@linuxfoundation.org>
 <OSAPR01MB238589153016EE2B686404A9B7670@OSAPR01MB2385.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OSAPR01MB238589153016EE2B686404A9B7670@OSAPR01MB2385.jpnprd01.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 08, 2020 at 10:41:35AM +0000, Chris Paterson wrote:
> Hello Greg,
> 
> > From: stable-owner@vger.kernel.org <stable-owner@vger.kernel.org> On
> > Behalf Of Greg Kroah-Hartman
> > Sent: 07 July 2020 16:17
> > 
> > This is the start of the stable review cycle for the 4.19.132 release.
> > There are 36 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Thu, 09 Jul 2020 14:57:34 +0000.
> > Anything received after that time might be too late.
> 
> No build/boot issues seen for CIP configs with Linux 4.19.132-rc1 (168e2945aaf5).
> 
> Build/test pipeline/logs: https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/164002971
> GitLab CI pipeline: https://gitlab.com/cip-project/cip-testing/linux-cip-pipelines/-/blob/master/trees/linux-4.19.y.yml
> Relevant LAVA jobs: https://lava.ciplatform.org/scheduler/alljobs?length=25&search=168e29#table

Thanks for testing two of these and letting me know.

greg k-h
