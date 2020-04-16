Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B533C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 03:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9F582076A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 03:51:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403767AbgDPDv4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 23:51:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8692 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729245AbgDPDvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 23:51:52 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03G3X3li146983
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 23:51:50 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30ef1jh09g-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 23:51:49 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <vaibhav@linux.ibm.com>;
        Thu, 16 Apr 2020 04:51:06 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 16 Apr 2020 04:51:02 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03G3phKW51904692
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Apr 2020 03:51:43 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 68245AE051;
        Thu, 16 Apr 2020 03:51:43 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 23D45AE045;
        Thu, 16 Apr 2020 03:51:40 +0000 (GMT)
Received: from vajain21.in.ibm.com.com (unknown [9.85.94.100])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 16 Apr 2020 03:51:39 +0000 (GMT)
From:   Vaibhav Jain <vaibhav@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Vaibhav Jain <vaibhav@linux.ibm.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <ellerman@au1.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Piotr Maziarz <piotrx.maziarz@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Borislav Petkov <bp@alien8.de>
Subject: [RFC] seq_buf: Export symbols to external modules
Date:   Thu, 16 Apr 2020 09:21:24 +0530
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20041603-0020-0000-0000-000003C8A2D2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20041603-0021-0000-0000-000022218753
Message-Id: <20200416035124.549067-1-vaibhav@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-15_08:2020-04-14,2020-04-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 clxscore=1011 priorityscore=1501 suspectscore=0 bulkscore=0
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004160018
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'seq_buf' provides a very useful abstraction for writing to a string
buffer without needing to worry about it over-flowing. However even
though the API has been stable for couple of years now its stills not
exported to external modules limiting its usage.

Hence this patch proposes update to 'seq_buf.c' to mark all functions
seq_buf_X() which are part of the seq_seq API to be exported to
external GPL modules.

Earlier work:
There was an earlier proposal by Borislav Petkov <bp@alien8.de> to
export seq_buf_printf() to modules at [1], as part of his EDAC
patch-set "EDAC, mce_amd: Add a tracepoint for the decoded
error". However the proposed patch was never merged and its fate is
unknown as I couldn't locate any subsequent discussion as to why patch
in [1] was dropped.

References:
[1]: https://lore.kernel.org/lkml/20170825102411.8682-5-bp@alien8.de/
[2]: https://lore.kernel.org/lkml/20170825092757.434f1eda@gandalf.local.home/

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Piotr Maziarz <piotrx.maziarz@linux.intel.com>
Cc: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
---
 lib/seq_buf.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/lib/seq_buf.c b/lib/seq_buf.c
index 4e865d42ab03..3aaa685e902d 100644
--- a/lib/seq_buf.c
+++ b/lib/seq_buf.c
@@ -43,6 +43,7 @@ int seq_buf_print_seq(struct seq_file *m, struct seq_buf *s)
 
 	return seq_write(m, s->buffer, len);
 }
+EXPORT_SYMBOL_GPL(seq_buf_print_seq);
 
 /**
  * seq_buf_vprintf - sequence printing of information.
@@ -70,6 +71,7 @@ int seq_buf_vprintf(struct seq_buf *s, const char *fmt, va_list args)
 	seq_buf_set_overflow(s);
 	return -1;
 }
+EXPORT_SYMBOL_GPL(seq_buf_vprintf);
 
 /**
  * seq_buf_printf - sequence printing of information
@@ -91,6 +93,7 @@ int seq_buf_printf(struct seq_buf *s, const char *fmt, ...)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(seq_buf_printf);
 
 #ifdef CONFIG_BINARY_PRINTF
 /**
@@ -127,6 +130,7 @@ int seq_buf_bprintf(struct seq_buf *s, const char *fmt, const u32 *binary)
 	seq_buf_set_overflow(s);
 	return -1;
 }
+EXPORT_SYMBOL_GPL(seq_buf_bprintf);
 #endif /* CONFIG_BINARY_PRINTF */
 
 /**
@@ -156,6 +160,7 @@ int seq_buf_puts(struct seq_buf *s, const char *str)
 	seq_buf_set_overflow(s);
 	return -1;
 }
+EXPORT_SYMBOL_GPL(seq_buf_puts);
 
 /**
  * seq_buf_putc - sequence printing of simple character
@@ -177,6 +182,7 @@ int seq_buf_putc(struct seq_buf *s, unsigned char c)
 	seq_buf_set_overflow(s);
 	return -1;
 }
+EXPORT_SYMBOL_GPL(seq_buf_putc);
 
 /**
  * seq_buf_putmem - write raw data into the sequenc buffer
@@ -202,6 +208,7 @@ int seq_buf_putmem(struct seq_buf *s, const void *mem, unsigned int len)
 	seq_buf_set_overflow(s);
 	return -1;
 }
+EXPORT_SYMBOL_GPL(seq_buf_putmem);
 
 #define MAX_MEMHEX_BYTES	8U
 #define HEX_CHARS		(MAX_MEMHEX_BYTES*2 + 1)
@@ -251,6 +258,7 @@ int seq_buf_putmem_hex(struct seq_buf *s, const void *mem,
 	}
 	return 0;
 }
+EXPORT_SYMBOL_GPL(seq_buf_putmem_hex);
 
 /**
  * seq_buf_path - copy a path into the sequence buffer
@@ -282,6 +290,7 @@ int seq_buf_path(struct seq_buf *s, const struct path *path, const char *esc)
 
 	return res;
 }
+EXPORT_SYMBOL_GPL(seq_buf_path);
 
 /**
  * seq_buf_to_user - copy the squence buffer to user space
@@ -328,6 +337,7 @@ int seq_buf_to_user(struct seq_buf *s, char __user *ubuf, int cnt)
 	s->readpos += cnt;
 	return cnt;
 }
+EXPORT_SYMBOL_GPL(seq_buf_to_user);
 
 /**
  * seq_buf_hex_dump - print formatted hex dump into the sequence buffer
@@ -390,3 +400,4 @@ int seq_buf_hex_dump(struct seq_buf *s, const char *prefix_str, int prefix_type,
 	}
 	return 0;
 }
+EXPORT_SYMBOL_GPL(seq_buf_hex_dump);
-- 
2.25.2

