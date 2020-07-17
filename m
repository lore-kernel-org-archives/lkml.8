Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB74CC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 20:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8535320684
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 20:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BiXgkm8Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbgGQUi6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 16:38:58 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:56768 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbgGQUi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 16:38:57 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06HKXO8D151756;
        Fri, 17 Jul 2020 20:38:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=VLVPZEMJwQQ0WvBRzyPVCNtnIVB0qvXryFUj1Ha4Tno=;
 b=BiXgkm8QaDArg06s5nzI7L6kgCR5+25TC5KWESzfPx3PaDuvyyYtpFLGekW9bqJOuPul
 GhkQhPaX08zPXTN6b/3KqdPaH59xr/pPO8Snyg4Kx3EBr6qmpaiHUbe8Y9dlD50IFfBQ
 vNj0D5mwhQ0GslbO0OXJthpJ2XIYGznJ7SD1E0VRUP79QNMmyMekMELauk11SFTwwKSu
 T90ROJq90ClOvreZfTq3qLQ/Zunw10LnTp5eAPgBm5RHFXrzb9jjegI3gk298mSA7pqw
 k+C7q46wXGBony9uOIBM2yTyOFtsXxjzrGX5CXYqDRHKw9+hLF2wguuO9Yy2g4hgQ4Ku Wg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 3275cmscfk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 17 Jul 2020 20:38:49 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06HKc0Yh124545;
        Fri, 17 Jul 2020 20:38:48 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 32bj2d2mfa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jul 2020 20:38:48 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06HKciQV018816;
        Fri, 17 Jul 2020 20:38:44 GMT
Received: from localhost (/10.159.159.76)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 17 Jul 2020 13:38:44 -0700
Date:   Fri, 17 Jul 2020 13:38:42 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Dave Chinner <dchinner@redhat.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Allison Collins <allison.henderson@oracle.com>,
        Brian Foster <bfoster@redhat.com>
Subject: Re: arch/x86/include/asm/preempt.h:79:9: sparse: sparse: context
 imbalance in 'xfs_iflush_abort' - wrong count at exit
Message-ID: <20200717203842.GP7625@magnolia>
References: <202007131148.9IapVMiV%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202007131148.9IapVMiV%lkp@intel.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9685 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007170139
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9685 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 clxscore=1015 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007170138
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 11:03:53AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   11ba468877bb23f28956a35e896356252d63c983
> commit: 4165994ac9672d91134675caa6de3645a9ace6c8 xfs: factor common AIL item deletion code
> date:   4 months ago
> config: i386-randconfig-s001-20200713 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-14) 9.3.0
> reproduce:
>         # apt-get install sparse
>         # sparse version: v0.6.2-37-gc9676a3b-dirty
>         git checkout 4165994ac9672d91134675caa6de3645a9ace6c8
>         # save the attached .config to linux build tree
>         make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=i386 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> 
> sparse warnings: (new ones prefixed by >>)
> 
> >> arch/x86/include/asm/preempt.h:79:9: sparse: sparse: context imbalance in 'xfs_iflush_abort' - wrong count at exit

Um, does this still need attention?

--D

> vim +/xfs_iflush_abort +79 arch/x86/include/asm/preempt.h
> 
> c2daa3bed53a81 Peter Zijlstra    2013-08-14  72  
> c2daa3bed53a81 Peter Zijlstra    2013-08-14  73  /*
> c2daa3bed53a81 Peter Zijlstra    2013-08-14  74   * The various preempt_count add/sub methods
> c2daa3bed53a81 Peter Zijlstra    2013-08-14  75   */
> c2daa3bed53a81 Peter Zijlstra    2013-08-14  76  
> c2daa3bed53a81 Peter Zijlstra    2013-08-14  77  static __always_inline void __preempt_count_add(int val)
> c2daa3bed53a81 Peter Zijlstra    2013-08-14  78  {
> b3ca1c10d7b32f Christoph Lameter 2014-04-07 @79  	raw_cpu_add_4(__preempt_count, val);
> c2daa3bed53a81 Peter Zijlstra    2013-08-14  80  }
> c2daa3bed53a81 Peter Zijlstra    2013-08-14  81  
> 
> :::::: The code at line 79 was first introduced by commit
> :::::: b3ca1c10d7b32fdfdfaf5484eda486323f52d9be percpu: add raw_cpu_ops
> 
> :::::: TO: Christoph Lameter <cl@linux.com>
> :::::: CC: Linus Torvalds <torvalds@linux-foundation.org>
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


