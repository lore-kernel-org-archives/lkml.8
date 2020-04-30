Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBDCC83000
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9831720774
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbgD3Ois (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 10:38:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51460 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726481AbgD3Ois (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 10:38:48 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03UEa6KC117198;
        Thu, 30 Apr 2020 10:38:32 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30q7qk14mg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Apr 2020 10:38:32 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 03UEaI32118447;
        Thu, 30 Apr 2020 10:38:31 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30q7qk14k1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Apr 2020 10:38:31 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 03UEZhnv012766;
        Thu, 30 Apr 2020 14:38:29 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma05fra.de.ibm.com with ESMTP id 30mcu52r72-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Apr 2020 14:38:29 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03UEcQwT60882962
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Apr 2020 14:38:27 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CF50A52057;
        Thu, 30 Apr 2020 14:38:26 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.14.241])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 28F3A52052;
        Thu, 30 Apr 2020 14:38:26 +0000 (GMT)
From:   Claudio Imbrenda <imbrenda@linux.ibm.com>
To:     viro@zeniv.linux.org.uk
Cc:     borntraeger@de.ibm.com, david@redhat.com,
        akpm@linux-foundation.org, aarcange@redhat.com, linux-mm@kvack.org,
        frankja@linux.ibm.com, sfr@canb.auug.org.au, jhubbard@nvidia.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        jack@suse.cz, kirill@shutemov.name, dave.hansen@intel.com,
        peterz@infradead.org, sean.j.christopherson@intel.com,
        Ulrich.Weigand@de.ibm.com
Subject: [PATCH v2 1/1] fs/splice: add missing callback for inaccessible pages
Date:   Thu, 30 Apr 2020 16:38:25 +0200
Message-Id: <20200430143825.3534128-1-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-30_09:2020-04-30,2020-04-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 malwarescore=0 suspectscore=1
 mlxlogscore=978 lowpriorityscore=0 phishscore=0 adultscore=0
 impostorscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2004300120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inaccessible pages are pages that should not be accessed by any device,
and belong to a protected VM. If any such pages are passed to a
device, there will be I/O errors, which will not always be recoverable,
depending on the architecture and on the specific device.

CPU accesses to inaccessible pages are less problematic, since they are
always recoverable.

Page cache and direct I/O were fixed in a previous patch, in which a
architecture hook is provided to make the page accessible by I/O
devices.

One possible remaining path to sneak a protected page directly to a
device is sendfile and similar syscalls. Those syscalls take a page
directly from the page cache and give them directly to the device with
zero-copy. This bypasses both existing hooks in gup and in writeback.

This patch fixes the issue by adding a call to arch_make_page_accessible
in page_cache_pipe_buf_confirm, thus fixing the issue.

Notice that we only need to make sure the source is accessible, since
zero-copy only works in one direction, and CPU accesses to inaccessible
pages are not a problem. Pagecache-to-pagecache is also not a problem
since that is done by the CPU.

The hook has no overhead for architectures that do not need to deal
with inaccessible pages.

Fixes: f28d43636d6f ("mm/gup/writeback: add callbacks for inaccessible pages")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 fs/splice.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/splice.c b/fs/splice.c
index 4735defc46ee..f026e0ce9acd 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -106,6 +106,9 @@ static int page_cache_pipe_buf_confirm(struct pipe_inode_info *pipe,
 	struct page *page = buf->page;
 	int err;
 
+	if (arch_make_page_accessible(page))
+		return -EIO;
+
 	if (!PageUptodate(page)) {
 		lock_page(page);
 
-- 
2.25.4

