Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C91BC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 07:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6100C2173E
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 07:25:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729831AbgBMHY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 02:24:59 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:58314 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729364AbgBMHY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 02:24:59 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01D7MUPO025678;
        Thu, 13 Feb 2020 02:24:50 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 2y1udn1bjf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Feb 2020 02:24:50 -0500
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 01D7Om7E013138
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 13 Feb 2020 02:24:49 -0500
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Wed, 12 Feb
 2020 23:24:47 -0800
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Wed, 12 Feb 2020 23:24:47 -0800
Received: from saturn.ad.analog.com ([10.48.65.124])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 01D7Oi87022204;
        Thu, 13 Feb 2020 02:24:44 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <akpm@linux-foundation.org>, <keescook@chromium.org>,
        <andriy.shevchenko@linux.intel.com>, <tobin@kernel.org>,
        <gregkh@linuxfoundation.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2] lib/string: update match_string() doc-strings with correct behavior
Date:   Thu, 13 Feb 2020 09:27:22 +0200
Message-ID: <20200213072722.8249-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200212144723.21884-1-alexandru.ardelean@analog.com>
References: <20200212144723.21884-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-13_01:2020-02-12,2020-02-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=1 bulkscore=0 adultscore=0 mlxlogscore=570 lowpriorityscore=0
 clxscore=1015 mlxscore=0 impostorscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002130058
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There were a few attempts at changing behavior of the match_string()
helpers (i.e. 'match_string()' & 'sysfs_match_string()'), to change &
extend the behavior according to the doc-string.

But the simplest approach is to just fix the doc-strings. The current
behavior is fine as-is, and some bugs were introduced trying to fix it.

As for extending the behavior, new helpers can always be introduced if
needed.

The match_string() helpers behave more like 'strncmp()' in the sense that
they go up to n elements or until the first NULL element in the array of
strings.

This change updates the doc-strings with this info.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 lib/string.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/lib/string.c b/lib/string.c
index f607b967d978..6012c385fb31 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -699,6 +699,14 @@ EXPORT_SYMBOL(sysfs_streq);
  * @n:		number of strings in the array or -1 for NULL terminated arrays
  * @string:	string to match with
  *
+ * This routine will look for a string in an array of strings up to the
+ * n-th element in the array or until the first NULL element.
+ *
+ * Historically the value of -1 for @n, was used to search in arrays that
+ * are NULL terminated. However, the function does not make a distinction
+ * when finishing the search: either @n elements have been compared OR
+ * the first NULL element was found.
+ *
  * Return:
  * index of a @string in the @array if matches, or %-EINVAL otherwise.
  */
@@ -727,6 +735,14 @@ EXPORT_SYMBOL(match_string);
  *
  * Returns index of @str in the @array or -EINVAL, just like match_string().
  * Uses sysfs_streq instead of strcmp for matching.
+ *
+ * This routine will look for a string in an array of strings up to the
+ * n-th element in the array or until the first NULL element.
+ *
+ * Historically the value of -1 for @n, was used to search in arrays that
+ * are NULL terminated. However, the function does not make a distinction
+ * when finishing the search: either @n elements have been compared OR
+ * the first NULL element was found.
  */
 int __sysfs_match_string(const char * const *array, size_t n, const char *str)
 {
-- 
2.20.1

