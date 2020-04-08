Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E49BC2BA2B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 21:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43A36206C0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 21:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kU38jp13"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729283AbgDHVgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 17:36:04 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:38314 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728104AbgDHVgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 17:36:03 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 038LYJud112156;
        Wed, 8 Apr 2020 21:36:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=X44Ebp5uRbRTRUewZMMs2SgPjRTQVEdbIdoNLajs77g=;
 b=kU38jp13L8GzIEnK5kon0DbUuh34s6S6NdligRDxZGA4qeI7kbWZKXI6Csthhk19BvXq
 1nNoPQOQOwzuKQdzhJgbdsSmiC4wpleJFuhAni6mnm/ViBSEuldg+YxV8Rzr4bySmsEC
 BAL5o9XG/hxhEXqQiuUhK60hNiKBprSZWIMb9TviP9WJU+DOskXyPciNkl3MFwByxqOp
 ag8yMznoVaJhPbHy4hjtb+XWyt7ybwnZVaf0SAxLXpVQZHHLPImv6mHSfibIGCql8IfA
 ZokNbez+r5t3kjKZfdDmDESUbj5CxM6yjPe4JAncn/ElFt5LobFQv6Vkp1lpdQqzTD0l XA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 3091m3e3mj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Apr 2020 21:36:00 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 038LXNus008593;
        Wed, 8 Apr 2020 21:35:59 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 3091m24r8g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Apr 2020 21:35:59 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 038LZw0o031821;
        Wed, 8 Apr 2020 21:35:58 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 08 Apr 2020 14:35:58 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: net/sunrpc/svcsock.c:527:32: warning: Variable
 'uninitialized_var' is assigned a value that is never used. [unreadVariable]
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <202004090524.zHtJ3R2B%lkp@intel.com>
Date:   Wed, 8 Apr 2020 17:35:56 -0400
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <76A08BC7-C37A-495D-998A-2E9DADF454A7@oracle.com>
References: <202004090524.zHtJ3R2B%lkp@intel.com>
To:     kbuild test robot <lkp@intel.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9585 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 spamscore=0 adultscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004080147
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9585 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1011 bulkscore=0 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004080147
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 8, 2020, at 5:32 PM, kbuild test robot <lkp@intel.com> wrote:
>=20
> tree:   =
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git =
master
> head:   f5e94d10e4c468357019e5c28d48499f677b284f
> commit: da1661b93bf489cdbc8bcea919b165d31b4810bf SUNRPC: Teach server =
to use xprt_sock_sendmsg for socket sends
> date:   3 weeks ago
>=20
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kbuild test robot <lkp@intel.com>
>=20
>=20
> cppcheck warnings: (new ones prefixed by >>)
>=20
>   net/sunrpc/svcsock.c:405:9: warning: union member 'Anonymous0::all' =
is never used. [unusedStructMember]
>     long  all[SVC_PKTINFO_SPACE / sizeof(long)];
>           ^
>   net/sunrpc/svcsock.c:518:9: warning: union member 'Anonymous1::all' =
is never used. [unusedStructMember]
>     long  all[SVC_PKTINFO_SPACE / sizeof(long)];
>           ^
>>> net/sunrpc/svcsock.c:527:32: warning: Variable 'uninitialized_var' =
is assigned a value that is never used. [unreadVariable]
>    unsigned int uninitialized_var(sent);
>                                  ^
>=20
> vim +/uninitialized_var +527 net/sunrpc/svcsock.c
>=20
>   504=09
>   505	/**
>   506	 * svc_udp_sendto - Send out a reply on a UDP socket
>   507	 * @rqstp: completed svc_rqst
>   508	 *
>   509	 * Returns the number of bytes sent, or a negative errno.
>   510	 */
>   511	static int svc_udp_sendto(struct svc_rqst *rqstp)
>   512	{
>   513		struct svc_xprt *xprt =3D rqstp->rq_xprt;
>   514		struct svc_sock	*svsk =3D container_of(xprt, struct =
svc_sock, sk_xprt);
>   515		struct xdr_buf *xdr =3D &rqstp->rq_res;
>   516		union {
>   517			struct cmsghdr	hdr;
>   518			long		all[SVC_PKTINFO_SPACE / =
sizeof(long)];
>   519		} buffer;
>   520		struct cmsghdr *cmh =3D &buffer.hdr;
>   521		struct msghdr msg =3D {
>   522			.msg_name	=3D &rqstp->rq_addr,
>   523			.msg_namelen	=3D rqstp->rq_addrlen,
>   524			.msg_control	=3D cmh,
>   525			.msg_controllen	=3D sizeof(buffer),
>   526		};
>> 527		unsigned int uninitialized_var(sent);
>   528		int err;
>   529=09
>   530		svc_set_cmsg_data(rqstp, cmh);
>   531=09
>   532		err =3D xprt_sock_sendmsg(svsk->sk_sock, &msg, xdr, 0, =
0, &sent);
>   533		xdr_free_bvec(xdr);
>   534		if (err =3D=3D -ECONNREFUSED) {
>   535			/* ICMP error on earlier request. */
>   536			err =3D xprt_sock_sendmsg(svsk->sk_sock, &msg, =
xdr, 0, 0, &sent);
>   537			xdr_free_bvec(xdr);
>   538		}
>   539		if (err < 0)
>   540			return err;
>   541		return sent;

Wha? "sent" is used right here. Can someone explain this warning?


>   542	}
>   543=09
>=20
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--
Chuck Lever



