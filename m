Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC0FC10DCE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 20:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E93EF2067C
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 20:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbgCHUPU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 16:15:20 -0400
Received: from smtprelay0098.hostedemail.com ([216.40.44.98]:34838 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726338AbgCHUPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 16:15:20 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id F09ED101B8E96;
        Sun,  8 Mar 2020 20:15:18 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: crowd81_4b54de479a348
X-Filterd-Recvd-Size: 6081
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Sun,  8 Mar 2020 20:15:17 +0000 (UTC)
Message-ID: <0738b8e5422e60cabfbf58d5d812da20128be750.camel@perches.com>
Subject: Re: [PATCH RFC] MAINTAINERS: include GOOGLE FIRMWARE entry
From:   Joe Perches <joe@perches.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Julius Werner <jwerner@chromium.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sun, 08 Mar 2020 13:13:38 -0700
In-Reply-To: <20200308195116.12836-1-lukas.bulwahn@gmail.com>
References: <20200308195116.12836-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-03-08 at 20:51 +0100, Lukas Bulwahn wrote:
> All files in drivers/firmware/google/ are identified as part of THE REST
> according to MAINTAINERS, but they are really maintained by others.
> 
> Add a basic entry for drivers/firmware/google/ based on a simple statistics
> on tags of commits in that directory:
> 
>   $ git log drivers/firmware/google/ | grep '\-by:' \
>       | sort | uniq -c | sort -nr
>      62     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>      13     Reviewed-by: Guenter Roeck <groeck@chromium.org>
>      12     Signed-off-by: Stephen Boyd <swboyd@chromium.org>
>      11     Reviewed-by: Julius Werner <jwerner@chromium.org>
> 
> There is no specific mailing list for this driver, based on observations
> on the patch emails, and the git history suggests the driver is maintained.

The sign-off list is definitely not the MAINTAINER list
as that sign-off list can identify the upstreaming path
and not the actual maintainers.

You should instead try to identify the MAINTAINERS as authors
of the various patches rather than the sign-off list.

And even then you need to isolate the trivial changes from
the actual defect correction and significant features added.

And also time-limit the range of commits as people come and
go and only relatively recent changes should be analyzed.

For instance:

$ git log --since=2-years-ago --no-merges --pretty="%aN <%aE>	%s" -- drivers/firmware/google
Gustavo A. R. Silva <gustavo@embeddedor.com>    firmware: google: vpd: Replace zero-length array with flexible-array member
Gustavo A. R. Silva <gustavo@embeddedor.com>    firmware: google: memconsole: Replace zero-length array with flexible-array member
Arthur Heymans <arthur@aheymans.xyz>    firmware: google: Probe for a GSMI handler in firmware
Arthur Heymans <arthur@aheymans.xyz>    firmware: google: Unregister driver_info on failure and exit in gsmi
Patrick Rudolph <patrick.rudolph@9elements.com> firmware: google: Release devices before unregistering the bus
Brian Norris <briannorris@chromium.org> firmware: google: increment VPD key_len properly
Hung-Te Lin <hungte@chromium.org>       firmware: google: check if size is valid when decoding VPD data
Thomas Gleixner <tglx@linutronix.de>    treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 287
Stephen Boyd <swboyd@chromium.org>      firmware: google: coreboot: Drop unnecessary headers
Stephen Boyd <swboyd@chromium.org>      firmware: google: memconsole: Drop global func pointer
Stephen Boyd <swboyd@chromium.org>      firmware: google: memconsole: Drop __iomem on memremap memory
Stephen Boyd <swboyd@chromium.org>      firmware: google: memconsole: Use devm_memremap()
Stephen Boyd <swboyd@chromium.org>      firmware: google: Add a module_coreboot_driver() macro and use it
Thomas Gleixner <tglx@linutronix.de>    treewide: Add SPDX license identifier - Makefile/Kconfig
Thomas Gleixner <tglx@linutronix.de>    treewide: Add SPDX license identifier for more missed files
Stephen Boyd <swboyd@chromium.org>      firmware: vpd: Drop __iomem usage for memremap() memory
Furquan Shaikh <furquan@chromium.org>   gsmi: Add GSMI commands to log S0ix info
Duncan Laurie <dlaurie@chromium.org>    gsmi: Remove autoselected dependency on EFI and EFI_VARS
Duncan Laurie <dlaurie@chromium.org>    gsmi: Add coreboot to list of matching BIOS vendors
Duncan Laurie <dlaurie@chromium.org>    gsmi: Fix bug in append_to_eventlog sysfs handler
Colin Ian King <colin.king@canonical.com>       firmware: vpd: fix spelling mistake "partion" -> "partition"
Stephen Boyd <swboyd@chromium.org>      firmware: coreboot: Only populate devices in coreboot_table_init()
Stephen Boyd <swboyd@chromium.org>      firmware: coreboot: Remap RAM with memremap() instead of ioremap()
Stephen Boyd <swboyd@chromium.org>      firmware: coreboot: Collapse platform drivers into bus core
Stephen Boyd <swboyd@chromium.org>      firmware: coreboot: Make bus registration symmetric
Stephen Boyd <swboyd@chromium.org>      firmware: coreboot: Unmap ioregion after device population
Stephen Boyd <swboyd@chromium.org>      firmware: coreboot: Let OF core populate platform device
Colin Ian King <colin.king@canonical.com>       firmware: google: make structure gsmi_dev static
Anton Vasilyev <vasilyev@ispras.ru>     firmware: vpd: Fix section enabled flag on vpd_section_destroy
Samuel Holland <samuel@sholland.org>    firmware: coreboot: Add coreboot framebuffer driver
Samuel Holland <samuel@sholland.org>    firmware: coreboot: Remove unused coreboot_table_find
Samuel Holland <samuel@sholland.org>    firmware: vpd: Probe via coreboot bus
Samuel Holland <samuel@sholland.org>    firmware: memconsole: Probe via coreboot bus
Samuel Holland <samuel@sholland.org>    firmware: coreboot: Expose the coreboot table as a bus

Thomas Gleixner did licensing changes treewide which
would have no maintainer role, Gustavo Silva did generic
style changes and Stephen Boyd is really the only party
here that has done fundamental changes.

It's not an easy problem, but adding

