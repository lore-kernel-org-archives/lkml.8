Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 334CAC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 12:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F81520675
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 12:53:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732634AbgDAMxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 08:53:23 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:56473 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732579AbgDAMxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 08:53:22 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 48smMh3Lm4z9sTP; Wed,  1 Apr 2020 23:53:18 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: da9a1c10e2c7311e923210b6ccd9fbd1ac9132df
In-Reply-To: <9ebcbe37834e9d447dd97f4381084795a673260c.1582848567.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, mikey@neuling.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 01/13] powerpc: move ptrace into a subdirectory.
Message-Id: <48smMh3Lm4z9sTP@ozlabs.org>
Date:   Wed,  1 Apr 2020 23:53:18 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-02-28 at 00:14:37 UTC, Christophe Leroy wrote:
> In order to allow splitting of ptrace depending on the
> different CONFIG_ options, create a subdirectory dedicated to
> ptrace and move ptrace.c and ptrace32.c into it.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/da9a1c10e2c7311e923210b6ccd9fbd1ac9132df

cheers
