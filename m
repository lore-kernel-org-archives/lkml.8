Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD90C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 00:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DABB20709
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 00:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="XQMXj0qV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbgEQAMu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 20:12:50 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:15924 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbgEQAMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 20:12:50 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ec081750000>; Sat, 16 May 2020 17:12:37 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Sat, 16 May 2020 17:12:49 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Sat, 16 May 2020 17:12:49 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 17 May
 2020 00:12:49 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sun, 17 May 2020 00:12:49 +0000
Received: from sandstorm.nvidia.com (Not Verified[10.2.48.175]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ec081810001>; Sat, 16 May 2020 17:12:49 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Brian Geffon <bgeffon@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Mina Almasry <almasrymina@google.com>,
        Shuah Khan <shuah@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 1/2] selftests/vm/write_to_hugetlbfs.c: fix unused variable warning
Date:   Sat, 16 May 2020 17:12:44 -0700
Message-ID: <20200517001245.361762-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200517001245.361762-1-jhubbard@nvidia.com>
References: <20200517001245.361762-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1589674357; bh=uXlixiau1j95RmP9NA0wbCzX6HbvCN4ClDBoBcdanXk=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=XQMXj0qV/AX9NTtDgbIPGM40WnkSIrkE2RybnGe2neRMyAulj5Z4pu365jtx1rvkQ
         rNL8RTKovH405wwCgP7joRSwu+dX5VG4LWoE2V8QU0h1ueNMSCluL8VU9MbLcHvBWp
         +/0NMhjX8XBTgWgslN7enIlTy5/RVuO62sznjEew3sIif6hlTwzLPta7JuMQkQKi31
         meVJAzwMzBRKkt29s2F/w0zqcq6cn7cDZBn6XI3oMxKWLNE5RdShk0YvFD58nK5kwS
         95BR6IlaM3S4hMsA5t+ebSLDRLR8l//Di2ZWeeWU1xUfvriSrQQTAiIijSGSMRkg55
         hdODhy2/5arjQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused variable "i", which was triggering a compiler warning.

Fixes: 29750f71a9b4 ("hugetlb_cgroup: add hugetlb_cgroup reservation tests"=
)
Cc: Mina Almasry <almasrymina@google.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/vm/write_to_hugetlbfs.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/vm/write_to_hugetlbfs.c b/tools/testin=
g/selftests/vm/write_to_hugetlbfs.c
index 110bc4e4015d..6a2caba19ee1 100644
--- a/tools/testing/selftests/vm/write_to_hugetlbfs.c
+++ b/tools/testing/selftests/vm/write_to_hugetlbfs.c
@@ -74,8 +74,6 @@ int main(int argc, char **argv)
 	int write =3D 0;
 	int reserve =3D 1;
=20
-	unsigned long i;
-
 	if (signal(SIGINT, sig_handler) =3D=3D SIG_ERR)
 		err(1, "\ncan't catch SIGINT\n");
=20
--=20
2.26.2

