Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08DC1C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 06:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2F8C20658
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 06:36:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbgGUGgG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 02:36:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:29946 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726039AbgGUGgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 02:36:06 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06L6W64D148429;
        Tue, 21 Jul 2020 02:35:32 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32d91uv6gf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Jul 2020 02:35:31 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06L6Ulir019941;
        Tue, 21 Jul 2020 06:35:29 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma02fra.de.ibm.com with ESMTP id 32brq7ukuw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Jul 2020 06:35:29 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06L6Y3gP55574970
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jul 2020 06:34:03 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 561C542047;
        Tue, 21 Jul 2020 06:35:27 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 27E0A42041;
        Tue, 21 Jul 2020 06:35:26 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.148.203.12])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 21 Jul 2020 06:35:26 +0000 (GMT)
Date:   Tue, 21 Jul 2020 09:35:24 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     "liwei (CM)" <liwei213@huawei.com>
Cc:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        fengbaopeng <fengbaopeng2@hisilicon.com>,
        "nsaenzjulienne@suse.de" <nsaenzjulienne@suse.de>,
        "steve.capper@arm.com" <steve.capper@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        sujunfei <sujunfei2@hisilicon.com>,
        "Xiaqing (A)" <saberlily.xia@hisilicon.com>,
        "Yaobaofeng (Yaobaofeng)" <yaobaofeng@huawei.com>
Subject: Re: =?utf-8?B?562U5aSNOiBbUEFUQ0hdIGFybTY0?=
 =?utf-8?B?OiBtbTogZnJl?= =?utf-8?Q?e?= unused memmap for sparse memory model
 that define VMEMMAP
Message-ID: <20200721063524.GC802087@linux.ibm.com>
References: <20200708015555.14946-1-liwei213@huawei.com>
 <B926444035E5E2439431908E3842AFD255E7A1@DGGEMI525-MBS.china.huawei.com>
 <1699CE87DE933F49876AD744B5DC140F230F8396@DGGEMM506-MBS.china.huawei.com>
 <B926444035E5E2439431908E3842AFD256289A@DGGEMI525-MBS.china.huawei.com>
 <1699CE87DE933F49876AD744B5DC140F2312A02B@dggemm526-mbx.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1699CE87DE933F49876AD744B5DC140F2312A02B@dggemm526-mbx.china.huawei.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-21_02:2020-07-21,2020-07-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 impostorscore=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=5 clxscore=1011
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007210043
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jul 21, 2020 at 01:56:33AM +0000, liwei (CM) wrote:
> Hi, all
> 
> I'm sorry to bother you, but still very hope you can give comments or suggestions to this patch, thank you very much.
 
I cannot find your patch neither in Inbox nor in the public archives.
Can you resend it please?


