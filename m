Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D71AC3B189
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 05:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8F5A2173E
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 05:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="funinmbr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729713AbgBMFuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 00:50:13 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:11148 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbgBMFuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 00:50:11 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e44e3840000>; Wed, 12 Feb 2020 21:49:56 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 12 Feb 2020 21:50:10 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 12 Feb 2020 21:50:10 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 13 Feb
 2020 05:50:10 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 13 Feb 2020 05:50:10 +0000
Received: from blueforge.nvidia.com (Not Verified[10.110.48.28]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e44e3920001>; Wed, 12 Feb 2020 21:50:10 -0800
From:   John Hubbard <jhubbard@nvidia.com>
To:     Joe Perches <joe@perches.com>
CC:     Andy Whitcroft <apw@canonical.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2 0/1] checkpatch: support "base-commit:" format
Date:   Wed, 12 Feb 2020 21:50:03 -0800
Message-ID: <20200213055004.69235-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1581572997; bh=c5c6vj7oCLEPt01HPQEWuFd1BSxiH31flBTm7eIsdFM=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
         Content-Type;
        b=funinmbrXDHohBRuXf48d/RlzMcZZvTpVklfgdjVME7s+9J97Mk/ktRxFOu81cGyH
         zWZGjM74AyMfRHFkm9noXHJbGP+xDeVW98EnBDrRj/XZp/f73c6m/OqfAixw/XqYEE
         iEkg2VZgOE2EmCZ9MaLOWl3vU+OLWdNpVyMRruzpluvn81HyI2B4pYWoXCquw3wt0b
         Z8fA0DHAw9zJNV26JV/3h27y72EbG+V6hrI/rkCTIb8os5s9g0+iQGEYnjaS5lTFnr
         jEZvw4cKICpX8ALH3Pta2vUHg1d1Aba0Z+fIzgdkDFZTVkL2mHkmKCHU08FhFZaZBN
         4sGzMpMwzfj0w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Changes since v1:

* Changed to extend an existing regex line, instead of adding a new line
  (suggested by Joe Perches). Adjusted the commit description slightly
  to match.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

In order to support the get-lore-mbox.py tool described in [1], I ran:

    git format-patch --base=3D<commit> --cover-letter <revrange>

...which generated a "base-commit: <commit-hash>" tag at the end of the
cover letter, just like you can see at the end of this cover letter.
However, checkpatch.pl generated an error upon encounting
"base-commit:" in the cover letter.

So, I suspect that no one is actually using the --base option yet, but
if [1] leads to get-lore-mbox.py and similar scripts becoming popular,
then we'll want checkpatch.pl to work well with them. This tiny patch
does that.

An alternative approach to fixing this would be to make the --base
option emit a checkpatch-friendly commit style. However, I think that's
much less desirable, because base-commit is really just for tools
(mainly "git am") to consume. And so we don't really want it to take up
any more valuable lines in the commit letter than it already does.

thanks,
John Hubbard
NVIDIA

John Hubbard (1):
  checkpatch: support "base-commit:" format

 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


base-commit: 0bf999f9c5e74c7ecf9dafb527146601e5c848b9
--=20
2.25.0

