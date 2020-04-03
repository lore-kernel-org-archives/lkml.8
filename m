Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA5EC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 23:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 277E220721
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 23:45:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbgDCXpy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 19:45:54 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:56874 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725268AbgDCXpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 19:45:53 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0TuXvTsk_1585957549;
Received: from JosephdeMacBook-Pro.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0TuXvTsk_1585957549)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 04 Apr 2020 07:45:50 +0800
Subject: Re: [PATCH 3/5] ocfs2: Add missing annotation for dlm_empty_lockres()
To:     Jules Irenge <jbi.octave@gmail.com>, linux-kernel@vger.kernel.org
Cc:     boqun.feng@gmail.com, Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Gang He <ghe@suse.com>, Richard Fontana <rfontana@redhat.com>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Aditya Pakki <pakki001@umn.edu>, ChenGang <cg.chen@huawei.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "moderated list:ORACLE CLUSTER FILESYSTEM 2 (OCFS2)" 
        <ocfs2-devel@oss.oracle.com>
References: <0/5> <20200403160505.2832-1-jbi.octave@gmail.com>
 <20200403160505.2832-4-jbi.octave@gmail.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <5408edd7-87a9-ac56-5c52-c2a19c308311@linux.alibaba.com>
Date:   Sat, 4 Apr 2020 07:45:49 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200403160505.2832-4-jbi.octave@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/4/4 00:05, Jules Irenge wrote:
> Sparse reports a warning at dlm_empty_lockres()
> 
> warning: context imbalance in dlm_purge_lockres() - unexpected unlock
> 
> The root cause is the missing annotation at dlm_purge_lockres()
> 
> Add the missing __must_hold(&dlm->spinlock)
> 
Seems this is duplicate with assert_spin_locked()?

Thanks,
Joseph

> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
> ---
>  fs/ocfs2/dlm/dlmmaster.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/ocfs2/dlm/dlmmaster.c b/fs/ocfs2/dlm/dlmmaster.c
> index 900f7e466d11..8cbd46b3509a 100644
> --- a/fs/ocfs2/dlm/dlmmaster.c
> +++ b/fs/ocfs2/dlm/dlmmaster.c
> @@ -2762,6 +2762,7 @@ static int dlm_migrate_lockres(struct dlm_ctxt *dlm,
>   * Returns: 1 if dlm->spinlock was dropped/retaken, 0 if never dropped
>   */
>  int dlm_empty_lockres(struct dlm_ctxt *dlm, struct dlm_lock_resource *res)
> +	__must_hold(&dlm->spinlock)
>  {
>  	int ret;
>  	int lock_dropped = 0;
> 
