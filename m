Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FDAC2D0EE
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 23:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D54020771
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 23:37:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="S05WgtKN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbgC3Xhz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 19:37:55 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:44638 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728980AbgC3Xhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 19:37:55 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02UNNTCo175413;
        Mon, 30 Mar 2020 23:37:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=62p3SqIkPRrTrUQUrnww+150K3Afb4y1vUHtmaHqJDQ=;
 b=S05WgtKNcniGTGoZkZru+F83SF9x+zQgMHlTW8JThcP3UculkmgVkB//MqH/IBuWIsgW
 AhvBqYz5MHQCQLscQocRDwwiIkNDwkXINYYY2riJ6eZ3/PP97vOTrldIal4xgC3zF89E
 Zys5ZHZcEKgpLdq0S0iYvF/HConRjWReUyWEo5M5RVM0lGv01utFD8VLCwsVyXf9MDxO
 vpxkbiJqfQcHYYnZ/2b/TIbva1oeAamBfPdTzW7V6uUMdP5rSSkaTrBH2qkOYm0kuKws
 e8ET8Gln4lknR4zOGV8HsOacIJ61Pu0YmcbKeHTgWdEYGM6FlH7eF8RNA3LJZqCF24as xQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 301xhkss0g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Mar 2020 23:37:24 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02UNMIM5174852;
        Mon, 30 Mar 2020 23:37:24 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 302g4qhm1t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Mar 2020 23:37:24 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02UNbKmi008947;
        Mon, 30 Mar 2020 23:37:20 GMT
Received: from [10.154.136.252] (/10.154.136.252)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 30 Mar 2020 16:37:20 -0700
Subject: Re: [PATCH] swiotlb: Allow swiotlb to live at pre-defined address
To:     Alexander Graf <graf@amazon.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Kairui Song <kasong@redhat.com>,
        Jan Setje-Eilers <jan.setjeeilers@oracle.com>
Cc:     Dave Young <dyoung@redhat.com>, iommu@lists.linux-foundation.org,
        the arch/x86 maintainers <x86@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>, linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, dwmw@amazon.com,
        benh@amazon.com, Jan Kiszka <jan.kiszka@siemens.com>,
        alcioa@amazon.com, aggh@amazon.com, aagch@amazon.com,
        dhr@amazon.com, Laszlo Ersek <lersek@redhat.com>,
        Baoquan He <bhe@redhat.com>, Lianbo Jiang <lijiang@redhat.com>,
        brijesh.singh@amd.com,
        "Lendacky, Thomas" <thomas.lendacky@amd.com>,
        kexec@lists.infradead.org,
        "Schoenherr, Jan H." <jschoenh@amazon.de>
References: <20200326162922.27085-1-graf@amazon.com>
 <20200328115733.GA67084@dhcp-128-65.nay.redhat.com>
 <CACPcB9d_Pz9SRhSsRzqygRR6waV7r8MnGcCP952svnZtpFaxnQ@mail.gmail.com>
 <20200330134004.GA31026@char.us.oracle.com>
 <51432837-8804-0600-c7a3-8849506f999e@amazon.com>
