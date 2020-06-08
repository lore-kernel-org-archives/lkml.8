Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A77C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 19:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C6B1206A4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 19:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FooZzvkr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgFHTQx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 15:16:53 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60564 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbgFHTQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 15:16:52 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 058J2uB3031588;
        Mon, 8 Jun 2020 19:16:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=jiswnTVgmED18kuC02a6ihAd3n7cwfYz+Q7lXljGX+c=;
 b=FooZzvkr0pazIcONzEcKFgnFQlZT0bu5XIEkJhJdEDBNYS9KABxR/1ySQVEYv5gkkfH9
 VjnBjlBwB+svIxIJ0CQubmhk1eD1pHJ9/+LaUyqutJ4jtdMAeVwdEL0UsD8KSWSTIAbH
 ZZnid8LNAYuOG9iMTKS5gSEfdiknCksCvPzZToYZoFhUCeP8vxz9Q1W2y9moWibCNZdx
 rUCyHpyApP6zieHLj3JQs3kPgks9zOvQM2tzXx4Yzw8UqVacU+5wHIvXU61GWTiv3DwN
 hawjnkU8TC4YdNLJTWxADwkRa/f7lDnjVxQZFpL1ZLX+HwaD89Tz4qCChsxLk38w2FFt Jg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 31g3smrfx3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 08 Jun 2020 19:16:44 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 058Ivcr6153482;
        Mon, 8 Jun 2020 19:16:44 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 31gn2vmfq5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Jun 2020 19:16:44 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 058JGgTK027691;
        Mon, 8 Jun 2020 19:16:42 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 08 Jun 2020 12:16:42 -0700
Date:   Mon, 8 Jun 2020 22:16:35 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Souptick Joarder <jrdr.linux@gmail.com>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        Bharath Vedartham <linux.bhar@gmail.com>,
        harshjain32@gmail.com, Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Simon =?iso-8859-1?Q?Sandstr=F6m?= <simon@nikanor.nu>,
        jane.pnx9@gmail.com
Subject: Re: [PATCH] staging: kpc2000: kpc_dma: Convert get_user_pages() -->
 pin_user_pages()
Message-ID: <20200608191635.GA30374@kadam>
References: <1590947491-11194-1-git-send-email-jrdr.linux@gmail.com>
 <7e725dd0-7423-b85b-ff56-9705419d13b9@nvidia.com>
 <CAFqt6zbsNcHWF-0Na2xMKdJQs2kVkLHTCw=cytvdo+z-axx97Q@mail.gmail.com>
 <5f0c68a0-2cc4-5724-d778-7e9d5fd7dfde@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f0c68a0-2cc4-5724-d778-7e9d5fd7dfde@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9646 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 bulkscore=0 adultscore=0 mlxlogscore=908 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006080135
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9646 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 cotscore=-2147483648 suspectscore=0
 spamscore=0 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0
 mlxlogscore=993 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006080135
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 08, 2020 at 12:05:57PM -0700, John Hubbard wrote:
> On 2020-06-08 12:01, Souptick Joarder wrote:
> > On Mon, Jun 1, 2020 at 7:15 AM John Hubbard <jhubbard@nvidia.com> wrote:
> > > 
> > > On 2020-05-31 10:51, Souptick Joarder wrote:
> > > > In 2019, we introduced pin_user_pages*() and now we are converting
> > > > get_user_pages*() to the new API as appropriate. [1] & [2] could
> > > > be referred for more information.
> > > > 
> > > > When pin_user_pages() returns numbers of partially mapped pages,
> > > > those pages were not unpinned as part of error handling. Fixed
> > > > it as part of this patch.
> > > > 
> > > 
> > > Hi Souptick,
> > > 
> > > btw, Bharath (+cc) attempted to do the "put" side of this, last year.
> > > That got as far as a v4 patch [1], and then I asked him to let me put
> > > it into my tree. But then it didn't directly apply anymore after the
> > > whole design moved to pin+unpin, and so here we are now.
> > > 
> > > 
> > > If Bharath is still doing kernel work, you might offer him a Co-Developed-by:
> > > tag (see https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html).
> > 
> > Sure, will add him as *Co-Developed-by*
> > > 
> 
> 
> Yes, but it's best to wait and see if he responds, before adding that tag, because
> it also required a Signed-off-by from him.

Souptick is porting patches from your tree?  It's not clear to me how
Bharath actually helped author this patch.

regards,
dan carpenter

