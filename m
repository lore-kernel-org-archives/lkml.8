Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0334C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 23:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C481B2072D
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 23:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="l07jmwfv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbgHUXgc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 19:36:32 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:47314 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbgHUXga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 19:36:30 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07LNWML8180628;
        Fri, 21 Aug 2020 23:36:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=eG1DGNfwcUES8MdO+v6w04I3v53RR6Tb+fhbzPafdmk=;
 b=l07jmwfviTqLfoNB40c+jxDl1RmF0u9R5rVbpwmYgbZuXV1SqmJPePTSTu3rDa0cB9fK
 25NCyPnKroBR38mSbstPtqc1ib7139ee///ahlvT3bn07mn7VOdjiNmqZu6uCa1UV7uj
 8PCEp8NpbnfPwDdWCiqILAfaTZtiEOkMVlr9MYUUne7X2kVkVPXkspOlgJbVahXyYxB7
 J+o+i9VNaoLwQkXZyg3zq2Tw+xGcqvshHpC1YjcwOFCmwBCEJJe73DsIPglefQrUem5+
 XxfWTlRESKR5l5iUT2apuzSBe6xUcY+Z8gY3RrunQK5WX7T5Q3418gCSVB5fyswDiInO TQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 32x74rrdyf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 21 Aug 2020 23:36:16 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07LNYPP6187152;
        Fri, 21 Aug 2020 23:36:15 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 3325377uc6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Aug 2020 23:36:15 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07LNaD2m011347;
        Fri, 21 Aug 2020 23:36:13 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 21 Aug 2020 23:36:13 +0000
Subject: Re: [LKP] Re: [hugetlbfs] c0d0381ade: vm-scalability.throughput
 -33.4% regression
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        kernel test robot <rong.a.chen@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A.Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
References: <20200622005551.GK5535@shao2-debian>
 <e140ec78-1fbd-73e2-7a11-7db3b714874d@oracle.com>
 <718e1653-b273-096b-0ee3-f720cf794612@oracle.com>
 <d945497d-0edb-f540-33e1-8b1ba1e20f62@linux.intel.com>
 <691152ef-6787-9598-4445-fd2a0164f70f@oracle.com>
Message-ID: <1f6d321e-96b4-18c3-2991-d6a2e94c9e60@oracle.com>
Date:   Fri, 21 Aug 2020 16:36:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <691152ef-6787-9598-4445-fd2a0164f70f@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9720 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 phishscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008210216
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9720 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxlogscore=999
 priorityscore=1501 phishscore=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008210216
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/21/20 2:02 PM, Mike Kravetz wrote:
> Would you be willing to test this series on top of 34ae204f1851?  I will need
> to rebase the series to take the changes made by 34ae204f1851 into account.

Actually, the series in this thread will apply/run cleanly on top of
34ae204f1851.  No need to rebase or port.  If we decide to move forward more
work is required.  See a few FIXME's in the patches.
-- 
Mike Kravetz
