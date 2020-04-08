Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD21C2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 11:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2875A20780
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 11:37:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pi+DmAcE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbgDHLhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 07:37:21 -0400
Received: from mail-pj1-f46.google.com ([209.85.216.46]:40153 "EHLO
        mail-pj1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728488AbgDHLhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 07:37:20 -0400
Received: by mail-pj1-f46.google.com with SMTP id kx8so1041462pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 04:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-disposition;
        bh=9zgmEi4Pp4IB38ANd8pHK4nclFHRLhCP3RQ5vln66vA=;
        b=Pi+DmAcEroYSX7BE8mrmzCEvZMvsRf+H3MhBz6rQqzy+3BN5LUjq2Y2LsNpR2bewO4
         Bd8rP9qxO/w8LXjLnzZxNAsAzOEmZUP6him5u/o4I9mC+wSnxp7Y8yWq+oKeeNalO/La
         TeiEy9cl+1Y6zHEBvAGUs4a9sOtP2kVYd0FkH+vxKRzyF+SkRBUoYcfSHRLhKpGCbV/l
         m4FuhmdnvkDTE6keUXOeTRE5PCEBaY5MjHIKN5UlsQ8bS+aq+nRRNwc/IgzH1NPYNu35
         dIDFl8FY0r4EedOlpcfoGo6OHls+iJ1WOeTEMZ/P5sqxJt0VVa2d3tXtEeWYb3bZdooF
         4WhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:mime-version:content-disposition;
        bh=9zgmEi4Pp4IB38ANd8pHK4nclFHRLhCP3RQ5vln66vA=;
        b=mtkNLpsmdV6unw1jzC9yodkqaDrdhKmKhrzIkfg6Aorzl0+m/3BCh4FoMpOCQz1MDC
         N+d6adLUYialDY+zRr4eDE+iVx4Ih4UCaM3USpMY1HGm1UJt03e5Re3FeZ8fzh1r6w6G
         UXQ3R5ypy4TtssjkqkEaPhzJtgc57Gu8OR9Vty3N2TrCMKadbspglrydHrHr8Huov/b1
         oo/KHXMUTepbK/jlEXqKYvrzdzaO8n+LjQ/EOlHSa6LCKNE0WVJqYHbqg4tzAMUFC8a6
         RHZHL6BiREyjyE9R5tjPqdzho1Cb02LrE3KGoX9iugnob5PeHhY9IkuoHgKkS3/b4Euc
         sE1A==
X-Gm-Message-State: AGi0PuaCx+WBZTRUtMR93C3KaclW3HLRRLm1Ko/yPznZwZtJ1PzlPSFv
        /S3aTqMz2yVp1ziHOk7WPe2fvgtJ
X-Google-Smtp-Source: APiQypKCNF3fhbwAnY+g0Cfu8OnkKKnrsJn7lYzL+/PPLxh8QbSwRgKsi8ZtjkLNdXgwwc+Pr3qL/Q==
X-Received: by 2002:a17:90a:af8e:: with SMTP id w14mr4808165pjq.164.1586345839996;
        Wed, 08 Apr 2020 04:37:19 -0700 (PDT)
Received: from ArchLinux ([103.231.91.66])
        by smtp.gmail.com with ESMTPSA id w16sm16555742pfj.79.2020.04.08.04.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 04:37:19 -0700 (PDT)
Date:   Wed, 8 Apr 2020 17:07:05 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     LinuxKernel <linux-kernel@vger.kernel.org>
Subject: Kernel build failed ...SPHINX extension error
Message-ID: <20200408113705.GB1924@ArchLinux>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        LinuxKernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="z6Eq5LdranGa6ru8"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--z6Eq5LdranGa6ru8
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hey Jon,=20

What might caused it ...please take a peek ..

Apr 08 16:48:40 Running Sphinx v3.0.0
Apr 08 16:48:41   CC      arch/x86/events/intel/p6.o
Apr 08 16:48:41   CC      kernel/sched/completion.o
Apr 08 16:48:41   CC      kernel/power/snapshot.o
Apr 08 16:48:42   CC      arch/x86/events/intel/pt.o
Apr 08 16:48:42   CC      kernel/sched/cpupri.o
Apr 08 16:48:43   CC      kernel/power/swap.o
Apr 08 16:48:43   CC [M]  arch/x86/events/intel/rapl.o
Apr 08 16:48:43   CC      kernel/sched/cpudeadline.o
Apr 08 16:48:44   CC [M]  arch/x86/events/intel/uncore.o
Apr 08 16:48:44   CC      kernel/sched/topology.o
Apr 08 16:48:44   CC      kernel/power/user.o
Apr 08 16:48:45   CC      kernel/power/autosleep.o
Apr 08 16:48:45   CC      kernel/power/wakelock.o
Apr 08 16:48:46   CC [M]  arch/x86/events/intel/uncore_nhmex.o
Apr 08 16:48:46   CC      kernel/sched/stop_task.o

Extension error:
Could not import extension cdomain (exception: cannot import name
'c_funcptr_sig_re' from 'sphinx.domains.c'
(/usr/lib/python3.8/site-packages/sphinx/domains/c.py))
Apr 08 16:48:46 enabling CJK for LaTeX builder
Apr 08 16:48:46   CC      kernel/power/poweroff.o
make[1]: *** [Documentation/Makefile:81: htmldocs] Error 2
make: *** [Makefile:1549: htmldocs] Error 2
make: *** Waiting for unfinished jobs....


and the build aborted due to this ...

~Bhaskar

--z6Eq5LdranGa6ru8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAl6Nt10ACgkQsjqdtxFL
KRXSgQf+LOLhvmXtDpFK/E+YB6kaHpC/jf8xb/oVsgcgr7ooBoxbPZExEPHKySGP
PtAjITyi5dh/eXnpypgNyVThDWGZcPLcCJiQVJ5uPhgTDmFS56QmcAGJBluX8hjR
GR7WkS7vBkOe6kL3U8FtRCfNGWyw48WAcjog58SOD+4RDve4OBB8lFEtwbwasaqa
e/0Kw5DXn+oI+4uDkteYeoK6wsPxN8J/FW5kG4rlAoJV1J09HtkXX+JN7hbJ8/wK
zuLEO+8Wz+/Xu201BgJE17RWwGo00tRXqduvRHYIVNskztpq3FyvmvvMyCAAu2gp
/HjRLMx1QqxA0/nBuJ5XHH3UJDyAQg==
=Nr7j
-----END PGP SIGNATURE-----

--z6Eq5LdranGa6ru8--
