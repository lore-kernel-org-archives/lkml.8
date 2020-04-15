Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B466EC3815B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 08:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EF9920768
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 08:34:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404960AbgDOIeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 04:34:24 -0400
Received: from m17617.mail.qiye.163.com ([59.111.176.17]:11921 "EHLO
        m17617.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgDOIeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 04:34:18 -0400
Received: from wangqing-virtual-machine.localdomain (unknown [157.0.31.122])
        by m17617.mail.qiye.163.com (Hmail) with ESMTPA id AC17A2623E5;
        Wed, 15 Apr 2020 16:34:10 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] [V2 1/2]sched:add task_running_oncpu
Date:   Wed, 15 Apr 2020 16:34:05 +0800
Message-Id: <1586939645-2470-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1586779466-4439-2-git-send-email-wangqing@vivo.com>
References: <1586779466-4439-2-git-send-email-wangqing@vivo.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZSVVLTk5CQkJCQk9JTExCTllXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nhw6CDo6NzgyKAlLD0MxP0sP
        Ix0aCixVSlVKTkNNQkhCTU5LQ0hMVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZSk5M
        VUtVSEpVSklJWVdZCAFZQUlJS0g3Bg++
X-HM-Tid: 0a717cf962af9375kuwsac17a2623e5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On Tue, Apr 14, 2020 at 09:20:57AM +0200, Vincent Guittot wrote:
>> On Mon, 13 Apr 2020 at 14:04, Wang Qing <wangqing@vivo.com> wrote:
>> >
>> > We have no interface whether the task is running,
>> > so we need to add an interface and distinguish CONFIG_SMP.
>> >
>> > Signed-off-by: Wang Qing <wangqing@vivo.com>
>> > ---
>> >  include/linux/sched.h | 10 ++++++++++
>> >  1 file changed, 10 insertions(+)
>> >
>> > diff --git a/include/linux/sched.h b/include/linux/sched.h
>> > index 4418f5c..13cc8f5 100644
>> > --- a/include/linux/sched.h
>> > +++ b/include/linux/sched.h
>> > @@ -1843,6 +1843,11 @@ static inline unsigned int task_cpu(const struct task_struct *p)
>> >
>> >  extern void set_task_cpu(struct task_struct *p, unsigned int cpu);
>> >
>> > +static inline int task_running_oncpu(const struct task_struct *p)
>> 
>> This function name is too close from task_running_on_cpu() and can be
>> misleading as the difference is only "_"
>> Also, how task_running_oncpu() is different from task_running() ?
>
>It doesn't have the (arguably superfluous) rq argument. But yes, agreed,
>if anything lift that thing (without the argument).

I think task_running() should be renamed to task_running_on_rq() like
the naming of task_running_on_cpu(), this is what it originally mean,
and add task_running() (with the task argument only).

I updated the patch for that.
