Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57EB6C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 17:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4154C207E8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 17:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbgFZRUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 13:20:07 -0400
Received: from ms.lwn.net ([45.79.88.28]:35772 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbgFZRUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 13:20:06 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id B79207DB;
        Fri, 26 Jun 2020 17:20:04 +0000 (UTC)
Date:   Fri, 26 Jun 2020 11:20:03 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Tony Fischetti <tony.fischetti@gmail.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@suse.de>, Will Deacon <will@kernel.org>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Joe Perches <joe@perches.com>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jacob Huisman <jacobhuisman@kernelthusiast.com>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Jonathan =?UTF-8?B?TmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones:
 Documentation/process
Message-ID: <20200626112003.50788c9b@lwn.net>
In-Reply-To: <20200621133630.46435-1-grandmaster@al2klimov.de>
References: <20200621133630.46435-1-grandmaster@al2klimov.de>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Jun 2020 15:36:30 +0200
"Alexander A. Klimov" <grandmaster@al2klimov.de> wrote:

> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
> 
> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
>           If both the HTTP and HTTPS versions
>           return 200 OK and serve the same content:
>             Replace HTTP with HTTPS.
> 
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
> ---
>  Documentation/process/2.Process.rst           | 12 ++++----
>  Documentation/process/4.Coding.rst            |  4 +--
>  Documentation/process/botching-up-ioctls.rst  |  2 +-
>  Documentation/process/changes.rst             |  6 ++--
>  Documentation/process/clang-format.rst        |  2 +-
>  Documentation/process/coding-style.rst        |  2 +-
>  Documentation/process/howto.rst               |  2 +-
>  Documentation/process/kernel-docs.rst         | 28 +++++++++----------
>  .../process/maintainer-pgp-guide.rst          |  2 +-
>  Documentation/process/submitting-drivers.rst  | 22 +++++++--------
>  Documentation/process/submitting-patches.rst  |  4 +--
>  11 files changed, 43 insertions(+), 43 deletions(-)

I've applied this, thanks.

jon
