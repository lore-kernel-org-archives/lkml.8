Return-Path: <SRS0=fzvl=3P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA02C35242
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 01:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1942D20709
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 01:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbgAZBoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 20:44:04 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:36814 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727163AbgAZBoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 20:44:03 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R641e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0ToX4oE-_1580003038;
Received: from JosephdeMacBook-Pro.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0ToX4oE-_1580003038)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 26 Jan 2020 09:43:59 +0800
Subject: Re: [PATCH] OCFS2: remove unused macros
To:     Alex Shi <alex.shi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        ChenGang <cg.chen@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Richard Fontana <rfontana@redhat.com>,
        ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org
References: <1579577827-251796-1-git-send-email-alex.shi@linux.alibaba.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <a12fc48c-3165-3519-c2b2-399b06c8b5c6@linux.alibaba.com>
Date:   Sun, 26 Jan 2020 09:43:58 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <1579577827-251796-1-git-send-email-alex.shi@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/1/21 11:37, Alex Shi wrote:
> O2HB_DEFAULT_BLOCK_BITS/DLM_THREAD_MAX_ASTS/DLM_MIGRATION_RETRY_MS and
> OCFS2_MAX_RESV_WINDOW_BITS/OCFS2_MIN_RESV_WINDOW_BITS are
> never used from they were introduced to kernel. so better to remove
> them.
> 
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Mark Fasheh <mark@fasheh.com> 
> Cc: Joel Becker <jlbec@evilplan.org> 
> Cc: Joseph Qi <joseph.qi@linux.alibaba.com> 
> Cc: Andrew Morton <akpm@linux-foundation.org> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org> 
> Cc: Kate Stewart <kstewart@linuxfoundation.org> 
> Cc: ChenGang <cg.chen@huawei.com> 
> Cc: Thomas Gleixner <tglx@linutronix.de> 
> Cc: Richard Fontana <rfontana@redhat.com> 
> Cc: ocfs2-devel@oss.oracle.com 
> Cc: linux-kernel@vger.kernel.org 
> ---
>  fs/ocfs2/cluster/heartbeat.c | 2 --
>  fs/ocfs2/dlm/dlmmaster.c     | 2 --
>  fs/ocfs2/dlm/dlmthread.c     | 1 -
>  fs/ocfs2/reservations.c      | 3 ---
>  4 files changed, 8 deletions(-)
> 
> diff --git a/fs/ocfs2/cluster/heartbeat.c b/fs/ocfs2/cluster/heartbeat.c
> index a368350d4c27..78cb48d6a596 100644
> --- a/fs/ocfs2/cluster/heartbeat.c
> +++ b/fs/ocfs2/cluster/heartbeat.c
> @@ -101,8 +101,6 @@ struct o2hb_debug_buf {
>  
>  static struct o2hb_callback *hbcall_from_type(enum o2hb_callback_type type);
>  
> -#define O2HB_DEFAULT_BLOCK_BITS       9
> -
>  enum o2hb_heartbeat_modes {
>  	O2HB_HEARTBEAT_LOCAL		= 0,
>  	O2HB_HEARTBEAT_GLOBAL,
> diff --git a/fs/ocfs2/dlm/dlmmaster.c b/fs/ocfs2/dlm/dlmmaster.c
> index 74b768ca1cd8..123b6873d9fa 100644
> --- a/fs/ocfs2/dlm/dlmmaster.c
> +++ b/fs/ocfs2/dlm/dlmmaster.c
> @@ -2751,8 +2751,6 @@ static int dlm_migrate_lockres(struct dlm_ctxt *dlm,
>  	return ret;
>  }
>  
> -#define DLM_MIGRATION_RETRY_MS  100
> -
It is no longer used since commit 66effd3c6812 ("ocfs2/dlm: Do not
migrate resource to a node that is leaving the domain").

>  /*
>   * Should be called only after beginning the domain leave process.
>   * There should not be any remaining locks on nonlocal lock resources,
> diff --git a/fs/ocfs2/dlm/dlmthread.c b/fs/ocfs2/dlm/dlmthread.c
> index 61c51c268460..2dd9727537fe 100644
> --- a/fs/ocfs2/dlm/dlmthread.c
> +++ b/fs/ocfs2/dlm/dlmthread.c
> @@ -680,7 +680,6 @@ static void dlm_flush_asts(struct dlm_ctxt *dlm)
>  
>  #define DLM_THREAD_TIMEOUT_MS (4 * 1000)
>  #define DLM_THREAD_MAX_DIRTY  100
> -#define DLM_THREAD_MAX_ASTS   10
>  
>  static int dlm_thread(void *data)
>  {
> diff --git a/fs/ocfs2/reservations.c b/fs/ocfs2/reservations.c
> index 0249e8ca1028..bf3842e34fb9 100644
> --- a/fs/ocfs2/reservations.c
> +++ b/fs/ocfs2/reservations.c
> @@ -33,9 +33,6 @@
>  
>  static DEFINE_SPINLOCK(resv_lock);
>  
> -#define	OCFS2_MIN_RESV_WINDOW_BITS	8
> -#define	OCFS2_MAX_RESV_WINDOW_BITS	1024
> -
>  int ocfs2_dir_resv_allowed(struct ocfs2_super *osb)
>  {
>  	return (osb->osb_resv_level && osb->osb_dir_resv_level);
> 
