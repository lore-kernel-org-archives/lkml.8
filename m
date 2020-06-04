Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C7DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 08:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5E8220738
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 08:45:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbgFDIpg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 04:45:36 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5850 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728021AbgFDIpd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 04:45:33 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9FA35AB0C11E63B23BD3;
        Thu,  4 Jun 2020 16:45:27 +0800 (CST)
Received: from [127.0.0.1] (10.67.102.197) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Thu, 4 Jun 2020
 16:45:21 +0800
Subject: Re: [PATCH 13/13] fs: move binfmt_misc sysctl to its own file
To:     Luis Chamberlain <mcgrof@kernel.org>, <keescook@chromium.org>,
        <yzaikin@google.com>, <ebiederm@xmission.com>, <axboe@kernel.dk>,
        <clemens@ladisch.de>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>, <jani.nikula@linux.intel.com>,
        <joonas.lahtinen@linux.intel.com>, <rodrigo.vivi@intel.com>,
        <airlied@linux.ie>, <daniel@ffwll.ch>, <benh@kernel.crashing.org>,
        <rdna@fb.com>, <viro@zeniv.linux.org.uk>, <mark@fasheh.com>,
        <jlbec@evilplan.org>, <joseph.qi@linux.alibaba.com>,
        <vbabka@suse.cz>, <sfr@canb.auug.org.au>, <jack@suse.cz>,
        <amir73il@gmail.com>, <rafael@kernel.org>, <tytso@mit.edu>
CC:     <julia.lawall@lip6.fr>, <akpm@linux-foundation.org>,
        <intel-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linuxppc-dev@lists.ozlabs.org>,
        <ocfs2-devel@oss.oracle.com>, <linux-kernel@vger.kernel.org>,
        <wangle6@huawei.com>, <alex.huangjianhui@huawei.com>,
        <laiyuanyuan.lai@huawei.com>
References: <20200529074108.16928-1-mcgrof@kernel.org>
 <20200529074108.16928-14-mcgrof@kernel.org>
From:   Xiaoming Ni <nixiaoming@huawei.com>
Message-ID: <6cbba430-a768-72db-bd45-bcbba0376219@huawei.com>
Date:   Thu, 4 Jun 2020 16:45:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200529074108.16928-14-mcgrof@kernel.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.197]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/5/29 15:41, Luis Chamberlain wrote:
> This moves the binfmt_misc sysctl to its own file to help remove
> clutter from kernel/sysctl.c.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>   fs/binfmt_misc.c | 1 +
>   kernel/sysctl.c  | 7 -------
>   2 files changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
> index f69a043f562b..656b3f5f3bbf 100644
> --- a/fs/binfmt_misc.c
> +++ b/fs/binfmt_misc.c
> @@ -821,6 +821,7 @@ static int __init init_misc_binfmt(void)
>   	int err = register_filesystem(&bm_fs_type);
>   	if (!err)
>   		insert_binfmt(&misc_format);
> +	register_sysctl_empty_subdir("fs", "binfmt_misc");
>   	return err;
>   }
build error when CONFIG_BINFMT_MISC=m

ERROR: modpost: "register_sysctl_empty_subdir" [fs/binfmt_misc.ko] 
undefined!

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 27f0c9ea..4129dfb 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2853,6 +2853,7 @@ void register_sysctl_empty_subdir(const char *base,
  {
         register_sysctl_subdir(base, subdir, sysctl_mount_point);
  }
+EXPORT_SYMBOL_GPL(register_sysctl_empty_subdir);
  #endif /* CONFIG_SYSCTL */


Thanks
Xiaoming Ni


