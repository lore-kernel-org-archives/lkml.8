Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 418B8C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 07:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 165D4206B5
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 07:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="upl0Pzk8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbgHKH7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 03:59:36 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:53622 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbgHKH7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 03:59:35 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07B7uYE0113987;
        Tue, 11 Aug 2020 07:59:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2020-01-29;
 bh=53EN8jKASnS7i1eXPDv4p2t1yWjIDbQVRwGz+VVRrIE=;
 b=upl0Pzk8ZJUdOITxSNUhtcfc3rXWAbR9iiKllxb1lxQXDWnEwvB/JGxoackkkpHd8Bk7
 HHLUTvn7hUFwN+hjsDzU/Q/cWhahMR0OLt79yyuYxoZShevBYEZ/whzgukWxyAc4HfXy
 63GTtT/yiLQO2obBDAs42iXtvUJBiya06JNJGl7EdCpkWxZ1WVCpuOXEo2SQ/8I9iVFC
 eLH46z5Vh0lqNOM2gLsXaHPu6+iG/byXSRE65DTI8l5P6PxhjKS2BTNiuJzFjq/uCoV9
 GZSoFVRHPGYJoZj0fTIglMcLgNxbPqLwn04c5j9ONL0IpeKftM628VEw+Pkchr/k7563 UA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 32smpnb04t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Aug 2020 07:59:21 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07B7rQw4114558;
        Tue, 11 Aug 2020 07:57:21 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 32u3h12k4j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Aug 2020 07:57:21 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07B7vBZb008189;
        Tue, 11 Aug 2020 07:57:11 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 11 Aug 2020 07:57:11 +0000
Date:   Tue, 11 Aug 2020 10:57:02 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Marion & Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     alexander.deucher@amd.com, christian.koenig@amd.com,
        airlied@linux.ie, daniel@ffwll.ch, sumit.semwal@linaro.org,
        colton.w.lewis@protonmail.com, Ori.Messinger@amd.com,
        m.szyprowski@samsung.com, bernard@vivo.com,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] drm: amdgpu: Use the correct size when allocating memory
Message-ID: <20200811075702.GE5493@kadam>
References: <20200809203406.751971-1-christophe.jaillet@wanadoo.fr>
 <20200810154213.GM1793@kadam>
 <8c414dd7-4a80-6ff2-03de-5340fb0d9c61@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8c414dd7-4a80-6ff2-03de-5340fb0d9c61@wanadoo.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9709 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008110049
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9709 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 impostorscore=0 phishscore=0 clxscore=1015 spamscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008110050
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 08:41:14PM +0200, Marion & Christophe JAILLET wrote:
> 
> Le 10/08/2020 à 17:42, Dan Carpenter a écrit :
> > On Sun, Aug 09, 2020 at 10:34:06PM +0200, Christophe JAILLET wrote:
> > > When '*sgt' is allocated, we must allocated 'sizeof(**sgt)' bytes instead
> > > of 'sizeof(*sg)'. 'sg' (i.e. struct scatterlist) is smaller than
> > > 'sgt' (i.e struct sg_table), so this could lead to memory corruption.
> > The sizeof(*sg) is bigger than sizeof(**sgt) so this wastes memory but
> > it won't lead to corruption.
> > 
> >      11  struct scatterlist {
> >      12          unsigned long   page_link;
> >      13          unsigned int    offset;
> >      14          unsigned int    length;
> >      15          dma_addr_t      dma_address;
> >      16  #ifdef CONFIG_NEED_SG_DMA_LENGTH
> >      17          unsigned int    dma_length;
> >      18  #endif
> >      19  };
> > 
> >      42  struct sg_table {
> >      43          struct scatterlist *sgl;        /* the list */
> >      44          unsigned int nents;             /* number of mapped entries */
> >      45          unsigned int orig_nents;        /* original size of list */
> >      46  };
> > 
> > regards,
> > dan carpenter
> 
> 
> My bad. I read 'struct scatterlist sgl' (without the *)
> Thanks for the follow-up, Dan.
> 
> Doesn't smatch catch such mismatch?
> (I've not run smatch for a while, so it is maybe reported)

That's why I was investigating it, because Smatch didn't catch it.

Smatch would have warned if it led to memory corruption.  Smatch also
tries to detect struct mismatches as a separate check but for some
reason it missed it.  I'm not totally sure why yet.  I suspect that it's
a complicated internal reason where Sparse is the sizeof to a normal
number...  It's a known issue and hard to fix.

> 
> Well, the proposal is still valid, even if it has less impact as initially
> thought.

Yep.

regards,
dan carpenter

