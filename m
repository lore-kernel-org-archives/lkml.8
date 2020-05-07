Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D89EAC38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0CB32495D
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588877599;
	bh=qD1YTu45POQi4xsMj+gdlSVCGKp5j89OYm2p2pPtKh4=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=DKTeS8X1s/Lq5i1KizLew9mFmrww/sLWO6lIIGIIYXjPAqgNMefy6TpjfMN2PUZn9
	 zmvmnp6hGzTyWlq/z7fOm/S1/mW33c9vfi8rynUioufUHECue9xGlPD50wXzQU427Y
	 2PAocHoLkaXy/hv0Tps8d6IyBQGKPCL3n5LvRqFs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbgEGSxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 14:53:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:54736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728451AbgEGSxS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 14:53:18 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8828424960;
        Thu,  7 May 2020 18:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588877598;
        bh=qD1YTu45POQi4xsMj+gdlSVCGKp5j89OYm2p2pPtKh4=;
        h=Date:From:To:Cc:Subject:From;
        b=FSQeULZOf97JknZWY5LLJLQT/B28yD4GV5UeqoNuLVRKkxweMPCE3bj9Ix6zBiXZG
         SkK2rXUmNi8iocLO2FpUJfFio+NqcvdSBhbGk6cfmwEwR3nhnNDUrEwSblam8VUPu8
         tKEbXqXjoojLcnrP4v7c2q3FxuHkngwmGz6OeIH8=
Date:   Thu, 7 May 2020 13:57:44 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Cc:     linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tools/testing/nvdimm: Replace zero-length array with
 flexible-array
Message-ID: <20200507185744.GA14974@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on.

Also, notice that, dynamic memory allocations won't be affected by
this change:

"Flexible array members have incomplete type, and so the sizeof operator
may not be applied. As a quirk of the original implementation of
zero-length arrays, sizeof evaluates to zero."[1]

sizeof(flexible-array-member) triggers a warning because flexible array
members have incomplete type[1]. There are some instances of code in
which the sizeof operator is being incorrectly/erroneously applied to
zero-length arrays and the result is zero. Such instances may be hiding
some bugs. So, this work (flexible-array member conversions) will also
help to get completely rid of those sorts of issues.

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 tools/testing/nvdimm/test/nfit_test.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/nvdimm/test/nfit_test.h b/tools/testing/nvdimm/test/nfit_test.h
index db3c07beb9d1..b5f7a996c4d0 100644
--- a/tools/testing/nvdimm/test/nfit_test.h
+++ b/tools/testing/nvdimm/test/nfit_test.h
@@ -51,7 +51,7 @@ struct nd_cmd_translate_spa {
 		__u32 nfit_device_handle;
 		__u32 _reserved;
 		__u64 dpa;
-	} __packed devices[0];
+	} __packed devices[];
 
 } __packed;
 
@@ -74,7 +74,7 @@ struct nd_cmd_ars_err_inj_stat {
 	struct nd_error_stat_query_record {
 		__u64 err_inj_stat_spa_range_base;
 		__u64 err_inj_stat_spa_range_length;
-	} __packed record[0];
+	} __packed record[];
 } __packed;
 
 #define ND_INTEL_SMART			 1
@@ -180,7 +180,7 @@ struct nd_intel_fw_send_data {
 	__u32 context;
 	__u32 offset;
 	__u32 length;
-	__u8 data[0];
+	__u8 data[];
 /* this field is not declared due ot variable data from input */
 /*	__u32 status; */
 } __packed;

