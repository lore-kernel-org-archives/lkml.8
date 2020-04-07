Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2309C2BABC
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 06:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B49C620644
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 06:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgDGGj5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 02:39:57 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:34233 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726030AbgDGGj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 02:39:57 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TusvTcJ_1586241590;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TusvTcJ_1586241590)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 07 Apr 2020 14:39:50 +0800
Subject: Re: [PATCH v5] Translate debugfs.txt into Chinese and link it to the
 index.
To:     Chucheng Luo <luochucheng@vivo.com>,
        Harry Wei <harryxiyou@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com
References: <20200328122315.4245-1-luochucheng@vivo.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <83019620-ed71-7efb-7ccd-6bbb52f9ee3f@linux.alibaba.com>
Date:   Tue, 7 Apr 2020 14:39:50 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200328122315.4245-1-luochucheng@vivo.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chucheng,

Sorry for a bit late.
This patch is still have some place to improve.


在 2020/3/28 下午8:23, Chucheng Luo 写道:
> Translate Documentation/filesystems/debugfs.txt into Chinese.
> 
> Signed-off-by: Chucheng Luo <luochucheng@vivo.com>
> ---
> Changelog:
> v5:
>  - include disclaimer-zh_CN.rst
>  - fix space missing between debugfs.txt and its reference
>  - remove redundant '=' in caption
>  - no 'introduction' in original file, remove it
>  - keep each line less than 80 chars>  - change 'attention' to 'Note' in second last line
> ---
>  .../zh_CN/filesystems/debugfs.rst             | 258 ++++++++++++++++++
>  .../translations/zh_CN/filesystems/index.rst  |  21 ++
>  Documentation/translations/zh_CN/index.rst    |   2 +
>  3 files changed, 281 insertions(+)
>  create mode 100644 Documentation/translations/zh_CN/filesystems/debugfs.rst
>  create mode 100644 Documentation/translations/zh_CN/filesystems/index.rst
> 
> diff --git a/Documentation/translations/zh_CN/filesystems/debugfs.rst b/Documentation/translations/zh_CN/filesystems/debugfs.rst
> new file mode 100644
> index 000000000000..c33d3c797b4a
> --- /dev/null
> +++ b/Documentation/translations/zh_CN/filesystems/debugfs.rst
> @@ -0,0 +1,258 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +.. include:: ../disclaimer-zh_CN.rst
> +
> +:Original: :ref:`Documentation/filesystems/debugfs.txt <debugfs_index>`
> +
> +=======
> +Debugfs
> +=======
> +
> +译者
> +::
> +
> +	中文版维护者： 罗楚成 Chucheng Luo <luochucheng@vivo.com>
> +	中文版翻译者： 罗楚成 Chucheng Luo <luochucheng@vivo.com>
> +	中文版校译者:  罗楚成 Chucheng Luo <luochucheng@vivo.com>
> +
> +
> +
> +版权所有2020 罗楚成 <luochucheng@vivo.com>
> +
> +
> +Debugfs是内核开发人员在用户空间获取信息的简单方法。
> +与/proc不同，proc只提供进程信息。
> +也不像sysfs,具有严格的“每个文件一个值“的规则。
> +debugfs根本没有规则,开发人员可以在这里放置他们
> +想要的任何信息。debugfs文件系统也不能用作稳定的ABI接口。
> +从理论上讲，debugfs导出文件的时候没有任何约束。
> +但是[1]实际情况并不总是那么简单。
> +即使是debugfs接口，也最好根据需要进行设计,
> +并尽量保持接口不变。

This is one section, except no more 80 chars, we'd better
to keep them as one section too. So fulfill each lines, and 
don't close too ealry until 80 chars.

And this requriment is also apply to following sections.

> +
> +

...

> +注释：
> +[1] http://lwn.net/Articles/309298/
> diff --git a/Documentation/translations/zh_CN/filesystems/index.rst b/Documentation/translations/zh_CN/filesystems/index.rst
> new file mode 100644
> index 000000000000..3a7f5233767d
> --- /dev/null
> +++ b/Documentation/translations/zh_CN/filesystems/index.rst
> @@ -0,0 +1,21 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +===============================
> +Linux 内核中的文件系统
> +===============================

The '=' char is also too long to surpass contents. please change
them too. (as well as the '-' in following lines)
As to a same style issue. please check whole patch, not only
the comment line.


Btw, before sent out your patch, would you change the 
'charset=y' to 'charset=UTF-8'?

Thanks
Alex

> +
> +这个不完整的指南在某一天将会提供关于Linux 虚拟文件系统(VFS)层如何工作的
> +完整信息。以及VFS以下的的文件系统。目前为止，我们提供了以下信息。
> +
> +
> +
> +
> +文件系统
> +===========> +
> +关于文件系统实现的文档.
> +
> +.. toctree::
> +   :maxdepth: 2
> +
> +   debugfs
> diff --git a/Documentation/translations/zh_CN/index.rst b/Documentation/translations/zh_CN/index.rst
> index d3165535ec9e..770f886d081c 100644
> --- a/Documentation/translations/zh_CN/index.rst
> +++ b/Documentation/translations/zh_CN/index.rst
> @@ -1,3 +1,4 @@
> +.. SPDX-License-Identifier: GPL-2.0
>  .. raw:: latex
>  
>  	\renewcommand\thesection*
> @@ -14,6 +15,7 @@
>     :maxdepth: 2
>  
>     process/index
> +   filesystems/index
>  
>  目录和表格
>  ----------
> 
