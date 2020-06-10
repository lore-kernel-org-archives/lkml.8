Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E5AFC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 08:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 469442078D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 08:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="t95kRWpI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgFJI6E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 04:58:04 -0400
Received: from mx.kolabnow.com ([95.128.36.41]:20030 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726081AbgFJI6D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 04:58:03 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTP id 422B2A1D;
        Wed, 10 Jun 2020 10:58:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:message-id:date:date:subject:subject
        :from:from:received:received:received; s=dkim20160331; t=
        1591779479; x=1593593880; bh=ukQu5iHRn6B2xVjPeaJqvtM0JRMk3+0xuHb
        TRO+Q5Bo=; b=t95kRWpIwCm6xMKS+QoQc8bxZ5xBWGu+g0EuKaxNsY7R78Yv3hp
        umT/bVqPY5yLqw1dsjek4RRUOoVltXKpwtr7XKaIb0QPbhewPMX7Qf8y4tm3rM5v
        PWkFZxAo7xdu4OskyPdvJovtCtWmwjVYXkpbjQ53B+Jxr8N8cuHb/B9pF17Qe/qF
        5lY0lN2eQjBTnFIMsEBZYTBqZyz/SAPzroH1G1p7rVSByj2CW9YSUmIofPSYGSuj
        z3QNWAVz1CuliTl8QwgQ+yv2IvzYXLqMQQQ/YnaquiBK3JYE81YWP3C0N7pejlsv
        NkfsoWcRL5Z20viM2r3c/IsFFkRYPKKu8QBYXqQ9OALxJemsOAGsFw3oiZc3S/Zz
        4LERU22uUCwouNmczt8t1A5pcSdkMySdHjyhLcq4xtizpp49bVRH6dZt6bp3NtB5
        XvBAm+jvGke4lIu17prCMjFcO/wZ/tgTQQv5zNCQ3dG9iF4AQl0MTeWHJjeN+F10
        RMLMJvSSiAFrKVlH884d/4QygYUcLVOP+/ts6ws1YR6q02PtKs1bjZStzHkU5Nds
        98qQLYd6Ki8ytxGKsHG2Efhfai79XWJ5nNJgCzdGGWTyLNuTOhwGY1y3ufTGTQVs
        JwZiTfdlLp3ZCuR92R9pq4DF3yogXIK8g4HElLOajrFGCRAmuBEsZiec=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out002.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id N5sj-GWGxziN; Wed, 10 Jun 2020 10:57:59 +0200 (CEST)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTPS id 7722445E;
        Wed, 10 Jun 2020 10:57:59 +0200 (CEST)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
        by int-mx003.mykolab.com (Postfix) with ESMTPS id ACAB0AF0;
        Wed, 10 Jun 2020 10:57:58 +0200 (CEST)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Jonathan Corbet <corbet@lwn.net>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        David Sterba <dsterba@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Jacob Huisman <jacobhuisman@kernelthusiast.com>,
        Jonathan =?ISO-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        Rob Herring <robh@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones: Documentation/translations/it_IT
Date:   Wed, 10 Jun 2020 10:57:57 +0200
Message-ID: <4235548.LvFx2qVVIh@harkonnen>
In-Reply-To: <20200609201241.81518-1-grandmaster@al2klimov.de>
References: <20200609201241.81518-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, June 9, 2020 10:12:41 PM CEST Alexander A. Klimov wrote:
> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
>=20
> Deterministic algorithm:
> For each file:
>   For each line:
>     If doesn't contain `\bxmlns\b`:
>       For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
>         If both the HTTP and HTTPS versions
>         return 200 OK and serve the same content:
>           Replace HTTP with HTTPS.
>=20
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
> ---
>  .../translations/it_IT/admin-guide/README.rst      |  2 +-
>  .../translations/it_IT/doc-guide/parse-headers.rst |  2 +-
>  .../translations/it_IT/doc-guide/sphinx.rst        | 10 +++++-----
>  .../translations/it_IT/process/2.Process.rst       | 12 ++++++------
>  .../translations/it_IT/process/3.Early-stage.rst   |  2 +-
>  .../translations/it_IT/process/4.Coding.rst        |  4 ++--
>  .../it_IT/process/7.AdvancedTopics.rst             |  8 ++++----
>  .../translations/it_IT/process/8.Conclusion.rst    | 14 +++++++-------
>  .../translations/it_IT/process/adding-syscalls.rst |  4 ++--
>  .../translations/it_IT/process/changes.rst         |  6 +++---
>  .../translations/it_IT/process/clang-format.rst    |  2 +-
>  .../translations/it_IT/process/coding-style.rst    |  2 +-
>  Documentation/translations/it_IT/process/howto.rst |  2 +-
>  .../it_IT/process/maintainer-pgp-guide.rst         |  2 +-
>  .../it_IT/process/submitting-patches.rst           |  4 ++--
>  .../it_IT/process/volatile-considered-harmful.rst  |  4 ++--
>  16 files changed, 40 insertions(+), 40 deletions(-)
>=20


> diff --git a/Documentation/translations/it_IT/doc-guide/sphinx.rst
> b/Documentation/translations/it_IT/doc-guide/sphinx.rst index
> f1ad4504b734..0aaeb0297661 100644
> --- a/Documentation/translations/it_IT/doc-guide/sphinx.rst
> +++ b/Documentation/translations/it_IT/doc-guide/sphinx.rst
> @@ -14,7 +14,7 @@ Per generare la documentazione in HTML o PDF, usate
> comandi ``make htmldocs`` o ``make pdfdocs``. La documentazione cos=EC
> generata sar=E0 disponibile nella cartella ``Documentation/output``.
>=20
> -.. _Sphinx: http://www.sphinx-doc.org/
> +.. _Sphinx: https://www.sphinx-doc.org/
>  .. _reStructuredText: http://docutils.sourceforge.net/rst.html

It is not part of the deterministic algorithm but you may consider this as=
=20
well

=2D.. _reStructuredText: http://docutils.sourceforge.net/rst.html
+.. _reStructuredText: https://docutils.sourceforge.io/rst.html




