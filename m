Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDA1C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 04:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C101720884
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 04:15:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="IHgj/s0t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgEVEPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 00:15:09 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:11816 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbgEVEPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 00:15:09 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ec7517c0000>; Thu, 21 May 2020 21:13:49 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 21 May 2020 21:15:09 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 21 May 2020 21:15:09 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 22 May
 2020 04:15:08 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 22 May 2020 04:15:08 +0000
Received: from sandstorm.nvidia.com (Not Verified[10.2.48.182]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ec751cb0005>; Thu, 21 May 2020 21:15:08 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     LKML <linux-kernel@vger.kernel.org>
CC:     John Hubbard <jhubbard@nvidia.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Jani Nikula <jani.nikula@intel.com>,
        <dri-devel@lists.freedesktop.org>, <linux-fbdev@vger.kernel.org>
Subject: [PATCH 0/2] video: fbdev: fix error handling, convert to pin_user_pages*()
Date:   Thu, 21 May 2020 21:15:04 -0700
Message-ID: <20200522041506.39638-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1590120829; bh=4CvomaKzVwHB+77SfF7gRmZ5Wb1M+7zo/2BM1L60cTk=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
         Content-Type;
        b=IHgj/s0tM22z621m0z8ePs8Uvb1f01gFZTsmrfC4NWm58+BHqupDe1z8HyohCtUPD
         xFZERRuzJgbzy3FpFiRVVklOb8j7ry1m6NCgtQd4zmeFQV6RpUQBJyT0rN03kvEEfM
         PC+lmZGzXxeY00Fn64STilbZm1LqHwjoh7FUXCYSQI899vTRsFTNz6Eo1is8ej5bcu
         qkMjXjiStDYm7zjLYU02pC3HaWWGRZDsHu9y8zUYxCOsIXERPr2TeQVqpLC17sKoEx
         cWqserHfltRNnMKtT8v6yZAfBKU9VisFjyQtFj35L4pBOgNVGWdVMgdDdpeq/ohEfM
         E9o5kJXdzF3XA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Note that I have only compile-tested this series, although that does
also include cross-compiling for a few other arches. I'm hoping that
this posting will lead to some run-time testing.

Also: the proposed fix does not have a "Fixes:" tag, nor does it
Cc stable. That's because the issue has been there since the dawn of
git history for the kernel. If it's gone unnoticed this long, then
there is clearly no need for the relatively fast track of putting it
into stable, IMHO. But please correct me if that's wrong.

Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Gustavo A. R. Silva <gustavo@embeddedor.com>
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org

John Hubbard (2):
  video: fbdev: fix error handling for get_user_pages_fast()
  video: fbdev: convert get_user_pages() --> pin_user_pages()

 drivers/video/fbdev/pvr2fb.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)


base-commit: 051143e1602d90ea71887d92363edd539d411de5
--=20
2.26.2

