Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C550C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 18:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB82B206A2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 18:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="r4tSOSiV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbgFBS4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 14:56:43 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56666 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbgFBS4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 14:56:42 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 052Im6fp051721;
        Tue, 2 Jun 2020 18:56:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=cXPrppqHkISNja9HBBAo1BlILsN/hj+lR9AXtTE7Oqg=;
 b=r4tSOSiVMkAr27VpbEFsxdwU0zDXaaAlwtJmlrb5MFmhCaQLiP8j7sjCey8GkSZJk8FP
 i7EYa02Fp54yAunSzoeeDKr34Q0R36DetpIeEcTWv/e0mkt4AUGIP3OjmjmRBAHkhcGg
 gzPZcgzprojEeDtiL+umetqDLWt09r+gdUVM9lutwtc9zPDWqgEQGr93jMSRQpcZXm5w
 vj2lTB87ucqtdIdcGvuuyl0EDM6m/7IoWsAOnZqdhSGIxV7a7SxP5+nMX1izytj2mEQS
 dLlGO8AKsJpAt6OJ0t2aVmLn2080na2Q6LCyXgxKqgUsEyH7EyrF6Q8C7v5acev7STWe ow== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 31dkrujp4v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 02 Jun 2020 18:56:35 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 052InGW0040278;
        Tue, 2 Jun 2020 18:56:35 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 31c1dxr5bj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Jun 2020 18:56:35 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 052IuXGL007999;
        Tue, 2 Jun 2020 18:56:34 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 02 Jun 2020 11:56:33 -0700
Date:   Tue, 2 Jun 2020 21:56:26 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Pascal Terjan <pterjan@google.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>
Subject: Re: [PATCH] staging: rtl8712: switch to common ieee80211 headers
Message-ID: <20200602185626.GJ30374@kadam>
References: <20200601202410.124593-1-pterjan@google.com>
 <e668fc72-9103-70cd-e545-095e88c53dcf@lwfinger.net>
 <CAANdO=KBPh81Jaxhta8k3ipnwWbr5xdhTuRW6GNEZsTTpyMjXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAANdO=KBPh81Jaxhta8k3ipnwWbr5xdhTuRW6GNEZsTTpyMjXQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9640 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006020136
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9640 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 priorityscore=1501
 mlxscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 clxscore=1011
 adultscore=0 mlxlogscore=999 cotscore=-2147483648 phishscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006020136
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 02, 2020 at 04:58:46PM +0100, Pascal Terjan wrote:
> On Tue, 2 Jun 2020 at 15:57, Larry Finger <Larry.Finger@lwfinger.net> wrote:
> >
> > On 6/1/20 3:24 PM, Pascal Terjan wrote:
> > > This patch switches to <linux/ieee80211.h> and <net/cfg80211.h> and
> > > deletes a lot of duplicate definitions plus many unused ones.
> > >
> > > Non obvious changes:
> > > - struct ieee80211_ht_cap is different enough that I preferred to keep
> > >    (and rename) it for now.
> > > - mcs_rate in translate_scan was not read after being set, so I deleted
> > >    that part rather than using the renamed struct
> > > - WLAN_CAPABILITY_BSS is replaced with WLAN_CAPABILITY_ESS which is the
> > >    corresponding one with same value
> > >
> > > Signed-off-by: Pascal Terjan <pterjan@google.com>
> >
> > This patch does not apply to the staging repo, current mainline, or
> > wireless-drivers-next. Where did you intend it to go? Staging is the correct tree.
> 
> It was against staging-testing as there is a (trivial) merge conflict
> in there with https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/commit/?h=staging-testing&id=2aaeaaff1ae21b2817256435c7fc0095eeda61ae
> which is also in staging-next
> What is the best practice in such case?

It has to apply against staging-next so that's fine.

> 
> Thanks to kbuild test robot I found that it is failing to build there
> because I forgot to add a dependency on CFG80211 in Kconfig, so I will
> need to send a v2.

Yup.

regards,
dan carpenter

