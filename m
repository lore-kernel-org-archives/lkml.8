Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC43EC47247
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6E9B20708
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:57:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgEHN5i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:57:38 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:45514 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbgEHN5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 09:57:37 -0400
Received: from 89-64-85-173.dynamic.chello.pl (89.64.85.173) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id d8c954b8ac2de5b7; Fri, 8 May 2020 15:57:05 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>
Subject: Re: linux-next: manual merge of the amdgpu tree with the pm tree
Date:   Fri, 08 May 2020 15:57:05 +0200
Message-ID: <1973656.7Sjq3fjOQu@kreacher>
In-Reply-To: <20200508143457.14acfc46@canb.auug.org.au>
References: <20200508143457.14acfc46@canb.auug.org.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, May 8, 2020 6:34:57 AM CEST Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the amdgpu tree got a conflict in:
> 
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> 
> between commit:
> 
>   e07515563d01 ("PM: sleep: core: Rename DPM_FLAG_NEVER_SKIP")
> 
> from the pm tree and commit:
> 
>   500bd19a7e5d ("drm/amdgpu: only set DPM_FLAG_NEVER_SKIP for legacy ATPX BOCO")
> 
> from the amdgpu tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Thanks for resolving this, the resolution looks good to me.

Cheers!



