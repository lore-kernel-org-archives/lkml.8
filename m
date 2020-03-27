Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3115C2D0E7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 09:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C048D20578
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 09:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="FOMeTWdR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbgC0J7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 05:59:05 -0400
Received: from mout.web.de ([212.227.17.11]:48729 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbgC0J7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 05:59:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1585303125;
        bh=3sJu9fUArkbibaP7WFaKAEzBqN+q83Qrxfjqw40JE6M=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=FOMeTWdRP5Eq/kmssOzWMXzpWckepwiZa8XLZnpzSmVHwM/Wpzli/svaTVQCA8KRs
         FdBtlRpT/mnjCrt1aLSZfG9jMCto/q+8HKIStBsiVgtM/nHTWoewJw1Xheq/REYPOl
         9sFNduTJJIsIMdb4sZh76/GwWiKv7Yxj+OxI7Is8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.10] ([95.157.55.156]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Le4Lg-1jaMzw3m0K-00psvk; Fri, 27
 Mar 2020 10:58:45 +0100
Subject: Re: [PATCH] swiotlb: Allow swiotlb to live at pre-defined address
To:     Alexander Graf <graf@amazon.com>, iommu@lists.linux-foundation.org
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, x86@kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        dwmw@amazon.com, benh@amazon.com, alcioa@amazon.com,
        aggh@amazon.com, aagch@amazon.com, dhr@amazon.com
References: <20200326162922.27085-1-graf@amazon.com>
From:   Jan Kiszka <jan.kiszka@web.de>
Message-ID: <9ff68753-20d1-62b1-6250-91ed4beb1bde@web.de>
Date:   Fri, 27 Mar 2020 10:58:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200326162922.27085-1-graf@amazon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PdNtUhVPObC1NxI5ax+8GQe3v47vjTq4mEi/59bmOUWMu8JZqRT
 TNsTyDMgV8WUeg5bRVyv6+8YkM5TSW3rx1+/2MwfU3JfQDCCwUpNZyLngpOBHLtQ4yZEokN
 9Srm+Yp8CXFi0oImvFpp+VZZAGxD/8rob6pQYSNrIwWC6pwbq78YBDWjj7y5Wvtw/FICW73
 39eDdNmuXDeVlwXfDcYww==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yc+0mO+tq5w=:bs26ghpzYfEHeSNgiR/cxk
 qn5cFDWow2uB1Q8hzYS++4jk6MRQO1NS24MjTgkFukmI7h8blEstF1DgaQ+pvkrAMMipH97HK
 fRYwtiLvE0wE7Qdmxd+63EodXC9wP0zjEVTnxQq7P63BazGxO7S0GLEJByvuh/6HS62tv9ew+
 P0CZ5P/rkald9bPj7rXArwRwxZDUbsK5qIVMpJpBWqYVgUkjkGiFHv5GxWqJPYjxvL4f9nyxV
 bcuWFVS6I6UlGhM/1IvUZLAsV876+nRRUAiQ7V8GNEsjFy7SEj/A2okKv9Mi+bEs3iYBSeD5R
 DDar4nrE65D+blKX6CAz+cEiZMYaVhkK8ddqp4i0/3t68qD1G0NuIGOpleI34oq4qIRuzAfab
 CErKH/UXBkqk8XEJMeLimQEMTepz5+7fbVCONVwx5NI68RPm+LApdueKgIyUiGzWn5ve5mGya
 oUP1T50PaRofQ1vUilOpVC8muIum2t/wcK/e5Y7t9148BXSZr4rKdgMBff58N7nmGIQBXJyTK
 8DmcLFDLKHF1xAS/ItRytGalJ0+h0kXhdYF2t9Z/4boqcJ3dbaWSoz3DuKzUY2oYfI1hwMOoz
 nvcNGmt1DMbG4JQ3tt8mA/KT/Q5jVec2cuKOGvTzQOKM0Q6CUeZ/QMaRutpFiel+o6k98yAb7
 KlzYXFnSCuHVAvzVwvSUhizU2nF/1xmEPFXNQxhRgAt1tLJzLekBZ5qe3eNtxg6NHyP6N7v0I
 lQFIX9Tm4Eg1eCXl2TfY9KoQKq53vF/V2ThhYoLEL7DOohCVWQ17Fo3YRilwON7SnR/5W+SCk
 S4Tg2OWiJ7n5MU97jWlSKewChMlCGJW2qqCODzZ82EKVsBjGuZacJk8HAdE6xmQAtUnuTv5xH
 uq1fm92lH90rv2WMJM0u9N4EnWy/Ez/yF+wi9Yu42IAqJxHKaLoqjZqRShcIich0MZJKq40K0
 lgfE3qrxeGvNE9dTl9TaFGmYkeWgZeFMhUXeWdmpORU26MdBA7exRoJuBRLQPCjoYEa5d+fLR
 aYtTLh7cMroAFgn/pVi0EjLIkYH1XHR7qj46p0yB4Fjwo794q3JWWfrp7mNMmByyNH7UdZWjz
 VYfQwQA/1KrBbFzNjYelnSyHT6cNRTgF+MIo2kGzSVFkrA3tfUnNzeEl1tHFqSpVM9wKXayd1
 6MEqAK50K4x2Y+yYcNGJmwb5SzULGS2h6LW6i8meC6OBSI69+U3sc5M+NxkDCMmrFlkNRzzfK
 diZRZZ8kpd4amq0dq
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.03.20 17:29, Alexander Graf wrote:
> The swiotlb is a very convenient fallback mechanism for bounce buffering=
 of
> DMAable data. It is usually used for the compatibility case where device=
s
> can only DMA to a "low region".
>
> However, in some scenarios this "low region" may be bound even more
> heavily. For example, there are embedded system where only an SRAM regio=
n
> is shared between device and CPU. There are also heterogeneous computing
> scenarios where only a subset of RAM is cache coherent between the
> components of the system. There are partitioning hypervisors, where
> a "control VM" that implements device emulation has limited view into a
> partition's memory for DMA capabilities due to safety concerns.
>
> This patch adds a command line driven mechanism to move all DMA memory i=
nto
> a predefined shared memory region which may or may not be part of the
> physical address layout of the Operating System.
>
> Ideally, the typical path to set this configuration would be through Dev=
ice
> Tree or ACPI, but neither of the two mechanisms is standardized yet. Als=
o,
> in the x86 MicroVM use case, we have neither ACPI nor Device Tree, but
> instead configure the system purely through kernel command line options.
>
> I'm sure other people will find the functionality useful going forward
> though and extend it to be triggered by DT/ACPI in the future.
>
> Signed-off-by: Alexander Graf <graf@amazon.com>
> ---
>   Documentation/admin-guide/kernel-parameters.txt |  3 +-
>   Documentation/x86/x86_64/boot-options.rst       |  4 ++-
>   kernel/dma/swiotlb.c                            | 46 +++++++++++++++++=
++++++--
>   3 files changed, 49 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documenta=
tion/admin-guide/kernel-parameters.txt
> index c07815d230bc..d085d55c3cbe 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4785,11 +4785,12 @@
>   			it if 0 is given (See Documentation/admin-guide/cgroup-v1/memory.rs=
t)
>
>   	swiotlb=3D	[ARM,IA-64,PPC,MIPS,X86]
> -			Format: { <int> | force | noforce }
> +			Format: { <int> | force | noforce | addr=3D<phys addr> }
>   			<int> -- Number of I/O TLB slabs
>   			force -- force using of bounce buffers even if they
>   			         wouldn't be automatically used by the kernel
>   			noforce -- Never use bounce buffers (for debugging)
> +			addr=3D<phys addr> -- Try to allocate SWIOTLB at defined address
>
>   	switches=3D	[HW,M68k]
>
> diff --git a/Documentation/x86/x86_64/boot-options.rst b/Documentation/x=
86/x86_64/boot-options.rst
> index 2b98efb5ba7f..ca46c57b68c9 100644
> --- a/Documentation/x86/x86_64/boot-options.rst
> +++ b/Documentation/x86/x86_64/boot-options.rst
> @@ -297,11 +297,13 @@ iommu options only relevant to the AMD GART hardwa=
re IOMMU:
>   iommu options only relevant to the software bounce buffering (SWIOTLB)=
 IOMMU
>   implementation:
>
> -    swiotlb=3D<pages>[,force]
> +    swiotlb=3D<pages>[,force][,addr=3D<phys addr>]
>         <pages>
>           Prereserve that many 128K pages for the software IO bounce buf=
fering.
>         force
>           Force all IO through the software TLB.
> +      addr=3D<phys addr>
> +        Try to allocate SWIOTLB at defined address
>
>   Settings for the IBM Calgary hardware IOMMU currently found in IBM
>   pSeries and xSeries machines
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index c19379fabd20..83da0caa2f93 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -46,6 +46,7 @@
>   #include <linux/init.h>
>   #include <linux/memblock.h>
>   #include <linux/iommu-helper.h>
> +#include <linux/io.h>
>
>   #define CREATE_TRACE_POINTS
>   #include <trace/events/swiotlb.h>
> @@ -102,6 +103,12 @@ unsigned int max_segment;
>   #define INVALID_PHYS_ADDR (~(phys_addr_t)0)
>   static phys_addr_t *io_tlb_orig_addr;
>
> +/*
> + * The TLB phys addr may be defined on the command line. Store it here =
if it is.
> + */
> +static phys_addr_t io_tlb_addr =3D INVALID_PHYS_ADDR;
> +
> +
>   /*
>    * Protect the above data structures in the map and unmap calls
>    */
> @@ -119,11 +126,23 @@ setup_io_tlb_npages(char *str)
>   	}
>   	if (*str =3D=3D ',')
>   		++str;
> -	if (!strcmp(str, "force")) {
> +	if (!strncmp(str, "force", 5)) {
>   		swiotlb_force =3D SWIOTLB_FORCE;
> -	} else if (!strcmp(str, "noforce")) {
> +		str +=3D 5;
> +	} else if (!strncmp(str, "noforce", 7)) {
>   		swiotlb_force =3D SWIOTLB_NO_FORCE;
>   		io_tlb_nslabs =3D 1;
> +		str +=3D 7;
> +	}
> +
> +	if (*str =3D=3D ',')
> +		++str;
> +	if (!strncmp(str, "addr=3D", 5)) {
> +		char *addrstr =3D str + 5;
> +
> +		io_tlb_addr =3D kstrtoul(addrstr, 0, &str);
> +		if (addrstr =3D=3D str)
> +			io_tlb_addr =3D INVALID_PHYS_ADDR;
>   	}
>
>   	return 0;
> @@ -239,6 +258,25 @@ int __init swiotlb_init_with_tbl(char *tlb, unsigne=
d long nslabs, int verbose)
>   	return 0;
>   }
>
> +static int __init swiotlb_init_io(int verbose, unsigned long bytes)
> +{
> +	unsigned __iomem char *vstart;
> +
> +	if (io_tlb_addr =3D=3D INVALID_PHYS_ADDR)
> +		return -EINVAL;
> +
> +	vstart =3D memremap(io_tlb_addr, bytes, MEMREMAP_WB);
> +	if (!vstart)
> +		return -EINVAL;
> +
> +	if (swiotlb_init_with_tbl(vstart, io_tlb_nslabs, verbose)) {
> +		memunmap(vstart);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>   /*
>    * Statically reserve bounce buffer space and initialize bounce buffer=
 data
>    * structures for the software IO TLB used to implement the DMA API.
> @@ -257,6 +295,10 @@ swiotlb_init(int verbose)
>
>   	bytes =3D io_tlb_nslabs << IO_TLB_SHIFT;
>
> +	/* Map IO TLB from device memory */
> +	if (!swiotlb_init_io(verbose, bytes))
> +		return;
> +
>   	/* Get IO TLB memory from the low pages */
>   	vstart =3D memblock_alloc_low(PAGE_ALIGN(bytes), PAGE_SIZE);
>   	if (vstart && !swiotlb_init_with_tbl(vstart, io_tlb_nslabs, verbose))
>

To make this useful also for shared-memory based devices, it should not
only have a command-line independent interface. Multi-instance support
would be needed so that you can attach swiotlb with individual address
ranges to devices that need it and leave it alone for other that do not
(e.g. passed-through guest devices).

Jan
