Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD9DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 13:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CADF8207D3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 13:32:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="S7lLmzfT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390420AbgE1NcJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 09:32:09 -0400
Received: from ozlabs.org ([203.11.71.1]:48711 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390303AbgE1NcH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 09:32:07 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49XpX46yFYz9sSJ;
        Thu, 28 May 2020 23:32:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1590672725;
        bh=0sJJ11D8pW/bxn58Yyk4JUx2OhJl8nn/ry1kzGYvIA4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=S7lLmzfTbleQxCIXEp5wejgCFp06D8FgfRoukDWeaIxQOU3NOnI87fXfV2MfQGsts
         G5cQDAqms4IXi4coEhnmcUtEm3XHi+C3fb+0Is66Jwsqa37eqA88mCn6/WjbQnqo7G
         HnhSL61dJ5SoCXLdkG6WreBn8C3hnSahyMT9bb+LfCAAzM9jpErN1rA4tkokzUzF41
         FZKDt1Fzm3Cp/ofOZAjb/y24PFt0FiulUDihrHqL078aV+nyfStp4iHSr5vXM4mK8Z
         yoe/xu57ErV+3RKAQ7l6ChDsZJ/mtRi8WFzEQ/LY7EWgkZvVQaw0P2SoRw/dNDcArz
         JrBWOiOBBCbHg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        kbuild test robot <lkp@intel.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v2] powerpc/wii: Fix declaration made after definition
In-Reply-To: <20200526205756.2952882-1-natechancellor@gmail.com>
References: <20200413190644.16757-1-natechancellor@gmail.com> <20200526205756.2952882-1-natechancellor@gmail.com>
Date:   Thu, 28 May 2020 23:32:29 +1000
Message-ID: <871rn4jic2.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Chancellor <natechancellor@gmail.com> writes:
> A 0day randconfig uncovered an error with clang, trimmed for brevity:
>
> arch/powerpc/platforms/embedded6xx/wii.c:195:7: error: attribute
> declaration must precede definition [-Werror,-Wignored-attributes]
>         if (!machine_is(wii))
>              ^
>
> The macro machine_is declares mach_##name but define_machine actually
> defines mach_##name, hence the warning.
>
> To fix this, move define_machine after the machine_is usage.
>
> Fixes: 5a7ee3198dfa ("powerpc: wii: platform support")
> Reported-by: kbuild test robot <lkp@intel.com>
> Link: https://github.com/ClangBuiltLinux/linux/issues/989
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>
> v1 -> v2:
>
> * s/is_machine/machine_is/ (Nick)
>
> * Add Nick's reviewed-by tag.

I already picked up v1, and it's behind a merge so I don't want to
rebase it. I'll live with the typo. Thanks.

cheers
