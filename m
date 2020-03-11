Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	PDS_HP_HELO_NORDNS,RDNS_NONE,SPF_HELO_NONE,SPF_NONE,SPOOFED_FREEMAIL_NO_RDNS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39884 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730096AbgCKQfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 12:35:23 -0400
MIME-Version: 1.0
References: <CAOMZO5CrvxZDuRfBvwLV6uJJwtPuj1-vqoELKP3j15k3TbSjyg@mail.gmail.com>
 <20200301100755.4532-1-hdanton@sina.com> <20200309120327.3656-1-hdanton@sina.com>
In-Reply-To: <20200309120327.3656-1-hdanton@sina.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 11 Mar 2020 13:35:09 -0300
Message-ID: <CAOMZO5B54o=RSKH7-k=cUv5umusgU67XLV9SRNr3AJY-WqKnEA@mail.gmail.com>
Subject: Re: rcu_sched stalls on 4.14
To: Hillf Danton <hdanton@sina.com>
Cc: paulmck@kernel.org, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Hillf and Paul,

On Mon, Mar 9, 2020 at 9:03 AM Hillf Danton <hdanton@sina.com> wrote:

> Hi Fabio, two minutes to take a look at the softirq part in the syzbot report
> BUG: soft lockup in sys_exit_group.
>
> https://lore.kernel.org/lkml/s5h8sk9svdd.wl-tiwai@suse.de/T/#m0402638ecd30cf5a3c8bb44f03952ccad7a041d8

A different user reported the same bug and it turns out it was an USB
CDC ACM related issue:
https://www.spinics.net/lists/linux-usb/msg192162.html

Thanks for your help!

Fabio Estevam

