Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 977B9C2BA19
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 20:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 671AF20672
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 20:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ox9XanzK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbgDEUtw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 16:49:52 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50480 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbgDEUtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 16:49:52 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 035Kh9sw057267;
        Sun, 5 Apr 2020 20:49:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=y7ZahLPILWikQeCjld1D1QOXNNv6J0H2ohGApvDE+GU=;
 b=ox9XanzK/rS7B95nf8FIs6xBDghS/C1Gv6oekKSteD72Xh+x2NOAYH77Uq1jNJA5b4PA
 OnyADF7inR8/wo13GEviFoJ25deHswEL9Yv8qR/81+qyqfQy2fm78yMHFFnamJUD8Jv6
 bPQCI/t8XLtShOx7VeuJDnXHbnnU+JpyFIApGzBbyCUErGltnHr+1/A3fIOvzY+1Rnks
 zWKO/er087JfnOhsxgKu96JbgQTHlXMi50zfS3Wy+jbgA3J+1Y29l2m58wiGJ29mQebw
 OfNmsc6Ce1ptEquttCDPsmZIgfSBjbHcpKyxaf342KbsXueTDoMu/9koy56OfbV8rwrk EQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 306jvmusj8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 05 Apr 2020 20:49:22 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 035KhAjH056442;
        Sun, 5 Apr 2020 20:49:22 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 3073qb8gkt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 05 Apr 2020 20:49:22 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 035KnEOF007900;
        Sun, 5 Apr 2020 20:49:14 GMT
Received: from [192.168.0.110] (/73.243.10.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 05 Apr 2020 13:49:14 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] mm/vmalloc: Sanitize __get_vm_area() arguments
From:   William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <20200405192108.GA9429@pc636>
Date:   Sun, 5 Apr 2020 14:49:13 -0600
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
        jroedel@suse.de, Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Transfer-Encoding: 7bit
Message-Id: <65663E36-DC60-4E6E-B6C6-3A0F6852543D@oracle.com>
References: <D25C4027-6EF9-44C2-AD4D-DDC785288B9A@oracle.com>
 <20200404185229.GA424@pc636>
 <EEB53CBF-0B3F-43E0-94F6-B001918BAC3E@oracle.com>
 <20200405172315.GA8404@pc636> <20200405192108.GA9429@pc636>
To:     Uladzislau Rezki <urezki@gmail.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9582 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 mlxlogscore=765
 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004050189
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9582 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 mlxlogscore=821 mlxscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004050189
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

That's fine.

One could still argue size should be sanitized earlier when start and end
are, but it's a nit either way (though size is used before it's checked,
it's not in any way that could fail with bad results.)

    -- Bill

> On Apr 5, 2020, at 1:21 PM, Uladzislau Rezki <urezki@gmail.com> wrote:
> 
> On Sun, Apr 05, 2020 at 07:23:15PM +0200, Uladzislau Rezki wrote:
> Sorry, was thinking about one place showed different one. Here we go:
> 
> <snip>
> /* Check the "vend" restriction. */
>  if (nva_start_addr + size > vend)
>    return vend;
> <snip>
> 
> --
> Vlad Rezki


