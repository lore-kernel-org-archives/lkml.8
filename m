Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C28E8C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 08:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 976DA2080C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 08:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Z7WtmY4B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387740AbgDBIQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 04:16:29 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50614 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387709AbgDBIQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 04:16:24 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0328Cgvf143520;
        Thu, 2 Apr 2020 08:16:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=IQ7YCVvQUn/2GtTwOiaRAxLYjy7bIgPD0hE/r1qJuEI=;
 b=Z7WtmY4BDK4OCH5AWjWWQAmmhFGmNYFs+Mnk36gWgjcKnNemQopamHMHkc5mdEocQfkz
 VYUSdVm8lr1UUtpv37G3cSAuDn372DqbhZfiZYn5BftXSoO47KKqec2UQGORJ3rpNUok
 pWmUYfwAS1vmBFWH53q9J6qNXQr4VUD+azg/1Xls73ut0/iRSrYtH620vcUbIMeJ99NU
 SzAcG3e1kpUweWKw2lgn3IA6yUTQcktIA9JGeTzNUw9rVgNcVMwGBrdnFmGharQE2IwZ
 uSdD/dRprT/UpZ5CmSaacnPWj4wecMq1C5syEA0UwfbMPePQnWbQwdO919quY7rA6oYK 8w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 303aqhta0u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Apr 2020 08:16:16 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0328CQu6076161;
        Thu, 2 Apr 2020 08:16:16 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 302g4v4mhx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Apr 2020 08:16:15 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0328GEPF021379;
        Thu, 2 Apr 2020 08:16:14 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 02 Apr 2020 01:16:13 -0700
Date:   Thu, 2 Apr 2020 11:16:06 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Joe Perches <joe@perches.com>
Cc:     aimannajjar <aiman.najjar@hurranet.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: [PATCH v2 4/5] staging: rtl8712: fix multiline derefernce warning
Message-ID: <20200402081605.GD2001@kadam>
References: <20200327080429.GB1627562@kroah.com>
 <cover.1585353747.git.aiman.najjar@hurranet.com>
 <beb6c8c826cdda751f29f985f2b5dedfd2f87914.1585353747.git.aiman.najjar@hurranet.com>
 <197b261122fc6a751a163545044195f2d98d79dc.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <197b261122fc6a751a163545044195f2d98d79dc.camel@perches.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9578 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 spamscore=0 malwarescore=0 mlxlogscore=709 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004020074
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9578 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 mlxlogscore=765 spamscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004020074
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aiman,

On Sat, Mar 28, 2020 at 12:17:19PM -0700, Joe Perches wrote:
> On Fri, 2020-03-27 at 20:08 -0400, aimannajjar wrote:
> 
> so these would be
> 
> 			ether_addr_copy(pwlanhdr->addr2, pattr->src);
> 
> and pwlanhdr isn't a particularly valuable name
> for an automatic either.  It's hungarian like.
>

"Hungarian like" means it starts with a "p".

https://en.wikipedia.org/wiki/Hungarian_notation

It's against the rules of kernel style.

regards,
dan carpenter

