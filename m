Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C15C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 18:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5554020663
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 18:36:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="c+hg1ZrT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbgG2SgH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 14:36:07 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:60242 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgG2SgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 14:36:06 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06TIVxgx018213;
        Wed, 29 Jul 2020 18:35:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=3QuIhOvbPPB9XM2WftKT9SKANlKh1T59MgfKSRu5wDs=;
 b=c+hg1ZrTNQEljpNXsefaZLQ3NSmBIm4/jrENLLB9Jj03Y8hX7cT/NOF1lT0Zjm6H+c5S
 UOWme/FNNWWqkCHBlBspQR21nQG7MeV78lSlCz/4n33ja2DuSaEwHVY+V+HnwfEif23R
 AR/m5IrDEVL7izW2R4Hhmtmo04u1IDOJqQ5gXdHkL2Ps8ZvEjLuB8cZIdN6mSvra0Nfp
 4PtVWrhFYjeC+kzwuWlFvym8IlIgKEO/vv86TUcLOv0DGRn/t2f1gWopDs2UEYzWHIXU
 1YddQP+lt9tgOXq67RZjX2n+99p5687f7xkla2WcUHL2QSQ36IusO7f2DW9fD8c52QS4 Ug== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 32hu1jfbkf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Jul 2020 18:35:54 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06TIWV69194155;
        Wed, 29 Jul 2020 18:35:53 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 32hu5xp7ad-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jul 2020 18:35:53 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06TIZqRf017180;
        Wed, 29 Jul 2020 18:35:52 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 29 Jul 2020 11:35:52 -0700
Subject: Re: [PATCH v1 2/6] mm/page_isolation: don't dump_page(NULL) in
 set_migratetype_isolate()
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "Michael S.Tsirkin" <mst@redhat.com>
References: <20200630142639.22770-1-david@redhat.com>
 <20200630142639.22770-3-david@redhat.com>
 <6a05470a-75be-e895-dff6-ed494af8d6d9@oracle.com>
 <7d32cdd3-7f19-2916-1930-33236bf33e19@redhat.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <79240e7f-de16-aee6-fbf6-07e7f184a924@oracle.com>
Date:   Wed, 29 Jul 2020 11:35:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <7d32cdd3-7f19-2916-1930-33236bf33e19@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9697 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007290125
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9697 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 clxscore=1015 mlxscore=0 impostorscore=0
 phishscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007290125
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/29/20 11:08 AM, David Hildenbrand wrote:
> I have no clue what you mean with "reintroducing this abandoning of
> pageblocks". All this patch is changing is not doing the dump_page() -
> or am I missing something important?

My apologies!!!

I got confused when I saw 'Return -EBUSY' removed from the comment and
assumed the code would not return an error code.  The code now more
explicitly does return -EBUSY.  My concern was when I incorrectly thought
you were removing the error return code.  Sorry for the noise.

Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
