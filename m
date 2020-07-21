Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A26C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 14:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DDE820578
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 14:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729460AbgGUOz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 10:55:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20730 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726710AbgGUOz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 10:55:57 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06LEfeZj106832;
        Tue, 21 Jul 2020 10:55:27 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32e1vr13rx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Jul 2020 10:55:27 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06LEfkL7107709;
        Tue, 21 Jul 2020 10:55:27 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32e1vr13rq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Jul 2020 10:55:27 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06LEkCtx003867;
        Tue, 21 Jul 2020 14:55:26 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma03dal.us.ibm.com with ESMTP id 32brq9ax36-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Jul 2020 14:55:26 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06LEtNow26214852
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jul 2020 14:55:23 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F3646C605D;
        Tue, 21 Jul 2020 14:55:24 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9A6C9C6057;
        Tue, 21 Jul 2020 14:55:24 +0000 (GMT)
Received: from sofia.ibm.com (unknown [9.79.221.206])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 21 Jul 2020 14:55:24 +0000 (GMT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
        id BE5002E3C48; Tue, 21 Jul 2020 20:25:19 +0530 (IST)
Date:   Tue, 21 Jul 2020 20:25:19 +0530
From:   Gautham R Shenoy <ego@linux.vnet.ibm.com>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     benh@kernel.crashing.org, ego@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        mikey@neuling.org, mpe@ellerman.id.au, paulus@samba.org,
        pratik.r.sampat@gmail.com, Pratik Sampat <psampat@linux.ibm.com>,
        svaidy@linux.ibm.com
Subject: Re: [PATCH v3 2/3] powerpc/powernv/idle: Rename
 pnv_first_spr_loss_level variable
Message-ID: <20200721145519.GA26845@in.ibm.com>
Reply-To: ego@linux.vnet.ibm.com
References: <20200717185306.60607-1-psampat@linux.ibm.com>
 <20200717185306.60607-3-psampat@linux.ibm.com>
 <1595202681.bt4670u7q7.astroid@bobo.none>
 <81dcf34e-870d-b3a1-7876-a6a2f0b37d1f@linux.ibm.com>
 <1595341835.8ad8mjl9hm.astroid@bobo.none>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595341835.8ad8mjl9hm.astroid@bobo.none>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-21_09:2020-07-21,2020-07-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007210106
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jul 22, 2020 at 12:37:41AM +1000, Nicholas Piggin wrote:
> Excerpts from Pratik Sampat's message of July 21, 2020 8:29 pm:
> > 
> > 
> > On 20/07/20 5:27 am, Nicholas Piggin wrote:
> >> Excerpts from Pratik Rajesh Sampat's message of July 18, 2020 4:53 am:
> >>> Replace the variable name from using "pnv_first_spr_loss_level" to
> >>> "pnv_first_fullstate_loss_level".
> >>>
> >>> As pnv_first_spr_loss_level is supposed to be the earliest state that
> >>> has OPAL_PM_LOSE_FULL_CONTEXT set, however as shallow states too loose
> >>> SPR values, render an incorrect terminology.
> >> It also doesn't lose "full" state at this loss level though. From the
> >> architecture it could be called "hv state loss level", but in POWER10
> >> even that is not strictly true.
> >>
> > Right. Just discovered that deep stop states won't loose full state
> > P10 onwards.
> > Would it better if we rename it as "pnv_all_spr_loss_state" instead
> > so that it stays generic enough while being semantically coherent?
> 
> It doesn't lose all SPRs. It does physically, but for Linux it appears 
> at least timebase SPRs are retained and that's mostly how it's 
> documented.
> 
> Maybe there's no really good name for it, but we do call it "deep" stop 
> in other places, you could call it deep_spr_loss maybe. I don't mind too 
> much though, whatever Gautham is happy with.

Nick's suggestion is fine by me. We can call it deep_spr_loss_state.

> 
> Thanks,
> Nick

--
Thanks and Regards
gautham.
