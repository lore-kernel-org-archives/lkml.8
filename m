Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136DEC2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 14:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6DDB2078E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 14:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ThmeQBVE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbgDIOkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 10:40:16 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:44564 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727327AbgDIOkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 10:40:15 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 039EcF15058098;
        Thu, 9 Apr 2020 14:40:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=gIlObyBd/X6vtrruLSVOV91EVZH8HEpDqenNYw1Pv2s=;
 b=ThmeQBVEZA9YXGKybMhq5miGhOexi3IrV3yJJRDGq89msT8uA5OJJxW68UrrquA8sBWb
 mgxh547W2eQg6VjMGUGQ0+P3Cdu+J/6aCGWy7kt2aqi+0i7nO7z6RQtb3K9LgvaM2wgS
 fq1lgm/Q5Os56bZTINOtqvzno7lstZJ6p3af4JQ94PWb56VPU9f1Pa3aYnEIxLdQOfE2
 G0wUcOmiBOAQsrTf6so4NOo2zgr1A2Zu7dbk86++XCTG0WX3s8bM+J40WUIWU96/Q3ps
 +l8Lg4iiysyTcmoqY6B9302h91SVI0zXc+uO+ub8ed8tFHflWHsp35o8YQfLsrE0AVvT +A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 3091m3hw3n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Apr 2020 14:40:08 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 039EbbiO008064;
        Thu, 9 Apr 2020 14:38:08 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 3091m48k2u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Apr 2020 14:38:08 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 039Ec6an031611;
        Thu, 9 Apr 2020 14:38:06 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 09 Apr 2020 07:38:06 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [kbuild-all] Re: net/sunrpc/svcsock.c:527:32: warning: Variable
 'uninitialized_var' is assigned a value that is never used. [unreadVariable]
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <2342285b-3bb6-32cd-2611-264bc0773150@intel.com>
Date:   Thu, 9 Apr 2020 10:38:05 -0400
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <997058C9-4AAE-4B70-93E0-4CC6E3DE4FA0@oracle.com>
References: <202004090524.zHtJ3R2B%lkp@intel.com>
 <76A08BC7-C37A-495D-998A-2E9DADF454A7@oracle.com>
 <2342285b-3bb6-32cd-2611-264bc0773150@intel.com>
To:     Rong Chen <rong.a.chen@intel.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9586 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 spamscore=0 adultscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004090115
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9586 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1011 bulkscore=0 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004090115
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 8, 2020, at 11:04 PM, Rong Chen <rong.a.chen@intel.com> wrote:
>=20
>=20
>=20
> On 4/9/20 5:35 AM, Chuck Lever wrote:
>>=20
>>> On Apr 8, 2020, at 5:32 PM, kbuild test robot <lkp@intel.com> wrote:
>>>=20
>>> tree:   =
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git =
master
>>> head:   f5e94d10e4c468357019e5c28d48499f677b284f
>>> commit: da1661b93bf489cdbc8bcea919b165d31b4810bf SUNRPC: Teach =
server to use xprt_sock_sendmsg for socket sends
>>> date:   3 weeks ago
>>>=20
>>> If you fix the issue, kindly add following tag as appropriate
>>> Reported-by: kbuild test robot <lkp@intel.com>
>>>=20
>>>=20
>>> cppcheck warnings: (new ones prefixed by >>)
>>>=20
>>>   net/sunrpc/svcsock.c:405:9: warning: union member =
'Anonymous0::all' is never used. [unusedStructMember]
>>>     long  all[SVC_PKTINFO_SPACE / sizeof(long)];
>>>           ^
>>>   net/sunrpc/svcsock.c:518:9: warning: union member =
'Anonymous1::all' is never used. [unusedStructMember]
>>>     long  all[SVC_PKTINFO_SPACE / sizeof(long)];
>>>           ^
>>>>> net/sunrpc/svcsock.c:527:32: warning: Variable 'uninitialized_var' =
is assigned a value that is never used. [unreadVariable]
>>>    unsigned int uninitialized_var(sent);
>>>                                  ^
>>>=20
>>> vim +/uninitialized_var +527 net/sunrpc/svcsock.c
>>>=20
>>>   504=09
>>>   505	/**
>>>   506	 * svc_udp_sendto - Send out a reply on a UDP socket
>>>   507	 * @rqstp: completed svc_rqst
>>>   508	 *
>>>   509	 * Returns the number of bytes sent, or a negative =
errno.
>>>   510	 */
>>>   511	static int svc_udp_sendto(struct svc_rqst *rqstp)
>>>   512	{
>>>   513		struct svc_xprt *xprt =3D rqstp->rq_xprt;
>>>   514		struct svc_sock	*svsk =3D container_of(xprt, =
struct svc_sock, sk_xprt);
>>>   515		struct xdr_buf *xdr =3D &rqstp->rq_res;
>>>   516		union {
>>>   517			struct cmsghdr	hdr;
>>>   518			long		all[SVC_PKTINFO_SPACE / =
sizeof(long)];
>>>   519		} buffer;
>>>   520		struct cmsghdr *cmh =3D &buffer.hdr;
>>>   521		struct msghdr msg =3D {
>>>   522			.msg_name	=3D &rqstp->rq_addr,
>>>   523			.msg_namelen	=3D rqstp->rq_addrlen,
>>>   524			.msg_control	=3D cmh,
>>>   525			.msg_controllen	=3D sizeof(buffer),
>>>   526		};
>>>> 527		unsigned int uninitialized_var(sent);
>>>   528		int err;
>>>   529=09
>>>   530		svc_set_cmsg_data(rqstp, cmh);
>>>   531=09
>>>   532		err =3D xprt_sock_sendmsg(svsk->sk_sock, &msg, =
xdr, 0, 0, &sent);
>>>   533		xdr_free_bvec(xdr);
>>>   534		if (err =3D=3D -ECONNREFUSED) {
>>>   535			/* ICMP error on earlier request. */
>>>   536			err =3D xprt_sock_sendmsg(svsk->sk_sock, =
&msg, xdr, 0, 0, &sent);
>>>   537			xdr_free_bvec(xdr);
>>>   538		}
>>>   539		if (err < 0)
>>>   540			return err;
>>>   541		return sent;
>> Wha? "sent" is used right here. Can someone explain this warning?
>=20
> Hi Chuck,
>=20
> Sorry for the inconvenience, it should be a false warning,
> It's every odd that removing uninitialized_var can silence this =
warning.

Rong, thanks for your response! I will leave the code as-is, then.


> Best Regards,
> Rong Chen
>=20
>>=20
>>=20
>>>   542	}
>>>   543=09
>>>=20
>>> ---
>>> 0-DAY CI Kernel Test Service, Intel Corporation
>>> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>> --
>> Chuck Lever
>>=20
>>=20
>> _______________________________________________
>> kbuild-all mailing list -- kbuild-all@lists.01.org
>> To unsubscribe send an email to kbuild-all-leave@lists.01.org

--
Chuck Lever



