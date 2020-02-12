Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E2BC352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 23:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAA9621734
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 23:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="B7ll61A6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729367AbgBLXcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 18:32:24 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:12761 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727117AbgBLXcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 18:32:23 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e448af90000>; Wed, 12 Feb 2020 15:32:09 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 12 Feb 2020 15:32:23 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 12 Feb 2020 15:32:23 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 12 Feb
 2020 23:32:22 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 12 Feb 2020 23:32:22 +0000
Received: from blueforge.nvidia.com (Not Verified[10.110.48.28]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e448b060001>; Wed, 12 Feb 2020 15:32:22 -0800
From:   John Hubbard <jhubbard@nvidia.com>
To:     Joe Perches <joe@perches.com>
CC:     Andy Whitcroft <apw@canonical.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 1/1] checkpatch: support "base-commit:" format
Date:   Wed, 12 Feb 2020 15:32:21 -0800
Message-ID: <20200212233221.47662-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200212233221.47662-1-jhubbard@nvidia.com>
References: <20200212233221.47662-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1581550329; bh=FRuYVUnC7K1U/LqgpvS/vWTnisUzXBRoaqzkfsIXevs=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=B7ll61A6N7ZeDDyVelqd7SYXmE7rdK5rt85E6B/QZV4mIs/aLMMh8fC3jWcFDosdm
         esZUppfRjYe2e9fPbr97uk328nmpBxOWfxNWY07j9/izK4EYMOLyLI8rKTtd0WAuo/
         4q8v5lNPsaniSIi3h+okjmrPGU9k+xWmGJ4z6sm7idTfL8EOC00CNamjkFhQAqiBt6
         7xaWIImPGgF3xTg+jm5RHsvrgvYUysiJa4Tl91qLt5ht0y6ZhTUaxF+yKNL2cB1Au+
         XiSdVVYgi+sfv0IDFwVwaImPh1E1faoYZa154OU4dQrnZefTpgvRu8TlZufLXwoDXB
         UzaWTFbwRGURQ==
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

Update checkpatch.pl to include a special case for "base-commit:", so
that that tag no longer generates a checkpatch error.

[1] https://lwn.net/Articles/811528/ "Better tools for kernel
    developers"

Cc: Andy Whitcroft <apw@canonical.com>
Cc: Joe Perches <joe@perches.com>
Cc: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 scripts/checkpatch.pl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index a63380c6b0d2..f241865cedb3 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2761,6 +2761,7 @@ sub process {
=20
 # Check for git id commit length and improperly formed commit descriptions
 		if ($in_commit_log && !$commit_log_possible_stack_dump &&
+		    $line !~ /base-commit:/ &&
 		    $line !~ /^\s*(?:Link|Patchwork|http|https|BugLink):/i &&
 		    $line !~ /^This reverts commit [0-9a-f]{7,40}/ &&
 		    ($line =3D~ /\bcommit\s+[0-9a-f]{5,}\b/i ||
--=20
2.25.0

