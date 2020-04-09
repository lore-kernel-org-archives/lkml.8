Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3629AC2BA19
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 22:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 055CE2083E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 22:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="K1VZhl35"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbgDIWIQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 18:08:16 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52232 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726797AbgDIWIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 18:08:16 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 039M3jf0081816;
        Thu, 9 Apr 2020 22:08:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=KJh07q7uvOkDoDWvPxD4kKvVu9QeaGoOd2hp5uE/ptE=;
 b=K1VZhl35SODodLXB/ZzTyYKN/5naGz4OQx77cB58MUiTOIdU2OduyWbJLX6DUXpweRzI
 KQWnNiMjLjZw7Bd4bjDo/fj0PwzSRBVyFrlv3bqhmU3C4MBjVSibVFPP/PuYu6XCq6gh
 TMi9a67XCQHJGtMueZT0BIHdtQ0pIYkxKPLm9LIbumLqSTaUDP1FW9JNR+CghMhxk/2j
 ucCWhR9mjRax1iFuqQk0eya3lnoQjJFbrHI3WCFQ+d4nChi78G3wEcuh5bFKsoxSwhHe
 8KE3LmRYfXEGmMGqU4P70+PIXKi6cq7Ag9/c9pILGQw8EwRMbZrLzEr8R8KoNQJtwEfy kg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 309gw4fxde-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Apr 2020 22:08:10 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 039M6umD116523;
        Thu, 9 Apr 2020 22:08:09 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 309ag5tgdw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Apr 2020 22:08:09 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 039M88EO014851;
        Thu, 9 Apr 2020 22:08:08 GMT
Received: from [192.168.1.206] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 09 Apr 2020 15:08:08 -0700
Subject: Re: [PATCH] Documentation: hugetlb: Update hugetlb options
To:     Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Nitesh Narayan Lal <nitesh@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20200409215800.8967-1-peterx@redhat.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <ba5c87df-9a77-ebd2-e45e-f262a36fbf22@oracle.com>
Date:   Thu, 9 Apr 2020 15:08:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200409215800.8967-1-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9586 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 malwarescore=0
 phishscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004090156
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9586 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 bulkscore=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1011
 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004090155
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/9/20 2:58 PM, Peter Xu wrote:
> The hugepage options are not documented clearly.
> 
> Firstly, default_hugepagesz= should always be specified after the
> declaration of the same type of huge page using hugepagesz=.  For
> example, if we boot a x86_64 system with kernel cmdline
> "default_hugepagesz=2M", we'll get a very funny error message:
> 
> "HugeTLB: unsupported default_hugepagesz 2097152. Reverting to 2097152"
> 
> It's understandable from code-wise because when hugetlb_init() we
> didn't have the 2M page hstate registered, so it's unsupported.
> However 2M is actually the default huge page size on x86_64, so we'll
> register it right after the error message.  However it's very
> confusing if without these knowledges.
> 
> Secondly, hugepages= option must be used _after_ another hugepagesz=.
> The word "interleave" is fine but it didn't declare the fact that
> each of the hugepages= option will be applied to the previous parsed
> hugepagesz= option.
> 
> State all these clear.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

Hi Peter,

Did you happen to see this patch series?

https://lore.kernel.org/linux-mm/20200401183819.20647-1-mike.kravetz@oracle.com/

That should address the documentation issue and more.
-- 
Mike Kravetz
