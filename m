Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E6BC11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 16:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC17A24677
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 16:28:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pallissard.net header.i=@pallissard.net header.b="G1GkiPbf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730223AbgB0Q2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 11:28:49 -0500
Received: from mail-io1-f48.google.com ([209.85.166.48]:44739 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729263AbgB0Q2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 11:28:48 -0500
Received: by mail-io1-f48.google.com with SMTP id z16so62740iod.11
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 08:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pallissard.net; s=google;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=RouZj86RMULXvU0+Z7IZtP2zRr9IowTURkckXtT6oes=;
        b=G1GkiPbfF1Epvh5ZrZhrHNAepcAHIEEPBvdMSs11mfdsPseYwgSG8Fp7wGmAqJX0cB
         0V33R/QSss7q+oiZxGepZiAiVQTT8Y+QMSDrJmzLv1NcpTgDo+3XJyqXJqYC4jtmxeS9
         UkMR2/HpzUIPmZsDJ05Jl2man+TBstAkEsCb4Os/qOXo0iC6pGE33DrSbDJ5IhPcKkLZ
         xySO+q56FXtiGGDU2Hb3GXMcqU5JvFICLYcwe4vzzYR1C5PVRpx4bpt+2NUgO6E47A/s
         7VB3rtjG20FaZPusELbfrgwHnL/ogfvHDD1RMwCwbqI6uDUOIzRd3GhjnupBEy4dV1Cq
         C4aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=RouZj86RMULXvU0+Z7IZtP2zRr9IowTURkckXtT6oes=;
        b=Wu+Ut6gbhw3i8VniKeKkMQj7suYFtUBDIu3Q7oeAiwTgdYv/DCq22+VZ8myCr9eRat
         642oeqUgzMr4GVZ+hWkb1ZCSMRqvnPqwIZSLiC4MROXf8UStkNMgJc4DQa9Gr7EbxPUH
         zntG9ib1LexJLe6XQDChMAiCivNWEQw3CnxvXwvO9iW4ov30UGSQ+ecjqsUJCE69ZoQ4
         ELe3fnkJkB687JkvxjEYp4O6EXoHIEKb5MsmeyRw8ahff9bVzhb++P56059uyeXeryVz
         ol7XXS2WXnPiAFjFoNr5GcWP5l3bQ1rzvpiZVtq9rOGUT0PBAdGdM2FUPh7d7p8F3ED2
         kaRw==
X-Gm-Message-State: APjAAAXvCLY7FnYP2QQ+9VFQ+Tyt2YNIXqxwnYdXGhpI70iARXkuKiAP
        5kfUf3mP2EJEATZcDxRKxdEmQX/6q/w=
X-Google-Smtp-Source: APXvYqx/HbT1ZZPgrXHf8ymkNieFYeaBn4FfmcwSncYS+QJPiAI1/ja8GkP6DqqtVWu1cKAWvXYvMQ==
X-Received: by 2002:a6b:b594:: with SMTP id e142mr117664iof.198.1582820927024;
        Thu, 27 Feb 2020 08:28:47 -0800 (PST)
Received: from mail.matt.pallissard.net (169.121.68.34.bc.googleusercontent.com. [34.68.121.169])
        by smtp.gmail.com with ESMTPSA id g132sm1483207iof.44.2020.02.27.08.28.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 08:28:46 -0800 (PST)
Date:   Thu, 27 Feb 2020 08:28:43 -0800
From:   "Pallissard, Matthew" <matt@pallissard.net>
To:     linux-kernel@vger.kernel.org
Subject: possible nfsv3 write corruption
Message-ID: <20200227162843.n2qjuka2rjc44qcv@matt-gen-desktop-p01.matt.pallissard.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="e5jfn5ho7nk32f3n"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--e5jfn5ho7nk32f3n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Forgive me if this is the wrong list.

Ok, I have this super infrequent data corruption on write that seems to be limited to nfsv3 async mounts.  I have not tested nfsv4 yet.  I _think_ I've narrowed down to the 5.5.0 > X >= 5.1.4 (maybe earlier) kernels.  I had some users report they had random data corruption.  A bit of testing shows that it's reproducible and the corruption is nearly identical every time.

I'd like to get to the bottom of this so I can guarantee that a kernel upgrade will resolve the issue.

What winds up happening is every several hundred GiB[ish] we wind up with the first half of a 64 bit segment corrupted.  Here is some example output from a test.  My test writes a few Gib, alternating between 64 bits of `0`'s and 64 bits of `1`'s.  I then read it in and check the contents. Re-reading the file shows that it's corrupted on write, not read.

> 2020-02-14 11:04:34 crit   found mis-match on word segment 11911168 / 33554432!
> 2020-02-14 11:04:34 crit   found mis-match on byte 7, 188 != 255
> 2020-02-14 11:04:34 crit   found mis-match on byte 6, 0 != 255
> 2020-02-14 11:04:34 crit   found mis-match on byte 5, 16 != 255
> 2020-02-14 11:04:34 crit   found mis-match on byte 4, 128 != 255
> 2020-02-14 11:04:34 crit   1011110000000000000100001000000011111111111111111111111111111111

> 2020-02-14 13:38:11 crit   found mis-match on word segment 1982464 / 33554432!
> 2020-02-14 13:38:11 crit   found mis-match on byte 7, 188 != 255
> 2020-02-14 13:38:11 crit   found mis-match on byte 6, 0 != 255
> 2020-02-14 13:38:11 crit   found mis-match on byte 5, 16 != 255
> 2020-02-14 13:38:11 crit   found mis-match on byte 4, 128 != 255
> 2020-02-14 13:38:11 crit   1011110000000000000100001000000011111111111111111111111111111111


Knowns;

	* does not appear to happen on CentOS/EL 3.10 series kernel

	* does not appear to happen on a 5.5 series kernel
		* I'm re-running all my tests now to confirm this.

	* not hardware dependent

	* not processor dependent
		* I tested 3 different Intel processors

	* appears to only happen on NFS v3 async mounts
		* local disk and `-o sync` NFS v3 mounts have been tested

	* It happens on random 64 bit segments

	* It's *always* the same 4 bytes that are corrupted

	* While often identical, the corrupted bytes are not always identical
		* the identical corruption pattern can appear on separate computers.

	* It's *always* on words that are written with `1`'s <- this is the part I find most interesting

	* whether or not I explicitly call `fflush` and `sync` has no effect on the results.

	* usually takes ~80-2000Gib to reproduce, sometimes higher or lower but infrequent.
		* I've been writing 2GiB files
		* sometimes I never hit the corruption case.

	* I've yet to see more than one corrupted segment in a file.


A little bit about the build/run environments;

the hardware
	CentOS 7.
	CentOS glibc 2.17
	clang 9 / lld
	Dell PowerEdge R620
	Dell PowerEdge C6320
	Dell PowerEdge C6420
	Intel(R) Xeon(R) Gold 6230 CPU @ 2.10GHz
	Intel(R) Xeon(R) CPU E5-2660 v4 @ 2.00GHz
	Intel(R) Xeon(R) CPU E5-2680 v2 @ 2.80GHz

* I did compile locally on every box.  I also tested every compiled binary on every box.  It didn't seem to affect the results.
* I don't have a tcpdump of this yet.  I'm hoping to get that started before the end of the week.
* I read and write to the same file every time, unlinking it before writing again
* I have not tried dropping the cache between any of the steps.
* I have engaged our storage vendor to see what they have to say.  They're pretty good at getting useful metrics and insight so if there is anything I should have them gather server-side please let me know.


If anyone as any insight or additional testing I can perform I would *greatly* appreciate it.  I would be thrilled if this turned out to be some dumb configuration option or other operational thing performed incorrectly.


Thank you for your time.

Matt Pallissard

--e5jfn5ho7nk32f3n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTvIUMPApUGn6YFkXl1uof+t048SQUCXlfuOAAKCRB1uof+t048
SdCRAQCrD2jblRIe1GKkEmWK2KMlAntmmY9O7LG1OS95K4pGZgEA70tBudOvEFNz
iuNS6S9ZdzgkYYcpULBJffFPoxyoxwY=
=ZUzT
-----END PGP SIGNATURE-----

--e5jfn5ho7nk32f3n--
