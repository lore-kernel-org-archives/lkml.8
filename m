Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1ADC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 21:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDDB6206F1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 21:04:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbgENVEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 17:04:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45260 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727122AbgENVEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 17:04:45 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04EL376s033207;
        Thu, 14 May 2020 17:04:41 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 310tjpks5t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 May 2020 17:04:40 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04EL3a7W035141;
        Thu, 14 May 2020 17:04:40 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 310tjpks4w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 May 2020 17:04:40 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04EL3Aui018301;
        Thu, 14 May 2020 21:04:39 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma03wdc.us.ibm.com with ESMTP id 3100ubhthv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 May 2020 21:04:38 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04EL4bSL28967186
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 May 2020 21:04:37 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0C71013604F;
        Thu, 14 May 2020 21:04:38 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AF9F4136051;
        Thu, 14 May 2020 21:04:35 +0000 (GMT)
Received: from oc3272150783.ibm.com (unknown [9.160.9.126])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Thu, 14 May 2020 21:04:35 +0000 (GMT)
Date:   Thu, 14 May 2020 16:04:25 -0500
From:   "Paul A. Clarke" <pc@us.ibm.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        acme@kernel.org, ananth@linux.vnet.ibm.com,
        maddy@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com,
        sukadev@linux.ibm.com, irogers@google.com
Subject: Re: [PATCH 2/2] perf: Add missing metrics to POWER9 'cpi_breakdown'
Message-ID: <20200514210425.GA3338@oc3272150783.ibm.com>
References: <1588868938-21933-1-git-send-email-pc@us.ibm.com>
 <1588868938-21933-3-git-send-email-pc@us.ibm.com>
 <87eerob5n4.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87eerob5n4.fsf@mpe.ellerman.id.au>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-14_07:2020-05-14,2020-05-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 spamscore=0 clxscore=1015
 suspectscore=0 phishscore=0 adultscore=0 priorityscore=1501
 cotscore=-2147483648 malwarescore=0 mlxscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005140184
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 06:28:31PM +1000, Michael Ellerman wrote:
> "Paul A. Clarke" <pc@us.ibm.com> writes:
> > Add the following metrics to the POWER9 'cpi_breakdown' metricgroup:
> > - ict_noslot_br_mpred_cpi
> > - ict_noslot_br_mpred_icmiss_cpi
> > - ict_noslot_cyc_other_cpi
> > - ict_noslot_disp_held_cpi
> > - ict_noslot_disp_held_hb_full_cpi
> > - ict_noslot_disp_held_issq_cpi
> > - ict_noslot_disp_held_other_cpi
> > - ict_noslot_disp_held_sync_cpi
> > - ict_noslot_disp_held_tbegin_cpi
> > - ict_noslot_ic_l2_cpi
> > - ict_noslot_ic_l3_cpi
> > - ict_noslot_ic_l3miss_cpi
> > - ict_noslot_ic_miss_cpi
> >
> > Signed-off-by: Paul A. Clarke <pc@us.ibm.com>
> > ---
> >  .../arch/powerpc/power9/metrics.json          | 143 ++++++++++--------
> >  1 file changed, 78 insertions(+), 65 deletions(-)
> >
> > diff --git a/tools/perf/pmu-events/arch/powerpc/power9/metrics.json b/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
> > index 811c2a8c1c9e..6169351a72c8 100644
> > --- a/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
> > +++ b/tools/perf/pmu-events/arch/powerpc/power9/metrics.json
> > @@ -207,6 +207,84 @@
> >          "MetricGroup": "cpi_breakdown",
> >          "MetricName": "fxu_stall_cpi"
> >      },
> > +    {
> > +        "BriefDescription": "Ict empty for this thread due to branch mispred",
> 
> I think you're just moving this, not adding it. But ICT is an acronym,
> so it should be spelled ICT not Ict.
> 
> It might be worth expanding it too?

This was 98% produced through automated means, translating an existing
XML file to perf's JSON format.

I've gotten the upstream XML file changed to include the "ICT" metrics
in the "cpi_breakdown" group already, and can request the changes you
suggest also be incorporated.

For the time being, can we move forward with the patch as-is?

PC
