Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E0E7C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 04:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 262DA20722
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 04:40:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="RrfIQ6xw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgCOEka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 00:40:30 -0400
Received: from mout.gmx.net ([212.227.17.21]:58303 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbgCOEk3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 00:40:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1584247228;
        bh=C8oAC+ephMsyHFHAO7X3i49cAhiXb0eeDtczwsGpuBY=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=RrfIQ6xwOlS8zSsQCOXADu/M5QbPSLZZlbmyyR4+vmOYxHWycy7o239Y6W6Oc/WUC
         DOhT7y11KDzgR0pwnooSX1ZpWDAd8a2oa6ONrZE+7x0hDseuA50Uiowzmiu3TLjGhN
         +6Sfzynh+bBOW0H9AaRmkOlgBWT+TmD0XNXuKZB4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ubuntu ([83.52.229.196]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MIMbU-1j7aRo3fVc-00EOx6; Sat, 14
 Mar 2020 16:06:25 +0100
Date:   Sat, 14 Mar 2020 16:06:13 +0100
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Malcolm Priestley <tvboxspy@gmail.com>, devel@driverdev.osuosl.org,
        Colin Ian King <colin.king@canonical.com>,
        Forest Bond <forest@alittletooquiet.net>,
        Gabriela Bittencourt <gabrielabittencourt00@gmail.com>,
        linux-kernel@vger.kernel.org, Oscar Carter <oscar.carter@gmx.com>
Subject: Re: [PATCH] staging: vt6656: Use BIT_ULL() macro instead of bit
 shift operation
Message-ID: <20200314150612.GA3153@ubuntu>
References: <20200307104929.7710-1-oscar.carter@gmx.com>
 <20200308065538.GF3983392@kroah.com>
 <20200308161047.GA3285@ubuntu>
 <561bc968-f88c-40e3-f53c-5c03f74f75ea@gmail.com>
 <20200310095011.GC2516963@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310095011.GC2516963@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:G+I101FTrb9L8V0q7JzFuevV31mO2bV7RWoMbDwOukp6UUeCKq9
 +tlYqu3jGMXEhMHEHIEsXsbz4IdRepEVTgZIvRVn9cpSusRzjJ78TveUhvQJBDdeWOoa4ig
 ToC3HrPK54JvPJ/AEIj+o1XYeNy7M2DtvAJMw0kLgZz1Gd96la3yOBsEARVrGE1DF7/36LJ
 I/aA6sB1JwFyTZq4kYyiA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:G4YWjPqouOA=:+IXRzJUuKnIGMgxyc1li3n
 GaRDptOweB1B58embF3bCQNQ2nvkAY6cqmwqCFtUh2JTfIgf8pdpAitl8xVe55JT7jb4yDiFn
 PCQ1Ml72wed+H8IA+QABLN0h71wGoBrVOizjy3+EUY+qWYeOhGFCYxYmExsBCTSc4aE/EzTkL
 6Y5SYxvh39OzNZhHEL2p6RKgzPXS9+2IiGwPjQauZ5Ch/97phu//uHwqr18VkOtt9A3HWCPX8
 43gIbRU5Re68IpTxnpV8rSSzFm6jBVA/MZLHaKyR88k8YMezbOVoS9RF0m41amQ2JM7XO8M1B
 7mjYpRE8b8qifWdmnTE7KpT1+VhYb0LU7TgXC2fIZC2Um+gXq0iYyjp4TmWGg+9/bNH0Zpv86
 WXa7e7byNyP/8IdxJL8WsxTT3viUc/iVkfBc6Y//vqdbGsmRW2j//AzIfTJnbE1CMUaQrRRGb
 PFTqRHJL+CTX2v/zlhxMtixD//fWrr+4a6VX8wgJ9gay1lvTvBdJfrmakzaICFiX3aZJCI+mf
 WqrR8kbD5ewwnrB4mK/BF4IvwDz6Tiu7Q1FBRax5S/q2TCvRk8LfcgJtgeuJIIiHQdYhd+kiq
 3zr70O0pq9I/jnecqvaW3+FE7GRiocLDKRwd7FbvhsNLWCPZKIUKzWRmP4oNkCucOTawI5U/N
 nPim6HuSjQCXxXEo28s9FlmN/mKrDKxPwhXM3MAqfcKtI6hwB4IYDcIwuw7+sdR4FDz4BPpAB
 vqJau9PUf9GTbXumrdEDSwByTNEco9h2Pn/p1wy5WVK58bO8qKkPx0h+1Vew4gxm9/r1Swnoj
 ucDgqvZzP4Qx0LlE/CplbqZ/xtl9cfxh7RLNKVkyxhcOrI7JjGnVt/Fxv43YAXJZc2HMZaUnV
 XCQpqJvWWbjWcV4Z57vXMrCPw5l4qOVWAZBmbqgeEJCKwR66l7e5nXJJ+BxUuXLG2YJUAoGt/
 X4pS3BTQcb3O3UVkuG6FEZpx8CzdcxfMbxeyOyW8Nwp4aiRXWodSeNQOvpM5OKDwct/qeR+CH
 t+4BTrJYCSzSW8QqByveXzk3mQ/CgpNqvYA2SKqlDnD6xlTbSTZESk1Y9r93/PVN/RGITwRtV
 0usW3ZLRWzuFjqKSTedg77to31bnFt3Wmpx+Gi8j7L1Z4FU4RnsIH45DKDHM6whrR1Vc2yLYV
 h9Lb52fY7jPO/AId4PTDgycJklZNsPSnemecYjIhD3UQ9qVV4XBCAH9vKip2NaBXoZLCfBxbV
 jw5GkXdQbMDHodC9u
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 10:50:11AM +0100, Greg Kroah-Hartman wrote:
> On Sun, Mar 08, 2020 at 07:22:07PM +0000, Malcolm Priestley wrote:
> > >>>   */
> > >>>  #undef __NO_VERSION__
> > >>>
> > >>> +#include <linux/bits.h>
> > >>>  #include <linux/etherdevice.h>
> > >>>  #include <linux/file.h>
> > >>>  #include "device.h"
> > >>> @@ -802,8 +803,7 @@ static u64 vnt_prepare_multicast(struct ieee80=
211_hw *hw,
> > >>>
> > >>>  	netdev_hw_addr_list_for_each(ha, mc_list) {
> > >>>  		bit_nr =3D ether_crc(ETH_ALEN, ha->addr) >> 26;
> > >>> -
> > >>> -		mc_filter |=3D 1ULL << (bit_nr & 0x3f);
> > >>> +		mc_filter |=3D BIT_ULL(bit_nr);
> > >>
> > >> Are you sure this does the same thing?  You are not masking off bit=
_nr
> > >> anymore, why not?
> > >
> > > My reasons are exposed below:
> > >
> > > The ether_crc function returns an u32 type (unsigned of 32 bits). Th=
en the right
> > > shift operand discards the 26 lsb bits (the bits shifted off the rig=
ht side are
> > > discarded). The 6 msb bits of the u32 returned by the ether_crc func=
tion are
> > > positioned in bit 5 to bit 0 of the variable bit_nr. Due to the righ=
t shift
> > > happens over an unsigned type, the 26 new bits added on the left sid=
e will be 0.
> > >
> > > In summary, after the right bit shift operation we obtain in the var=
iable bit_nr
> > > (unsigned of 32 bits) the value represented by the 6 msb bits of the=
 value
> > > returned by the ether_crc function. So, only the 6 lsb bits of the v=
ariable
> > > bit_nr are important. The 26 msb bits of this variable are 0.
> > >
> > > In this situation, the "and" operation with the mask 0x3f (mask of 6=
 lsb bits)
> > > is unnecessary due to its purpose is to reset (set to 0 value) the 2=
6 msb bits
> > > that are yet 0.
> >
> > The mask is only there out of legacy originally it was 31(0x1f) and th=
e
> > bit_nr spread across two mc_filter u32 arrays.
> >
> > The mask is not needed now it is u64.
> >
> > The patch is fine.
>
> Ok, then the changelog needs to be fixed up to explain all of this and
> resent.

Ok, I will create a new version patch with all of this information and I w=
ill
resend it.

>
> thanks,
>
> greg k-h

thanks,

Oscar
