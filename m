Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06AF9C47254
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D903120735
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:01:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gFnT5jo6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbgEDPBC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 11:01:02 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:51266 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729355AbgEDPBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 11:01:00 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044ElbqT116461;
        Mon, 4 May 2020 14:59:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=6TPxMgWmQtH64Bn23GV/AftZjSew5g3GNKLiViW6Iy4=;
 b=gFnT5jo6XL/vq8JpP48I0AftEHAaN8XlSDr4W8ZpfRzhx8JGBr6tAK6D0mKyk6E58rF/
 oquWByjYyxEMe8qAeG3v2f8p2pZd287Oj6ua7SZNIyRvuvZpfGzbCZyrniOX3aP/g6lz
 xa/80tQTPFYDbmomam+cMU5Y4F+X84v0DhJvRDSsSK4AWeX8mgkSklKaIzWS8wviZF1A
 eDLA3CHAPTcjVjrnS8QKReCGLjvHEExbZbjNTmAFKpWDdCGfIhidrMsMHzlfnVfardgg
 A7rOcl5YOGUB+9GxY5xya5LOf7jnVERNWH2eM8++6AzZvbq7Z91KbFGnaH9on9GUpIRn BQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 30s09qyfp4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 14:59:35 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044EkfUs094736;
        Mon, 4 May 2020 14:59:35 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 30sjdqq5u8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 14:59:34 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 044ExWnw027298;
        Mon, 4 May 2020 14:59:32 GMT
Received: from linux-1.home.com (/10.175.9.166)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 May 2020 07:59:32 -0700
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     pbonzini@redhat.com, konrad.wilk@oracle.com,
        jan.setjeeilers@oracle.com, liran.alon@oracle.com,
        junaids@google.com, graf@amazon.de, rppt@linux.vnet.ibm.com,
        kuzuno@gmail.com, mgross@linux.intel.com,
        alexandre.chartre@oracle.com
Subject: [RFC v4][PATCH part-2 00/13] ASI - Part II (Decorated Page-Table)
Date:   Mon,  4 May 2020 16:57:57 +0200
Message-Id: <20200504145810.11882-1-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.2
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9610 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 adultscore=0 phishscore=0 mlxlogscore=859 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005040123
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9610 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=948 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005040123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is part II of ASI RFC v4. Please refer to the cover letter of
part I for an overview the ASI RFC.

  https://lore.kernel.org/lkml/20200504144939.11318-1-alexandre.chartre@oracle.com/

This part introduces decorated page-table which encapsulate native page
table (e.g. a PGD) in order to provide convenient page-table management
functions, such as tracking address range mapped in a page-table or
safely handling references to another page-table.

Decorated page-table can then be used to easily create and manage page
tables to be used with ASI. It will be used by the ASI test driver (see
part III) and later by KVM ASI.

Decorated page-table is independent of ASI, and can potentially be used
anywhere a page-table is needed.

Thanks,

alex.

-----

Alexandre Chartre (13):
  mm/x86: Introduce decorated page-table (dpt)
  mm/dpt: Track buffers allocated for a decorated page-table
  mm/dpt: Add decorated page-table entry offset functions
  mm/dpt: Add decorated page-table entry allocation functions
  mm/dpt: Add decorated page-table entry set functions
  mm/dpt: Functions to populate a decorated page-table from a VA range
  mm/dpt: Helper functions to map module into a decorated page-table
  mm/dpt: Keep track of VA ranges mapped in a decorated page-table
  mm/dpt: Functions to clear decorated page-table entries for a VA range
  mm/dpt: Function to copy page-table entries for percpu buffer
  mm/dpt: Add decorated page-table remap function
  mm/dpt: Handle decorated page-table mapped range leaks and overlaps
  mm/asi: Function to init decorated page-table with ASI core mappings

 arch/x86/include/asm/asi.h |    2 +
 arch/x86/include/asm/dpt.h |   89 +++
 arch/x86/mm/Makefile       |    2 +-
 arch/x86/mm/asi.c          |   57 ++
 arch/x86/mm/dpt.c          | 1051 ++++++++++++++++++++++++++++++++++++
 5 files changed, 1200 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/include/asm/dpt.h
 create mode 100644 arch/x86/mm/dpt.c

-- 
2.18.2

