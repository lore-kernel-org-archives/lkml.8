Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60EF8C32771
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 08:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 343BC21569
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 08:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CIjLD+pw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbgA0IKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 03:10:13 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:36198 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgA0IKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 03:10:13 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00R88NjO020434;
        Mon, 27 Jan 2020 08:10:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=jd96EvBODZ1OmeCFJuFhnzEFmdqOYHBsCDn6ZgiV2sM=;
 b=CIjLD+pwa9IzEDfXQCAqWpdKiOFqijZCfhU2KNk3fovQVdIwTp+HghTtUvRxrqHKlkpj
 57Tl42SK0fVvDfndHCaAV/L6xHDpirawDsUg9dkGWYK6jFoN0o249KbMD4DhZSQGx08z
 k4wewgfYZjPwsYdgBSe6hLXuP6JZQn6AoTQN/LJMlfGYywFLozwZkaTqwO+gfV7brELi
 aXiET5/Q2ZYJKEguC8pXqKsJoosPvTAh4ugw1OX/J8Vclg9VhZfFjehVm/1eN+ti3cLV
 QjA8Tw0yFpA7tv4OXPF4SWci3nhqzdasG1bysc9QedomQreIMB04Y8c+98bGbZzqrOBP SA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2xreaqwkab-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jan 2020 08:10:05 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00R88gXq069886;
        Mon, 27 Jan 2020 08:10:04 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2xryu8v17p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jan 2020 08:10:04 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00R8A2ca014877;
        Mon, 27 Jan 2020 08:10:02 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 27 Jan 2020 00:10:02 -0800
Date:   Mon, 27 Jan 2020 11:09:53 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Saurav Girepunje <saurav.girepunje@gmail.com>
Cc:     vireshk@kernel.org, johan@kernel.org, elder@kernel.org,
        gregkh@linuxfoundation.org, greybus-dev@lists.linaro.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        saurav.girepunje@hotmail.com
Subject: Re: [PATCH] staging: greybus: bootrom: fix uninitialized variables
Message-ID: <20200127080953.GQ1847@kadam>
References: <20200125084403.GA3386@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200125084403.GA3386@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9512 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001270070
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9512 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001270070
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 25, 2020 at 02:14:03PM +0530, Saurav Girepunje wrote:
> fix uninitialized variables issue found using static code analysis tool
> 
> (error) Uninitialized variable: offset
> (error) Uninitialized variable: size
> 

These are false positives as Johan said.  Don't change the code just to
make the static analysis tool happy, fix the tools instead.

Also the patch doesn't apply.  Read the first paragraph of
Documentation/process/email-clients.rst and figure out why it's not
working.

regards,
dan carpenter

