Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3551C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 05:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9665D2063A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 05:40:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgHRFkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 01:40:47 -0400
Received: from david.siemens.de ([192.35.17.14]:49134 "EHLO david.siemens.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726382AbgHRFkq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 01:40:46 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by david.siemens.de (8.15.2/8.15.2) with ESMTPS id 07I5efPM017941
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Aug 2020 07:40:41 +0200
Received: from [139.22.40.250] ([139.22.40.250])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 07I5eenx028261;
        Tue, 18 Aug 2020 07:40:40 +0200
Subject: Re: [PATCH 2/2] tasks: Add task_struct addr for lx-ps cmd
To:     Ritesh Harjani <riteshh@linux.ibm.com>,
        Kieran Bingham <kbingham@kernel.org>
Cc:     linux-kernel@vger.kernel.org
References: <cover.1597721575.git.riteshh@linux.ibm.com>
 <99e6236ed1b67140dae967dbf802c0eabd7b0eba.1597721575.git.riteshh@linux.ibm.com>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <1566dd81-a906-068d-ccc9-ed9cde8571d7@siemens.com>
Date:   Tue, 18 Aug 2020 07:40:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <99e6236ed1b67140dae967dbf802c0eabd7b0eba.1597721575.git.riteshh@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.08.20 06:04, Ritesh Harjani wrote:
> task_struct addr in lx-ps cmd seems helpful
> 
> <e.g. o/p>
>       TASK          PID    COMM
> 0xffffffff82c2b8c0   0   swapper/0
> 0xffff888a0ba20040   1   systemd
> 0xffff888a0ba24040   2   kthreadd
> 0xffff888a0ba28040   3   rcu_gp
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> ---
>  scripts/gdb/linux/tasks.py | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/scripts/gdb/linux/tasks.py b/scripts/gdb/linux/tasks.py
> index 0301dc1e0138..17ec19e9b5bf 100644
> --- a/scripts/gdb/linux/tasks.py
> +++ b/scripts/gdb/linux/tasks.py
> @@ -73,11 +73,12 @@ class LxPs(gdb.Command):
>          super(LxPs, self).__init__("lx-ps", gdb.COMMAND_DATA)
>  
>      def invoke(self, arg, from_tty):
> +        gdb.write("{:>10} {:>12} {:>7}\n".format("TASK", "PID", "COMM"))
>          for task in task_lists():
> -            gdb.write("{address} {pid} {comm}\n".format(
> -                address=task,
> -                pid=task["pid"],
> -                comm=task["comm"].string()))
> +            gdb.write("{} {:^5} {}\n".format(
> +                task.format_string().split()[0],
> +                task["pid"].format_string(),
> +                task["comm"].string()))
>  
>  
>  LxPs()
> 

This patch is confusing me. We already dump the task address. What the
patch changes is adding a header and some conversions of the values. Can
you elaborate?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
