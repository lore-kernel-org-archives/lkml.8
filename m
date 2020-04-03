Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D8E7C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 14:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D69A2073B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 14:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391034AbgDCOio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 10:38:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:61268 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728066AbgDCOin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 10:38:43 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 033EWt6D019629
        for <linux-kernel@vger.kernel.org>; Fri, 3 Apr 2020 10:38:42 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 303ws0k823-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 10:38:42 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <bharata@linux.ibm.com>;
        Fri, 3 Apr 2020 15:38:22 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 3 Apr 2020 15:38:19 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 033Eca5655771264
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Apr 2020 14:38:36 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 16927A4064;
        Fri,  3 Apr 2020 14:38:36 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 08F74A405B;
        Fri,  3 Apr 2020 14:38:34 +0000 (GMT)
Received: from in.ibm.com (unknown [9.85.86.108])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri,  3 Apr 2020 14:38:33 +0000 (GMT)
Date:   Fri, 3 Apr 2020 20:08:31 +0530
From:   Bharata B Rao <bharata@linux.ibm.com>
To:     Leonardo Bras <leonardo@linux.ibm.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nathan Fontenot <nfont@linux.vnet.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] powerpc/kernel: Enables memory hot-remove after
 reboot on pseries guests
Reply-To: bharata@linux.ibm.com
References: <20200402195156.626430-1-leonardo@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200402195156.626430-1-leonardo@linux.ibm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-TM-AS-GCONF: 00
x-cbid: 20040314-0016-0000-0000-000002FDA61F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20040314-0017-0000-0000-000033617529
Message-Id: <20200403143831.GA12662@in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-03_11:2020-04-03,2020-04-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 clxscore=1015 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 priorityscore=1501 spamscore=0 adultscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004030129
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 02, 2020 at 04:51:57PM -0300, Leonardo Bras wrote:
> While providing guests, it's desirable to resize it's memory on demand.
> 
> By now, it's possible to do so by creating a guest with a small base
> memory, hot-plugging all the rest, and using 'movable_node' kernel
> command-line parameter, which puts all hot-plugged memory in
> ZONE_MOVABLE, allowing it to be removed whenever needed.
> 
> But there is an issue regarding guest reboot:
> If memory is hot-plugged, and then the guest is rebooted, all hot-plugged
> memory goes to ZONE_NORMAL, which offers no guaranteed hot-removal.
> It usually prevents this memory to be hot-removed from the guest.
> 
> It's possible to use device-tree information to fix that behavior, as
> it stores flags for LMB ranges on ibm,dynamic-memory-vN.
> It involves marking each memblock with the correct flags as hotpluggable
> memory, which mm/memblock.c puts in ZONE_MOVABLE during boot if
> 'movable_node' is passed.
> 
> For carrying such information, the new flag DRCONF_MEM_HOTREMOVABLE was
> proposed and accepted into Power Architecture documentation.
> This flag should be:
> - true (b=1) if the hypervisor may want to hot-remove it later, and
> - false (b=0) if it does not care.
> 
> During boot, guest kernel reads the device-tree, early_init_drmem_lmb()
> is called for every added LMBs. Here, checking for this new flag and
> marking memblocks as hotplugable memory is enough to get the desirable
> behavior.
> 
> This should cause no change if 'movable_node' parameter is not passed
> in kernel command-line.
> 
> Signed-off-by: Leonardo Bras <leonardo@linux.ibm.com>
> Reviewed-by: Bharata B Rao <bharata@linux.ibm.com>
> 
> ---
> 
> Changes since v2:
> - New flag name changed from DRCONF_MEM_HOTPLUGGED to
> 	DRCONF_MEM_HOTREMOVABLE

The patch would be more complete with the following change that ensures
that DRCONF_MEM_HOTREMOVABLE flag is set for non-boot-time hotplugged
memory too. This will ensure that ibm,dynamic-memory-vN property
reflects the right flags value for memory that gets hotplugged
post boot.

diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index a4d40a3ceea3..6d75f6e182ae 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -395,7 +395,8 @@ static int dlpar_remove_lmb(struct drmem_lmb *lmb)
 
 	invalidate_lmb_associativity_index(lmb);
 	lmb_clear_nid(lmb);
-	lmb->flags &= ~DRCONF_MEM_ASSIGNED;
+	lmb->flags &= ~(DRCONF_MEM_ASSIGNED |
+			DRCONF_MEM_HOTREMOVABLE);
 
 	return 0;
 }
@@ -678,7 +679,8 @@ static int dlpar_add_lmb(struct drmem_lmb *lmb)
 		invalidate_lmb_associativity_index(lmb);
 		lmb_clear_nid(lmb);
 	} else {
-		lmb->flags |= DRCONF_MEM_ASSIGNED;
+		lmb->flags |= (DRCONF_MEM_ASSIGNED |
+			       DRCONF_MEM_HOTREMOVABLE);
 	}
 
 	return rc;

Regards,
Bharata.

