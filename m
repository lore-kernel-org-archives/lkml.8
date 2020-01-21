Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30138C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 20:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 024E821734
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 20:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Q4U19iIq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbgAUUzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 15:55:16 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:39550 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728741AbgAUUzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 15:55:15 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00LKhosb128897;
        Tue, 21 Jan 2020 20:54:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=097qPjqdtLQ/u66QFt3FxKMZ7mao/EVAbbQjFNVYa14=;
 b=Q4U19iIqSyGgLf5SGthY7IKajJE5vk6hjt4L/JH8/cr3D5Cx+68VRLb01YBXLrPSfHWH
 mzgi458Q12OJJJdqeJSV+b84dhCdlKDAd+/EnV1kVk9igTMpp2Xpgt8xaCvsBcJ0DsdX
 DrVCwfRhUnvozWJSLy8Nm1DpskaD3XpzR7Az56cup1Apu6WAJgkC10vX8dqL31+z/HPb
 yYEjSK3cu7Gyt/+P27HtBzgysZLYCNbk/xmQILMXDRb5x1dyXxNCoxo/gqeoKoRGwayp
 Ipg/bBGAm4qC61wXvW82vCX5U5GTeNwWh1l00O11cCGy02wscx0WoxY6SUF1xQI7VxsK 7Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2xkseufvcy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jan 2020 20:54:11 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00LKiPUf139141;
        Tue, 21 Jan 2020 20:54:11 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2xnsj5bx6j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jan 2020 20:54:11 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00LKs7er001986;
        Tue, 21 Jan 2020 20:54:07 GMT
Received: from Konrads-MacBook-Pro.local (/10.74.98.244)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 21 Jan 2020 12:54:07 -0800
Date:   Tue, 21 Jan 2020 15:54:03 -0500
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Ashish Kalra <ashish.kalra@amd.com>
Cc:     Konrad Rzeszutek Wilk <konrad@darnok.org>, hch@lst.de,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, luto@kernel.org, peterz@infradead.org,
        dave.hansen@linux-intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, brijesh.singh@amd.com,
        Thomas.Lendacky@amd.com
Subject: Re: [PATCH v2] swiotlb: Adjust SWIOTBL bounce buffer size for SEV
 guests.
Message-ID: <20200121205403.GC75374@Konrads-MacBook-Pro.local>
References: <20191209231346.5602-1-Ashish.Kalra@amd.com>
 <20191220015245.GA7010@localhost.localdomain>
 <20200121200947.GA24884@ashkalra_ubuntu_server>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200121200947.GA24884@ashkalra_ubuntu_server>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9507 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001210156
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9507 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001210156
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 08:09:47PM +0000, Ashish Kalra wrote:
> On Thu, Dec 19, 2019 at 08:52:45PM -0500, Konrad Rzeszutek Wilk wrote:
> > On Mon, Dec 09, 2019 at 11:13:46PM +0000, Ashish Kalra wrote:
> > > From: Ashish Kalra <ashish.kalra@amd.com>
> > > 
> > > For SEV, all DMA to and from guest has to use shared
> > > (un-encrypted) pages. SEV uses SWIOTLB to make this happen
> > > without requiring changes to device drivers. However,
> > > depending on workload being run, the default 64MB of SWIOTLB
> > > might not be enough and SWIOTLB may run out of buffers to
> > > use for DMA, resulting in I/O errors.
> > > 
> > > Increase the default size of SWIOTLB for SEV guests using
> > > a minimum value of 128MB and a maximum value of 512MB,
> > > determining on amount of provisioned guest memory.
> > > 
> > > The SWIOTLB default size adjustment is added as an
> > > architecture specific interface/callback to allow
> > > architectures such as those supporting memory encryption
> > > to adjust/expand SWIOTLB size for their use.
> > 
> > What if this was made dynamic? That is if there is a memory
> > pressure you end up expanding the SWIOTLB dynamically?
> 
> As of now we want to keep it as simple as possible and more
> like a stop-gap arrangement till something more elegant is
> available.

That is nice. But past experience has shown that stop-gap arrangments
end up being the defacto solution.

> 
> > 
> >> Also is it worth doing this calculation based on memory or
> >> more on the # of PCI devices + their MMIO ranges size?
> 
> Additional memory calculations based on # of PCI devices and
> their memory ranges will make it more complicated with so
> many other permutations and combinations to explore, it is
> essential to keep this patch as simple as possible by 
> adjusting the bounce buffer size simply by determining it
> from the amount of provisioned guest memory.

Please rework the patch to:

 - Use a log solution instead of the multiplication.
   Feel free to cap it at a sensible value.

 - Also the code depends on SWIOTLB calling in to the
   adjust_swiotlb_default_size which looks wrong.

   You should not adjust io_tlb_nslabs from swiotlb_size_or_default.
   That function's purpose is to report a value.

 - Make io_tlb_nslabs be visible outside of the SWIOTLB code.

 - Can you utilize the IOMMU_INIT APIs and have your own detect which would
   modify the io_tlb_nslabs (and set swiotbl=1?).

   Actually you seem to be piggybacking on pci_swiotlb_detect_4gb - so
   perhaps add in this code ? Albeit it really should be in it's own
   file, not in arch/x86/kernel/pci-swiotlb.c

 - Tweak the code in the swiotlb code to make sure it can deal
   with io_tlb_nslabs being modified outside of the code at
   the start. It should have no trouble, but only testing will
   tell for sure.

> 
> Thanks,
> Ashish