From:   Anthony Yznaga <anthony.yznaga@oracle.com>
Organization: Oracle Corporation
Message-ID: <5dd6e987-8867-9fb8-386a-f86bbe0828e8@oracle.com>
Date:   Mon, 30 Mar 2020 16:37:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <51432837-8804-0600-c7a3-8849506f999e@amazon.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9576 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003300192
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9576 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 malwarescore=0
 clxscore=1011 phishscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003300192
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/30/20 1:42 PM, Alexander Graf wrote:
>
>
> On 30.03.20 15:40, Konrad Rzeszutek Wilk wrote:
>>
>>
>>
>> On Mon, Mar 30, 2020 at 02:06:01PM +0800, Kairui Song wrote:
>>> On Sat, Mar 28, 2020 at 7:57 PM Dave Young <dyoung@redhat.com> wrote:
>>>>
>>>> On 03/26/20 at 05:29pm, Alexander Graf wrote:
>>>>> The swiotlb is a very convenient fallback mechanism for bounce buffering of
>>>>> DMAable data. It is usually used for the compatibility case where devices
>>>>> can only DMA to a "low region".
>>>>>
>>>>> However, in some scenarios this "low region" may be bound even more
>>>>> heavily. For example, there are embedded system where only an SRAM region
>>>>> is shared between device and CPU. There are also heterogeneous computing
>>>>> scenarios where only a subset of RAM is cache coherent between the
>>>>> components of the system. There are partitioning hypervisors, where
>>>>> a "control VM" that implements device emulation has limited view into a
>>>>> partition's memory for DMA capabilities due to safety concerns.
>>>>>
>>>>> This patch adds a command line driven mechanism to move all DMA memory into
>>>>> a predefined shared memory region which may or may not be part of the
>>>>> physical address layout of the Operating System.
>>>>>
>>>>> Ideally, the typical path to set this configuration would be through Device
>>>>> Tree or ACPI, but neither of the two mechanisms is standardized yet. Also,
>>>>> in the x86 MicroVM use case, we have neither ACPI nor Device Tree, but
>>>>> instead configure the system purely through kernel command line options.
>>>>>
>>>>> I'm sure other people will find the functionality useful going forward
>>>>> though and extend it to be triggered by DT/ACPI in the future.
>>>>
>>>> Hmm, we have a use case for kdump, this maybe useful.  For example
>>>> swiotlb is enabled by default if AMD SME/SEV is active, and in kdump
>>>> kernel we have to increase the crashkernel reserved size for the extra
>>>> swiotlb requirement.  I wonder if we can just reuse the old kernel's
>>>> swiotlb region and pass the addr to kdump kernel.
>>>>
>>>
>>> Yes, definitely helpful for kdump kernel. This can help reduce the
>>> crashkernel value.
>>>
>>> Previously I was thinking about something similar, play around the
>>> e820 entry passed to kdump and let it place swiotlb in wanted region.
>>> Simply remap it like in this patch looks much cleaner.
>>>
>>> If this patch is acceptable, one more patch is needed to expose the
>>> swiotlb in iomem, so kexec-tools can pass the right kernel cmdline to
>>> second kernel.
>>
>> We seem to be passsing a lot of data to kexec.. Perhaps something
>> of a unified way since we seem to have a lot of things to pass - disabling
>> IOMMU, ACPI RSDT address, and then this.
>>
>> CC-ing Anthony who is working on something - would you by any chance
>> have a doc on this?
>
>
> I see in general 2 use cases here:
>
>
> 1) Allow for a generic mechanism to have the fully system, individual buses, devices or functions of a device go through a particular, self-contained bounce buffer.
>
> This sounds like the holy grail to a lot of problems. It would solve typical embedded scenarios where you only have a shared SRAM. It solves the safety case (to some extent) where you need to ensure that one device interaction doesn't conflict with another device interaction. It also solves the problem I've tried to solve with the patch here.
>
> It's unfortunately a lot harder than the patch I sent, so it will take me some time to come up with a working patch set.. I suppose starting with a DT binding only is sensible. Worst case, x86 does also support DT ...
>
> (And yes, I'm always happy to review patches if someone else beats me to it)

Not precisely what is described here, but I am working on a somewhat generic mechanism for preserving pages across kexec based on this old RFC patch set: https://lkml.org/lkml/2013/7/1/211.  I expect to post patches soon.

Anthony

>
>
> 2) Reuse the SWIOTLB from the previous boot on kexec/kdump
>
> I see little direct relation to SEV here. The only reason SEV makes it more relevant, is that you need to have an SWIOTLB region available with SEV while without you could live with a disabled IOMMU.
>
> However, I can definitely understand how you would want to have a way to tell the new kexec'ed kernel where the old SWIOTLB was, so it can reuse its memory for its own SWIOTLB. That way, you don't have to reserve another 64MB of RAM for kdump.
>
> What I'm curious on is whether we need to be as elaborate. Can't we just pass the old SWIOTLB as free memory to the new kexec'ed kernel and everything else will fall into place? All that would take is a bit of shuffling on the e820 table pass-through to the kexec'ed kernel, no?
>
>
> Thanks,
>
> Alex
>
>
>
>
> Amazon Development Center Germany GmbH
> Krausenstr. 38
> 10117 Berlin
> Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
> Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
> Sitz: Berlin
> Ust-ID: DE 289 237 879
>
>
>

