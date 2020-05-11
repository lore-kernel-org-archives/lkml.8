Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98058C54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 10:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EA5320735
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 10:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729535AbgEKKyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 06:54:10 -0400
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:56629 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728573AbgEKKyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 06:54:09 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436287|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.115081-0.00104849-0.883871;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03306;MF=liaoweixiong@allwinnertech.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.HWrnPPN_1589194442;
Received: from 172.16.10.102(mailfrom:liaoweixiong@allwinnertech.com fp:SMTPD_---.HWrnPPN_1589194442)
          by smtp.aliyun-inc.com(10.147.41.231);
          Mon, 11 May 2020 18:54:03 +0800
Subject: Re: [PATCH v7 00/18] pstore: mtd: support crash log to block and mtd
 device
To:     Kees Cook <keescook@chromium.org>
Cc:     Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Rob Herring <robh@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
References: <20200510202436.63222-1-keescook@chromium.org>
From:   WeiXiong Liao <liaoweixiong@allwinnertech.com>
Message-ID: <0586f5cb-991c-3528-dfbf-ee61a39a3955@allwinnertech.com>
Date:   Mon, 11 May 2020 18:54:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20200510202436.63222-1-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees Cook,

On 2020/5/11 AM 4:24, Kees Cook wrote:
> Hi!
> 
> Well, I guess I spoke too soon. :) Here is v7. Hopefully this is
> it. WeiXiong, can you test this and make sure you're happy with the
> results?

I tested it on Allwinner board for all frontends, including panic.
All of them work well! That's a very good news.

> 
> Take care!
> 
> -Kees
> 
> v7:
> - more renamings in the exported APIs and structs
> - fix mtd build
> - replace psblk_blkdev_info with passing in a struct to fill
> - consolidate bdev opening/checking
> - rename psblk_device -> pstore_device_info
> - kerndoc for pstore_blk_get_config
> - fix hunks in wrong patch
> - add missing "static"s for local functions (0day)
> 
> v6: https://lore.kernel.org/lkml/20200509234103.46544-1-keescook@chromium.org/
> v5: https://lore.kernel.org/lkml/1589022854-19821-1-git-send-email-liaoweixiong@allwinnertech.com/
> v4: https://lore.kernel.org/lkml/20200508064004.57898-1-keescook@chromium.org/
> v3: https://lore.kernel.org/lkml/1585126506-18635-1-git-send-email-liaoweixiong@allwinnertech.com/
> v2: https://lore.kernel.org/lkml/1581078355-19647-1-git-send-email-liaoweixiong@allwinnertech.com/
> v1: https://lore.kernel.org/lkml/1579482233-2672-1-git-send-email-liaoweixiong@allwinnertech.com/
> 
> 
> Kees Cook (8):
>   pstore/ram: Move dump_oops to end of module_param list
>   pstore/platform: Switch pstore_info::name to const
>   pstore/platform: Move module params after declarations
>   pstore/platform: Use backend name for console registration
>   pstore/ram: Refactor ftrace buffer merging
>   pstore/ftrace: Provide ftrace log merging routine
>   printk: Introduce kmsg_dump_reason_str()
>   pstore/blk: Introduce "best_effort" mode
> 
> WeiXiong Liao (10):
>   pstore/zone: Introduce common layer to manage storage zones
>   pstore/blk: Introduce backend for block devices
>   pstore/zone,blk: Add support for pmsg frontend
>   pstore/zone,blk: Add console frontend support
>   pstore/zone,blk: Add ftrace frontend support
>   Documentation: Add details for pstore/blk
>   pstore/zone: Provide way to skip "broken" zone for MTD devices
>   pstore/blk: Provide way to query pstore configuration
>   pstore/blk: Support non-block storage devices
>   mtd: Support kmsg dumper based on pstore/blk
> 
>  Documentation/admin-guide/pstore-blk.rst |  243 ++++
>  MAINTAINERS                              |    1 +
>  drivers/mtd/Kconfig                      |   10 +
>  drivers/mtd/Makefile                     |    1 +
>  drivers/mtd/mtdpstore.c                  |  564 +++++++++
>  fs/pstore/Kconfig                        |  109 ++
>  fs/pstore/Makefile                       |    6 +
>  fs/pstore/blk.c                          |  520 ++++++++
>  fs/pstore/ftrace.c                       |   54 +
>  fs/pstore/internal.h                     |    9 +
>  fs/pstore/platform.c                     |   40 +-
>  fs/pstore/ram.c                          |   70 +-
>  fs/pstore/zone.c                         | 1463 ++++++++++++++++++++++
>  include/linux/kmsg_dump.h                |    7 +
>  include/linux/pstore.h                   |    2 +-
>  include/linux/pstore_blk.h               |  118 ++
>  include/linux/pstore_zone.h              |   60 +
>  kernel/printk/printk.c                   |   21 +
>  18 files changed, 3210 insertions(+), 88 deletions(-)
>  create mode 100644 Documentation/admin-guide/pstore-blk.rst
>  create mode 100644 drivers/mtd/mtdpstore.c
>  create mode 100644 fs/pstore/blk.c
>  create mode 100644 fs/pstore/zone.c
>  create mode 100644 include/linux/pstore_blk.h
>  create mode 100644 include/linux/pstore_zone.h
> 

-- 
WeiXiong Liao
