Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49EBFC33C99
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 03:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF9F52467E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 03:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="E6JYVX25"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731180AbgAJDuj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 22:50:39 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:59442 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731136AbgAJDui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 22:50:38 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00A3i4bp172345;
        Fri, 10 Jan 2020 03:50:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=hb+RMY33Xy+NtaD9xu3jQrdOQUcFpiM5I8zLdhDCgD4=;
 b=E6JYVX25p0gIs6+QjGwmiNGRJj8EfihqDHupJ/3reWPPdNFJzS2uewbJVC6wxmeBUim5
 5yGhQfNslpWYGYGcdefbGz6v/DTdibUmRmXJCrrzP7pz7OaoN4KDFH6bOD5b/2gemWoq
 6EsYvGLtRs3DbFjGiZGMWH4vtcRHTgSDnBjaSqlAkTlF5oBHzjlbs9ABb6fyQuD7G6in
 VuUzVpRXKr3voC/sh7c6SYbJvuRFR9TqmNKf569Vkg0aKMRO8mzpVqgxoRhM2pirsotP
 IlXYxFkBdxebE2Nc8O38ORb2ou8zPHPlV0nDc4UpMMoz0M5CatXN40awjQPKbwVADQVg iw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2xakbr7aev-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Jan 2020 03:50:07 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00A3iMkY012693;
        Fri, 10 Jan 2020 03:50:07 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2xdsa5t65a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Jan 2020 03:50:06 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00A3nxMv004191;
        Fri, 10 Jan 2020 03:50:00 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 09 Jan 2020 19:49:58 -0800
Date:   Fri, 10 Jan 2020 06:49:49 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Dave Airlie <airlied@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] drm/mgag200: Fix typo in parameter description
Message-ID: <20200110034949.GA1792@kadam>
References: <20200110012523.33053-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200110012523.33053-1-weiyongjun1@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9495 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001100030
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9495 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001100030
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 01:25:23AM +0000, Wei Yongjun wrote:
> Fix typo in parameter description.
> 

This commit message isn't totally clear.  Maybe say something like:

There was a typo in the MODULE_PARM_DESC().  It said that the module
parameter was "modeset" but it's actually the description for
"hw_bug_no_startadd".

> Fixes: 3cacb2086e41 ("drm/mgag200: Add module parameter to pin all buffers at offset 0")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

regards,
dan carpenter

