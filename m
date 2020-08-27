Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FAF6C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 02:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03B982075B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 02:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Env49Aaq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgH0CGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 22:06:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11078 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726784AbgH0CGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 22:06:49 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07R22Mik108985;
        Wed, 26 Aug 2020 22:06:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=BOPCPy33GxY8VeRsFHwbZ447KUNVbNwOFiiOis+yQ1w=;
 b=Env49AaqoaOHJRIEqm73ec6n4iU59pTPFkoxu//v1JWrWAUGthIvTS2joFDOn53LdfzV
 49MzlTqywtupsV5jr6Ve+jSZnyUfQIJv5BRKVERxBFWTl9ADaBA3vA54L5WsT7VQZ6Y2
 Q4AvJp0qAk5Zp5OzwUNN2dWDIYPl9CIg6Q1XpAQ+hFdN+mEINjQsXHtqJc6HC6dvNLWK
 lI3MnQPGhEHkivBmapwkGuz5LVPLrQWeQkkhqd1dAV6Hr1MGnClN+PQl6d9kneI+sicd
 lFolnOWCmExFZFSkdBYkW40dWiad4kSGKbizMDQkBOfp1PnXPk5AJzbC37zKSx8mBRw8 Uw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3361fqbcra-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Aug 2020 22:06:47 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07R22NHW109139;
        Wed, 26 Aug 2020 22:06:47 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3361fqbcr5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Aug 2020 22:06:47 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07R21dcl008319;
        Thu, 27 Aug 2020 02:06:46 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma04dal.us.ibm.com with ESMTP id 332ujrg0f9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Aug 2020 02:06:46 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07R26gFl64028990
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Aug 2020 02:06:42 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DC6F8136053;
        Thu, 27 Aug 2020 02:06:44 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6EDCC136051;
        Thu, 27 Aug 2020 02:06:43 +0000 (GMT)
Received: from li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com (unknown [9.160.126.224])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Thu, 27 Aug 2020 02:06:43 +0000 (GMT)
Date:   Wed, 26 Aug 2020 21:06:40 -0500
From:   "Paul A. Clarke" <pc@us.ibm.com>
To:     Ian Rogers <irogers@google.com>
Cc:     kajoljain <kjain@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, maddy@linux.ibm.com,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] perf stat: update POWER9 metrics to utilize other metrics
Message-ID: <20200827020640.GA48404@li-24c3614c-2adc-11b2-a85c-85f334518bdb.ibm.com>
References: <20200813222155.268183-1-pc@us.ibm.com>
 <CAP-5=fU4P7o1TwVz+PzcrJsBKnrHW4yrNx3R165i9d3BwgP2RQ@mail.gmail.com>
 <cfa27e83-ac2c-7495-b453-ceeaf2412311@linux.ibm.com>
 <20200814124307.GF13995@kernel.org>
 <CAP-5=fWw-W3wfy_WeirM_jbEmsbQCC8L_AGo2zsMvv2MW1x04A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fWw-W3wfy_WeirM_jbEmsbQCC8L_AGo2zsMvv2MW1x04A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-26_14:2020-08-26,2020-08-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 impostorscore=0 bulkscore=0
 phishscore=0 adultscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008270011
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 09:26:40AM -0700, Ian Rogers wrote:
> On Fri, Aug 14, 2020 at 5:43 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> > Em Fri, Aug 14, 2020 at 11:20:42AM +0530, kajoljain escreveu:
> > > On 8/14/20 9:13 AM, Ian Rogers wrote:
> > > > On Thu, Aug 13, 2020 at 3:21 PM Paul A. Clarke <pc@us.ibm.com> wrote:
> > > >> These changes take advantage of the new capability added in
> > > >> merge commit 00e4db51259a5f936fec1424b884f029479d3981
> > > >> "Allow using computed metrics in calculating other metrics".
> > > >>
> > > >> The net is a simplification of the expressions for a handful
> > > >> of metrics, but no functional change.
> > > >>
> > > >> Signed-off-by: Paul A. Clarke <pc@us.ibm.com>
> > >
> > >   The patch looks good to me.
> > >
> > > Reviewed-by: Kajol Jain<kjain@linux.ibm.com>
> >
> > Thanks, applied. Added Ian's Acked-by as well.
> 
> I've synced perf and testing on a remote machine (not easy for me to
> log into) I see failures in perf test "10.3: Parsing of PMU event
> table metrics" like:
> ...
> parsing metric: dfu_stall_cpi - dflong_stall_cpi
> Parse event failed metric 'dfu_other_stall_cpi' id 'dflong_stall_cpi'
> expr 'dfu_stall_cpi - dflong_stall_cpi'
> Error string 'parser error' help '(null)'
> Parse event failed metric 'dfu_other_stall_cpi' id 'dfu_stall_cpi'
> expr 'dfu_stall_cpi - dflong_stall_cpi'
> Error string 'parser error' help '(null)'
> ...
> 
> This may be that the test doesn't handle the metric in terms of metric
> addition and so I'll look for a fix. I thought I'd send a heads up in
> case you had already seen/addressed this. Is perf test on PowerPC
> clean for you at the moment?

I see these errors as well (on 5.9-rc2).  Each error seems to be for the
newer metrics that take advantage of the newer functionality, including
the metrics I changed recently, and Kajol's 24x7 and nest metrics.

Thanks for the heads up!  I confess I had not seen the errors only because
I wasn't looking.  :-/

PC
