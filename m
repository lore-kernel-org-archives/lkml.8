Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C9A4C33CB2
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 04:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBD7F2073C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 04:53:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbgBCEuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Feb 2020 23:50:25 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56856 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727317AbgBCEuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 23:50:24 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0134oH7H021102;
        Sun, 2 Feb 2020 23:50:19 -0500
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xxcmb8e0h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 02 Feb 2020 23:50:19 -0500
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 0134nx48007166;
        Mon, 3 Feb 2020 04:50:18 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma04wdc.us.ibm.com with ESMTP id 2xw0y663ku-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Feb 2020 04:50:18 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0134oHrZ62456292
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 3 Feb 2020 04:50:17 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1DFB413604F;
        Mon,  3 Feb 2020 04:50:17 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C86A4136051;
        Mon,  3 Feb 2020 04:50:16 +0000 (GMT)
Received: from sofia.ibm.com (unknown [9.124.31.110])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon,  3 Feb 2020 04:50:16 +0000 (GMT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
        id 19FAF2E2DB0; Mon,  3 Feb 2020 10:20:14 +0530 (IST)
Date:   Mon, 3 Feb 2020 10:20:14 +0530
From:   Gautham R Shenoy <ego@linux.vnet.ibm.com>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/3] powerpc/sysfs: Show idle_purr and idle_spurr for
 every CPU
Message-ID: <20200203045013.GC13468@in.ibm.com>
Reply-To: ego@linux.vnet.ibm.com
References: <1574856072-30972-1-git-send-email-ego@linux.vnet.ibm.com>
 <1574856072-30972-3-git-send-email-ego@linux.vnet.ibm.com>
 <1575564547.si4rk0s96p.naveen@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1575564547.si4rk0s96p.naveen@linux.ibm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-02_09:2020-02-02,2020-02-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2002030037
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Naveen,

On Thu, Dec 05, 2019 at 10:23:58PM +0530, Naveen N. Rao wrote:
> >diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
> >index 80a676d..42ade55 100644
> >--- a/arch/powerpc/kernel/sysfs.c
> >+++ b/arch/powerpc/kernel/sysfs.c
> >@@ -1044,6 +1044,36 @@ static ssize_t show_physical_id(struct device *dev,
> > }
> > static DEVICE_ATTR(physical_id, 0444, show_physical_id, NULL);
> >
> >+static ssize_t idle_purr_show(struct device *dev,
> >+			      struct device_attribute *attr, char *buf)
> >+{
> >+	struct cpu *cpu = container_of(dev, struct cpu, dev);
> >+	unsigned int cpuid = cpu->dev.id;
> >+	struct lppaca *cpu_lppaca_ptr = paca_ptrs[cpuid]->lppaca_ptr;
> >+	u64 idle_purr_cycles = be64_to_cpu(cpu_lppaca_ptr->wait_state_cycles);
> >+
> >+	return sprintf(buf, "%llx\n", idle_purr_cycles);
> >+}
> >+static DEVICE_ATTR_RO(idle_purr);
> >+
> >+DECLARE_PER_CPU(u64, idle_spurr_cycles);
> >+static ssize_t idle_spurr_show(struct device *dev,
> >+			       struct device_attribute *attr, char *buf)
> >+{
> >+	struct cpu *cpu = container_of(dev, struct cpu, dev);
> >+	unsigned int cpuid = cpu->dev.id;
> >+	u64 *idle_spurr_cycles_ptr = per_cpu_ptr(&idle_spurr_cycles, cpuid);
> 
> Is it possible for a user to read stale values if a particular cpu is in an
> extended cede? Is it possible to use smp_call_function_single() to force the
> cpu out of idle?

Yes, if the CPU whose idle_spurr cycle is being read is still in idle,
then we will miss reporting the delta spurr cycles for this last
idle-duration. Yes, we can use an smp_call_function_single(), though
that will introduce IPI noise. How often will idle_[s]purr be read ?

> 
> - Naveen
>

--
Thanks and Regards
gautham.
