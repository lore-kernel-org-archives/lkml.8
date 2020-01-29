Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57043C33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 05:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34E9920CC7
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 05:17:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgA2FRq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 00:17:46 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:57551 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726719AbgA2FRn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 00:17:43 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 486sF15MZrz9sRs; Wed, 29 Jan 2020 16:17:41 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 1e3531982ee70adf1880715a968d9c3365f321ed
In-Reply-To: <20200121013153.9937-1-chenzhou10@huawei.com>
To:     Chen Zhou <chenzhou10@huawei.com>, <benh@kernel.crashing.org>,
        <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     chenzhou10@huawei.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, nivedita@alum.mit.edu,
        tglx@linutronix.de, linuxppc-dev@lists.ozlabs.org,
        allison@lohutok.net
Subject: Re: [PATCH -next] powerpc/maple: fix comparing pointer to 0
Message-Id: <486sF15MZrz9sRs@ozlabs.org>
Date:   Wed, 29 Jan 2020 16:17:41 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-01-21 at 01:31:53 UTC, Chen Zhou wrote:
> Fixes coccicheck warning:
> ./arch/powerpc/platforms/maple/setup.c:232:15-16:
> 	WARNING comparing pointer to 0
> 
> Compare pointer-typed values to NULL rather than 0.
> 
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/1e3531982ee70adf1880715a968d9c3365f321ed

cheers
