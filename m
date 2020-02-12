Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 672CEC352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 23:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3922820578
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 23:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="GrGEJdKh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729375AbgBLXcZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 18:32:25 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:5405 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729356AbgBLXcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 18:32:24 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e448ac60000>; Wed, 12 Feb 2020 15:31:18 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 12 Feb 2020 15:32:23 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 12 Feb 2020 15:32:23 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 12 Feb
 2020 23:32:22 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 12 Feb 2020 23:32:22 +0000
Received: from blueforge.nvidia.com (Not Verified[10.110.48.28]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e448b060000>; Wed, 12 Feb 2020 15:32:22 -0800
From:   John Hubbard <jhubbard@nvidia.com>
To:     Joe Perches <joe@perches.com>
CC:     Andy Whitcroft <apw@canonical.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 0/1] checkpatch: support "base-commit:" format
Date:   Wed, 12 Feb 2020 15:32:20 -0800
Message-ID: <20200212233221.47662-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1581550278; bh=H6KGmzsUSuIzRA/EXfGNLRaFmbExROqmQptBt0bV0SM=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
         Content-Type;
        b=GrGEJdKhcMsZibc4hZnkG4pRzYeQW0dxyHrjicrPLTgKMocnp1pGf50WtGubOnRQ6
         A9e8Rgt4uRrF/OGA4xFzJ5fxduOkFKUISNlrpqQvFi7unzqRsfKcuSJotO9XDlFl6T
         Y22uit8hIyDATuU9Yeao7OZ7uvfpOyX3Ub7PFZmh5Mmy48KElT7KPXRGNHTfvA74XD
         oDyVK9+bIie8qAqWFhL+5ryeKayK10YXwfON8rU5BHLezDQUpbeq7TGozE5zO4N3OU
         Ji2gLrPCUFUOSIZdsYo6U5d6ABc8QYEbSjtspBre2UaVmLCEVUCnWsBH2/uZ7KkDdX
         Q4/rqvTzoIf4Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

 scripts/checkpatch.pl | 1 +
 1 file changed, 1 insertion(+)


base-commit: 0bf999f9c5e74c7ecf9dafb527146601e5c848b9
--=20
2.25.0

