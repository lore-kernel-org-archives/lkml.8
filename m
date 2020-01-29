Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D63EC33CB7
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 05:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EED3A20CC7
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 05:17:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgA2FRp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 00:17:45 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:44445 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726650AbgA2FRk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 00:17:40 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 486sDz1RWgz9sSS; Wed, 29 Jan 2020 16:17:38 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 173bf44bdfc768af3c07cd0aeeb6ad8d1331b77d
In-Reply-To: <20200114110012.17351-1-laurentiu.tudor@nxp.com>
To:     Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "timur@kernel.org" <timur@kernel.org>,
        Diana Madalina Craciun <diana.craciun@nxp.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "swood@redhat.com" <swood@redhat.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: Re: [PATCH] MAINTAINERS: Add myself as maintainer of ehv_bytechan tty driver
Message-Id: <486sDz1RWgz9sSS@ozlabs.org>
Date:   Wed, 29 Jan 2020 16:17:38 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-01-14 at 11:00:25 UTC, Laurentiu Tudor wrote:
> Michael Ellerman made a call for volunteers from NXP to maintain
> this driver and I offered myself.
> 
> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/173bf44bdfc768af3c07cd0aeeb6ad8d1331b77d

cheers
