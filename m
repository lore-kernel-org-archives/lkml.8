Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA16C33CB3
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 01:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C7A821D56
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 01:38:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Wd8rk5FV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730555AbgARBiV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 20:38:21 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:58592 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729102AbgARBiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 20:38:21 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00I1cEKL093561;
        Sat, 18 Jan 2020 01:38:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=cO7KleizkFcu89dtLpGWsABRgJIewtAdVz5atjRvjXg=;
 b=Wd8rk5FVNoZrFWdfGk9DZRemsvPMK6TTDHKlzK+8Bx/JaqS4PWS5rsTuy8P1Z+vVokDk
 ZfMXKWmQi5nIL5jQV8HQ8h7yhEPcByFI8wtlzwstkE4GMw31Ehsim3XXnPVxAmkRU6I+
 FyHhwYx6t94SJ93MXvLz9IAEU72FLaE4A/qtqDrLRy+ZxgRvDcLBFhO1F3bVzz6Cgnhs
 EGSjlNaLuFuqd20q3Wv3guAvKblZgBR7W1y8RTxmRU0VUFDdy/RGwydN++imAz700ryy
 Pr7SobEyM0ct6GVHVhmExICZ3Ep/2hLMVaOmkD3kpVNTZ9ZL5vuUU/IZa3LBV5JQA4tl oA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2xf7403s11-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 18 Jan 2020 01:38:14 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00I1YRr3195988;
        Sat, 18 Jan 2020 01:38:14 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2xk235vajy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 18 Jan 2020 01:38:13 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00I1cCNp015199;
        Sat, 18 Jan 2020 01:38:12 GMT
Received: from [192.168.1.206] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 17 Jan 2020 17:38:11 -0800
Subject: Re: [PATCH] mm/migrate.c: also overwrite error when it is bigger than
 zero
To:     Wei Yang <richardw.yang@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200117074534.25324-1-richardw.yang@linux.intel.com>
 <20200117222740.GB29229@richard>
 <CAHbLzkoYH1_JHH99pnopj_v=Wb=UEGMS9dJs1J6GZn0=6F4SJw@mail.gmail.com>
 <20200117234829.GA2844@richard>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <cc48623f-329b-ec43-a85a-d9a914ca87bc@oracle.com>
Date:   Fri, 17 Jan 2020 17:38:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200117234829.GA2844@richard>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9503 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=801
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001180010
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9503 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=841 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001180011
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/20 3:48 PM, Wei Yang wrote:
> This is another point I think current code is not working well. And actually,
> the behavior is not well defined or our kernel is broken for a while.
> 
> When you look at the man page, it says:
> 
>     RETURN VALUE
>            On success move_pages() returns zero.  On error, it returns -1, and sets errno to indicate the error
> 

Is this from your migrate_pages(2) man page?

The latest version of the migrate_pages(2) man page in the git repo has this
for RETURN VALUE.

RETURN VALUE
       On  success  migrate_pages() returns the number of pages that could not
       be moved (i.e., a return of zero means that all pages were successfully
       moved).  On error, it returns -1, and sets errno to indicate the error.

-- 
Mike Kravetz
