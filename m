Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C545C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 344092080C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="o99keg9q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbgHJPot (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 11:44:49 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:51366 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgHJPos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 11:44:48 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07AFhXtJ153655;
        Mon, 10 Aug 2020 15:44:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=JvLiuuU3UgGUfrDifIj6lXvZMS7W5udsSPkBUIuvbkM=;
 b=o99keg9qf1qCDxOhoorD6MCLSCgG2oiYfCjODzVYEfkaELoMgwnwZ4iv8hQ9KEaneAda
 iiZsUsiNkXMJfMXxW+3gLZ2PW7raHV/Kq4Z/OpNKyBQH7DNsIOPntyB9k4UjdF00IIa+
 XBwbI6vHtVrPx2WuehFw/AG/dtsTgxnd+H+hjN5w6bXUes3s51e09EgqtC7Yl4MpRAKl
 eQrbhKPWAdiOe9r2eCsf8YkrrOsPemAZdBKucdRfYA5KUkBGCzPkVcV07irNbBwO5Ipb
 YsQG5z8AtbiO1F8Rl4JrhU9vkxqeJcuG/48hNkNhXFzjwZ0HcapCSuNxr7FW8iF/14xa fQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 32smpn79q6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 10 Aug 2020 15:44:35 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07AFJEiH003551;
        Mon, 10 Aug 2020 15:42:34 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 32t5y16wbq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Aug 2020 15:42:34 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07AFgNSI016391;
        Mon, 10 Aug 2020 15:42:23 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 10 Aug 2020 15:42:22 +0000
Date:   Mon, 10 Aug 2020 18:42:13 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     alexander.deucher@amd.com, christian.koenig@amd.com,
        airlied@linux.ie, daniel@ffwll.ch, sumit.semwal@linaro.org,
        colton.w.lewis@protonmail.com, Ori.Messinger@amd.com,
        m.szyprowski@samsung.com, bernard@vivo.com,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] drm: amdgpu: Use the correct size when allocating memory
Message-ID: <20200810154213.GM1793@kadam>
References: <20200809203406.751971-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200809203406.751971-1-christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9709 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008100115
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9709 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 impostorscore=0 phishscore=0 clxscore=1011 spamscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008100116
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 09, 2020 at 10:34:06PM +0200, Christophe JAILLET wrote:
> When '*sgt' is allocated, we must allocated 'sizeof(**sgt)' bytes instead
> of 'sizeof(*sg)'. 'sg' (i.e. struct scatterlist) is smaller than
> 'sgt' (i.e struct sg_table), so this could lead to memory corruption.

The sizeof(*sg) is bigger than sizeof(**sgt) so this wastes memory but
it won't lead to corruption.

    11  struct scatterlist {
    12          unsigned long   page_link;
    13          unsigned int    offset;
    14          unsigned int    length;
    15          dma_addr_t      dma_address;
    16  #ifdef CONFIG_NEED_SG_DMA_LENGTH
    17          unsigned int    dma_length;
    18  #endif
    19  };

    42  struct sg_table {
    43          struct scatterlist *sgl;        /* the list */
    44          unsigned int nents;             /* number of mapped entries */
    45          unsigned int orig_nents;        /* original size of list */
    46  };

regards,
dan carpenter

