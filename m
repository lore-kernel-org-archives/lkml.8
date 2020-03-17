Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD851C10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 13:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 859C320724
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 13:14:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgCQNOj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 09:14:39 -0400
Received: from ozlabs.org ([203.11.71.1]:59375 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726084AbgCQNOj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 09:14:39 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 48hYY83BzFz9sPR; Wed, 18 Mar 2020 00:14:36 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 9451c79bc39e610882bdd12370f01af5004a3c4f
In-Reply-To: <20190920153951.25762-1-ilie.halip@gmail.com>
To:     Ilie Halip <ilie.halip@gmail.com>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Ilie Halip <ilie.halip@gmail.com>, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Paul Mackerras <paulus@samba.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/pmac/smp: avoid unused-variable warnings
Message-Id: <48hYY83BzFz9sPR@ozlabs.org>
Date:   Wed, 18 Mar 2020 00:14:36 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-09-20 at 15:39:51 UTC, Ilie Halip wrote:
> When building with ppc64_defconfig, the compiler reports
> that these 2 variables are not used:
>     warning: unused variable 'core99_l2_cache' [-Wunused-variable]
>     warning: unused variable 'core99_l3_cache' [-Wunused-variable]
> 
> They are only used when CONFIG_PPC64 is not defined. Move
> them into a section which does the same macro check.
> 
> Reported-by: Nathan Chancellor <natechancellor@gmail.com>
> Signed-off-by: Ilie Halip <ilie.halip@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/9451c79bc39e610882bdd12370f01af5004a3c4f

cheers
