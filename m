Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A84C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 04:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4980220C56
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 04:24:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgE2EYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 00:24:25 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:47217 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727062AbgE2EYQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 00:24:16 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 49YBKW17nhz9sT1; Fri, 29 May 2020 14:24:14 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 4fe5cda9f89d0aea8e915b7c96ae34bda4e12e51
In-Reply-To: <6c83af0f0809ef2a955c39ac622767f6cbede035.1585898438.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, airlied@linux.ie,
        daniel@ffwll.ch, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        keescook@chromium.org, hpa@zytor.com
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        intel-gfx@lists.freedesktop.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] powerpc/uaccess: Implement user_read_access_begin and user_write_access_begin
Message-Id: <49YBKW17nhz9sT1@ozlabs.org>
Date:   Fri, 29 May 2020 14:24:14 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-04-03 at 07:20:53 UTC, Christophe Leroy wrote:
> Add support for selective read or write user access with
> user_read_access_begin/end and user_write_access_begin/end.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Applied to powerpc topic/uaccess-ppc, thanks.

https://git.kernel.org/powerpc/c/4fe5cda9f89d0aea8e915b7c96ae34bda4e12e51

cheers
