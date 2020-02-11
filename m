Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B5E7C35242
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 22:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38A3820714
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 22:04:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbgBKWET (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 17:04:19 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45291 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727111AbgBKWET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 17:04:19 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01BLmhnu139789;
        Tue, 11 Feb 2020 17:04:14 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2y3wxdenk4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Feb 2020 17:04:14 -0500
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 01BLnxRA142464;
        Tue, 11 Feb 2020 17:04:14 -0500
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2y3wxdenjs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Feb 2020 17:04:14 -0500
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 01BM02ML002835;
        Tue, 11 Feb 2020 22:04:13 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma03wdc.us.ibm.com with ESMTP id 2y1mm737xy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Feb 2020 22:04:13 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01BM4CLl50856340
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Feb 2020 22:04:12 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9F9FC6E410;
        Tue, 11 Feb 2020 22:04:12 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 809F86E40F;
        Tue, 11 Feb 2020 22:04:07 +0000 (GMT)
Received: from localhost (unknown [9.41.179.32])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 11 Feb 2020 22:04:07 +0000 (GMT)
Date:   Tue, 11 Feb 2020 16:04:06 -0600
From:   Scott Cheloha <cheloha@linux.ibm.com>
To:     Nathan Lynch <nathanl@linux.ibm.com>
Cc:     Nathan Fontenont <ndfont@gmail.com>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] pseries/hotplug-memory: remove
 dlpar_memory_{add,remove}_by_index() functions
Message-ID: <20200211220406.72jdndodtp23v4w2@rascal.austin.ibm.com>
References: <20200127200839.12441-1-cheloha@linux.ibm.com>
 <87ftfimbjy.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ftfimbjy.fsf@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-11_06:2020-02-11,2020-02-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 malwarescore=0 suspectscore=1 clxscore=1015 mlxscore=0 priorityscore=1501
 bulkscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002110141
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 02:28:49PM -0600, Nathan Lynch wrote:
> Scott Cheloha <cheloha@linux.ibm.com> writes:
> > The dlpar_memory_{add,remove}_by_index() functions are just special
> > cases of their dlpar_memory_{add,remove}_by_ic() counterparts where
> > the LMB count is 1.
> 
> I wish that were the case, but there are (gratuitous?) differences:
> 
> - dlpar_memory_remove_by_ic() checks DRCONF_MEM_RESERVED and
>   DRCONF_MEM_ASSIGNED flags; dlpar_memory_remove_by_index() does not.

The lack of a DRCONF_MEM_RESERVED check in add_by_index() and
remove_by_index() might be a mistake.  If I understand the PAPR
correctly, when DRCONF_MEM_RESERVED is set for an LMB the operating
system isn't allowed to touch it.  The LMB could become available for
use later if the platform clears the bit, but if it's set it's
no good.

DRCONF_MEM_ASSIGNED checks are not present in
dlpar_memory_add_by_index() and dlpar_memory_remove_by_index() but
they are done at the top of dlpar_add_lmb() and lmb_is_removable(),
so the checks do happen in those paths.

> - dlpar_memory_remove_by_ic() attempts to roll back failed removal;
>   dlpar_memory_remove_by_index() does not.

The exclusion of rollback in the remove_by_index() path makes sense,
as there are only N=1 possible elements where the operation can fail.
Doing the marking/unmarking for rollback in the N=1 case is harmless
though.  If the removal fails for the given LMB we never call
drmem_mark_reserved() to indicate that we need to re-add it.  The
rollback loop then finds no marked LMBs and does no work.

> I'm not sure how much either of these gets used in practice. AFAIK the
> usual HMC/drmgr-driven workflow tends to exercise
> dlpar_memory_remove_by_count().

drmgr eventually uses dlpar_memory_*_by_count() when you give it a
count of LMBs with the '-q' flag, e.g.:

# drmgr -c mem -a -q 10

drmgr eventually uses dlpar_memory_*_by_index() when you give it a
particular DRC, e.g.:

# drmgr -c mem -a -s <some drc number>

QEMU hotplug uses dlpar_memory_*_by_ic().

> I agree this code needs consolidation, but we should proceed a little
> carefully because it's likely going to entail changing some user-visible
> behaviors.

Sure.

Maybe there are less ambitious ways to start out.
