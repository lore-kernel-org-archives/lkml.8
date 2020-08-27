Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE74C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66F982054F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eK6ViccI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbgH0O4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 10:56:48 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:55912 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbgH0O4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 10:56:43 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07REnLuC119443;
        Thu, 27 Aug 2020 14:56:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=i0cvgVD9mKaurEeb+8oLNxEBRbao060MNxXFZb6HaGo=;
 b=eK6ViccIsPw4TfUld5EEmWECzCo09zfXbL0Fd9MDG3mIq9wMv7sYOoGYuNAqRSJCKvVR
 EFKvuL3n6K+ajWw+V+dzIsPZEcGdgSGfdiafFyes7sNlaoW9lXkHwanKsLRxlxJrqUQl
 XVpa5ZPmERyDRGnosjLMf1FmVRqScJw/whI/lysHV4ic/F7rRZ+/C8Kb6shqA+OTg5Cd
 O/+Gi4qkHDn9FeQpsS6CH9Hlw8A9BaD73qUsXHfs3G7Cy1wxJYN8cSJIhCXD00OpzVMp
 iiBnfNVfpv3HzBGE3fRlUNpZt9TaeqKaA01FKQHIQReCL3BtwkS9I9plGxXk6T16PyVm +g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 333w6u5dp0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 27 Aug 2020 14:56:31 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07REotcF020173;
        Thu, 27 Aug 2020 14:56:30 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 333r9ngwb8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Aug 2020 14:56:30 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07REuS1S013544;
        Thu, 27 Aug 2020 14:56:29 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 27 Aug 2020 07:56:27 -0700
Subject: Re: [drm/mgag200] 913ec479bb: vm-scalability.throughput 26.2%
 improvement
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        kernel test robot <rong.a.chen@intel.com>
Cc:     John Donnelly <John.p.donnelly@oracle.com>,
        Emil Velikov <emil.velikov@collabora.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@intel.com
References: <20200826085847.GL4299@shao2-debian>
 <76926ade-15fb-75a3-17aa-a2b5a68471c8@suse.de>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <99c7683c-f428-378d-2b19-ef51270a5d8e@oracle.com>
Date:   Thu, 27 Aug 2020 07:56:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <76926ade-15fb-75a3-17aa-a2b5a68471c8@suse.de>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9726 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008270114
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9725 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 clxscore=1011 mlxscore=0 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008270114
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/27/20 2:16 AM, Thomas Zimmermann wrote:
> Hi
> 
> Am 26.08.20 um 10:58 schrieb kernel test robot:
>> Greeting,
>>
>> FYI, we noticed a 26.2% improvement of vm-scalability.throughput due to commit:
> 
> I guess this resolves the once-measured performance penalty of similar
> magnitude. But do we really understand these tests? When I sent out
> patches to resolve the problem, nothing changed. And suddenly the
> performance is back to normal.
> 
> Best regards
> Thomas
> 
>>
>>
>> commit: 913ec479bb5cc27f99f24d5fd111b3ef29a4deb9 ("drm/mgag200: Replace VRAM helpers with SHMEM helpers")
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>>
>>
>> in testcase: vm-scalability
>> on test machine: 288 threads Intel(R) Xeon Phi(TM) CPU 7295 @ 1.50GHz with 80G memory
>> with following parameters:
>>
>> 	runtime: 300s
>> 	size: 8T
>> 	test: anon-cow-seq-hugetlb
>> 	cpufreq_governor: performance
>> 	ucode: 0x11

Hello Thomas,

Did drm changes really impact anon-cow-seq-hugetlb performance?

My change c0d0381ade79 ("hugetlbfs: use i_mmap_rwsem for more pmd sharing
synchronization") caused a -33.4% regression of anon-cow-seq-hugetlb.  A
recent change 34ae204f185 (hugetlbfs: remove call to huge_pte_alloc without
i_mmap_rwsem) was tested by Zhengjun Xing and improved performance by 20
something percent.  That seems in line with this report/improvement.

Perhaps the tooling is not always accurate in determining the commit which
causes the performance changes?
Perhaps I am misreading information in the reports?
-- 
Mike Kravetz
