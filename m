Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F118C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 12:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB68120679
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 12:05:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="c88CDHOE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729808AbgFOMFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 08:05:53 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:36666 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728510AbgFOMFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 08:05:53 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05FBuhUj185278;
        Mon, 15 Jun 2020 12:05:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=1ZyfpjNW70O/reszk5u6HkvTyC7DS0UPZqomeyJuQ8E=;
 b=c88CDHOEdp4q5gpgtUJ8XS5PjNzV9xNwM1feZaL2UGm5DCNhARFHYxa3YwFHMfJbbeOt
 nkVSWIysGkdzeqwWub0LCOjjR0WG7KiIEQamrKSW7rHgDiJTuH9710h6jWyIbM7DPwDp
 F6UtyugpPQCuu0C6aQ/8NqjXF+ejhtA3jRxhZHd1SLBIk9CmZp6I61f2QTyRt7ghyxw6
 CF6bgMCRq3T8C/laEoXdyroxOb5Sn9Kesi0HL33QaM+dZjHoHMuE22sv2tED+TOT9gef
 XJu5Djbpnd4sI0WgQigMGtmu6SJ1qB3i3Z2xS4AScxKzh9KaYOCQP21ykKARUesU1f8e cQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 31p6e7rn6k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 15 Jun 2020 12:05:43 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05FBxGj5153699;
        Mon, 15 Jun 2020 12:03:42 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 31p6darng0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Jun 2020 12:03:42 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 05FC3eWw012453;
        Mon, 15 Jun 2020 12:03:40 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 15 Jun 2020 05:03:39 -0700
Date:   Mon, 15 Jun 2020 15:03:32 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Denis Efremov <efremov@linux.com>
Cc:     Joe Perches <joe@perches.com>, Julia Lawall <Julia.Lawall@lip6.fr>,
        cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coccinelle: api: add kzfree script
Message-ID: <20200615120332.GJ4282@kadam>
References: <20200604140805.111613-1-efremov@linux.com>
 <e4981fd76a88e18376c4e634c235501b57d321e7.camel@perches.com>
 <345c783b-a8cf-9dd1-29c6-d32b9b29053f@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <345c783b-a8cf-9dd1-29c6-d32b9b29053f@linux.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9652 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006150097
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9652 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 impostorscore=0 bulkscore=0 clxscore=1011 malwarescore=0 suspectscore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 lowpriorityscore=0
 cotscore=-2147483648 priorityscore=1501 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006150097
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 14, 2020 at 10:42:54PM +0300, Denis Efremov wrote:
> On 6/4/20 7:27 PM, Joe Perches wrote:
> > On Thu, 2020-06-04 at 17:08 +0300, Denis Efremov wrote:
> >> Check for memset() with 0 followed by kfree().
> > 
> > Perhaps those uses should be memzero_explicit or kvfree_sensitive.
> > 
> 
> Is it safe to suggest to use kzfree instead of memzero_explicit && kfree?
> Or it would be better to use kvfree_sensitive in this case.
> 
> kzfree uses memset(0) with no barrier_data.

Yeah.  That seems buggy.  It should have a barrier.  Also I thought I
saw somewhere that Linus doesn't like the name and so that's why we have
the _sensitive() name?

regards,
dan carpenter

