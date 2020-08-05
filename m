Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B84E0C433E3
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E83322D2C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbgHERJJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 13:09:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36010 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728451AbgHEREw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 13:04:52 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 075FDwkb127568;
        Wed, 5 Aug 2020 11:32:29 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32qu0v8ymy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Aug 2020 11:32:28 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 075FGMQE029092;
        Wed, 5 Aug 2020 15:32:26 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06fra.de.ibm.com with ESMTP id 32mynhas6q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Aug 2020 15:32:26 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 075FUvYT60555774
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Aug 2020 15:30:57 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1DF38AE045;
        Wed,  5 Aug 2020 15:32:24 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 49002AE051;
        Wed,  5 Aug 2020 15:32:23 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.95.205])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  5 Aug 2020 15:32:23 +0000 (GMT)
Message-ID: <4400d951e18528297e3e63524ff0ff63d48efda1.camel@linux.ibm.com>
Subject: [GIT PULL] integrity subsystem updates for v5.9
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Date:   Wed, 05 Aug 2020 11:32:19 -0400
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-05_10:2020-08-03,2020-08-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 suspectscore=2
 phishscore=0 mlxscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008050124
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The nicest change is the IMA policy rule checking.  The other changes
include allowing the kexec boot cmdline line measure policy rules to be
defined in terms of the inode associated with the kexec kernel image,
making the IMA_APPRAISE_BOOTPARAM, which governs the IMA appraise mode
(log, fix, enforce), a runtime decision based on the secure boot mode
of the system, and including errno in the audit log.

thanks,

Mimi

The following changes since commit 48778464bb7d346b47157d21ffde2af6b2d39110:

  Linux 5.8-rc2 (2020-06-21 15:45:29 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git tags/integrity-v5.9

for you to fetch changes up to 3db0d0c276a752af39beb5ca7424cb659aa005bb:

  integrity: remove redundant initialization of variable ret (2020-07-27 16:52:09 -0400)

----------------------------------------------------------------
integrity-v5.9

----------------------------------------------------------------
Bruno Meneguele (1):
      ima: move APPRAISE_BOOTPARAM dependency on ARCH_POLICY to runtime

Colin Ian King (1):
      integrity: remove redundant initialization of variable ret

Lakshmi Ramasubramanian (2):
      integrity: Add errno field in audit message
      IMA: Add audit log for failure conditions

Maurizio Drocco (1):
      ima: extend boot_aggregate with kernel measurements

Mimi Zohar (1):
      Merge branch 'validate-policy-rules' into next-integrity

Tyler Hicks (14):
      ima: Have the LSM free its audit rule
      ima: Free the entire rule when deleting a list of rules
      ima: Free the entire rule if it fails to parse
      ima: Fail rule parsing when buffer hook functions have an invalid action
      ima: Fail rule parsing when the KEXEC_CMDLINE hook is combined with an invalid cond
      ima: Fail rule parsing when the KEY_CHECK hook is combined with an invalid cond
      ima: Fail rule parsing when appraise_flag=blacklist is unsupportable
      ima: Shallow copy the args_p member of ima_rule_entry.lsm elements
      ima: Use correct type for the args_p member of ima_rule_entry.lsm elements
      ima: Move comprehensive rule validation checks out of the token parser
      ima: Use the common function to detect LSM conditionals in a rule
      ima: Support additional conditionals in the KEXEC_CMDLINE hook function
      ima: Rename internal filter rule functions
      ima: AppArmor satisfies the audit rule requirements

 include/linux/ima.h                          |   4 +-
 kernel/kexec_file.c                          |   2 +-
 security/integrity/digsig_asymmetric.c       |   2 +-
 security/integrity/ima/Kconfig               |   4 +-
 security/integrity/ima/ima.h                 |  75 +++++----
 security/integrity/ima/ima_api.c             |   2 +-
 security/integrity/ima/ima_appraise.c        |   8 +-
 security/integrity/ima/ima_asymmetric_keys.c |   2 +-
 security/integrity/ima/ima_crypto.c          |  15 +-
 security/integrity/ima/ima_main.c            |  41 +++--
 security/integrity/ima/ima_modsig.c          |  20 ---
 security/integrity/ima/ima_policy.c          | 240 +++++++++++++++++++--------
 security/integrity/ima/ima_queue_keys.c      |   7 +-
 security/integrity/integrity.h               |  13 ++
 security/integrity/integrity_audit.c         |  11 +-
 15 files changed, 301 insertions(+), 145 deletions(-)

