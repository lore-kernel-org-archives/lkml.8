Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBAD3C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 15:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFCE420704
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 15:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729122AbgAWP4l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 10:56:41 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:61074 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727194AbgAWP4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 10:56:41 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00NFlsLm141519;
        Thu, 23 Jan 2020 10:56:13 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xqeeeg8kk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jan 2020 10:56:13 -0500
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 00NFoOos022344;
        Thu, 23 Jan 2020 10:56:12 -0500
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xqeeeg8jj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jan 2020 10:56:12 -0500
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 00NFtPcr031469;
        Thu, 23 Jan 2020 15:56:11 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma04wdc.us.ibm.com with ESMTP id 2xksn6y1fj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jan 2020 15:56:11 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00NFuASY44040532
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jan 2020 15:56:10 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D9129AE067;
        Thu, 23 Jan 2020 15:56:10 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B22F0AE063;
        Thu, 23 Jan 2020 15:56:10 +0000 (GMT)
Received: from localhost (unknown [9.85.181.148])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 23 Jan 2020 15:56:10 +0000 (GMT)
From:   Nathan Lynch <nathanl@linux.ibm.com>
To:     Libor Pechacek <lpechacek@suse.cz>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Suchanek <msuchanek@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Leonardo Bras <leonardo@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: drmem: avoid NULL pointer dereference when drmem is unavailable
In-Reply-To: <20200116102758.GC25138@fm.suse.cz>
References: <20200116102758.GC25138@fm.suse.cz>
Date:   Thu, 23 Jan 2020 09:56:10 -0600
Message-ID: <87o8uudv51.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-23_08:2020-01-23,2020-01-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=1
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 priorityscore=1501 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-2001230129
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello and thanks for the patch.

Libor Pechacek <lpechacek@suse.cz> writes:
> In KVM guests drmem structure is only zero initialized. Trying to
> manipulate DLPAR parameters results in a crash in this environment.

I think this statement needs qualification. Unless I'm mistaken, this
happens only when you boot a guest without any hotpluggable memory
configured, and then try to add or remove memory.


