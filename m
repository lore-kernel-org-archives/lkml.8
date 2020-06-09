Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F209C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 05:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24CD620810
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 05:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgFIF2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 01:28:37 -0400
Received: from ozlabs.org ([203.11.71.1]:44059 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725770AbgFIF2h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 01:28:37 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 49gzDg6Xgpz9sT5; Tue,  9 Jun 2020 15:28:35 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     mpe@ellerman.id.au, benh@kernel.crashing.org,
        Chen Zhou <chenzhou10@huawei.com>, paulus@samba.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20200509020838.121660-1-chenzhou10@huawei.com>
References: <20200509020838.121660-1-chenzhou10@huawei.com>
Subject: Re: [PATCH -next] powerpc/powernv: add NULL check after kzalloc
Message-Id: <159168031252.1381411.17963161685967073553.b4-ty@ellerman.id.au>
Date:   Tue,  9 Jun 2020 15:28:35 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 May 2020 10:08:38 +0800, Chen Zhou wrote:
> Fixes coccicheck warning:
> 
> ./arch/powerpc/platforms/powernv/opal.c:813:1-5:
> 	alloc with no test, possible model on line 814
> 
> Add NULL check after kzalloc.

Applied to powerpc/next.

[1/1] powerpc/powernv: add NULL check after kzalloc
      https://git.kernel.org/powerpc/c/ceffa63acce7165c442395b7d64a11ab8b5c5dca

cheers
