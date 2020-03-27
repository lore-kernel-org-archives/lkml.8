Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419C9C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 06:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AD3E2071B
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 06:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbgC0Gh3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 02:37:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:2100 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725936AbgC0Gh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 02:37:29 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02R6W0c1067000
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 02:37:28 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ywbuyxjpd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 02:37:27 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <kjain@linux.ibm.com>;
        Fri, 27 Mar 2020 06:37:19 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 27 Mar 2020 06:37:12 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02R6bHU559506908
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Mar 2020 06:37:17 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8AF805204F;
        Fri, 27 Mar 2020 06:37:17 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.85.85.82])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 09E1A52051;
        Fri, 27 Mar 2020 06:37:11 +0000 (GMT)
From:   Kajol Jain <kjain@linux.ibm.com>
To:     acme@kernel.org, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        sukadev@linux.vnet.ibm.com
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        anju@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com,
        ravi.bangoria@linux.ibm.com, peterz@infradead.org,
        yao.jin@linux.intel.com, ak@linux.intel.com, jolsa@kernel.org,
        kan.liang@linux.intel.com, jmario@redhat.com,
        alexander.shishkin@linux.intel.com, mingo@kernel.org,
        paulus@ozlabs.org, namhyung@kernel.org, mpetlan@redhat.com,
        gregkh@linuxfoundation.org, benh@kernel.crashing.org,
        mamatha4@linux.vnet.ibm.com, mark.rutland@arm.com,
        tglx@linutronix.de, kjain@linux.ibm.com
Subject: [PATCH v7 3/5] powerpc/hv-24x7: Add sysfs files inside hv-24x7 device to show processor details
Date:   Fri, 27 Mar 2020 12:06:40 +0530
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200327063642.26175-1-kjain@linux.ibm.com>
References: <20200327063642.26175-1-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20032706-0016-0000-0000-000002F8F1FA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20032706-0017-0000-0000-0000335CA18C
Message-Id: <20200327063642.26175-4-kjain@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-26_14:2020-03-26,2020-03-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_spam_definite policy=outbound score=100 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 impostorscore=0 mlxlogscore=405
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003270054
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To expose the system dependent parameter like total number of
sockets and numbers of chips per socket, patch adds two sysfs files.
"sockets" and "chips" are added to /sys/devices/hv_24x7/interface/
of the "hv_24x7" pmu.

Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
---
 arch/powerpc/perf/hv-24x7.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
index 9ae00f29bd21..a31bd5b88f7a 100644
--- a/arch/powerpc/perf/hv-24x7.c
+++ b/arch/powerpc/perf/hv-24x7.c
@@ -454,6 +454,20 @@ static ssize_t device_show_string(struct device *dev,
 	return sprintf(buf, "%s\n", (char *)d->var);
 }
 
+#ifdef CONFIG_PPC_RTAS
+static ssize_t sockets_show(struct device *dev,
+			    struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%d\n", physsockets);
+}
+
+static ssize_t chips_show(struct device *dev, struct device_attribute *attr,
+			  char *buf)
+{
+	return sprintf(buf, "%d\n", physchips);
+}
+#endif
+
 static struct attribute *device_str_attr_create_(char *name, char *str)
 {
 	struct dev_ext_attribute *attr = kzalloc(sizeof(*attr), GFP_KERNEL);
@@ -1100,6 +1114,10 @@ PAGE_0_ATTR(catalog_len, "%lld\n",
 		(unsigned long long)be32_to_cpu(page_0->length) * 4096);
 static BIN_ATTR_RO(catalog, 0/* real length varies */);
 static DEVICE_ATTR_RO(domains);
+#ifdef CONFIG_PPC_RTAS
+static DEVICE_ATTR_RO(sockets);
+static DEVICE_ATTR_RO(chips);
+#endif
 
 static struct bin_attribute *if_bin_attrs[] = {
 	&bin_attr_catalog,
@@ -1110,6 +1128,10 @@ static struct attribute *if_attrs[] = {
 	&dev_attr_catalog_len.attr,
 	&dev_attr_catalog_version.attr,
 	&dev_attr_domains.attr,
+#ifdef CONFIG_PPC_RTAS
+	&dev_attr_sockets.attr,
+	&dev_attr_chips.attr,
+#endif
 	NULL,
 };
 
-- 
2.18.1