> diff --git a/arch/powerpc/include/asm/drmem.h b/arch/powerpc/include/asm/drmem.h
> index 3d76e1c388c2..28c3d936fdf3 100644
> --- a/arch/powerpc/include/asm/drmem.h
> +++ b/arch/powerpc/include/asm/drmem.h
> @@ -27,12 +27,12 @@ struct drmem_lmb_info {
>  extern struct drmem_lmb_info *drmem_info;
>  
>  #define for_each_drmem_lmb_in_range(lmb, start, end)		\
> -	for ((lmb) = (start); (lmb) <= (end); (lmb)++)
> +	for ((lmb) = (start); (lmb) < (end); (lmb)++)
>  
>  #define for_each_drmem_lmb(lmb)					\
>  	for_each_drmem_lmb_in_range((lmb),			\
>  		&drmem_info->lmbs[0],				\
> -		&drmem_info->lmbs[drmem_info->n_lmbs - 1])
> +		&drmem_info->lmbs[drmem_info->n_lmbs])
>  
>  /*
>   * The of_drconf_cell_v1 struct defines the layout of the LMB data
> diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
> index c126b94d1943..4ea6af002e27 100644
> --- a/arch/powerpc/platforms/pseries/hotplug-memory.c
> +++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
> @@ -236,9 +236,9 @@ static int get_lmb_range(u32 drc_index, int n_lmbs,
>  	if (!start)
>  		return -EINVAL;
>  
> -	end = &start[n_lmbs - 1];
> +	end = &start[n_lmbs];
>  
> -	last_lmb = &drmem_info->lmbs[drmem_info->n_lmbs - 1];
> +	last_lmb = &drmem_info->lmbs[drmem_info->n_lmbs];
>  	if (end > last_lmb)
>  		return -EINVAL;

Is this not undefined behavior? I'd rather do this in a way that does
not involve forming out-of-bounds pointers. Even if it's safe, naming
that pointer "last_lmb" now actively hinders understanding of the code;
it should be named "limit" or something.

Anyway, I confess I've had the following patch sitting unsubmitted due
to a combination of perceived low urgency and lack of time. I've
verified it addresses your reported problem but I need a day or two to
check that it doesn't regress memory add/remove on suitably configured
guests:

================================================================

powerpc/drmem: make drmem list traversal safe on non-drmem systems

A user has reported a crash when attempting to remove an LMB on a KVM
guest where the device tree lacks the nodes and properties
(ibm,dynamic-reconfiguration-memory etc) which allow the drmem code to
support dynamic memory removal:

pseries-hotplug-mem: Attempting to hot-remove 1 LMB(s)
Unable to handle kernel paging request for data at address 0x00000010
Faulting instruction address: 0xc0000000000f0a30
Oops: Kernel access of bad area, sig: 11 [#1]
[... regs etc ...]
NIP [c0000000000f0a30] dlpar_memory+0x510/0xb50
LR [c0000000000f09e8] dlpar_memory+0x4c8/0xb50
Call Trace:
[c0000001edf97ba0] [c0000000000f09e8] dlpar_memory+0x4c8/0xb50 (unreliable)
[c0000001edf97c20] [c0000000000e8390] handle_dlpar_errorlog+0x60/0x140
[c0000001edf97c90] [c0000000000e85e0] dlpar_store+0x170/0x490
[c0000001edf97d40] [c000000000cb0c90] kobj_attr_store+0x30/0x50
[c0000001edf97d60] [c000000000591598] sysfs_kf_write+0x68/0xa0
[c0000001edf97d80] [c00000000058fec4] kernfs_fop_write+0x104/0x270
[c0000001edf97dd0] [c0000000004a1078] sys_write+0x128/0x380
[c0000001edf97e30] [c00000000000b388] system_call+0x5c/0x70

Make for_each_drmem_lmb() safe for the case where the list of drmem
LMBs is unpopulated.

Signed-off-by: Nathan Lynch <nathanl@linux.ibm.com>

1 file changed, 36 insertions(+), 7 deletions(-)
arch/powerpc/include/asm/drmem.h | 43 +++++++++++++++++++++++++++++++++-------

modified   arch/powerpc/include/asm/drmem.h
@@ -20,19 +20,48 @@ struct drmem_lmb {
 
 struct drmem_lmb_info {
 	struct drmem_lmb        *lmbs;
-	int                     n_lmbs;
+	unsigned int            n_lmbs;
 	u32                     lmb_size;
 };
 
 extern struct drmem_lmb_info *drmem_info;
 
-#define for_each_drmem_lmb_in_range(lmb, start, end)		\
-	for ((lmb) = (start); (lmb) <= (end); (lmb)++)
+static inline bool drmem_present(void)
+{
+	return drmem_info->lmbs != NULL;
+}
+
+static inline struct drmem_lmb *drmem_lmb_index(unsigned int index)
+{
+	if (!drmem_present())
+		return NULL;
 
-#define for_each_drmem_lmb(lmb)					\
-	for_each_drmem_lmb_in_range((lmb),			\
-		&drmem_info->lmbs[0],				\
-		&drmem_info->lmbs[drmem_info->n_lmbs - 1])
+	if (WARN_ON(index >= drmem_info->n_lmbs))
+		return NULL;
+
+	return &drmem_info->lmbs[index];
+}
+
+static inline struct drmem_lmb *drmem_first_lmb(void)
+{
+	return drmem_lmb_index(0);
+}
+
+static inline struct drmem_lmb *drmem_last_lmb(void)
+{
+	if (!drmem_present())
+		return NULL;
+
+	return drmem_lmb_index(drmem_info->n_lmbs - 1);
+}
+
+#define for_each_drmem_lmb(lmb)						\
+	for ((lmb) = drmem_first_lmb();					\
+	     (lmb) != NULL && (lmb) <= drmem_last_lmb();		\
+	     (lmb)++)
+
+#define for_each_drmem_lmb_in_range(lmb, start, end)	\
+	for ((lmb) = (start); (lmb) <= (end); (lmb)++)
 
 /*
  * The of_drconf_cell_v1 struct defines the layout of the LMB data

