Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE8C2C3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 20:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 850F020870
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 20:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583353734;
	bh=W/R/FWArGtnpFP7wkWD+JUcgbM7aaWuG7tLZ/8wBXGw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=yCrnzRAqG+56IsygKo0VDKIgJ7E2psqmxyLsO01iMBnpCJp9BARmtimnnITJe5DDV
	 qeAgszTEKDmJg4fRkyFZWHXOjUuilYFbvMuQYwYSeoo8jMwk/1oxNkC37PL1n8JXkw
	 16ey4Mr/Me0zPUfDvrE/2Wy01kSW6Mi34Cxq4eRs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388084AbgCDU2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 15:28:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:60930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387469AbgCDU2x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 15:28:53 -0500
Received: from coco.lan (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 903A920870;
        Wed,  4 Mar 2020 20:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583353732;
        bh=W/R/FWArGtnpFP7wkWD+JUcgbM7aaWuG7tLZ/8wBXGw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tDe8gBT9u5HZ078rKAVe1u1xlBXjWnRp/sN6UmaMUBd29a99fJgOOdO/WXbl9sonb
         KY3uqJ0I77CUk2Lqz0Rv7xccr9s7dWXipag9r9p3nTpLEqjXUSqFsHealLWICYRSe5
         sEI3clS6XIBDHCTF495XzP/Mc5y9l8/KcU21bHvA=
Date:   Wed, 4 Mar 2020 21:28:46 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Joe Perches <joe@perches.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: adjust to filesystem doc ReST conversion
Message-ID: <20200304212846.0c79c6da@coco.lan>
In-Reply-To: <20200304131035.731a3947@lwn.net>
References: <20200304072950.10532-1-lukas.bulwahn@gmail.com>
        <20200304131035.731a3947@lwn.net>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 4 Mar 2020 13:10:35 -0700
Jonathan Corbet <corbet@lwn.net> escreveu:

> On Wed,  4 Mar 2020 08:29:50 +0100
> Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> 
> > Mauro's patch series <cover.1581955849.git.mchehab+huawei@kernel.org>
> > ("[PATCH 00/44] Manually convert filesystem FS documents to ReST")
> > converts many Documentation/filesystems/ files to ReST.
> > 
> > Since then, ./scripts/get_maintainer.pl --self-test complains with 27
> > warnings on Documentation/filesystems/ of this kind:
> > 
> >   warning: no file matches F: Documentation/filesystems/...
> > 
> > Adjust MAINTAINERS entries to all files converted from .txt to .rst in the
> > patch series and address the 27 warnings.
> > 
> > Link: https://lore.kernel.org/linux-erofs/cover.1581955849.git.mchehab+huawei@kernel.org
> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > ---
> > Mauro, please ack.
> > Jonathan, pick pick this patch for doc-next.  
> 
> Sigh, I need to work a MAINTAINERS check into my workflow...
> 
> Thanks for fixing these, but ... what tree did you generate the patch
> against?  I doesn't come close to applying to docs-next.

I'm starting to suspect that maybe the best workflow would be to just 
apply the patches at docs-next keeping links broken, and then run
./scripts/documentation-file-ref-check --fix by the end of a merge
window, addressing such breakages.

There are usually lots of churn outside the merge window.

Another alternative would be to split the MAINTAINERS file on a
per-subsystem basis. If I remember well, someone proposed this once at
LKML. I vaguely remember that there were even a patch (or RFC)
adding support for such thing for get_maintainers.pl.

Thanks,
Mauro
