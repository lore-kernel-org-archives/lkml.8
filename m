Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A7CC55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 12:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 167CC20780
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 12:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="X5nJyTqx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbgDVMGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 08:06:06 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:49092 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbgDVMGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 08:06:06 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03MC2rO5097413;
        Wed, 22 Apr 2020 12:05:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=L7GWEspZEtRD1L/VpVBFE+u2DMBWTYytg1A5zTqZe30=;
 b=X5nJyTqxnfILH2uNAa7QDwqOe8hrE6bDeRIvPmz1Cpaoh53/11LPQPw4KtyysOCmdkPi
 HiB5s88TgJfH6kGG/vfz0meC7MjVbU8YZyJ13789MnTI2g+ypq4g7gXTMZFczjrg+7Q2
 3HuFxt3gbvnbw6fC0WkPO27FuVleMvCSnpWPcSRaa/UDboA3z82Q8BpwquavPEnsNerG
 aD+PTW6qPezUpl01xWk3L3RK8W9Zzr+wj6Bhad/SDV8qjmPPjjj8cZbtzpAmLr5sYcA+
 0u25f+ExdHzlDGJVayFr2cB9giFclsvPfZx9K0suD3VjISH/tzfnTiPZvr1slurgZcII bA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 30fsgm2cbn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Apr 2020 12:05:45 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03MC2HqJ052051;
        Wed, 22 Apr 2020 12:03:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 30gb1jeep1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 22 Apr 2020 12:03:44 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 03MC3imt056174;
        Wed, 22 Apr 2020 12:03:44 GMT
Received: from control-surface.uk.oracle.com (dhcp-10-175-178-214.vpn.oracle.com [10.175.178.214])
        by userp3030.oracle.com with ESMTP id 30gb1jeehu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 22 Apr 2020 12:03:43 +0000
Received: from control-surface.uk.oracle.com (localhost [127.0.0.1])
        by control-surface.uk.oracle.com (8.15.2/8.15.2) with ESMTPS id 03MC3epQ080674
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 22 Apr 2020 13:03:41 +0100
Received: (from jch@localhost)
        by control-surface.uk.oracle.com (8.15.2/8.15.2/Submit) id 03MC3dPx080672;
        Wed, 22 Apr 2020 13:03:39 +0100
X-Authentication-Warning: control-surface.uk.oracle.com: jch set sender to john.haxby@oracle.com using -f
From:   John Haxby <john.haxby@oracle.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, John Haxby <john.haxby@oracle.com>
Subject: [PATCH 0/1] x86/fpu: Allow clearcpuid= to clear several bits
Date:   Wed, 22 Apr 2020 13:03:18 +0100
Message-Id: <cover.1587555769.git.john.haxby@oracle.com>
X-Mailer: git-send-email 2.25.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9598 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 clxscore=1015
 spamscore=0 bulkscore=0 phishscore=0 suspectscore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004220097
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Back in the mists of time, well, prior to 4.14.9, you could put clearcpuid=N
several times on the command line to clear several CPUID bits.  Unfortunately,
there was a problem with the way that this was done which meant XSAVE, in
particular, wasn't cleared early enough.  This was fixed in 0c2a3913d6f5
("x86/fpu: Parse clearcpuid= as early XSAVE argument").  Unfortunately that
also meant that only one bit could be cleared.

This patch mostly fixes that.  Gone is the old, anachronistic, multiple
clearcpuid= arguments to be replaced by a single clearcpuid=BITNUM[,BITNUM,...]
argument.  It's no longer possible to clear perhaps dozens of flags with a very
long kernel command line, but you can clear up to about eight bits now instead
of just one.

jch


John Haxby (1):
  x86/fpu: Allow clearcpuid= to clear several bits

 .../admin-guide/kernel-parameters.txt         | 24 ++++++++++---------
 arch/x86/kernel/fpu/init.c                    | 18 ++++++++------
 2 files changed, 24 insertions(+), 18 deletions(-)

-- 
2.25.3

