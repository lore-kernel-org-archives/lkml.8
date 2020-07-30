Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C52DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 21:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6887A20809
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 21:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="zI4Avvu0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730492AbgG3Vtg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 17:49:36 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:37496 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728499AbgG3Vtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 17:49:35 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06ULbxWT189784;
        Thu, 30 Jul 2020 21:49:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=VhPoQ91Z8DcdITe8DMePmmf/oHiACBtLRKfXshYhz/Y=;
 b=zI4Avvu05svh9hkFH+8R4WRl1y80MLEsHoZKleuKXewcfhZso81l893WIwjJNokZUFW8
 JVYEOKPaKT+PhVdmtH5pHW2soRfEquasUWoStFcBv40FaL8hKC49e2RMlFQq38RmjL+j
 0nFN02I4tXyN8YRwpY2bdUgaKxI7MJxtPikNCCTQh9/iyhAgOj+zPLEMy3wD69Jt2kpK
 pl4W0KlztacBV5rnJZ5faDPFLR8AqjT8X0icu+6akOL9ZOnYMD8dDlWHDSC1PxRpdgiE
 xLQQySV84NL99AvD2HRFJ1RHv/lhbgI0mVDUk4MMqse8a9/7uPEBwCbzwm+Qgh8phuYh Yw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 32hu1jp5wm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 30 Jul 2020 21:49:21 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06ULcpIK163961;
        Thu, 30 Jul 2020 21:49:21 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 32hu5xytbs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Jul 2020 21:49:20 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06ULnJki008286;
        Thu, 30 Jul 2020 21:49:20 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 30 Jul 2020 14:49:19 -0700
Subject: Re: [PATCH v2] mm/hugetlb: Fix calculation of
 adjust_range_if_pmd_sharing_possible
To:     Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20200730201636.74778-1-peterx@redhat.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <4680014a-a328-b0c2-dc86-8c1eb4556f69@oracle.com>
Date:   Thu, 30 Jul 2020 14:49:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200730201636.74778-1-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9698 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 adultscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007300151
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9698 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 clxscore=1015 mlxscore=0 impostorscore=0
 phishscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007300151
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/30/20 1:16 PM, Peter Xu wrote:
> This is found by code observation only.
> 
> Firstly, the worst case scenario should assume the whole range was covered by
> pmd sharing.  The old algorithm might not work as expected for ranges
> like (1g-2m, 1g+2m), where the adjusted range should be (0, 1g+2m) but the
> expected range should be (0, 2g).
> 
> Since at it, remove the loop since it should not be required.  With that, the
> new code should be faster too when the invalidating range is huge.

Thanks Peter!

That is certainly much simpler than the loop in current code.  You say there
are instances where old code 'might not work' for ranges like (1g-2m, 1g+2m).
Not sure I understand what you mean by adjusted and expected ranges in the
message.  Both are possible 'adjusted' ranges depending on vma size.

Just trying to figure out if there is an actual problem in the existing code
that needs to be fixed in stable.  I think the existing code is correct, just
inefficient.
-- 
Mike Kravetz
