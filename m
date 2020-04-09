Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA41C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 03:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCFF420730
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 03:04:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgDIDEZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 23:04:25 -0400
Received: from mga01.intel.com ([192.55.52.88]:2898 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726523AbgDIDEY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 23:04:24 -0400
IronPort-SDR: 8fGZOQaZfkjSsyaBGX7Jtmsy4p6YDjR6oQBWvfMZTBH3RqGCBalUv+33U6hOEAVur6Zn0toml1
 ctLSMsSm7+ag==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2020 20:04:24 -0700
IronPort-SDR: vDxBV0AmCbLH8/faC998XO8FxwbfFq0sCtpWv9QL7v+DmQ75QXKmjn896vWB+xDwh2D9wWub/i
 hDw5A+U3Ffdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,361,1580803200"; 
   d="scan'208";a="297404358"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.3]) ([10.239.13.3])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Apr 2020 20:04:23 -0700
Subject: Re: [kbuild-all] Re: net/sunrpc/svcsock.c:527:32: warning: Variable
 'uninitialized_var' is assigned a value that is never used. [unreadVariable]
To:     Chuck Lever <chuck.lever@oracle.com>,
        kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
References: <202004090524.zHtJ3R2B%lkp@intel.com>
 <76A08BC7-C37A-495D-998A-2E9DADF454A7@oracle.com>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <2342285b-3bb6-32cd-2611-264bc0773150@intel.com>
Date:   Thu, 9 Apr 2020 11:04:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <76A08BC7-C37A-495D-998A-2E9DADF454A7@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/9/20 5:35 AM, Chuck Lever wrote:
>
>> On Apr 8, 2020, at 5:32 PM, kbuild test robot <lkp@intel.com> wrote:
>>
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   f5e94d10e4c468357019e5c28d48499f677b284f
>> commit: da1661b93bf489cdbc8bcea919b165d31b4810bf SUNRPC: Teach server to use xprt_sock_sendmsg for socket sends
>> date:   3 weeks ago
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kbuild test robot <lkp@intel.com>
>>
>>
>> cppcheck warnings: (new ones prefixed by >>)
>>
>>    net/sunrpc/svcsock.c:405:9: warning: union member 'Anonymous0::all' is never used. [unusedStructMember]
>>      long  all[SVC_PKTINFO_SPACE / sizeof(long)];
>>            ^
>>    net/sunrpc/svcsock.c:518:9: warning: union member 'Anonymous1::all' is never used. [unusedStructMember]
>>      long  all[SVC_PKTINFO_SPACE / sizeof(long)];
>>            ^
>>>> net/sunrpc/svcsock.c:527:32: warning: Variable 'uninitialized_var' is assigned a value that is never used. [unreadVariable]
>>     unsigned int uninitialized_var(sent);
>>                                   ^
>>
>> vim +/uninitialized_var +527 net/sunrpc/svcsock.c
>>
>>    504	
>>    505	/**
>>    506	 * svc_udp_sendto - Send out a reply on a UDP socket
>>    507	 * @rqstp: completed svc_rqst
>>    508	 *
>>    509	 * Returns the number of bytes sent, or a negative errno.
>>    510	 */
>>    511	static int svc_udp_sendto(struct svc_rqst *rqstp)
>>    512	{
>>    513		struct svc_xprt *xprt = rqstp->rq_xprt;
>>    514		struct svc_sock	*svsk = container_of(xprt, struct svc_sock, sk_xprt);
>>    515		struct xdr_buf *xdr = &rqstp->rq_res;
>>    516		union {
>>    517			struct cmsghdr	hdr;
>>    518			long		all[SVC_PKTINFO_SPACE / sizeof(long)];
>>    519		} buffer;
>>    520		struct cmsghdr *cmh = &buffer.hdr;
>>    521		struct msghdr msg = {
>>    522			.msg_name	= &rqstp->rq_addr,
>>    523			.msg_namelen	= rqstp->rq_addrlen,
>>    524			.msg_control	= cmh,
>>    525			.msg_controllen	= sizeof(buffer),
>>    526		};
>>> 527		unsigned int uninitialized_var(sent);
>>    528		int err;
>>    529	
>>    530		svc_set_cmsg_data(rqstp, cmh);
>>    531	
>>    532		err = xprt_sock_sendmsg(svsk->sk_sock, &msg, xdr, 0, 0, &sent);
>>    533		xdr_free_bvec(xdr);
>>    534		if (err == -ECONNREFUSED) {
>>    535			/* ICMP error on earlier request. */
>>    536			err = xprt_sock_sendmsg(svsk->sk_sock, &msg, xdr, 0, 0, &sent);
>>    537			xdr_free_bvec(xdr);
>>    538		}
>>    539		if (err < 0)
>>    540			return err;
>>    541		return sent;
> Wha? "sent" is used right here. Can someone explain this warning?

Hi Chuck,

Sorry for the inconvenience, it should be a false warning,
It's every odd that removing uninitialized_var can silence this warning.

Best Regards,
Rong Chen

>
>
>>    542	}
>>    543	
>>
>> ---
>> 0-DAY CI Kernel Test Service, Intel Corporation
>> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> --
> Chuck Lever
>
>
> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org

