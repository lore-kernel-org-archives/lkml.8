Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E179DC2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 07:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFA6B206F7
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 07:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pL4MAQ0l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgDJHwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 03:52:25 -0400
Received: from mail-pj1-f43.google.com ([209.85.216.43]:50212 "EHLO
        mail-pj1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbgDJHwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 03:52:25 -0400
Received: by mail-pj1-f43.google.com with SMTP id b7so514316pju.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 00:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mail-followup-to:mime-version
         :content-disposition;
        bh=++i4XLt2rxQ9d08pCPF9LVsNkjnVyiDU1y31+VBVrkQ=;
        b=pL4MAQ0lxJrzQwdLVV89ZFD4QvX4GJ1kMz5bDtp7qmuLLqihIrlbbKc6AJKkAjTkgg
         vTjysAp8Lgn7Ag7rOQwWpR5KDkP95lfP4rpDg8us3hvY6c04WCadmJqX7ekgBcK0pmdV
         5um9LnsUmafd7gkBAgr23fY83ot2IMKlQHsdOn3gM3S7xryoO2Q1ssEYZecJerTMByEy
         XjocwAJToLDtI6BkRga3lQNbkRorrE5OUOWSKNQz/7QSKTdJSTSHhJoav85fYGFstbFl
         /JwM4mDDwDVHZgcpz7sk1dMa5E+nmkqK0oT8gdiPpljAMZQYYo6giubtu73p81DjPUcU
         5PgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :mime-version:content-disposition;
        bh=++i4XLt2rxQ9d08pCPF9LVsNkjnVyiDU1y31+VBVrkQ=;
        b=Iu5qVscz/qwinI1qmUmoBTTmSXt4rnpkCB4eX9VIRRQ4vXmjvZarx73Fj2sEu9Ypre
         12L5PHcVoN0aTqIt3IfKPid6K7GWL7z4e8GmikFthfvYHjty0Ca0+znESZa/W8JVS9VG
         XYJbw7577Ddnno60LyaAXcyDJDJnFsEwYWQHW9FWTQKOB6xYlcOVKUftMRq/XvYfuf85
         cgJ0kGLiXbD5cwWbDklZofppGh/oSQ63tABhUwnPD4NqZ/EEMSGlW80BFrZ+4U0guchb
         sLG7Kf+1y2sbabaJ9nv+Av/IQJVR4E+g7dMmjr/qQHIk2fZd/NKk/OwW3+Fo1w3QUDRe
         BNhw==
X-Gm-Message-State: AGi0PuaAdczNWvCt0qHfI3/4kvHuT+1nOBf+b8CMyzkNv8pGymzLGySl
        LTKDrCl+Hs5gbdi8k2f8htG0H39l
X-Google-Smtp-Source: APiQypLfxo3pwKibQYEYDr5wPUhh4qfXnTNdp4DC32Ha0WWNvZyOPaCR8LHGl0/x8I8Ot71AU9YX9Q==
X-Received: by 2002:a17:902:eb13:: with SMTP id l19mr3541402plb.156.1586505144427;
        Fri, 10 Apr 2020 00:52:24 -0700 (PDT)
Received: from VoidLinux ([103.231.91.67])
        by smtp.gmail.com with ESMTPSA id f10sm1044353pjt.7.2020.04.10.00.52.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 Apr 2020 00:52:23 -0700 (PDT)
Date:   Fri, 10 Apr 2020 13:22:15 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     LinuxKernel <linux-kernel@vger.kernel.org>
Subject: linux-next 10/04/2020 build failed 
Message-ID: <20200410075215.GA2644@VoidLinux>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        LinuxKernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

  Here is the snippet

  scripts/kconfig/conf  --syncconfig Kconfig
    HYPERCALLS arch/x86/include/generated/asm/xen-hypercalls.h
      UPD     include/config/kernel.release
      /bin/sh: 1: Syntax error: redirection unexpected
      make: *** [Makefile:1195: include/generated/utsrelease.h] Error 2
      make: *** Waiting for unfinished jobs....
      scripts/kconfig/conf  --syncconfig Kconfig
        HOSTCC  scripts/genksyms/genksyms.o
          YACC    scripts/genksyms/parse.tab.[ch]
	   HOSTCC  scripts/genksyms/parse.tab.o
	     LEX     scripts/genksyms/lex.lex.c
	       HOSTCC  scripts/genksyms/lex.lex.o
	         HOSTLD  scripts/genksyms/genksyms
		   HOSTCC  scripts/selinux/genheaders/genheaders
		     HOSTCC  scripts/selinux/mdp/mdp
		       UPD     include/config/kernel.release
		       /bin/sh: 1: Syntax error: redirection unexpected
		       make: *** [Makefile:1195:
		       include/generated/utsrelease.h] Error 2


		       ~Bhaskar

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAl6QJasACgkQsjqdtxFL
KRWMIwf/fdk6oqTpr2BqpRUScGU9FI4EilDPTlM4Oaq6PmzzTZRWhB1zsV4vCf76
Zw7HcrCYM3LNOax8gInlDJVgV6l315YiiKcV0gEnX6G5weyywi9vmtynqCRK4Y9h
25tlS6FpgvHg6jUf0kw0FSnrKzyZEXUo+3sWFpEkSn6VcgD/m7h6mJKk4dqvN0H4
HTl5SartUkydbc409ECEoDf4lMKXIjUup04oeYkve6iFwbtCRNS/8YQlMs6C6vM5
In50Zaul50Zf2k0JSHVcfFqKtS72JuRP1bG/zwQmG83dqDC05WtxnlwB8vkFpZhs
IDLUBT3af3SWW+McFWBwAaADa8u24w==
=zggP
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
