Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE45C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 07:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB490205CB
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 07:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PB4EO8Je"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbgE2Hpd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 03:45:33 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56974 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgE2Hpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 03:45:32 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04T7gOJk052517;
        Fri, 29 May 2020 07:45:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=/zyDyVC68d9YZ6KEmiarS9O/AvAUU4/O8BpkManDjZc=;
 b=PB4EO8JeymwCk49nnqmL6gJudVGRM82/M5nb4G1VwWeLcn06D9J+kWZStry9uaGUIuf+
 0OooNg6aZA+U21zq6b1TzqMv8l5zCm6K/WFbBw09SJ5SBaGMYXP2KCBMLjqawYlKjCft
 X57W3hfIyc4Po0qHTEaa04qicTSIy33HBUaLjeA4qAz2MmKW4jvhlclf4nTs7KZm76Dv
 Ld0uBL+bFWfVlaZzBynCjcBOd/gwIz0YpqdowD+c/sTT/gStii8MM1rDacmCYUH2JvU4
 AKwR3EB5orS/9bgQBfXOA6fkoNRtlQxN5+lGYXJ7IlkUes0PsTz/s3Vi6IHp4bCcfhQB xA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 318xbk8y1x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 29 May 2020 07:45:25 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04T7d85x051707;
        Fri, 29 May 2020 07:45:24 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 317ddu2mxj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 May 2020 07:45:24 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04T7jNAM022993;
        Fri, 29 May 2020 07:45:23 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 29 May 2020 00:45:23 -0700
Date:   Fri, 29 May 2020 10:45:16 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Souptick Joarder <jrdr.linux@gmail.com>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Rob Springer <rspringer@google.com>,
        Todd Poynor <toddpoynor@google.com>
Subject: Re: [PATCH] staging: gasket: Convert get_user_pages*() -->
 pin_user_pages*()
Message-ID: <20200529074516.GL30374@kadam>
References: <1590613362-27495-1-git-send-email-jrdr.linux@gmail.com>
 <20200528110408.GJ30374@kadam>
 <CAFqt6zaKWBQTy9XfvxwVAvzGS+gz9Qv1gL8Bv1VxLq+THYf+Aw@mail.gmail.com>
 <CAFqt6zbtg0NWbAnDGPC0ZddEiTeohz=8JN+S_KxqM0bnnvar3g@mail.gmail.com>
 <52f75ec4-a2a0-f979-a3b9-ef016b88907c@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52f75ec4-a2a0-f979-a3b9-ef016b88907c@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9635 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 phishscore=0 adultscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005290060
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9635 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 cotscore=-2147483648
 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005290060
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 12:38:20AM -0700, John Hubbard wrote:
> On 2020-05-28 23:27, Souptick Joarder wrote:
> > On Fri, May 29, 2020 at 11:46 AM Souptick Joarder <jrdr.linux@gmail.com> wrote:
> > > 
> > > On Thu, May 28, 2020 at 4:34 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > > > 
> > > > On Thu, May 28, 2020 at 02:32:42AM +0530, Souptick Joarder wrote:
> > > > > This code was using get_user_pages_fast(), in a "Case 2" scenario
> > > > > (DMA/RDMA), using the categorization from [1]. That means that it's
> > > > > time to convert the get_user_pages_fast() + put_page() calls to
> > > > > pin_user_pages_fast() + unpin_user_page() calls.
> > > > 
> > > > You are saying that the page is used for DIO and not DMA, but it sure
> > > > looks to me like it is used for DMA.
> > > 
> > > No, I was referring to "Case 2" scenario in change log which means  it is
> > > used for DMA, not DIO.
> 
> Hi,
> 
> Dan, I also uncertain as to how you read this as referring to DIO. Case 2 is
> DMA or RDMA, and in fact the proposed commit log says both of those things:
> Case 2 and DMA/RDMA. I don't see "DIO" anywhere here...

I thought he meant that the original code was appropriate for DMA and he
was fixing it.  :P

regards,
dan carpenter

