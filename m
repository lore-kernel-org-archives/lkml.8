Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5227C35249
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 03:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A27BF2082E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 03:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EhvNNw5Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbgBEDjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 22:39:17 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:39210 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727714AbgBEDjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 22:39:17 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0153XEmn025027;
        Wed, 5 Feb 2020 03:37:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=OmuUUofIK0R0rgxFdw+4ekLdvylBjN4LllylBkz949I=;
 b=EhvNNw5ZARed2+zcw6mKcoyEMrZUZlSpPwcYhgfmbpUZ8B3xXQJDu9IbnoNAqHLss66b
 pEkMz14APiuRedU68g2oTsXhQpVhYPoX2p5DxopeJkAhOk4deljqXb4LSooZFa2aZGx6
 0+lQSaWgmQRi8AlvlCAoFtO/O13VwfHsZhcQAw4y4qHM67C2xxms7E/18/iek7+EBXQv
 FytsjohSKp/V3aiJ/iLG7EQX8IgoaKdwLVIA0QvQi/enFGd/8B/we9pfUY7mcOXEZTv1
 yU4LmCn2B2h75cXaYQDvxAbWwbCP/jLQ3XWVnMQleChAiIxaMXrsiGhAk/fDq5C+xHND Ow== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2xykbp0fdj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Feb 2020 03:37:39 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0153YXb6052959;
        Wed, 5 Feb 2020 03:37:38 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2xykc3p6fe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Feb 2020 03:37:38 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0153b4hH002038;
        Wed, 5 Feb 2020 03:37:09 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 04 Feb 2020 19:37:03 -0800
Date:   Wed, 5 Feb 2020 06:34:16 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "brandonbonaby94@gmail.com" <brandonbonaby94@gmail.com>,
        "julia.lawall@lip6.fr" <julia.lawall@lip6.fr>,
        "yuehaibing@huawei.com" <yuehaibing@huawei.com>,
        "paulburton@kernel.org" <paulburton@kernel.org>,
        "aaro.koskinen@iki.fi" <aaro.koskinen@iki.fi>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "fw@strlen.de" <fw@strlen.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ddaney@caviumnetworks.com" <ddaney@caviumnetworks.com>,
        "bobdc9664@seznam.cz" <bobdc9664@seznam.cz>,
        "sandro@volery.com" <sandro@volery.com>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "ivalery111@gmail.com" <ivalery111@gmail.com>,
        "ynezz@true.cz" <ynezz@true.cz>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "wambui.karugax@gmail.com" <wambui.karugax@gmail.com>
Subject: Re: [PATCH 1/2] staging: octeon: delete driver
Message-ID: <20200205033416.GT1778@kadam>
References: <20191210091509.3546251-1-gregkh@linuxfoundation.org>
 <6f934497-0635-7aa0-e7d5-ed2c4cc48d2d@roeck-us.net>
 <da150cdb160b5d1b58ad1ea2674cc93c1fc6aadc.camel@alliedtelesis.co.nz>
 <20200204070927.GA966981@kroah.com>
 <1a90dc4c62c482ed6a44de70962996b533d6f627.camel@alliedtelesis.co.nz>
 <20200204203116.GN8731@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200204203116.GN8731@bombadil.infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9521 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002050027
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9521 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002050027
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 04, 2020 at 12:31:16PM -0800, Matthew Wilcox wrote:
> On Tue, Feb 04, 2020 at 08:06:14PM +0000, Chris Packham wrote:
> > On Tue, 2020-02-04 at 07:09 +0000, gregkh@linuxfoundation.org wrote:
> > > On Tue, Feb 04, 2020 at 04:02:15AM +0000, Chris Packham wrote:
> > On Tue, 2020-02-04 at 10:21 +0300, Dan Carpenter wrote:
> > > My advice is to delete all the COMPILE_TEST code.  That stuff was a
> > > constant source of confusion and headaches.
> > 
> > I was also going to suggest this. Since the COMPILE_TEST has been a
> > source of trouble I was going to propose dropping the || COMPILE_TEST
> > from the Kconfig for the octeon drivers.
> 
> Not having it also causes problems.  I didn't originally add it for
> shits and giggles.

I wonder if the kbuild bot does enough cross compile build testing these
days to detect compile problems.  It might have improved to the point
where COMPILE_TEST isn't required.

One of the things about having a bunch of dummy functions for
COMPILE_TEST is that they introduce a lot of static checker warnings.
The real function is supposed to initialize stuff but the dummy function
just returns so now we get uninitialized variable warnings etc.

regards,
dan carpenter
