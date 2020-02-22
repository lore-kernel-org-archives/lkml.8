Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD84C35671
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 04:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD3E8208C4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 04:32:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="E6MKTnGs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbgBVEcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 23:32:02 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35466 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727959AbgBVEcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 23:32:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=XfGTO7Us+1xmScgro1e+X7n3mnQDon0InuDzMdikMEw=; b=E6MKTnGstEhFaGANjP0zfbCpF2
        2gkyRP0p1PkZiIC2rI0QHkHK9HDgAI+GwxNpmPcWNloNg0AFOEzqbxqpKB9kfoUX34KUx6vo9l0Pc
        5bY5VC0b4xN7PfLlZzjSPBUf6Ug9s6S9qAHHElzzUJ5Fc63MzpAXik1geZVYYN3xA6I3KGM5jwBWu
        D+v/sZeQ2Kn+SgEAv9RtM6nLnctyfXephxkAAjMd8DdxuJAk7zLH6WLXKLK4NPiSpNgQf55vVKMLu
        yqP+j59BMXkLdWVKbwuTmBZX4fkaIiBwCa8r0ZKrvTphZG8Oqlbol/ZLI7MxALKnW7AzxM7y9eRMb
        o8BTp82A==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j5MHi-0001Nl-NW; Sat, 22 Feb 2020 04:20:58 +0000
Subject: Re: [PATCH v3 1/2] bootconfig: Prohibit re-defining value on same key
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <158227281198.12842.8478910651170568606.stgit@devnote2>
 <158227282199.12842.10110929876059658601.stgit@devnote2>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <536c681d-a546-bb51-a6cb-2d39ed726716@infradead.org>
Date:   Fri, 21 Feb 2020 20:20:57 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <158227282199.12842.10110929876059658601.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/21/20 12:13 AM, Masami Hiramatsu wrote:
> Currently, bootconfig adds new value on the existing key
> to the tail of an array. But this looks a bit confusing
> because admin can rewrite original value in same config
> file easily.
> 
> This rejects following value re-definition.
> 
>   key = value1
>   ...
>   key = value2
> 
> You should rewrite value1 to value2 in this case.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>

Hi,
One correction below and then question.

> ---
>  Documentation/admin-guide/bootconfig.rst   |   11 ++++++++++-
>  lib/bootconfig.c                           |   13 ++++++++-----
>  tools/bootconfig/samples/bad-samekey.bconf |    6 ++++++
>  3 files changed, 24 insertions(+), 6 deletions(-)
>  create mode 100644 tools/bootconfig/samples/bad-samekey.bconf
> 
> diff --git a/Documentation/admin-guide/bootconfig.rst b/Documentation/admin-guide/bootconfig.rst
> index dfeffa73dca3..9ee7650b7817 100644
> --- a/Documentation/admin-guide/bootconfig.rst
> +++ b/Documentation/admin-guide/bootconfig.rst
> @@ -62,7 +62,16 @@ Or more shorter, written as following::
>  In both styles, same key words are automatically merged when parsing it
>  at boot time. So you can append similar trees or key-values.
>  
> -Note that a sub-key and a value can not co-exist under a parent key.
> +Same-key Values
> +---------------
> +
> +It is prohibited that two or more values or arraies share a same-key.

I think (?):                                   arrays

> +For example,::
> +
> + foo = bar, baz
> + foo = qux  # !ERROR! we can not re-define same key
> +
> +Also, a sub-key and a value can not co-exist under a parent key.
>  For example, following config is NOT allowed.::
>  
>   foo = value1


I'm pretty sure that the kernel command line allows someone to use
  key=value1 ... key=value2
and the first setting is just overwritten with value2 (for most "key"s).

Am I wrong?  and is this patch saying that bootconfig won't operate like that?

thanks.
-- 
~Randy

