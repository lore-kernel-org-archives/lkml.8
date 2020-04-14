Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57BB7C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 08:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A1D9206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 08:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gDswYByS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436874AbgDNIb1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 04:31:27 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52078 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436826AbgDNIbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 04:31:18 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03E8SY8h030059;
        Tue, 14 Apr 2020 08:30:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=B4F5aK58uXm+SQw8mnNaOVLDhAMxHIBWcLtQ7vVYAdc=;
 b=gDswYBySZ6leZ9Zb7x9/yQfTmqfKWVKXdGBWundE2UoyBcb011loVccqqP4x7nQ7x1F6
 nGaYbCCme8KPyl3nRLOtgysEKqsHw/sOpPUAU3aEJCtxqOt+oyYRg0ZW2vyACJb3MCgu
 Yvah95aNEJzJPeTQPt3oEw2PmibKw/Db37gzPxqF+umNSOIT2IMWZv4RuAq6wNdL46EJ
 0duPTGY4SCNSUdSn0xag4qvLxAY+cVsEWoEG0G7u1fVP7zT04qrbWmRyZNv4PisS1coP
 OEDi9VY5INA3/7Ej4tcXZBUBs8g2cKhA/lqymThBnAar6EhuiKGHinsrz/3rXtMI43IU Wg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 30b5ar2xd3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Apr 2020 08:30:56 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03E8QwSL021727;
        Tue, 14 Apr 2020 08:30:56 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 30bqm13gtg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Apr 2020 08:30:56 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03E8Ulsa008651;
        Tue, 14 Apr 2020 08:30:48 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 14 Apr 2020 01:30:47 -0700
Date:   Tue, 14 Apr 2020 11:30:36 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Tang Bin <tangbin@cmss.chinamobile.com>
Cc:     Markus Elfring <Markus.Elfring@web.de>,
        Li Yang <leoyang.li@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: fsl: Fix a wrong judgment in fsl_udc_probe()
Message-ID: <20200414083036.GC14722@kadam>
References: <20200410015832.8012-1-tangbin@cmss.chinamobile.com>
 <be8cd229-884a-40e6-3363-7c4680a51b30@web.de>
 <0b718268-d330-dfc1-aca3-3dd3203363d7@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b718268-d330-dfc1-aca3-3dd3203363d7@cmss.chinamobile.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9590 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=608
 adultscore=0 mlxscore=0 phishscore=0 malwarescore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004140070
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9590 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 impostorscore=0
 clxscore=1011 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0
 mlxlogscore=669 suspectscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004140070
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 10, 2020 at 04:05:06PM +0800, Tang Bin wrote:
> > 
> > 
> > > Thus it must be fixed.
> > Wording alternative:
> >    Thus adjust the error detection and corresponding exception handling.
>
> Got it.

Wow...

No, don't listen to Markus when it comes to writing commit messages.
You couldn't find worse advice anywhere.  :P

regards,
dan carpenter

