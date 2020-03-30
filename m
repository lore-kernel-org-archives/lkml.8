Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DBBEC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 23:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF43620771
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 23:35:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FJw4WCPT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729167AbgC3Xfk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 19:35:40 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43058 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728880AbgC3Xfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 19:35:39 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02UNOZnD070815;
        Mon, 30 Mar 2020 23:35:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=hTNGH357V8fDPt3Sg7am+l1PufVb0mgR3cQhPNudEw8=;
 b=FJw4WCPTrBUvzllsCSSnJB8Ii5JuTEcbqKg1Lh9LBg+PlRA8npteRInLh1v0rqky23Mk
 LSjcqJfuRuCeIc1ethtyJSevwo4zm68mdA1sOff3ilTpL2/bIA21fXYw44ybMowAeVLZ
 zjQqqjIitGvO9w6MlOaQoWbjn+klEMbyPV9V+n8xuiQ1Tyo2T3wmnpPkiSyXxU6iSLC5
 ojR6rgLTjlw48w5VE2VW4THA2n25gQFCDhxLE4m1xvjYXy2tKUWgyXFdU6QoAdVeO2yp
 ClB6ZT8ehBlkiCs7D7aQgbS9icHhgeEJ7nLnfvZZ0NUDyXzhxPKwRg+MeJD8RNpLCjgu jQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 303aqhd2kb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Mar 2020 23:35:24 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02UNMwwO033138;
        Mon, 30 Mar 2020 23:35:23 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 302gcar1un-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Mar 2020 23:35:23 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02UNZKkp013067;
        Mon, 30 Mar 2020 23:35:20 GMT
Received: from [192.168.1.206] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 30 Mar 2020 16:35:20 -0700
Subject: Re: [PATCH v2 1/2] hugetlbfs: use i_mmap_rwsem for more pmd sharing
 synchronization
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     linux-mm <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A.Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        lkft-triage@lists.linaro.org
References: <20200316205756.146666-1-mike.kravetz@oracle.com>
 <20200316205756.146666-2-mike.kravetz@oracle.com>
 <CA+G9fYvopJ7v2w3+8Qb+ov_Ji30=mW-DJceZfUOtHFKFMWod8Q@mail.gmail.com>
 <CA+G9fYsJgZhhWLMzUxu_ZQ+THdCcJmFbHQ2ETA_YPP8M6yxOYA@mail.gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <74d61fb3-6750-e9c4-0b42-8d811d418091@oracle.com>
Date:   Mon, 30 Mar 2020 16:35:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CA+G9fYsJgZhhWLMzUxu_ZQ+THdCcJmFbHQ2ETA_YPP8M6yxOYA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9576 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxlogscore=983 adultscore=0 suspectscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003300192
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9576 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 clxscore=1011
 malwarescore=0 impostorscore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003300192
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/30/20 7:01 AM, Naresh Kamboju wrote:
> FYI,
> 
> The device is x86_64 device running i386 kernel image.
> 
> - Naresh
> 
> On Mon, 30 Mar 2020 at 19:00, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>>
>> On i386 running LTP hugetlb tests found kernel BUG at fs/hugetlbfs/inode.c:458
>> Running Linux version 5.6.0-rc7-next-20200330
>> And hugemmap test failed due to ENOMEM.
>>
>> steps to reproduce:
>>         # cd /opt/ltp
>>         # ./runltp -f hugetlb

It took me a while to set up an environment to reproduce.  I was finally
able to reproduce on an x86_64 VM running a 32 bit OS/5.6.0-rc7-next-20200330
kernel.

My first attempt with PAE enabled and 8GB of memory did not reproduce.  When
I disabled PAE and dropped memory to 4GB, the problem reproduced.

After reverting this patch, and the followup in the series I was still able
to recreate the issue.  So, the patches are not the root cause.

One 'interesting' thing are the messages,
mm/pgtable-generic.c:50: bad pgd ...
These show up before the hugetlbfs BUG.

I will continue to investigate.  However, if the 'bad pgd ..' message provides
a hint to someone please let us know.
-- 
Mike Kravetz
