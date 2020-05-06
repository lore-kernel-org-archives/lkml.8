Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C01C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 13:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 223CA20575
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 13:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sbK+SD6i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbgEFNel (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 09:34:41 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52994 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728433AbgEFNel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 09:34:41 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 046DOF5i017154;
        Wed, 6 May 2020 13:33:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=OoJULZN15rzOzucK52XHUFVg05dE09LhRmH7FrhVAp4=;
 b=sbK+SD6iUgt4k5rx96GUYZ5Du5V4mGn/+XemfUJ2cxaI+K6RIyOM1bc30FkPv2GA8JRG
 /RehrMXukvoPDJDMADX/0Dt6pMlq9NXT3eAt4MFNTYIW6Zn/t1RzuR7FdnIUx/UKHD+P
 uzgBxOrHAdZrSjLQnXNyHFZK5DlRYAa3SYytqmm7UhJI/qR7HNnbHiIL0hq7TwDboQl7
 FrdioIMkpNyE+cih5Fmj1ILAu+qJsUHR7eCiednQwjjfb9lFJ+5g7Cx+Dg0ZCfZqKgj5
 K0coQ0vEn+8Mp1IK9X6CznCYYi99l4N8yrPzGoFOnorduNbS87q05BBkEExhyrEtEZ77 Dg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 30s09racp4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 May 2020 13:33:20 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 046DWdR5002679;
        Wed, 6 May 2020 13:33:19 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 30us7mpxb9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 May 2020 13:33:19 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 046DXECf018025;
        Wed, 6 May 2020 13:33:14 GMT
Received: from tomti.i.net-space.pl (/10.175.199.38)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 May 2020 06:33:13 -0700
Date:   Wed, 6 May 2020 15:33:06 +0200
From:   Daniel Kiper <daniel.kiper@oracle.com>
To:     Matthew Garrett <mjg59@google.com>
Cc:     The development of GNU GRUB <grub-devel@gnu.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        trenchboot-devel@googlegroups.com,
        the arch/x86 maintainers <x86@kernel.org>,
        alexander.burmashev@oracle.com,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Daniel P. Smith" <dpsmith@apertussolutions.com>,
        eric.snowberg@oracle.com,
        Javier Martinez Canillas <javierm@redhat.com>,
        kanth.ghatraju@oracle.com, konrad.wilk@oracle.com,
        krystian.hebel@3mdeb.com, lukasz.hawrylko@linux.intel.com,
        michal.zygowski@3mdeb.com,
        "Vladimir 'phcoder' Serbinenko" <phcoder@gmail.com>,
        pirot.krol@3mdeb.com, Peter Jones <pjones@redhat.com>,
        Ross Philipson <ross.philipson@oracle.com>
Subject: Re: [GRUB PATCH RFC 12/18] i386/efi: Report UEFI Secure Boot status
 to the Linux kernel
Message-ID: <20200506133306.xrzplgdt4cckgrqc@tomti.i.net-space.pl>
References: <20200504232132.23570-1-daniel.kiper@oracle.com>
 <20200504232132.23570-13-daniel.kiper@oracle.com>
 <CACdnJuszO1_aNXdgKt0_5XigC-AeuBT=gKkECszk7xX2p2TpkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACdnJuszO1_aNXdgKt0_5XigC-AeuBT=gKkECszk7xX2p2TpkA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9612 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005060107
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9612 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005060106
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 05, 2020 at 10:29:05AM -0700, Matthew Garrett wrote:
> On Mon, May 4, 2020 at 4:25 PM Daniel Kiper <daniel.kiper@oracle.com> wrote:
> >
> > Otherwise the kernel does not know its state and cannot enable various
> > security features depending on UEFI Secure Boot.
>
> I think this needs more context. If the kernel is loaded via the EFI
> boot stub, the kernel is aware of the UEFI secure boot state. Why
> duplicate this functionality in order to avoid the EFI stub?

It seems to me that this issue was discussed here [1] and here [2].
So, if you want me to improve the commit message I am OK with that.

Additionally, FYI I am not happy with that patch too. So, if somebody
has better idea how to do that then I am happy to discuss it here.

Daniel

[1] https://lkml.org/lkml/2020/3/25/982
[2] https://lkml.org/lkml/2020/3/26/985
