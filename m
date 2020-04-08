Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 445ADC2D0F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 21:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EC9A206C0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 21:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730643AbgDHVc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 17:32:58 -0400
Received: from mga14.intel.com ([192.55.52.115]:53315 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728005AbgDHVc5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 17:32:57 -0400
IronPort-SDR: cYgaulDCEzTlSFdPYfF+BzxtH07s0N1DEMmXZhiSWDvkoREAQjiCjW7k+4bUv1lt9e9XsR4ehO
 r/GdmJs7dcBg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2020 14:32:57 -0700
IronPort-SDR: rPJeEQSTt1IXwAY/+awhaq7JpNVAyxgFC0lrHf837df6wJfzaot3QGx3f/JLKI4s9lrjziBilM
 jNBiy0xvpuCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,359,1580803200"; 
   d="scan'208";a="451752119"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 08 Apr 2020 14:32:56 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jMIJb-000G0D-Vq; Thu, 09 Apr 2020 05:32:55 +0800
Date:   Thu, 9 Apr 2020 05:32:34 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: net/sunrpc/svcsock.c:527:32: warning: Variable 'uninitialized_var'
 is assigned a value that is never used. [unreadVariable]
Message-ID: <202004090524.zHtJ3R2B%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f5e94d10e4c468357019e5c28d48499f677b284f
commit: da1661b93bf489cdbc8bcea919b165d31b4810bf SUNRPC: Teach server to use xprt_sock_sendmsg for socket sends
date:   3 weeks ago

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>


cppcheck warnings: (new ones prefixed by >>)

   net/sunrpc/svcsock.c:405:9: warning: union member 'Anonymous0::all' is never used. [unusedStructMember]
     long  all[SVC_PKTINFO_SPACE / sizeof(long)];
           ^
   net/sunrpc/svcsock.c:518:9: warning: union member 'Anonymous1::all' is never used. [unusedStructMember]
     long  all[SVC_PKTINFO_SPACE / sizeof(long)];
           ^
>> net/sunrpc/svcsock.c:527:32: warning: Variable 'uninitialized_var' is assigned a value that is never used. [unreadVariable]
    unsigned int uninitialized_var(sent);
                                  ^

vim +/uninitialized_var +527 net/sunrpc/svcsock.c

   504	
   505	/**
   506	 * svc_udp_sendto - Send out a reply on a UDP socket
   507	 * @rqstp: completed svc_rqst
   508	 *
   509	 * Returns the number of bytes sent, or a negative errno.
   510	 */
   511	static int svc_udp_sendto(struct svc_rqst *rqstp)
   512	{
   513		struct svc_xprt *xprt = rqstp->rq_xprt;
   514		struct svc_sock	*svsk = container_of(xprt, struct svc_sock, sk_xprt);
   515		struct xdr_buf *xdr = &rqstp->rq_res;
   516		union {
   517			struct cmsghdr	hdr;
   518			long		all[SVC_PKTINFO_SPACE / sizeof(long)];
   519		} buffer;
   520		struct cmsghdr *cmh = &buffer.hdr;
   521		struct msghdr msg = {
   522			.msg_name	= &rqstp->rq_addr,
   523			.msg_namelen	= rqstp->rq_addrlen,
   524			.msg_control	= cmh,
   525			.msg_controllen	= sizeof(buffer),
   526		};
 > 527		unsigned int uninitialized_var(sent);
   528		int err;
   529	
   530		svc_set_cmsg_data(rqstp, cmh);
   531	
   532		err = xprt_sock_sendmsg(svsk->sk_sock, &msg, xdr, 0, 0, &sent);
   533		xdr_free_bvec(xdr);
   534		if (err == -ECONNREFUSED) {
   535			/* ICMP error on earlier request. */
   536			err = xprt_sock_sendmsg(svsk->sk_sock, &msg, xdr, 0, 0, &sent);
   537			xdr_free_bvec(xdr);
   538		}
   539		if (err < 0)
   540			return err;
   541		return sent;
   542	}
   543	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
