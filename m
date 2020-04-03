Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F405C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 06:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 257E42073B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 06:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388498AbgDCGhl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 02:37:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39582 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732903AbgDCGhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 02:37:40 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0336Xh3I139605;
        Fri, 3 Apr 2020 02:37:31 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0b-001b2d01.pphosted.com with ESMTP id 305s830n84-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Apr 2020 02:37:31 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 0336ZrqC010353;
        Fri, 3 Apr 2020 06:37:30 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma01wdc.us.ibm.com with ESMTP id 301x76pxmk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Apr 2020 06:37:30 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0336bTQH21234074
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Apr 2020 06:37:29 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AE6EFC6055;
        Fri,  3 Apr 2020 06:37:29 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 29235C605A;
        Fri,  3 Apr 2020 06:37:29 +0000 (GMT)
Received: from sofia.ibm.com (unknown [9.199.34.1])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri,  3 Apr 2020 06:37:29 +0000 (GMT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
        id 48C752E3005; Fri,  3 Apr 2020 11:58:18 +0530 (IST)
Date:   Fri, 3 Apr 2020 11:58:18 +0530
From:   Gautham R Shenoy <ego@linux.vnet.ibm.com>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     ego@linux.vnet.ibm.com, Michael Ellerman <mpe@ellerman.id.au>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: Re: [PATCH v4 6/6] pseries/sysfs: Minimise IPI noise while reading
 [idle_][s]purr
Message-ID: <20200403062818.GB9066@in.ibm.com>
Reply-To: ego@linux.vnet.ibm.com
References: <1585308760-28792-1-git-send-email-ego@linux.vnet.ibm.com>
 <1585308760-28792-7-git-send-email-ego@linux.vnet.ibm.com>
 <1585734367.oqwn7dzljo.naveen@linux.ibm.com>
 <20200401120127.GC17237@in.ibm.com>
 <1585811157.uig8s95yst.naveen@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1585811157.uig8s95yst.naveen@linux.ibm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-03_04:2020-04-02,2020-04-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 mlxscore=0 suspectscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004030054
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Naveen,

On Thu, Apr 02, 2020 at 01:04:34PM +0530, Naveen N. Rao wrote:
[..snip..]

> >
> >It does reduce it to 10ms window. I am not sure if anyone samples PURR
> >etc faster than that rate.
> >
> >I measured how much time it takes to read the purr, spurr, idle_purr,
> >idle_spurr files back-to-back. It takes not more than 150us.  From
> >lparstat will these values be read back-to-back ? If so, we can reduce
> >the staleness_tolerance to something like 500us and still avoid extra
> >IPIs. If not, what is the maximum delay between the first sysfs file
> >read and the last sysfs file read ?
> 
> Oh, for lparstat usage, this is perfectly fine.
> 
> I meant that there could be other users of [s]purr who might care. I don't
> know of one, but since this is an existing sysfs interface, I wanted to
> point out that the behavior might change.

Fair point. Perhaps this should be documented in the Documentation, if
we are going to continue with this patch.

> 
> >
> >>
> >>I wonder if we should introduce a sysctl interface to control thresholding.
> >>It can default to 0, which disables thresholding so that the existing
> >>behavior continues. Applications (lparstat) can optionally set it to suit
> >>their use.
> >
> >We would be introducing 3 new sysfs interfaces that way instead of
> >two.
> >
> >/sys/devices/system/cpu/purr_spurr_staleness
> >/sys/devices/system/cpu/cpuX/idle_purr
> >/sys/devices/system/cpu/cpuX/idle_spurr
> >
> >I don't have a problem with this. Nathan, Michael, thoughts on this?
> >
> >
> >The alternative is to have a procfs interface, something like
> >/proc/powerpc/resource_util_stats
> >
> >which gives a listing similar to /proc/stat, i.e
> >
> >      CPUX  <purr>  <idle_purr>  <spurr>  <idle_spurr>
> >
> >Even in this case, the values can be obtained in one-shot with a
> >single IPI and be printed in the row corresponding to the CPU.
> 
> Right -- and that would be optimal requiring a single system call, at the
> cost of using a legacy interface.
> 
> The other option would be to drop this patch and to just go with patches 1-5
> introducing the new sysfs interfaces for idle_[s]purr. It isn't entirely
> clear how often this would be used, or its actual impact. We can perhaps
> consider this optimization if and when this causes problems...

I am ok with that. We can revisit the problem if IPI noise becomes
noticable. However, if Nathan or Michael feel that this problem is
better solved now, than leaving it for the future, we will have to
take a call on what the interface is going to be.

> 
> 
> Thanks,
> Naveen
> 

--
Thanks and Regards
gautham.
