Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF4C5C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 07:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0898204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 07:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="xmyrcOxJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729653AbgHYHiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 03:38:07 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33750 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729372AbgHYHiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 03:38:02 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07P7ZDei193236;
        Tue, 25 Aug 2020 07:37:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=yea0Yzl3MVzS3ZMBBvStQCGwcTQrcrJmt40gbGzaQqs=;
 b=xmyrcOxJ55uSTkrT2XY5Q6jz0vgx3Kafs7gcoo1BU9/9rDwAmDZZymkPdUjouttDJLjj
 b3K8ZiBHfplQCw7feE80XBl5OnCgg/9TadTp9hl190N6uEw6CX6EaB4P+LqCJz4UDZj3
 WjLDR89Ntj7Zbfj40zWPJAizdNtiT2VHKx5BkzIdA1/YwoI7zAyroC3VP64sk8ytHakD
 x8OkhjlNr7Lo9z2IYGna7SC16jgHe1rvjCX/6PapSYrmh5sqmxfvPtm+i8JdnIC4Ho7i
 HBwzhjO1oovICRyINsQ1MZjowb0idHCUqlbWfdC/2Q1qMg0pydX7QEwg2Seiyx7RWYip xg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 333w6tq9nw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Aug 2020 07:37:40 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07P7alMC082370;
        Tue, 25 Aug 2020 07:37:40 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 333r9jj73h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Aug 2020 07:37:40 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07P7bRfL023102;
        Tue, 25 Aug 2020 07:37:28 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 25 Aug 2020 00:37:27 -0700
Date:   Tue, 25 Aug 2020 10:37:13 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Alex Dewar <alex.dewar90@gmail.com>
Cc:     devel@driverdev.osuosl.org,
        Saiyam Doshi <saiyamdoshi.in@gmail.com>,
        Magnus Damm <damm+renesas@opensource.se>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        YueHaibing <yuehaibing@huawei.com>, linux-kernel@vger.kernel.org,
        "Javier F. Arias" <jarias.linux@gmail.com>,
        "Frank A. Cancio Bello" <frank@generalsoftwareinc.com>,
        Simon Horman <horms+renesas@verge.net.au>
Subject: Re: [PATCH] staging: emxx_udc: Fix passing of NULL to
 dma_alloc_coherent()
Message-ID: <20200825073713.GR1793@kadam>
References: <20200824142118.GA223827@mwanda>
 <20200824151920.251446-1-alex.dewar90@gmail.com>
 <20200824155712.4kgxwqiufm2ieboz@medion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824155712.4kgxwqiufm2ieboz@medion>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9723 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=2
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008250057
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9723 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 mlxlogscore=999 suspectscore=2 phishscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 clxscore=1011 mlxscore=0 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008250057
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 24, 2020 at 04:57:12PM +0100, Alex Dewar wrote:
> On Mon, Aug 24, 2020 at 04:19:17PM +0100, Alex Dewar wrote:
> > In nbu2ss_eq_queue() memory is allocated with dma_alloc_coherent(),
> > though, strangely, NULL is passed as the struct device* argument. Pass
> > the UDC's device instead.

I think passing NULL was always wrong, but it used to not cause an Oops.
This was changed a year or two ago.

> > 
> > Build-tested on x86 only.
> > 
> > Fixes: 33aa8d45a4fe ("staging: emxx_udc: Add Emma Mobile USB Gadget driver")
> > Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
> > ---
> > 
> > So I *think* this is the right fix, but I don't have the hardware so
> > I've only been able to build-test it. My worry is that I could be
> > passing in the wrong struct device* here, which would squelch the
> > warning without fixing the breakage.
> > 
> > Can someone cleverer than me tell me if this makes sense?
> > 
> > - Alex
> 
> PS -- I meant to put an RFC in the subject line and an extra tag:
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> 

I don't know which dev pointer we're supposed to pass...  It would be
good to find someone to test the patch but if not then applying your
patch is reasonable.

But could you search through the file and update the rest as well.
The dma_free_coherent() needs to be updated and there was a second
dma_alloc_coherent() in the bug report.

regards,
dan carpenter

