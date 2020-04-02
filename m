Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24BC6C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 08:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAA182080C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 08:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eej2Hpgw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387838AbgDBIS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 04:18:57 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:39230 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387737AbgDBISm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 04:18:42 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0328Hfuo196604;
        Thu, 2 Apr 2020 08:18:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=p17e2nyu9f8khVOWGKbMQnX5vaZpXcrK5ZQI2Ho/lm4=;
 b=eej2HpgwaI6tdb9RzaIbds5q10LJdi4Gg8qBlMRaU5df33iXwU/ReF1o76nS4+ga1kp3
 VcUwC5g+2GgkyR6G5KeLVCxLitTENpJOZIWM35xGHTLEhiWGyOdXmStVuLg1J2clXj1E
 oVIxSVHrCvlYa0dPPwRnWcqFNfdroCMR9mIsoMaZLpbRPGClbN9RmLMy30izaaahq3N7
 7Kl7IkBbObRA7qHtDpZf2f6FYaqcDqMGCMAbj8ILnUFnh6q+rblXD4IA5fMzVf+8z9+8
 VBAjkDIGXwuqsfCOj82mjwBSimpb9X3WPqbru/rBOynYCymnHMzQ2exPthletdpBboy6 jg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 303yunce44-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Apr 2020 08:18:12 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0328Gw4b022002;
        Thu, 2 Apr 2020 08:18:12 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 302g2j3pnm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Apr 2020 08:18:11 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0328I90O022173;
        Thu, 2 Apr 2020 08:18:09 GMT
Received: from linux-1.home (/92.157.90.160)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 02 Apr 2020 01:18:09 -0700
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        peterz@infradead.org, jthierry@redhat.com, tglx@linutronix.de,
        alexandre.chartre@oracle.com
Subject: [PATCH 0/7] objtool changes to remove most ANNOTATE_NOSPEC_ALTERNATIVE
Date:   Thu,  2 Apr 2020 10:22:13 +0200
Message-Id: <20200402082220.808-1-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.2
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9578 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=774 spamscore=0 mlxscore=0
 adultscore=0 phishscore=0 bulkscore=0 suspectscore=1 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004020075
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9578 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 mlxlogscore=830 bulkscore=0
 suspectscore=1 mlxscore=0 spamscore=0 impostorscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004020075
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Code like retpoline or RSB stuffing, which is used to mitigate some of
the speculative execution issues, is currently ignored by objtool with
the ANNOTATE_NOSPEC_ALTERNATIVE directive. This series adds support
for intra-function calls and trampoline return instructions to objtool
so that it can handle such a code. With these changes, we can remove
most ANNOTATE_NOSPEC_ALTERNATIVE directives.

Thanks,

alex.

--

Alexandre Chartre (7):
  objtool: is_fentry_call() crashes if call has no destination
  objtool: Allow branches within the same alternative.
  objtool: Add support for intra-function calls
  objtool: Add support for return trampoline call
  x86/speculation: Annotate intra-function calls
  x86/speculation: Annotate retpoline return instructions
  x86/speculation: Remove most ANNOTATE_NOSPEC_ALTERNATIVE

 arch/x86/include/asm/nospec-branch.h |  38 ++++--
 tools/objtool/check.c                | 172 +++++++++++++++++++++++++--
 tools/objtool/check.h                |   5 +-
 3 files changed, 196 insertions(+), 19 deletions(-)

-- 
2.18.2

