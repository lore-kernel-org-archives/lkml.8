Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85DDFC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6407D207E8
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:23:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="elyQXPFD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgESUXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 16:23:12 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:39712 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgESUXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 16:23:12 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04JKLjxR100506;
        Tue, 19 May 2020 20:22:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=qNNW5s1xeGm+K2As9XYYCmIIR1n/LTaTzzpAHOOw+OM=;
 b=elyQXPFD4nsB/VJn38aBWCqpaCIB6MQMHkKVGP1fLmJIRaO7WfkNspqYzxRIdKj1mo1W
 exW58AJu6Yz96MStBgD10iAvRwhmFECHXd+mHYU2ItwbCK3DLhTT/xFCPIE2ESWWyFoa
 CdkF17eIyWppQ4MS080TTxM7CbAX565LUgzOyfTTHHSpH9m7LCv6sZ8cU5632wyyFSuW
 2O0xftqaO0MnPzdhQkLmLhvD1D2elbcGZ8Kvv2QgP9RhPo8JqRnEgWWxXptpMi4zWa+t
 giKpNCyYEoe8QjuC7cd/w2aYFFdAgk4MLabOmivtaxxU/FnbCz8MlZf75ZLHIACv39LS sA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 31284kyngg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 May 2020 20:22:04 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04JKIOor097543;
        Tue, 19 May 2020 20:22:03 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 314gm5qmhr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 May 2020 20:22:02 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04JKM0LT031192;
        Tue, 19 May 2020 20:22:00 GMT
Received: from dhcp-10-154-188-23.vpn.oracle.com (/10.154.188.23)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 19 May 2020 13:21:59 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH v7 0/4] support reserving crashkernel above 4G on arm64
 kdump
From:   John Donnelly <john.p.donnelly@oracle.com>
In-Reply-To: <CAK8P3a2VrAqefPYF2JqRjwdhgTDtORUgWgVuYxRYWqKxE3+5pA@mail.gmail.com>
Date:   Tue, 19 May 2020 15:21:58 -0500
Cc:     Chen Zhou <chenzhou10@huawei.com>,
        Simon Horman <horms@verge.net.au>,
        Will Deacon <will@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        James Morse <james.morse@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Prabhakar Kushwaha <pkushwaha@marvell.com>,
        Dave Young <dyoung@redhat.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        John Donnelly <john.p.donnelly@oracle.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3D37F6BE-ECFC-4EC0-A7C4-341F85FC056E@oracle.com>
References: <20191223152349.180172-1-chenzhou10@huawei.com>
 <a57d46bc-881e-3526-91ca-558bf64e2aa8@huawei.com>
 <CAK8P3a2VrAqefPYF2JqRjwdhgTDtORUgWgVuYxRYWqKxE3+5pA@mail.gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
X-Mailer: Apple Mail (2.3445.9.1)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9626 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 phishscore=0 mlxscore=0 spamscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005190173
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9626 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 cotscore=-2147483648 impostorscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 spamscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005190174
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 19, 2020, at 5:21 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>=20
> On Thu, Mar 26, 2020 at 4:10 AM Chen Zhou <chenzhou10@huawei.com> =
wrote:
>>=20
>> Hi all,
>>=20
>> Friendly ping...
>=20
> I was asked about this patch series, and see that you last posted it =
in
> December. I think you should rebase it to linux-5.7-rc6 and post the
> entire series again to make progress, as it's unlikely that any =
maintainer
> would pick up the patches from last year.
>=20
> For the contents, everything seems reasonable to me, but I noticed =
that
> you are adding a property to the /chosen node without adding the
> corresponding documentation to
> Documentation/devicetree/bindings/chosen.txt
>=20
> Please add that, and Cc the devicetree maintainers on the updated
> patch.
>=20
>         Arnd
>=20
>> On 2019/12/23 23:23, Chen Zhou wrote:
>>> This patch series enable reserving crashkernel above 4G in arm64.
>>>=20
>>> There are following issues in arm64 kdump:
>>> 1. We use crashkernel=3DX to reserve crashkernel below 4G, which =
will fail
>>> when there is no enough low memory.
>>> 2. Currently, crashkernel=3DY@X can be used to reserve crashkernel =
above 4G,
>>> in this case, if swiotlb or DMA buffers are required, crash dump =
kernel
>>> will boot failure because there is no low memory available for =
allocation.
>>>=20
>>> The previous changes and discussions can be retrieved from:
>>>=20
>>> Changes since [v6]
>>> - Fix build errors reported by kbuild test robot.
> ...


 Hi=20

We found=20

https://lkml.org/lkml/2020/4/30/1583

Has cured our Out-Of-Memory kdump failures.=20

From	Henry Willard=20
Subject	[PATCH] mm: Limit boost_watermark on small zones.

I am currently not on linux-kernel@vger.kernel.org. dlist for all to see =
 this message so you may want to rebase and see if this cures your OoM =
issue and share the results.=20








