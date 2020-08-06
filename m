Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F6FC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0342C206B2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596735235;
	bh=EBG5noCPf3hsffiJxbyTLsGHbvKaQ8YSkj29Tp6pgqs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cjSOuTHdMumHnn3eyFKdSnyrf9wTo7KhGj0D2ZrDKVHXIP5exJtp3X4nb/iyO72mT
	 vAw86wp5gdQZrpUmdHtbx+LFXByklTF7Zbju+5dyB/fUt4cNPSHLqonz0dQJwkYPue
	 vBzD5ut4QjxvmNxNmxJipALpYeMPy/LP27PUsRJs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729889AbgHFRdr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:33:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:54634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729903AbgHFRcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:32:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36A2922CAF;
        Thu,  6 Aug 2020 11:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596712212;
        bh=EBG5noCPf3hsffiJxbyTLsGHbvKaQ8YSkj29Tp6pgqs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LGgIEfg4DK+e9lI12t1JcRwHSyOXrah9Cvrd92x/Bp20mcheMF+0N3Pqy7EO0pIeR
         Xs7QA3Nx+5a1tCS76l6z5uuSMUt5Tg0kfeBnpr/kE6leX0IzMahFBVN3kSttU9xXpC
         aLFwYjN3W3UYIOuteDGltfjWTpJ/KbdOO8QBzklE=
Date:   Thu, 6 Aug 2020 09:08:34 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     linux- stable <stable@vger.kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org
Subject: Re: stable rc 4.9- v4.9.232-51-g1f47445197d2 - build breaks on
 arm64, arm, x86_64 and i386.
Message-ID: <20200806070834.GE2582961@kroah.com>
References: <CA+G9fYu4tshr3YUqqU-y8vXtoMVt5BgHtmFXqMUa_457_-8D-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYu4tshr3YUqqU-y8vXtoMVt5BgHtmFXqMUa_457_-8D-A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 05, 2020 at 10:34:44PM +0530, Naresh Kamboju wrote:
> stable rc 4.9 build breaks on arm64, arm, x86_64 and i386.
> 
> Here are the build log failures on arm64.
> 
>     git_repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
>     target_arch: arm64
>     toolchain: gcc-9
>     git_short_log: 1f47445197d2 (\Linux 4.9.233-rc1\)
>     git_sha: 1f47445197d2c8eecafa2b996f635aa89851c123
>     git_describe: v4.9.232-51-g1f47445197d2
>     kernel_version: 4.9.233-rc1
> 
> make -sk KBUILD_BUILD_USER=TuxBuild -C/linux -j16 ARCH=arm64
> CROSS_COMPILE=aarch64-linux-gnu- HOSTCC=gcc CC="sccache
> aarch64-linux-gnu-gcc" O=build Image
> #
> ../arch/arm64/kernel/hw_breakpoint.c: In function ‘arch_bp_generic_fields’:
> ../arch/arm64/kernel/hw_breakpoint.c:352:5: note: parameter passing
> for argument of type ‘struct arch_hw_breakpoint_ctrl’ changed in GCC
> 9.1
>   352 | int arch_bp_generic_fields(struct arch_hw_breakpoint_ctrl ctrl,
>       |     ^~~~~~~~~~~~~~~~~~~~~~

Is this warning new?

> ../fs/ext4/inode.c: In function ‘ext4_direct_IO’:
> ../fs/ext4/inode.c:3610:9: error: redefinition of ‘offset’
>  3610 |  loff_t offset = iocb->ki_pos;
>       |         ^~~~~~
> ../fs/ext4/inode.c:3608:9: note: previous definition of ‘offset’ was here
>  3608 |  loff_t offset = iocb->ki_pos;
>       |         ^~~~~~

Sorry I missed these, now dropped the offending patch from 4.4 and 4.9
queues.

greg k-h
