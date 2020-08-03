Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 018F8C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 05:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFDEC20678
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 05:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbgHCF5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 01:57:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:15880 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727889AbgHCF5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 01:57:06 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0735X0su097242;
        Mon, 3 Aug 2020 01:56:53 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32p7xy60ht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Aug 2020 01:56:53 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0735pcUY024546;
        Mon, 3 Aug 2020 05:56:51 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma02fra.de.ibm.com with ESMTP id 32n01893sj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Aug 2020 05:56:51 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0735tNMj57934286
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 3 Aug 2020 05:55:23 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5707D4C050;
        Mon,  3 Aug 2020 05:56:49 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 42C574C052;
        Mon,  3 Aug 2020 05:56:49 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon,  3 Aug 2020 05:56:49 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
        id A5565E03D7; Mon,  3 Aug 2020 07:56:48 +0200 (CEST)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH RFC] s390: convert to GENERIC_VDSO
Date:   Mon,  3 Aug 2020 07:56:43 +0200
Message-Id: <20200803055645.79042-1-svens@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-03_04:2020-07-31,2020-08-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=884 impostorscore=0
 suspectscore=0 phishscore=0 clxscore=1011 priorityscore=1501 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008030037
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

these two patches convert the s390 architecture to generic VDSO. The
first patch adds an option to add architecture specific information
to struct vdso_data. We need that information because the old s390
assembly code had a steering capability, which steered the clock slowly.
To emulate that behaviour we need to add the steering offset to struct
vdso_data.

This requirements results in the need for a seqlock kind of lock, which is
implemented open-coded in __arch_get_hw_counter(). open-coded because we
cannot include seqlock.h in userspace code (and using the normal seqlock
interface on kernel side might result in people changing struct seqlock,
but not changing the vdso userspace part), therefore both sides are
open-coded. I think in theory we could also call vdso_write_begin()/
vdso_write_end(). What do you think?

If there are no objections we would carry both patches through the s390 tree.

Thanks
Sven


