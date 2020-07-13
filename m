Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 418E6C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 11:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2781C2072D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 11:56:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729616AbgGML4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 07:56:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:31884 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728714AbgGML4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 07:56:42 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06DBs4eL195413;
        Mon, 13 Jul 2020 07:56:25 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32792u0mrw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jul 2020 07:56:24 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06DBWsxO133872;
        Mon, 13 Jul 2020 07:56:23 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32792u0mrg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jul 2020 07:56:23 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06DBsNEp002462;
        Mon, 13 Jul 2020 11:56:22 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma01dal.us.ibm.com with ESMTP id 327528bhpc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jul 2020 11:56:22 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06DBuLve50659752
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jul 2020 11:56:22 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DE660AC059;
        Mon, 13 Jul 2020 11:56:21 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8B97AAC05B;
        Mon, 13 Jul 2020 11:56:21 +0000 (GMT)
Received: from sofia.ibm.com (unknown [9.77.204.163])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 13 Jul 2020 11:56:21 +0000 (GMT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
        id B1C1E2E4ACB; Mon, 13 Jul 2020 16:18:37 +0530 (IST)
Date:   Mon, 13 Jul 2020 16:18:37 +0530
From:   Gautham R Shenoy <ego@linux.vnet.ibm.com>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     benh@kernel.crashing.org, ego@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        mikey@neuling.org, mpe@ellerman.id.au, paulus@samba.org,
        pratik.r.sampat@gmail.com,
        Pratik Rajesh Sampat <psampat@linux.ibm.com>,
        ravi.bangoria@linux.ibm.com, svaidy@linux.ibm.com
Subject: Re: [PATCH v2 0/3] Power10 basic energy management
Message-ID: <20200713104837.GG24866@in.ibm.com>
Reply-To: ego@linux.vnet.ibm.com
References: <20200710052207.12003-1-psampat@linux.ibm.com>
 <1594617564.57k8bsyfd0.astroid@bobo.none>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594617564.57k8bsyfd0.astroid@bobo.none>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-13_07:2020-07-13,2020-07-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 adultscore=0 impostorscore=0 spamscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007130084
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 03:23:21PM +1000, Nicholas Piggin wrote:
> Excerpts from Pratik Rajesh Sampat's message of July 10, 2020 3:22 pm:
> > Changelog v1 --> v2:
> > 1. Save-restore DAWR and DAWRX unconditionally as they are lost in
> > shallow idle states too
> > 2. Rename pnv_first_spr_loss_level to pnv_first_fullstate_loss_level to
> > correct naming terminology
> > 
> > Pratik Rajesh Sampat (3):
> >   powerpc/powernv/idle: Exclude mfspr on HID1,4,5 on P9 and above
> >   powerpc/powernv/idle: save-restore DAWR0,DAWRX0 for P10
> >   powerpc/powernv/idle: Rename pnv_first_spr_loss_level variable
> > 
> >  arch/powerpc/platforms/powernv/idle.c | 34 +++++++++++++++++----------
> >  1 file changed, 22 insertions(+), 12 deletions(-)
> 
> These look okay to me, but the CPU_FTR_ARCH_300 test for 
> pnv_power9_idle_init() is actually wrong, it should be a PVR test 
> because idle is not completely architected (not even shallow stop 
> states, unfortunately).
> 
> It doesn't look like we support POWER10 idle correctly yet, and on older
> kernels it wouldn't work even if we fixed newer, so ideally the PVR 
> check would be backported as a fix in the front of the series.
> 
> Sadly, we have no OPAL idle driver yet. Hopefully we will before the
> next processor shows up :P

Abhishek posted a version recently :
https://patchwork.ozlabs.org/project/skiboot/patch/20200706043533.76539-1-huntbag@linux.vnet.ibm.com/


> 
> Thanks,
> Nick

--
Thanks and Regards
gautham.
