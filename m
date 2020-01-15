Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A1BC33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 04:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E22F7222C3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 04:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KnF0+PVn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbgAOE1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 23:27:13 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:42788 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728882AbgAOE1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 23:27:12 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00F4NGYK022687;
        Wed, 15 Jan 2020 04:26:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=MuixGUpf9tJQLi8Di1I6NZorE+teX0wGz5msomgVjUs=;
 b=KnF0+PVnx5EwNkbIaX2JflUyHPYMAjZVsCi5qrsvIBGGe2IThtrS+8c93wknQfkISkkd
 B/9UngUyLU4scWlE1TKeTAEsViqtVh3PQQMQo1cdQY1ny731umNzveEl3tRkBjI1R7Ut
 694mlLwctGaGSsJg+8jzKFQPoSjxljfbP/QvvrdaFg6FbV1OEvXfvR2ZnELmxEjnVeGx
 zKXCKXcmAmH+EvJdzpWODoAGqXC374Pw8t27LgInflE0l0z/OOkwuXwtoXiavkwyA7a2
 VwK9T4KpZzFKxejGMZKtlVx5+p/OSAKfx9tkQuWvjfdzmyk4j5RklzLw+eHsw7BpIBJe Zg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2xf73yj0gh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jan 2020 04:26:53 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00F4OBDY110914;
        Wed, 15 Jan 2020 04:24:52 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2xh315edqa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jan 2020 04:24:52 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00F4OoFj023206;
        Wed, 15 Jan 2020 04:24:50 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 14 Jan 2020 20:24:50 -0800
Date:   Wed, 15 Jan 2020 07:25:07 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Colin Ian King <colin.king@canonical.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/microcode/amd: fix uninitalized structure cp
Message-ID: <20200115042507.GE3719@kadam>
References: <20200114111505.320186-1-colin.king@canonical.com>
 <20200114113834.GE31032@zn.tnic>
 <b59bb156-891e-3a26-3204-f5a0a1cc60d3@canonical.com>
 <20200114120156.GG31032@zn.tnic>
 <54eca4f8-33ca-24b1-9123-70df3b164043@canonical.com>
 <20200114121000.GH31032@zn.tnic>
 <fcbb34b0-203e-0c7c-66cc-a3ae6fa3680c@canonical.com>
 <20200114150153.GJ31032@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200114150153.GJ31032@zn.tnic>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9500 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=871
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001150035
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9500 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=931 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001150035
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 04:01:53PM +0100, Borislav Petkov wrote:
> On Tue, Jan 14, 2020 at 02:08:50PM +0000, Colin Ian King wrote:
> > If I understand the question, it seems that get_builtin_microcode()
> > tries to load in the appropriate amd microcode binary from the cpio data
> > and this can potentially fail if the microcode is not provided for the
> > specific processor family, so I believe this is a legitimate fix.
> 
> If the microcode for the specific processor family is not provided,
> get_builtin_firmware() will return false and then we'll call
> find_microcode_in_initrd() which will definitely return either a proper
> pointer or a NULL-initialized cpio_data struct.
> 
> So I still don't see it.

It's probably complaining that cp.name[] isn't initialized.  UBSan will
probably generate a warning at runtime when we do:

	*ret = cp;

But otherwise it's harmless.

regards,
dan carpenter
