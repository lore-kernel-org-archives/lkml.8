Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DFBEC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 10:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 643252072D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 10:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="e0djzw/g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438722AbgDNK4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 06:56:09 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:41820 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438407AbgDNKeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 06:34:15 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03EAXI6P102563;
        Tue, 14 Apr 2020 10:34:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2020-01-29;
 bh=M8MvkDpLyHCF3YAFTo6D5bpm4FyG8RWh04rIgFIGDTc=;
 b=e0djzw/gAjSZac/wMBtbjiY9qsuwkuOFYBlhthLzM/ooy3+F5O6jO4FEonqBaGuCJ7Ap
 +DebQfdjkSkekTEKq31QCDrziLi4fsjFQToW7G4Z+vVsmORTerlEbd/KKawLVUyO73EX
 YPhRGYWzRrf5xbBydp+LSo9ZFujcxqdGjUan2QeG8JF0bltxs9QYlOLtqYjMr0uXRzZu
 zOBtQMmRVVYDg3anWyobDWGAGsnVB8wN6kxgQngw5BP4n4LKaPO72GxNU0B/lYwiTY3l
 VtXjRLSPMx+c66yEU7MG31tFbN182VCehjf3QbQWwdGy9Swslu4j+ZefTsPCvdAaTdJK Pg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 30b6hpkms5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Apr 2020 10:34:01 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03EAW0gU123332;
        Tue, 14 Apr 2020 10:32:01 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 30bqpfxnq0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Apr 2020 10:32:00 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03EAVmjb013580;
        Tue, 14 Apr 2020 10:31:53 GMT
Received: from linux-1.home (/92.157.90.160)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 14 Apr 2020 03:31:48 -0700
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        peterz@infradead.org, jthierry@redhat.com, tglx@linutronix.de,
        alexandre.chartre@oracle.com
Subject: [PATCH V3 0/9] objtool changes to check retpoline code
Date:   Tue, 14 Apr 2020 12:36:09 +0200
Message-Id: <20200414103618.12657-1-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.2
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9590 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 bulkscore=0 spamscore=0 suspectscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004140087
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9590 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=999 clxscore=1015 mlxscore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004140087
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is version 3 of the patchset previously named "objtool changes to
remove all ANNOTATE_NOSPEC_ALTERNATIVE". This patchset proposes two
main changes:

 1. Add intra-function call support to objtool. This allows objtool
    to check code like retpoline and RSB stuffing. Such code is present
    in alternative and it is not currently checked because of
    ANNOTATE_NOSPEC_ALTERNATIVE directives.

 2. Add alternative code validation in objtool. For stack unwinding to
    work, Peter and Josh have clearly explained that alternative code
    should have the same stack change sequence as the original code.
    This patchset adds this capability to objtool.

After changes 1, we could remove the ANNOTATE_SPEC_ALTERNATIVE directives
from retpoline/RSB alternatives, and alternatives would be correclty checked
by objtool. But, because of changes 2, objtool would now report inconsistency
in alternatives, like this:

  AS      arch/x86/lib/retpoline.o
arch/x86/lib/retpoline.o: warning: objtool: __x86_indirect_thunk_rax()+0x0: error in alternative
arch/x86/lib/retpoline.o: warning: objtool: .altinstr_replacement+0x0: in alternative 1
arch/x86/lib/retpoline.o: warning: objtool: .altinstr_replacement+0x5: misaligned alternative state change
arch/x86/lib/retpoline.o: warning: objtool: .altinstr_replacement+0x11: in alternative 2
arch/x86/lib/retpoline.o: warning: objtool: .altinstr_replacement+0x14: misaligned alternative state change

So this pachset doesn't remove ANNOTATE_NOSPEC_ALTERNATIVE directives
(unlike v1 and v2). But it makes objtool able to detect inconsistent
alternatives. Then such alternative will need to be refactored to
have stack unwinding information compatible with the original code.
For example, here is Peter suggestion for retpoline code:
  https://lkml.org/lkml/2020/4/8/905


Changes:

v2->v3:
 - rebase on v5.7-rc1
 - add alternative code validation in objtool
 - add return address unwind hints
 - track return address to correctly handle ret with intra-function call
 - remove inclusion of PeterZ UNWIND_HINT_RET_OFFSET patch
 - move alt_group changes to appropriate patch
 - move stack changes for calls to INSN_CALL decode

v1->v2:
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

Alexandre Chartre (9):
  objtool: is_fentry_call() crashes if call has no destination
  objtool: Allow branches within the same alternative.
  objtool: Add support for intra-function calls
  objtool: Handle return instruction with intra-function call
  objtool: Add return address unwind hints
  objtool: Report inconsistent stack changes in alternative
  x86/speculation: Change __FILL_RETURN_BUFFER to work with objtool
  x86/speculation: Add return address unwind hints to retpoline and RSB
    stuffing
  x86/speculation: Annotate intra-function calls

 arch/x86/include/asm/nospec-branch.h          |  42 +-
 arch/x86/include/asm/orc_types.h              |   2 +
 arch/x86/include/asm/unwind_hints.h           |  23 +
 include/linux/frame.h                         |  11 +
 tools/arch/x86/include/asm/orc_types.h        |   2 +
 .../Documentation/stack-validation.txt        |   8 +
 tools/objtool/arch/x86/decode.c               |  13 +
 tools/objtool/check.c                         | 480 ++++++++++++++++--
 tools/objtool/check.h                         |   8 +-
 9 files changed, 545 insertions(+), 44 deletions(-)

-- 
2.18.2

