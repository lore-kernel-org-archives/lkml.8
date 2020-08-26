Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0F8C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 08:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7142420786
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 08:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598430490;
	bh=cHTLDNEa084aWywrsMzXhLG36k3PLmsbjZOG8Hgx6NI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Pdjc/Vw5LAKy7IHSOqsnCLpR1BdVRJLDV7CotDWVcVkb7D4ad0XhBGUNPAf3EQw0i
	 Ps8ceE9Fa7RsIpbKO/mpGK9q+YiOIKMDyUjusC8O95gu8RN1UbMTpWfM3SOzviDfkW
	 M/yIASj8h0Lu1JZTcGCCOnw+ACIy1wCyxHl581T0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgHZI2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 04:28:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:46746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726016AbgHZI2I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 04:28:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A765206FA;
        Wed, 26 Aug 2020 08:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598430487;
        bh=cHTLDNEa084aWywrsMzXhLG36k3PLmsbjZOG8Hgx6NI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xTkEySzCK92GSsZ5izyHS+a1q2T+N6pygf0EXEwDMjVOet9EUC4/LkGk/cnbmT62s
         kKyGdOFyNdGPZHYWEZgW7++TFjED9uaEsOU07K4dw1bxGuBvXKrSPafMXozu3j4nSn
         rq86/ShNfNCtrypB1GY9A494XCURBDX+vdos63yk=
Date:   Wed, 26 Aug 2020 10:28:23 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pavel Machek <pavel@denx.de>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.19 00/71] 4.19.142-rc1 review
Message-ID: <20200826082823.GA1806567@kroah.com>
References: <20200824082355.848475917@linuxfoundation.org>
 <20200826080732.GA9637@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200826080732.GA9637@amd>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 10:07:32AM +0200, Pavel Machek wrote:
> Hi!
> 
> > This is the start of the stable review cycle for the 4.19.142 release.
> > There are 71 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed, 26 Aug 2020 08:23:34 +0000.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.142-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
> > and the diffstat can be found below.
> 
> Uh. I believe this was tested successfully by CIP probject:
> 
> https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/181017473
> 
> Yes, there are two "fails" but there seem to be caused by DNS
> resolution problems (i.e. test infrastructure problem, not kernel problem).

Thanks for testing two of these and letting me know.

greg k-h
