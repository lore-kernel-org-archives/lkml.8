Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A15C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 14:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80E7E2067B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 14:18:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fGmwpg13"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgFLOSF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 10:18:05 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:54280 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbgFLOSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 10:18:04 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05CEGVHu072690;
        Fri, 12 Jun 2020 14:18:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=FLO2dmSYnd+8KwMbQIvAENHAq6wW4XjxXYdHK1Ch854=;
 b=fGmwpg13pPmieOAX/2wjjkE3cxHST4RkEfRZUF3LtLDDasAbO4DsmthjyLg6UokIc+dD
 ba9hqZ6m2TQVFcs5igpHjApjRCoXFSSvz7RNBXn9gGtw4bxunZLDvKZTszlLKMxXPs8P
 r/gYzJSU8putOgo9B3IQJdLEAGWIm4OMec/sekDTbJE7lg8iqXMf2ZamLQkUYx4KMt5B
 Zd3K3VBpH6gkwoqTjLFd6O+814l1YDTUeuB4d6rmlYYGIwLX0oEYbgCuRwn35MCdsi0R
 gsUKwV2JUN5FBRRohMk1st8hz89JYYSKSZ0f2xlDv8nX5iy8by6a55ZoIG1Th2e9GqSQ tQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 31g3snd4uu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 12 Jun 2020 14:18:01 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05CEHfel002650;
        Fri, 12 Jun 2020 14:18:01 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 31mb9mg0ms-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jun 2020 14:18:01 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 05CE7xG0006062;
        Fri, 12 Jun 2020 14:07:59 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 12 Jun 2020 07:07:59 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.14\))
Subject: Re: net/sunrpc/svcsock.c:226:5: warning:
 "ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE" is not defined
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <202006121445.hPwlQgTl%lkp@intel.com>
Date:   Fri, 12 Jun 2020 10:07:58 -0400
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <AC2CCF35-1313-464A-B20F-AC3424692C31@oracle.com>
References: <202006121445.hPwlQgTl%lkp@intel.com>
To:     kernel test robot <lkp@intel.com>
X-Mailer: Apple Mail (2.3445.104.14)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9649 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006120107
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9649 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 cotscore=-2147483648 suspectscore=0
 spamscore=0 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006120106
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello-

> On Jun 12, 2020, at 2:31 AM, kernel test robot <lkp@intel.com> wrote:
>=20
> Hi Chuck,
>=20
> FYI, the error/warning still remains.
>=20
> tree:   =
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git =
master
> head:   b791d1bdf9212d944d749a5c7ff6febdba241771
> commit: ca07eda33e01eafa7a26ec06974f7eacee6a89c8 SUNRPC: Refactor =
svc_recvfrom()
> date:   3 weeks ago
> config: i386-randconfig-r016-20200612 (attached as .config)
> compiler: gcc-6 (Debian 6.3.0-18+deb9u1) 6.3.0 20170516
> reproduce (this is a W=3D1 build):
>        git checkout ca07eda33e01eafa7a26ec06974f7eacee6a89c8
>        # save the attached .config to linux build tree
>        make W=3D1 ARCH=3Di386=20
>=20
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>=20
> All warnings (new ones prefixed by >>, old ones prefixed by <<):
>=20
>>> net/sunrpc/svcsock.c:226:5: warning: =
"ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE" is not defined [-Wundef]
> #if ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE
> ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

IIUC this is a problem with the headers for the i386 architecture.
That macro is defined for most others:

[cel@klimt linux]$ git grep ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE
arch/alpha/include/asm/cacheflush.h:#define =
ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 0
arch/arc/include/asm/cacheflush.h:#define =
ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
arch/arm/include/asm/cacheflush.h:#define =
ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
arch/arm64/include/asm/cacheflush.h:#define =
ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
arch/c6x/include/asm/cacheflush.h:#define =
ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 0
arch/csky/abiv1/inc/abi/cacheflush.h:#define =
ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
arch/csky/abiv2/inc/abi/cacheflush.h:#define =
ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
arch/hexagon/include/asm/cacheflush.h:#define =
ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 0
arch/ia64/include/asm/cacheflush.h:#define =
ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
arch/m68k/include/asm/cacheflush_mm.h:#define =
ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
arch/m68k/include/asm/cacheflush_no.h:#define =
ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 0
arch/microblaze/include/asm/cacheflush.h:#define =
ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
arch/mips/include/asm/cacheflush.h:#define =
ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
arch/nds32/include/asm/cacheflush.h:#define =
ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
arch/nios2/include/asm/cacheflush.h:#define =
ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
arch/openrisc/include/asm/cacheflush.h:#define =
ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
arch/parisc/include/asm/cacheflush.h:#define =
ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
arch/powerpc/include/asm/cacheflush.h:#define =
ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
arch/riscv/include/asm/cacheflush.h:#define =
ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 0
arch/sh/include/asm/cacheflush.h:#define =
ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
arch/sparc/include/asm/cacheflush_32.h:#define =
ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
arch/sparc/include/asm/cacheflush_64.h:#define =
ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
arch/unicore32/include/asm/cacheflush.h:#define =
ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
arch/xtensa/include/asm/cacheflush.h:#define =
ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
arch/xtensa/include/asm/cacheflush.h:#define =
ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 0
block/blk-core.c:#if ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE
include/asm-generic/cacheflush.h:#define =
ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 0
include/crypto/scatterwalk.h:           /* Test =
ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE first as
include/crypto/scatterwalk.h:           if =
(ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE && !PageSlab(page))
include/linux/blkdev.h:#ifndef ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE
include/linux/blkdev.h:# error  "You should define =
ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE for your platform"
include/linux/blkdev.h:#if ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE
net/packet/af_packet.c:#if ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE =3D=3D 1
net/packet/af_packet.c:#if ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE =3D=3D 1
net/packet/af_packet.c:#if ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE =3D=3D 1
net/sunrpc/svcsock.c:#if ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE
net/sunrpc/xprtsock.c:#if ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE
[cel@klimt linux]$

Please let me know how to proceed.


> vim +/ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE +226 net/sunrpc/svcsock.c
>=20
>   225=09
>> 226	#if ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE
>   227	static void svc_flush_bvec(const struct bio_vec *bvec, size_t =
size, size_t seek)
>   228	{
>   229		struct bvec_iter bi =3D {
>   230			.bi_size	=3D size,
>   231		};
>   232		struct bio_vec bv;
>   233=09
>   234		bvec_iter_advance(bvec, &bi, seek & PAGE_MASK);
>   235		for_each_bvec(bv, bvec, bi, bi)
>   236			flush_dcache_page(bv.bv_page);
>   237	}
>   238	#else
>   239	static inline void svc_flush_bvec(const struct bio_vec *bvec, =
size_t size,
>   240					  size_t seek)
>   241	{
>   242	}
>   243	#endif
>   244=09
>=20
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> <.config.gz>

--
Chuck Lever



