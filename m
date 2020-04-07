Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58AA5C2BA80
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 07:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30B4B2064A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 07:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kyt9t+tP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbgDGH2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 03:28:01 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:47104 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727193AbgDGH15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 03:27:57 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0377RaCP152424;
        Tue, 7 Apr 2020 07:27:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=fVkYofmuk3HJT9Kp2o+/BbW/pN/3eB4v5F1XpsOZds8=;
 b=kyt9t+tP5muP0a1k/zf6ZRsLUCx6YAWsWOYOgHf6BQmE4Okq4FOE7tD7f5xwP21r8rf9
 a2MY9xwPHKbWAbWfjhNahpG7uhOU0YxT23FicjfUvzk2wPxsFwAt9461fAA7s5GnJ/o9
 54qpsi6aWrspxvfSuz8aMzsqsNKgGtG4TVpqYYCHs0Xdix9o2YLuK20UW0XzKl+aWl1k
 /fNtNI3jqOw/Sp7DSW4W9l4P4nc5SyG16o7V1FmLJ5uaYUx0ZH5sc18EjwBroRIkVN6/
 ofHqVCDLrrgT0lbVpxlPmrhlIsvDsX0KgwZBVHkdXOaiABbMzv61V78Wjf7R8XeFHOHd mA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 308ffd93hr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Apr 2020 07:27:36 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0377RTRw151616;
        Tue, 7 Apr 2020 07:27:29 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 30741d9tx2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Apr 2020 07:27:29 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0377RPl8031888;
        Tue, 7 Apr 2020 07:27:25 GMT
Received: from linux-1.home (/92.157.90.160)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 07 Apr 2020 00:27:25 -0700
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        peterz@infradead.org, jthierry@redhat.com, tglx@linutronix.de,
        alexandre.chartre@oracle.com
Subject: [PATCH V2 0/9] objtool changes to remove all ANNOTATE_NOSPEC_ALTERNATIVE
Date:   Tue,  7 Apr 2020 09:31:33 +0200
Message-Id: <20200407073142.20659-1-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.2
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9583 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 phishscore=0
 malwarescore=0 bulkscore=0 spamscore=0 adultscore=0 mlxlogscore=955
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004070062
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9583 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 priorityscore=1501
 impostorscore=0 malwarescore=0 mlxlogscore=999 lowpriorityscore=0
 clxscore=1015 phishscore=0 mlxscore=0 bulkscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004070062
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is version v2 of this patchset based on the different comments
received so far. It now uses and includes PeterZ patch to add
UNWIND_HINT_RET_OFFSET. Other changes are described below.

Code like retpoline or RSB stuffing, which is used to mitigate some of
the speculative execution issues, is currently ignored by objtool with
the ANNOTATE_NOSPEC_ALTERNATIVE directive. This series adds support
for intra-function calls to objtool so that it can handle such a code.
With these changes, we can remove all ANNOTATE_NOSPEC_ALTERNATIVE
directives.

Changes:
 - replace RETPOLINE_RET with PeterZ UNWIND_HINT_RET_OFFSET
 - make objtool intra-function call action architecture dependent
 - objtool now automatically detects and validates all intra-function
   calls but it issues a warning if the call was not explicitly tagged
 - change __FILL_RETURN_BUFFER to work with objtool
 - add generic ANNOTATE_INTRA_FUNCTION_CALL macro
 - remove all ANNOTATE_SPEC_ALTERNATIVE (even for __FILL_RETURN_BUFFER)

Thanks,

alex.

-----

Alexandre Chartre (8):
  objtool: UNWIND_HINT_RET_OFFSET should not check registers
  objtool: is_fentry_call() crashes if call has no destination
  objtool: Allow branches within the same alternative.
  objtool: Add support for intra-function calls
  x86/speculation: Change __FILL_RETURN_BUFFER to work with objtool
  x86/speculation: Annotate intra-function calls
  x86/speculation: Add unwind hint to trampoline return
  x86/speculation: Remove all ANNOTATE_NOSPEC_ALTERNATIVE directives

Peter Zijlstra (Intel) (1):
  objtool: Introduce HINT_RET_OFFSET

 arch/x86/include/asm/nospec-branch.h          |  32 ++--
 arch/x86/include/asm/orc_types.h              |   1 +
 arch/x86/include/asm/unwind_hints.h           |  10 ++
 include/linux/frame.h                         |  11 ++
 tools/arch/x86/include/asm/orc_types.h        |   1 +
 .../Documentation/stack-validation.txt        |   8 +
 tools/objtool/arch.h                          |   2 +
 tools/objtool/arch/x86/decode.c               |  12 ++
 tools/objtool/check.c                         | 152 ++++++++++++++----
 tools/objtool/check.h                         |   6 +-
 10 files changed, 192 insertions(+), 43 deletions(-)

-- 
2.18.2

