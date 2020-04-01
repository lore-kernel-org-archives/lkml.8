Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89693C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 12:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63F2820675
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 12:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732592AbgDAMxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 08:53:13 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:44771 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732435AbgDAMxM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 08:53:12 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 48smMT75j9z9sT9; Wed,  1 Apr 2020 23:53:09 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: b77afad84e1eedca03658ae1478ce5b8ed5aa18c
In-Reply-To: <20191125092033.20014-1-rppt@kernel.org>
To:     Mike Rapoport <rppt@kernel.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH] powerpc/32: drop unused ISA_DMA_THRESHOLD
Message-Id: <48smMT75j9z9sT9@ozlabs.org>
Date:   Wed,  1 Apr 2020 23:53:09 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-11-25 at 09:20:33 UTC, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> The ISA_DMA_THRESHOLD variable is set by several platforms but never
> referenced.
> Remove it.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/b77afad84e1eedca03658ae1478ce5b8ed5aa18c

cheers
