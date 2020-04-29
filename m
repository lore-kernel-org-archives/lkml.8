Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D99CC83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 16:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1A5F208FE
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 16:35:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgD2Qfz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 12:35:55 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:58137 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbgD2Qfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 12:35:54 -0400
Received: from fsav106.sakura.ne.jp (fsav106.sakura.ne.jp [27.133.134.233])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 03TGZEqk053301;
        Thu, 30 Apr 2020 01:35:14 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav106.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav106.sakura.ne.jp);
 Thu, 30 Apr 2020 01:35:14 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav106.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 03TGZ70P053248
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 30 Apr 2020 01:35:14 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] printk: Add loglevel for "do not print to consoles".
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Dmitry Safonov <dima@arista.com>,
        Yafang Shao <laoar.shao@gmail.com>
References: <20200424024239.63607-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20200425004609.GE8982@jagdpanzerIV.localdomain>
 <842ff40b-a232-6098-4333-996a3033b30a@i-love.sakura.ne.jp>
 <20200427062117.GC486@jagdpanzerIV.localdomain>
 <4dae86af-1d9a-f5a8-cff6-aa91ec038a79@i-love.sakura.ne.jp>
 <20200428121828.GP28637@dhcp22.suse.cz>
 <b4d74234-8009-9ffd-011f-bd5d1a4b85f6@i-love.sakura.ne.jp>
 <20200428154532.GU28637@dhcp22.suse.cz>
 <b1d507b1-dae7-f526-c74a-d465ddecea6a@i-love.sakura.ne.jp>
 <20200429142106.GG28637@dhcp22.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <a59271f1-b3fc-26d1-f0a2-5ec351d0095e@i-love.sakura.ne.jp>
Date:   Thu, 30 Apr 2020 01:35:04 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200429142106.GG28637@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/04/29 23:21, Michal Hocko wrote:
> I am trying to say that KERN_NO_CONSOLES resembles more a policy than a
> priority. Because I as a developer have no idea whether the message is
> good enough for console or not.

Right, KERN_NO_CONSOLES is not a priority.

> I believe we are free to change kernel log levels as we find a fit. I
> was not aware that KERN_DEBUG messages are automatically filtered out.

Below is the default rules for rsyslog-8.24.0-52.el7 (userspace syslog daemon).
Of course administrators can modify as needed, but notice that KERN_INFO is saved
to /var/log/messages but KERN_DEBUG is saved to nowhere.

----------
# Log all kernel messages to the console.
# Logging much else clutters up the screen.
#kern.*                                                 /dev/console

# Log anything (except mail) of level info or higher.
# Don't log private authentication messages!
*.info;mail.none;authpriv.none;cron.none                /var/log/messages

# The authpriv file has restricted access.
authpriv.*                                              /var/log/secure

# Log all the mail messages in one place.
mail.*                                                  -/var/log/maillog


# Log cron stuff
cron.*                                                  /var/log/cron

# Everybody gets emergency messages
*.emerg                                                 :omusrmsg:*

# Save news errors of level crit and higher in a special file.
uucp,news.crit                                          /var/log/spooler

# Save boot messages also to boot.log
local7.*                                                /var/log/boot.log
----------

> Even if this is the case then this doesn't really disallow admins to
> allow KERN_DEBUG into log files. Dump of the oom eligible tasks is
> arguably a debugging output anyway. So I disagree with your statement.

If dump_tasks() were changed to use KERN_DEBUG, administrators have to add
"kern.debug" rule (at the same time endure a lot of noise from KERN_DEBUG)
in order to record OOM victim candidates for later analysis.

> 
>> If the kernel allows the former to use KERN_NO_CONSOLES in addition to KERN_INFO, the administrator can
>> select from two choices: printing "both the former and the latter" or "only the latter" to consoles.
> 
> I am not really familiar with all the possibilities admins have when
> setting filtering for different consoles but KERN_NO_CONSOLES sounds
> rather alien to the existing priority based approach.

KERN_NO_CONSOLES is not a priority based approach.
KERN_NO_CONSOLES resembles CONSOLE_LOGLEVEL_SILENT.

>                                                       You can fine tune
> priorities and that is all right because they should be reflecting
> importance.

Developer's importance and administrator's interests are different. Any printk()
user is randomly selecting KERN_$LEVEL. Administrators are swayed by having to
record the lowest priority from all interested messages.

>             But global no-consoles doesn't really fit in here because
> each console might require a different policy but the marking is
> unconditional and largely unaware of existing consoles.

Why unconditional? I'm saying that users of KERN_NO_CONSOLES marking (in other
words, "whether the message is good enough for console or not") should be
configurable via e.g. sysctl. If administrators want to use per-console loglevel
setting, they can tell the kernel not to mark KERN_NO_CONSOLES via e.g. sysctl.

