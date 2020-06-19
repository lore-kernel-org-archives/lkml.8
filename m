Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1320FC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 13:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7AAC20771
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 13:34:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732834AbgFSNea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 09:34:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:13282 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728851AbgFSNe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 09:34:28 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05JDW5Kd000879
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 09:34:27 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31rmmf0rac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 09:34:27 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05JDXA4n004552
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 09:34:26 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31rmmf0r9r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Jun 2020 09:34:26 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05JDUkle023003;
        Fri, 19 Jun 2020 13:34:25 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma05fra.de.ibm.com with ESMTP id 31r1kq11wm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Jun 2020 13:34:24 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05JDYMdP15728674
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Jun 2020 13:34:22 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A4FE84C040;
        Fri, 19 Jun 2020 13:34:22 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1ED764C044;
        Fri, 19 Jun 2020 13:34:21 +0000 (GMT)
Received: from bangoria.ibmuc.com (unknown [9.199.63.130])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 19 Jun 2020 13:34:20 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     acme@redhat.com
Cc:     ravi.bangoria@linux.ibm.com, jolsa@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] libsubcmd: Fix OPT_CALLBACK_SET()
Date:   Fri, 19 Jun 2020 19:04:11 +0530
Message-Id: <20200619133412.50705-1-ravi.bangoria@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-19_11:2020-06-19,2020-06-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=1 phishscore=0 clxscore=1015 spamscore=0
 bulkscore=0 malwarescore=0 adultscore=0 cotscore=-2147483648
 impostorscore=0 mlxscore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006190096
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any option macro with _SET suffix should set opt->set variable which
is not happening for OPT_CALLBACK_SET(). This is causing issues with
perf record --switch-output-event. Fix that.

Before:
  # ./perf record --overwrite -e sched:*switch,syscalls:sys_enter_mmap \
           --switch-output-event syscalls:sys_enter_mmap
  ^C[ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.297 MB perf.data (657 samples) ]

After:

  $ ./perf record --overwrite -e sched:*switch,syscalls:sys_enter_mmap \
          --switch-output-event syscalls:sys_enter_mmap
  [ perf record: dump data: Woken up 1 times ]
  [ perf record: Dump perf.data.2020061918144542 ]
  [ perf record: dump data: Woken up 1 times ]
  [ perf record: Dump perf.data.2020061918144608 ]
  [ perf record: dump data: Woken up 1 times ]
  [ perf record: Dump perf.data.2020061918144660 ]
  ^C[ perf record: dump data: Woken up 1 times ]
  [ perf record: Dump perf.data.2020061918144784 ]
  [ perf record: Woken up 0 times to write data ]
  [ perf record: Dump perf.data.2020061918144803 ]
  [ perf record: Captured and wrote 0.419 MB perf.data.<timestamp> ]

Fixes: 636eb4d001b1 ("libsubcmd: Introduce OPT_CALLBACK_SET()")
Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 tools/lib/subcmd/parse-options.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/lib/subcmd/parse-options.c b/tools/lib/subcmd/parse-options.c
index dbb9efbf718a..39ebf6192016 100644
--- a/tools/lib/subcmd/parse-options.c
+++ b/tools/lib/subcmd/parse-options.c
@@ -237,6 +237,9 @@ static int get_value(struct parse_opt_ctx_t *p,
 		return err;
 
 	case OPTION_CALLBACK:
+		if (opt->set)
+			*(bool *)opt->set = true;
+
 		if (unset)
 			return (*opt->callback)(opt, NULL, 1) ? (-1) : 0;
 		if (opt->flags & PARSE_OPT_NOARG)
-- 
2.17.1

