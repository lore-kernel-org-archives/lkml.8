Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27469C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 21:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEA662168B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 21:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592429052;
	bh=ufGZakvAGLpuhnkgoqj4OGoXB8U1nf2Y0/5ilyOCk2I=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=DU22hBpvNK4wMY/7qV/gA7rWE2HgOQb13c96ySfJRZAdpQIChReHNrVgyKngFQh0s
	 0Or2BODz+feg2Wjm3tUUoCpSuBzDX155ihEa4MwYCQZpiqoAWCYVzQSlCypK20/UhO
	 wAIj0IqrD1H1VCWXfPEQOwnci9F/yVyz1vBvqwhE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbgFQVYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 17:24:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:51574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726899AbgFQVYK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 17:24:10 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C1FC2166E;
        Wed, 17 Jun 2020 21:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592429049;
        bh=ufGZakvAGLpuhnkgoqj4OGoXB8U1nf2Y0/5ilyOCk2I=;
        h=Date:From:To:Cc:Subject:From;
        b=I0jsAHxsAyeB6/UGhTqMiTeONq0QimmMmu5zyZZ9p/wKvckbkNlUIzAtFCJrfwOjV
         To99KIvnqyyOcjrXHe6wY+wcyg4lPr8G1dKkK21/IANX2uLpmrVCUfIcbs6cqDw5mU
         aqvveP4DcAOQAgQ4133PgNJ4X0zeMN6vOMgLNXnQ=
Date:   Wed, 17 Jun 2020 16:29:30 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] s390: appldata: Use struct_size() helper
Message-ID: <20200617212930.GA11728@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes.

This code was detected with the help of Coccinelle and, audited and
fixed manually.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 arch/s390/appldata/appldata_os.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/s390/appldata/appldata_os.c b/arch/s390/appldata/appldata_os.c
index 5503217366ec..a363d30ce739 100644
--- a/arch/s390/appldata/appldata_os.c
+++ b/arch/s390/appldata/appldata_os.c
@@ -129,8 +129,7 @@ static void appldata_get_os_data(void *data)
 
 	os_data->nr_cpus = j;
 
-	new_size = sizeof(struct appldata_os_data) +
-		   (os_data->nr_cpus * sizeof(struct appldata_os_per_cpu));
+	new_size = struct_size(os_data, os_cpu, os_data->nr_cpus);
 	if (ops.size != new_size) {
 		if (ops.active) {
 			rc = appldata_diag(APPLDATA_RECORD_OS_ID,
@@ -165,8 +164,7 @@ static int __init appldata_os_init(void)
 {
 	int rc, max_size;
 
-	max_size = sizeof(struct appldata_os_data) +
-		   (num_possible_cpus() * sizeof(struct appldata_os_per_cpu));
+	max_size = struct_size(appldata_os_data, os_cpu, num_possible_cpus());
 	if (max_size > APPLDATA_MAX_REC_SIZE) {
 		pr_err("Maximum OS record size %i exceeds the maximum "
 		       "record size %i\n", max_size, APPLDATA_MAX_REC_SIZE);
-- 
2.27.0

