Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D7F3C433E8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 17:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B27F20786
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 17:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="OyCTe/MK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731829AbgG1RGc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 13:06:32 -0400
Received: from esa6.hc3370-68.iphmx.com ([216.71.155.175]:44111 "EHLO
        esa6.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731684AbgG1RGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 13:06:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1595955990;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=NhQlpfgEzw5uIL26d7//uQgtQ8+lTO6nNMY87duUokQ=;
  b=OyCTe/MK30lAmmBevQOYaBhc1kTOGCX2+elGbz35mnBRtL+kTDT9XQ4A
   RJBY4+Hqa9skN6X4Ep2ii6pIa/fD8ahWECBCF1b4rw+V0ZQHpcwQOEzgr
   flWCDPV9WEK3hKqp76FAwbILAkgVx5cU6d/EFvIfw5xsH48ubnHDhoMQl
   g=;
Authentication-Results: esa6.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
IronPort-SDR: Zv07BbGuPhsiZuK1RAL+MXQS7+DkALPbSOLVSZU6zFhcWsNovWd2ezPA0u0r1ydAx+ftO+5rIq
 NYZIB7Ir83eaSN5NLUnEQUwpkSM93rbTHf5FdDjDIWKAeHW5XlIoRUumb0e9wguAvIvp4K7b+H
 wj1PKHL59HxgJHNABW9nSYRmjho8ubni3kkx1ZFgHlasMw2iQH4TLZsXntv6C0nojnpI0osC1H
 P4GfMlvA6ODgHDaodR3qUiDDbVxaEHvhgheUl2K9TujfOtvBGncUzSfPj+3oWbSEcATqj0RXdv
 ExM=
X-SBRS: 2.7
X-MesageID: 23700460
X-Ironport-Server: esa6.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.75,406,1589256000"; 
   d="scan'208";a="23700460"
Subject: Re: [PATCH v3 4/4] xen: add helpers to allocate unpopulated memory
To:     =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
        Julien Grall <julien@xen.org>
CC:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Wei Liu <wl@xen.org>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        David Airlie <airlied@linux.ie>,
        "Yan Yankovskyi" <yyankovskyi@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        "Michal Hocko" <mhocko@kernel.org>, <linux-mm@kvack.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        <xen-devel@lists.xenproject.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Dan Carpenter" <dan.carpenter@oracle.com>
References: <20200727091342.52325-1-roger.pau@citrix.com>
 <20200727091342.52325-5-roger.pau@citrix.com>
 <b5460659-88a5-c2aa-c339-815d5618bcb5@xen.org>
 <20200728165919.GA7191@Air-de-Roger>
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Message-ID: <cb1790b3-2ad0-2c1b-a632-e4fea4b6bcfa@citrix.com>
Date:   Tue, 28 Jul 2020 18:06:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200728165919.GA7191@Air-de-Roger>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-ClientProxiedBy: AMSPEX02CAS01.citrite.net (10.69.22.112) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/2020 17:59, Roger Pau Monné wrote:
> On Tue, Jul 28, 2020 at 05:48:23PM +0100, Julien Grall wrote:
>> Hi,
>>
>> On 27/07/2020 10:13, Roger Pau Monne wrote:
>>> To be used in order to create foreign mappings. This is based on the
>>> ZONE_DEVICE facility which is used by persistent memory devices in
>>> order to create struct pages and kernel virtual mappings for the IOMEM
>>> areas of such devices. Note that on kernels without support for
>>> ZONE_DEVICE Xen will fallback to use ballooned pages in order to
>>> create foreign mappings.
>>>
>>> The newly added helpers use the same parameters as the existing
>>> {alloc/free}_xenballooned_pages functions, which allows for in-place
>>> replacement of the callers. Once a memory region has been added to be
>>> used as scratch mapping space it will no longer be released, and pages
>>> returned are kept in a linked list. This allows to have a buffer of
>>> pages and prevents resorting to frequent additions and removals of
>>> regions.
>>>
>>> If enabled (because ZONE_DEVICE is supported) the usage of the new
>>> functionality untangles Xen balloon and RAM hotplug from the usage of
>>> unpopulated physical memory ranges to map foreign pages, which is the
>>> correct thing to do in order to avoid mappings of foreign pages depend
>>> on memory hotplug.
>> I think this is going to break Dom0 on Arm if the kernel has been built with
>> hotplug. This is because you may end up to re-use region that will be used
>> for the 1:1 mapping of a foreign map.
>>
>> Note that I don't know whether hotplug has been tested on Xen on Arm yet. So
>> it might be possible to be already broken.
>>
>> Meanwhile, my suggestion would be to make the use of hotplug in the balloon
>> code conditional (maybe using CONFIG_ARM64 and CONFIG_ARM)?
> Right, this feature (allocation of unpopulated memory separated from
> the balloon driver) is currently gated on CONFIG_ZONE_DEVICE, which I
> think could be used on Arm.
>
> IMO the right solution seems to be to subtract the physical memory
> regions that can be used for the identity mappings of foreign pages
> (all RAM on the system AFAICT) from iomem_resource, as that would make
> this and the memory hotplug done in the balloon driver safe?

The right solution is a mechanism for translated guests to query Xen to
find regions of guest physical address space which are unused, and can
be safely be used for foreign/grant/other  mappings.

Please don't waste any more time applying more duct tape to a broken
system, and instead spend the time organising some proper foundations.

~Andrew