> -----邮件原件-----
> 发件人: Song Bao Hua (Barry Song) 
> 发送时间: 2020年7月9日 20:27
> 收件人: liwei (CM) <liwei213@huawei.com>; catalin.marinas@arm.com; will@kernel.org
> 抄送: fengbaopeng <fengbaopeng2@hisilicon.com>; nsaenzjulienne@suse.de; steve.capper@arm.com; rppt@linux.ibm.com; linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; sujunfei <sujunfei2@hisilicon.com>; Xiaqing (A) <saberlily.xia@hisilicon.com>; Yaobaofeng (Yaobaofeng) <yaobaofeng@huawei.com>
> 主题: RE: [PATCH] arm64: mm: free unused memmap for sparse memory model that define VMEMMAP
> 
> 
> 
> > -----Original Message-----
> > From: liwei (CM)
> > Sent: Wednesday, July 8, 2020 7:52 PM
> > To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>; 
> > catalin.marinas@arm.com; will@kernel.org
> > Cc: fengbaopeng <fengbaopeng2@hisilicon.com>; nsaenzjulienne@suse.de; 
> > steve.capper@arm.com; rppt@linux.ibm.com; 
> > linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; 
> > sujunfei <sujunfei2@hisilicon.com>; Xiaqing (A) 
> > <saberlily.xia@hisilicon.com>; Yaobaofeng (Yaobaofeng) 
> > <yaobaofeng@huawei.com>
> > Subject: 答复: [PATCH] arm64: mm: free unused memmap for sparse memory 
> > model that define VMEMMAP
> > 
> > Hi, baohua
> > 
> > Thank you for your attention.
> > 
> > In my understanding of the MEMORY_HOTPLUG this patch has no effect on it.
> > The reason is that in sparse_add_one_section() the memory that memmap 
> > needs from Slab if kernel start completed，this memory has nothing to 
> > do with memblock alloc/ free memory in the process of kernel start.
> > 
> > You may have a look vmemmap_alloc_block () this function.
> > 
> > If I don't understand right welcome pointed out in a timely manner.
> 
> At the first glance of this patch, I suspect that this bootmem may be used by hot-added memory.
> If you confirm this won't happen, please ignore my noise.
> 
> BTW, next time, bear in mind that top-post is not a good way to reply mail :-)
> 
> > 
> > Thanks!
> > 
> > 
> > -----邮件原件-----
> > 发件人: Song Bao Hua (Barry Song)
> > 发送时间: 2020年7月8日 15:19
> > 收件人: liwei (CM) <liwei213@huawei.com>; catalin.marinas@arm.com; 
> > will@kernel.org
> > 抄送: fengbaopeng <fengbaopeng2@hisilicon.com>; nsaenzjulienne@suse.de; 
> > steve.capper@arm.com; rppt@linux.ibm.com; 
> > linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; 
> > sujunfei <sujunfei2@hisilicon.com>
> > 主题: RE: [PATCH] arm64: mm: free unused memmap for sparse memory model 
> > that define VMEMMAP
> > 
> > 
> > 
> > > -----Original Message-----
> > > From: liwei (CM)
> > > Sent: Wednesday, July 8, 2020 1:56 PM
> > > To: catalin.marinas@arm.com; will@kernel.org
> > > Cc: liwei (CM) <liwei213@huawei.com>; fengbaopeng 
> > > <fengbaopeng2@hisilicon.com>; nsaenzjulienne@suse.de; 
> > > steve.capper@arm.com; rppt@linux.ibm.com; Song Bao Hua (Barry Song) 
> > > <song.bao.hua@hisilicon.com>; linux-arm-kernel@lists.infradead.org;
> > > linux-kernel@vger.kernel.org; sujunfei <sujunfei2@hisilicon.com>
> > > Subject: [PATCH] arm64: mm: free unused memmap for sparse memory
> > model
> > > that define VMEMMAP
> > >
> > > For the memory hole, sparse memory model that define
> > SPARSEMEM_VMEMMAP
> > > do not free the reserved memory for the page map, this patch do it.
> > 
> > Hello Wei,
> > Just curious if this patch breaks MEMORY_HOTPLUG?
> > 
> > >
> > > Signed-off-by: Wei Li <liwei213@huawei.com>
> > > Signed-off-by: Chen Feng <puck.chen@hisilicon.com>
> > > Signed-off-by: Xia Qing <saberlily.xia@hisilicon.com>
> > > ---
> > >  arch/arm64/mm/init.c | 81
> > > +++++++++++++++++++++++++++++++++++++++++++++-------
> > >  1 file changed, 71 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c index 
> > > 1e93cfc7c47a..d1b56b47d5ba 100644
> > > --- a/arch/arm64/mm/init.c
> > > +++ b/arch/arm64/mm/init.c
> > > @@ -441,7 +441,48 @@ void __init bootmem_init(void)
> > >  	memblock_dump_all();
> > >  }
> > >
> > 
> > Thanks
> > Barry
> 

-- 
Sincerely yours,
Mike.
