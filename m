Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B062BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 06:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A4DF20757
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 06:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592203644;
	bh=cXTjwkxsJ3m+s8A7gePHCYRS9h1583UrQsK97o6NFGU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=caRb6H8WQju6ZmqLO6I0j2NC3zB8SvYeFyJAltzICCiqQRlvnhdeHqk4vFdyRCZIy
	 iu/l2Jib+JmEPRkUi3Xp/NMpKtYohHtNkEiTD6HHHVQsPbltrjXKilQXSb29cH58y7
	 TkTvnsM/zGKS7iWRMc8FZ2aNlcEG8VhJg6VFjnZE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728546AbgFOGrX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 02:47:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:60078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728470AbgFOGrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 02:47:14 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26AD820936;
        Mon, 15 Jun 2020 06:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592203632;
        bh=cXTjwkxsJ3m+s8A7gePHCYRS9h1583UrQsK97o6NFGU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GQbjoafGFBX2rvojKPKdnTvOJ5Vhyd+OFKih5P8pJJT0PVDZhB1ajvrhBmzXmft08
         UQ9lZm/KNsQixfGt2m4G18sJdq3X1zgXClSVlSYY51DC8RFCfx6N3xxa2cpVIgxDpr
         XaLNrgx2IAOwR0sZ6F7tZPJTO3FFKN+lycKRRWeQ=
Received: from mchehab by mail.kernel.org with local (Exim 4.93)
        (envelope-from <mchehab@kernel.org>)
        id 1jkiti-009nnX-2l; Mon, 15 Jun 2020 08:47:10 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com
Subject: [PATCH 21/29] docs: device-mapper: add dm-ebs.rst to an index file
Date:   Mon, 15 Jun 2020 08:47:00 +0200
Message-Id: <e6195a56b6e7924ccbb7fd07837453530f02e9dc.1592203542.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1592203542.git.mchehab+huawei@kernel.org>
References: <cover.1592203542.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Solves this Sphinx warning:
	Documentation/admin-guide/device-mapper/dm-ebs.rst: WARNING: document isn't included in any toctree

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/admin-guide/device-mapper/index.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/admin-guide/device-mapper/index.rst b/Documentation/admin-guide/device-mapper/index.rst
index ec62fcc8eece..6cf8adc86fa8 100644
--- a/Documentation/admin-guide/device-mapper/index.rst
+++ b/Documentation/admin-guide/device-mapper/index.rst
@@ -11,6 +11,7 @@ Device Mapper
     dm-clone
     dm-crypt
     dm-dust
+    dm-ebs
     dm-flakey
     dm-init
     dm-integrity
-- 
2.26.2

