Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E14C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 08:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5C4720716
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 08:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SVHARPEm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgC0IlA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 04:41:00 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38207 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbgC0IlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 04:41:00 -0400
Received: by mail-pf1-f193.google.com with SMTP id c21so3532141pfo.5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 01:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S6PFdRv3dFm4asBnQ4z7ID9xmAaZoaiRYwbnBf1Aomc=;
        b=SVHARPEmycHyImvHBgHAVvU2eJwJiMdtiGsZqydqXCXdHrwuikkc8lCEXfD7DF/GRw
         ciLI1jv6xBmwX8YeaDNwcSA6+3xLPQbgjtwHiqBrH/lvz72KpaHOG/I/NSjO/VtpCSsi
         u3t1vrOmYydtCTxsWFkHANaRzx6N4YHqeKnVHOEn3c5St/YeAFQMNBGmzp7OTqigpcKa
         IOhaWt34pTLDSh5IYfDyNn0fKzoPyjgpOTOY8jETXD5lOPYdMaUVEATJIBioB7xc9EJG
         8ke63TwrS7GtcsJGMz6UIMzjxT7uEA2Xo4hOdVxGQI4B8E+OMC32HtATxc2ZIMjqMSSZ
         ZiEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S6PFdRv3dFm4asBnQ4z7ID9xmAaZoaiRYwbnBf1Aomc=;
        b=NPrGn+1iiy6/n9vtG0gWAZnscZH7tA8W9a60IyfAPWYmotR2w8Lfh8Hjo8LfpQPfVc
         crsTIPAdwsg1E4/k0s2tAkDFg8aOLqiIcYbFBqcoU4G/aC1caBWrBHP0EiF7S8px7gT1
         G5L6SQ1f0aniITf/2hw7xjk+FRIh3yLql8W3BWZT2T9SLu8yzWRSER3hYT/lYRF3LZV3
         2/1uKnCrfZ5MBmDryDRuQh7Bk7dSScthsvW/japCjB5A51FcILc1QB84AM6ajGq0fgsp
         jafC8PyCtQgF5VQlpiTzI/SH1xGQCn6x87HKF5vo0xWtqsi3WGXhUiUT3SXcmGDGDqtc
         lHDQ==
X-Gm-Message-State: ANhLgQ02mLKAl4EuTXryZZL50TDKQ4EOi9g2JRLMtcDgPJPeZwRZsH80
        AHrS2M0+MX3AMzLC2/iJXV5+/7LeJw8xuc6ljUE=
X-Google-Smtp-Source: ADFU+vtwcQFCwFzM2ueqVGvKPa3MVfy8ElVkf6USapCChwulphg5iQDOysczS7g6xYHvBc6piEJosid5H9ua3LH5DJ8=
X-Received: by 2002:a63:798a:: with SMTP id u132mr13447042pgc.203.1585298458191;
 Fri, 27 Mar 2020 01:40:58 -0700 (PDT)
