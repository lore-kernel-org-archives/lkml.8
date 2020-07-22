Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E466C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 12:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D49D520717
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 12:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595422132;
	bh=E4QKQcz5E2jeceZ6ITI1hvBgZYFa+z7lTVwNAGLsmSU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=a7zcRvUzFkQebaDLUhBTbUURzqkmQ6cH1ylVk7MbNAmyfRJjDb9exn21jvA62Cfmy
	 V6g+SeyB0gk8Rjs0FFjsgf1fouuzUWUdWjTtk/879bXAtGiPOlUtR/nbneFeEFYNse
	 k84/wefq0SsGYRD08JHGuNUNvBvmJbysx0VHFcLs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732326AbgGVMsv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 08:48:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:45274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732154AbgGVMst (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 08:48:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 069B3206C1;
        Wed, 22 Jul 2020 12:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595422129;
        bh=E4QKQcz5E2jeceZ6ITI1hvBgZYFa+z7lTVwNAGLsmSU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DHBQi/1HQpbk0YU58yglL91aOFcbXQRCehT62uNviuWIvp2Kdcezvv2RdKZ/PHtux
         uy/wpzSwSBVpcoM2mluOmfkuJHsszKyqu9JZKur+m1QKqh444Ir3NnnUdYgeGJv5fv
         vzGzaMsid68JGYJnxoJFlCsn1K2QZjW+2SM9zSzQ=
Date:   Wed, 22 Jul 2020 14:48:55 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pavel Machek <pavel@denx.de>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.19 000/133] 4.19.134-rc1 review
Message-ID: <20200722124855.GC3155653@kroah.com>
References: <20200720152803.732195882@linuxfoundation.org>
 <20200721115633.GA26436@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721115633.GA26436@amd>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 01:56:33PM +0200, Pavel Machek wrote:
> Hi!
> 
> > This is the start of the stable review cycle for the 4.19.134 release.
> > There are 133 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed, 22 Jul 2020 15:27:31 +0000.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.134-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> > and the diffstat can be found below.
> 
> Seems to pass basic testing from CIP project:
> 
> https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/tree/linux-4.19.y

Thanks for testing 2 of these,

greg k-h
