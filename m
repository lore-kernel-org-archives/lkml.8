Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0034BC352A3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 05:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C15BD2173E
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 05:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="MyBxSIY7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729702AbgBMFuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 00:50:11 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:3324 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgBMFuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 00:50:11 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e44e3760001>; Wed, 12 Feb 2020 21:49:42 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 12 Feb 2020 21:50:10 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 12 Feb 2020 21:50:10 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 13 Feb
 2020 05:50:10 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 13 Feb 2020 05:50:10 +0000
Received: from blueforge.nvidia.com (Not Verified[10.110.48.28]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e44e3920002>; Wed, 12 Feb 2020 21:50:10 -0800
From:   John Hubbard <jhubbard@nvidia.com>
To:     Joe Perches <joe@perches.com>
CC:     Andy Whitcroft <apw@canonical.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2 1/1] checkpatch: support "base-commit:" format
Date:   Wed, 12 Feb 2020 21:50:04 -0800
Message-ID: <20200213055004.69235-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213055004.69235-1-jhubbard@nvidia.com>
References: <20200213055004.69235-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1581572982; bh=2fzW1cFQcCv8wV+9ogMJBPeSWfZqvFADlLbfZGyZt3Y=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=MyBxSIY7te8xFRF51y23sJ1vt2fRt38Auojnd0p+V5cCnVwa+mnGu0y4nZYPfFQAN
         NDARuJzh3/1H7CIiJ5tjdveXfsVxAxiAGVrv5MGFtmvnQmeolXyzw+tD+jiQY+Rmgj
         uV1Dyq646lUL1TMTUHV7FCwWMHWZoJaCYAMloO92zZ+P30H5WstN2RFU/fl9WjLLgp
         4+wLZqmVHZAsp/bGe6rUHPEZu375etObGnSm6lvXF4UhxjN4V/2SXQ3CIT0H/Uyz29
         aYaECHvMKHc3S0D3KS2HVrmPNU4amsTGh/b7uIJ8DonP7KW8rPXelK1vCXz4Y77lvP
         jXC3Bcf/rc5ng==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to support the get-lore-mbox.py tool described in [1], I ran:

    git format-patch --base=3D<commit> --cover-letter <revrange>

...which generated a "base-commit: <commit-hash>" tag at the end of the
cover letter. However, checkpatch.pl generated an error upon encounting
"base-commit:" in the cover letter:

    "ERROR: Please use git commit description style..."

...because it found the "commit" keyword, and failed to recognize that
it was part of the "base-commit" phrase, and as such, should not be
subjected to the same commit description style rules.

Update checkpatch.pl to include a special case for "base-commit:" (at
the start of the line, possibly with some leading whitespace) so
that that tag no longer generates a checkpatch error.

[1] https://lwn.net/Articles/811528/ "Better tools for kernel
    developers"

Cc: Andy Whitcroft <apw@canonical.com>
Suggested-by: Joe Perches <joe@perches.com>
Cc: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index a63380c6b0d2..1e66fc7a2f2f 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2761,7 +2761,7 @@ sub process {
=20
 # Check for git id commit length and improperly formed commit descriptions
 		if ($in_commit_log && !$commit_log_possible_stack_dump &&
-		    $line !~ /^\s*(?:Link|Patchwork|http|https|BugLink):/i &&
+		    $line !~ /^\s*(?:Link|Patchwork|http|https|BugLink|base-commit):/i &=
&
 		    $line !~ /^This reverts commit [0-9a-f]{7,40}/ &&
 		    ($line =3D~ /\bcommit\s+[0-9a-f]{5,}\b/i ||
 		     ($line =3D~ /(?:\s|^)[0-9a-f]{12,40}(?:[\s"'\(\[]|$)/i &&
--=20
2.25.0