MIME-Version: 1.0
References: <5aa5aad6fb1678230c260337dc066cd449a2bf32.camel@perches.com>
In-Reply-To: <5aa5aad6fb1678230c260337dc066cd449a2bf32.camel@perches.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 27 Mar 2020 10:40:50 +0200
Message-ID: <CAHp75VdyrvgD9GMP-gPWyHnLJC-zRcsupEhP3H1QuSuqqtUmdw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: List the section entries in the preferred order
To:     Joe Perches <joe@perches.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 1:29 AM Joe Perches <joe@perches.com> wrote:
>
> The MAINTAINERS file header has never shown a preferred order for the
> section entries but scripts/parse-maintainers.pl added a preferred
> order with commit 61f741645a35 ("parse-maintainers: Add section pattern
> sorting")
>
> Commit 5cdbec108fd2 ("parse-maintainers: Do not sort section content by
> default") changed the preferred order to be a bit more sensible.
>
> Update the MAINTAINERS section description block to use this preferred
> section entry ordering.
>

FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
thanks!

> Add a slightly better description for the N: entry too.
>
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  MAINTAINERS | 35 ++++++++++++++++++-----------------
>  1 file changed, 18 insertions(+), 17 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5060aa..ae4db4a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -77,21 +77,13 @@ Tips for patch submitters
>
>  8.     Happy hacking.
>
> -Descriptions of section entries
> --------------------------------
> +Descriptions of section entries and preferred order
> +---------------------------------------------------
>
>         M: *Mail* patches to: FullName <address@domain>
>         R: Designated *Reviewer*: FullName <address@domain>
>            These reviewers should be CCed on patches.
>         L: *Mailing list* that is relevant to this area
> -       W: *Web-page* with status/info
> -       B: URI for where to file *bugs*. A web-page with detailed bug
> -          filing info, a direct bug tracker link, or a mailto: URI.
> -       C: URI for *chat* protocol, server and channel where developers
> -          usually hang out, for example irc://server/channel.
> -       Q: *Patchwork* web based patch tracking system site
> -       T: *SCM* tree type and location.
> -          Type is one of: git, hg, quilt, stgit, topgit
>         S: *Status*, one of the following:
>            Supported:   Someone is actually paid to look after this.
>            Maintained:  Someone actually looks after it.
> @@ -102,30 +94,39 @@ Descriptions of section entries
>            Obsolete:    Old code. Something tagged obsolete generally means
>                         it has been replaced by a better system and you
>                         should be using that.
> +       W: *Web-page* with status/info
> +       Q: *Patchwork* web based patch tracking system site
> +       B: URI for where to file *bugs*. A web-page with detailed bug
> +          filing info, a direct bug tracker link, or a mailto: URI.
> +       C: URI for *chat* protocol, server and channel where developers
> +          usually hang out, for example irc://server/channel.
>         P: Subsystem Profile document for more details submitting
>            patches to the given subsystem. This is either an in-tree file,
>            or a URI. See Documentation/maintainer/maintainer-entry-profile.rst
>            for details.
> +       T: *SCM* tree type and location.
> +          Type is one of: git, hg, quilt, stgit, topgit
>         F: *Files* and directories wildcard patterns.
>            A trailing slash includes all files and subdirectory files.
>            F:   drivers/net/    all files in and below drivers/net
>            F:   drivers/net/*   all files in drivers/net, but not below
>            F:   */net/*         all files in "any top level directory"/net
>            One pattern per line.  Multiple F: lines acceptable.
> +       X: *Excluded* files and directories that are NOT maintained, same
> +          rules as F:. Files exclusions are tested before file matches.
> +          Can be useful for excluding a specific subdirectory, for instance:
> +          F:   net/
> +          X:   net/ipv6/
> +          matches all files in and below net excluding net/ipv6/
>         N: Files and directories *Regex* patterns.
> -          N:   [^a-z]tegra     all files whose path contains the word tegra

> +          N:   [^a-z]tegra     all files whose path contains tegra
> +                               (not including files like integrator)



>            One pattern per line.  Multiple N: lines acceptable.
>            scripts/get_maintainer.pl has different behavior for files that
>            match F: pattern and matches of N: patterns.  By default,
>            get_maintainer will not look at git log history when an F: pattern
>            match occurs.  When an N: match occurs, git log history is used
>            to also notify the people that have git commit signatures.
> -       X: *Excluded* files and directories that are NOT maintained, same
> -          rules as F:. Files exclusions are tested before file matches.
> -          Can be useful for excluding a specific subdirectory, for instance:
> -          F:   net/
> -          X:   net/ipv6/
> -          matches all files in and below net excluding net/ipv6/
>         K: *Content regex* (perl extended) pattern match in a patch or file.
>            For instance:
>            K: of_get_profile
>
>


-- 
With Best Regards,
Andy Shevchenko
