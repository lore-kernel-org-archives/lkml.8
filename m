Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B7EC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 11:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D559E20679
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 11:01:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726113AbgFALBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 07:01:55 -0400
Received: from esa6.hc3370-68.iphmx.com ([216.71.155.175]:36067 "EHLO
        esa6.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbgFALBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 07:01:54 -0400
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Jun 2020 07:01:53 EDT
Authentication-Results: esa6.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
IronPort-SDR: dE4OJlvFGeDUUtAzk3Pi5zV28ZQIW5UOP7UQrOT5lcQFU2YWh+Xc0k4Dbio1M5jzIQRGIdcbgX
 T0UA6G1hW8qVM0IXQuYrEA++MNqKuY+BQHzK8tdGNAXiBGrCA+PzIKy+tFZB/X5eMboLe8OBRi
 W/yT9uFgzTE+mD8IurFET4SeUBhqARgj1gOIEfCdjngudjQ7bEGpkuIoJXc0yVJffNpn7AyqoH
 Ac5ZSqvawoklGR18qCojrS7GFT73+YeKkHaDVpPE0iJZTpsNv82xn7a5GQ7gS4FqVLy6QkZWmH
 zDk=
X-SBRS: 2.7
X-MesageID: 19251855
X-Ironport-Server: esa6.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.73,460,1583211600"; 
   d="scan'208";a="19251855"
Date:   Mon, 1 Jun 2020 12:54:37 +0200
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Daniel Kiper <daniel.kiper@oracle.com>
CC:     <grub-devel@gnu.org>, <linux-kernel@vger.kernel.org>,
        <trenchboot-devel@googlegroups.com>, <x86@kernel.org>,
        <xen-devel@lists.xenproject.org>, <michal.zygowski@3mdeb.com>,
        <eric.snowberg@oracle.com>, <mtottenh@akamai.com>,
        <ard.biesheuvel@linaro.org>, <dpsmith@apertussolutions.com>,
        <andrew.cooper3@citrix.com>, <konrad.wilk@oracle.com>,
        <phcoder@gmail.com>, <javierm@redhat.com>, <mjg59@google.com>,
        <alexander.burmashev@oracle.com>, <krystian.hebel@3mdeb.com>,
        <kanth.ghatraju@oracle.com>, <lukasz.hawrylko@linux.intel.com>,
        <ross.philipson@oracle.com>, <hpa@zytor.com>, <leif@nuviainc.com>,
        <pjones@redhat.com>, <alec.brown@oracle.com>,
        <piotr.krol@3mdeb.com>
Subject: Re: [BOOTLOADER SPECIFICATION RFC] The bootloader log format for
 TrenchBoot and others
Message-ID: <20200601105437.GS1195@Air-de-Roger>
References: <20200529112735.qln44ds6z7djheof@tomti.i.net-space.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20200529112735.qln44ds6z7djheof@tomti.i.net-space.pl>
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 01:27:35PM +0200, Daniel Kiper wrote:
> Hey,
> 
> Below you can find my rough idea of the bootloader log format which is
> generic thing but initially will be used for TrenchBoot work. I discussed
> this proposal with Ross and Daniel S. So, the idea went through initial
> sanitization. Now I would like to take feedback from other folks too.
> So, please take a look and complain...
> 
> In general we want to pass the messages produced by the bootloader to the OS
> kernel and finally to the userspace for further processing and analysis. Below
> is the description of the structures which will be used for this thing.
> 
>   struct bootloader_log_msgs
>   {
>     grub_uint32_t level;
>     grub_uint32_t facility;

Nit: if this is aimed at cross-OS and cross-bootloader compatibility
uint32_t should be used here instead of a grub specific alias.

>     char type[];
>     char msg[];

I think you want char * here instead? Or are the above arrays expected
to have a fixed size in the final spec?

>   }
> 
>   struct bootloader_log
>   {
>     grub_uint32_t version;
>     grub_uint32_t producer;
>     grub_uint32_t size;
>     grub_uint32_t next_off;
>     bootloader_log_msgs msgs[];

As I understand it this is not a pointer to an array of
bootloader_log_msgs but rather in-place?

>   }
> 
> The members of struct bootloader_log:
>   - version: the bootloader log format version number, 1 for now,
>   - producer: the producer/bootloader type; we can steal some values from
>     linux/Documentation/x86/boot.rst:type_of_loader,
>   - size: total size of the log buffer including the bootloader_log struct,
>   - next_off: offset in bytes, from start of the bootloader_log struct,
>     of the next byte after the last log message in the msgs[];
>     i.e. the offset of the next available log message slot,

So this will be a memory area that's shared between the OS and the
bootloader and needs to be updated at runtime?

If this is something that's created by the bootloader during loading
and passed to the OS for consumption (but it's not further updated), I
don't see much point in the next_off field. The size field could be
updated to reflect the actual size of the produced messages?

Roger.
