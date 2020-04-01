Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25681C2D0F0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 12:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04F0520675
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 12:53:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732615AbgDAMxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 08:53:19 -0400
Received: from ozlabs.org ([203.11.71.1]:35845 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732435AbgDAMxO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 08:53:14 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 48smMX3rdHz9sTF; Wed,  1 Apr 2020 23:53:12 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 41b8426fdb59218f56a6e3b3facd43a82816e3eb
In-Reply-To: <20200215053637.280880-1-leonardo@linux.ibm.com>
To:     Leonardo Bras <leonardo@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Leonardo Bras <leonardo@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>, desnesn@linux.ibm.com
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] powerpc/cputable: Remove unnecessary copy of cpu_spec->oprofile_type
Message-Id: <48smMX3rdHz9sTF@ozlabs.org>
Date:   Wed,  1 Apr 2020 23:53:12 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-02-15 at 05:36:37 UTC, Leonardo Bras wrote:
> Before checking for cpu_type == NULL, this same copy happens, so doing
> it here will just write the same value to the t->oprofile_type
> again.
> 
> Remove the repeated copy, as it is unnecessary.
> 
> Signed-off-by: Leonardo Bras <leonardo@linux.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/41b8426fdb59218f56a6e3b3facd43a82816e3eb

cheers
