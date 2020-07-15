Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A97FFC433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 889F92065D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="c5VIn3Mt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729324AbgGOIiL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 04:38:11 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:54604 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729066AbgGOIiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 04:38:10 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06F8W7kg147701;
        Wed, 15 Jul 2020 08:37:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=0oIcIHic/n+18h7D2ez3Bk061rU2Mlnb/HJIfCwCVqU=;
 b=c5VIn3MtRNPOEhDMfEao95+zv9V3kIYxMcRBq6EDrPNQzGsumpbNqdjgju1O/oCBpdMx
 8Ku3ZlFWL64vWQcTS2hobf2++tYJaP0ccPSC3FekTWvdYu5eFk7LMEiy42Pi7A9fxfIF
 +VpJDL/B+ImOoY6MAUA5jbPgRY3acGVp/NdbWDsOck2eRZdwTf8KKo7ggfxBIcqAIQgj
 A6igT30WtACoCgBCsX2LrucRHqxrGxuOmMCN1V8F9cAmn74V4QVmfGxZ1WV5br2gZUWN
 VcaEVTneH1nDxhaCdKh+8OUcbEIUxKXUKKf3NA50CAaGGhdnDl0iIC9IlxubYeO78C6F 8Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 3274ura2kv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 15 Jul 2020 08:37:56 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06F8XeDp042497;
        Wed, 15 Jul 2020 08:37:56 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 327q6tytyk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jul 2020 08:37:56 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06F8bt7d017390;
        Wed, 15 Jul 2020 08:37:55 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 15 Jul 2020 01:37:54 -0700
Date:   Wed, 15 Jul 2020 11:37:27 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Joe Perches <joe@perches.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Zhixu Zhao <zhixu001@126.com>,
        rcy@google.com, rspringer@google.com, toddpoynor@google.com
Subject: Re: [PATCH v2] staging: gasket: core: Fix a coding style issue in
 gasket_core.c
Message-ID: <20200715083727.GY2549@kadam>
References: <20200617161127.32006-1-zhixu001@126.com>
 <20200714234440.27009-1-zhixu001@126.com>
 <20200715071748.GC2305231@kroah.com>
 <23ef3ca9616418b702df891443d0f4864edd58ff.camel@perches.com>
 <20200715075755.GA2516028@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715075755.GA2516028@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9682 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007150072
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9682 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 impostorscore=0
 suspectscore=0 phishscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007150072
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 09:57:55AM +0200, Greg KH wrote:
> On Wed, Jul 15, 2020 at 12:24:22AM -0700, Joe Perches wrote:
> > On Wed, 2020-07-15 at 09:17 +0200, Greg KH wrote:
> > > On Wed, Jul 15, 2020 at 07:44:40AM +0800, Zhixu Zhao wrote:
> > > > On Thu, Jun 18, 2020 at 12:11:27AM +0800, Zhixu Zhao wrote:
> > > > > A coding alignment issue is found by checkpatch.pl.
> > > > > Fix it by using a temporary for gasket_dev->bar_data[bar_num].
> > > > > 
> > > > > Signed-off-by: Zhixu Zhao <zhixu001@126.com>
> > > > 
> > > > Hi, there~
> > > > 
> > > > Does anybody have any further comments on this?
> > > > Can it be merged?
> > > 
> > > I never saw the first version of this, are you sure it got sent to the
> > > mailing list?  It's not in any archives anywhere.
> > 
> > I saw it.  It's here:
> > https://lore.kernel.org/lkml/20200617161127.32006-1-zhixu001@126.com/
> 
> Ah, doh, sorry.
> 
> Zhixu, please address the comments given to you on the series and resend
> it as a new version.

He responded but not as a reply to my email.  It turns out I made a
mistake.

Anyway, just resend, Zhixu.

regards,
dan carpenter

