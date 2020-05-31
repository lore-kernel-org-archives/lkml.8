Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FAC7C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 23:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC319206A4
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 23:41:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="qvcNTrea"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbgEaXld (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 19:41:33 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:18543 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgEaXlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 19:41:32 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ed440560000>; Sun, 31 May 2020 16:40:06 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Sun, 31 May 2020 16:41:32 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Sun, 31 May 2020 16:41:32 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 31 May
 2020 23:41:32 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sun, 31 May 2020 23:41:32 +0000
Received: from sandstorm.nvidia.com (Not Verified[10.2.56.10]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ed440ac0000>; Sun, 31 May 2020 16:41:32 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     David Hildenbrand <david@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2 0/2] mm/gup: introduce pin_user_pages_locked(), use it in frame_vector.c
Date:   Sun, 31 May 2020 16:41:29 -0700
Message-ID: <20200531234131.770697-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1590968406; bh=otv8+odmL4zqFWhReTZfBsIuJx61Pus8PEKMQhr3NGQ=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
         Content-Type;
        b=qvcNTreaeJlaPtVQX+5z+UEvX4qGJRgm04x9GbLMVMPdT1+zsY8ZVjMH4nW40Qynw
         1meQhyZcd4kLqSzjBprxutBiRZT7QyGL8X9i/rtyNzrRQf22rphaT+/lu87S7dI+bZ
         z8LrnUHmzVRwfs4V5Kat6F57ZuEEznY+mUt2oY3JUg4rjbjA614/u83TLUp+WykQCi
         oTddrOJ7zljI5IOehDP5N3g97qyEf9O0WHr2l4MqOcM8UsbXo+/zFSNhKv3aQDQvDa
         s2xdCzezH0KrSmZgd58NTBv1MKzxYeRk+t8VGFe4yrTL4T3OAPfFa9LySs9AxVunt9
         gdSq7h5vVGKwQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Changes since v1:

* added an assert-and-return to the corresponding
get_user_pages_locked() call, to keep out any externally set FOLL_PIN flag,
thanks to Souptick Joarder's review for spotting that.

* Added Acked-by and Reviewed by tags from David and Pakaj


John Hubbard (2):
  mm/gup: introduce pin_user_pages_locked()
  mm/gup: frame_vector: convert get_user_pages() --> pin_user_pages()

 include/linux/mm.h |  2 ++
 mm/frame_vector.c  |  7 +++----
 mm/gup.c           | 36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 41 insertions(+), 4 deletions(-)


base-commit: bdc48fa11e46f867ea4d75fa59ee87a7f48be144
--=20
2.26.2

