Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A76CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 08:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D94320659
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 08:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XqCGXaCF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgFEI6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 04:58:40 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:46768 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbgFEI6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 04:58:40 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0558uYfN010639;
        Fri, 5 Jun 2020 08:58:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=jhhoHlbMVTvrxxWURRJM87CrhANr1Lb8nHbTGVwVaxI=;
 b=XqCGXaCF8duhkFI7qPClQvI2vt834JKCKgH8wP4BmMSrIoOLCeESxLORTjmm+6U6qw+T
 f6PfOh8W9agf6S/DPAnUD0NkwHNN7UCo+c86cQ/XKo930ymRAnafyjbf5XrWJVfz5D45
 kvqZoj5Rz5zaHZyt0U69J8Hy71PPbsy5vl88uqWTJY7WMT/bS2raF9AZ0u1NieYSZyme
 CLYBPFH/aDAj2uqgQwMoRpRTtc4cHOQ+pJX+e5i4ar4gj9i8TGEV0N64bLQKdamDneTT
 rjIXDPfnfDtiLG+0831AbFKirCLdfdh3N7NqbWJwRiLl2LoiP8BpJK6w84YkNnsQX/a0 hQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 31f91dswcr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 05 Jun 2020 08:58:11 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0558wAKY158400;
        Fri, 5 Jun 2020 08:58:10 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 31f926x4c8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Jun 2020 08:58:10 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0558w1Cd032161;
        Fri, 5 Jun 2020 08:58:01 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 05 Jun 2020 01:58:01 -0700
Date:   Fri, 5 Jun 2020 11:57:51 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
Cc:     "kbuild@lists.01.org" <kbuild@lists.01.org>,
        "hch@lst.de" <hch@lst.de>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "lkp@intel.com" <lkp@intel.com>, Dan Carpenter <error27@gmail.com>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH 1/3] dma-direct: provide the ability to reserve per-numa
 CMA
Message-ID: <20200605085751.GQ30374@kadam>
References: <20200603024231.61748-2-song.bao.hua@hisilicon.com>
 <20200604113631.GP30374@kadam>
 <B926444035E5E2439431908E3842AFD24E0011@DGGEMI525-MBS.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B926444035E5E2439431908E3842AFD24E0011@DGGEMI525-MBS.china.huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9642 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006050070
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9642 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 cotscore=-2147483648 malwarescore=0 adultscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 spamscore=0 mlxscore=0
 impostorscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006050070
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 05, 2020 at 06:04:31AM +0000, Song Bao Hua (Barry Song) wrote:
> 
> 
> > -----Original Message-----
> > From: Dan Carpenter [mailto:dan.carpenter@oracle.com]
> > Sent: Thursday, June 4, 2020 11:37 PM
> > To: kbuild@lists.01.org; Song Bao Hua (Barry Song)
> > <song.bao.hua@hisilicon.com>; hch@lst.de; m.szyprowski@samsung.com;
> > robin.murphy@arm.com; catalin.marinas@arm.com
> > Cc: lkp@intel.com; Dan Carpenter <error27@gmail.com>;
> > kbuild-all@lists.01.org; iommu@lists.linux-foundation.org;
> > linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Linuxarm
> > <linuxarm@huawei.com>; Jonathan Cameron
> > <jonathan.cameron@huawei.com>; John Garry <john.garry@huawei.com>
> > Subject: Re: [PATCH 1/3] dma-direct: provide the ability to reserve per-numa
> > CMA
> > 
> > Hi Barry,
> > 
> > url:
> > https://github.com/0day-ci/linux/commits/Barry-Song/support-per-numa-CM
> > A-for-ARM-server/20200603-104821
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
> > for-next/core
> > config: x86_64-randconfig-m001-20200603 (attached as .config)
> > compiler: gcc-9 (Debian 9.3.0-13) 9.3.0
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> Dan, thanks! Good catch!
> as this patch has not been in mainline yet, is it correct to add these "reported-by" in patch v2?

These are just an automated email from the zero day bot.  I look over
the Smatch warnings and then forward them on.

regards,
dan carpenter

