Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE1CDC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 23:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC6F920709
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 23:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbgENXZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 19:25:36 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:50980 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbgENXZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 19:25:35 -0400
Received: from fsav405.sakura.ne.jp (fsav405.sakura.ne.jp [133.242.250.104])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 04ENOsH2007040;
        Fri, 15 May 2020 08:24:54 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav405.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav405.sakura.ne.jp);
 Fri, 15 May 2020 08:24:54 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav405.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 04ENOsEO007035
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Fri, 15 May 2020 08:24:54 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] printk: Add loglevel for "do not print to consoles".
To:     Petr Mladek <pmladek@suse.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Dmitry Safonov <dima@arista.com>,
        Yafang Shao <laoar.shao@gmail.com>
References: <a59271f1-b3fc-26d1-f0a2-5ec351d0095e@i-love.sakura.ne.jp>
 <20200513062652.GM413@jagdpanzerIV.localdomain>
 <a75d6560-ad99-5b02-3648-247c27c3a398@i-love.sakura.ne.jp>
 <20200513100413.GH17734@linux-b0ei> <20200513104938.GW29153@dhcp22.suse.cz>
 <d66c38d9-dd97-072d-e1a7-949e9573b38d@i-love.sakura.ne.jp>
 <20200513121942.GK17734@linux-b0ei>
 <2173e3ac-7d5e-24da-0c1e-6472df905767@i-love.sakura.ne.jp>
 <20200514080053.GN17734@linux-b0ei>
 <7af6fc77-986a-8a6a-ea93-b807db44413c@i-love.sakura.ne.jp>
 <20200514162612.GR17734@linux-b0ei>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <aa0e661d-684a-c00c-3484-fa80da564380@i-love.sakura.ne.jp>
Date:   Fri, 15 May 2020 08:24:49 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200514162612.GR17734@linux-b0ei>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/05/15 1:26, Petr Mladek wrote:
> This does not make much sense to me. KERN_NO_CONSOLES would be another
> global flag. If you enable/disable its functionality, it would affect
> all strings with this flag (not only the ones used by OOM killer).

Are you assuming that the switch is applied on KERN_$LEVEL setting (e.g.

  /proc/sys/kernel/print_emerg_messages_on_consoles
  /proc/sys/kernel/print_alert_messages_on_consoles
  /proc/sys/kernel/print_crit_messages_on_consoles
  /proc/sys/kernel/print_err_messages_on_consoles
  /proc/sys/kernel/print_warning_messages_on_consoles
  /proc/sys/kernel/print_notice_messages_on_consoles
  /proc/sys/kernel/print_info_messages_on_consoles
  /proc/sys/kernel/print_debug_messages_on_consoles

) ? Then, that is not what I'm proposing.

The switch I will propose is applied on individual printk() call (e.g.

  printk("%s[%7d] %5d %5d %8lu %8lu %8ld %8lu         %5hd %s\n",
         sysctl_oom_dump_tasks == 2 ? KERN_INFO KERN_NO_CONSOLES : KERN_INFO,
         task->pid, from_kuid(&init_user_ns, task_uid(task)),
         task->tgid, task->mm->total_vm, get_mm_rss(task->mm),
         mm_pgtables_bytes(task->mm),
         get_mm_counter(task->mm, MM_SWAPENTS),
         task->signal->oom_score_adj, task->comm);

) which is NOT another global flag.

Since Dmitry Safonov is working on adding loglevel argument to show_stack(),
we will also be able to implement dump_stack_loglvl(const char *loglvl). Thus,
we will be able to apply KERN_NO_CONSOLES flags to e.g. only dump_stack() /
show_mem() / dump_tasks() etc. WITHOUT MAKING THE SWITCHES GLOBAL.
The direction is heading for "+ loglevel assigned to each message".
