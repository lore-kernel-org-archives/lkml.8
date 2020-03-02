Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B449C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 09:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17E9A246B4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 09:11:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbgCBJLC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 04:11:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:51082 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbgCBJLC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 04:11:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E6043AF2D;
        Mon,  2 Mar 2020 09:11:00 +0000 (UTC)
Subject: Re: [PATCH] xen: Use 'unsigned int' instead of 'unsigned'
To:     Yan Yankovskyi <yyankovskyi@gmail.com>
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <20200229223035.GA28145@kbp1-lhp-F74019>
From:   Jan Beulich <jbeulich@suse.com>
Message-ID: <fba833c4-3173-0094-b4ec-53e9f42bfb3e@suse.com>
Date:   Mon, 2 Mar 2020 10:11:00 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200229223035.GA28145@kbp1-lhp-F74019>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.02.2020 23:30, Yan Yankovskyi wrote:
> Resolve the following warning, reported by checkpatch.pl:
> WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
> 
> No functional change.

IMO a change like this would ideally go a little further and try
to use the actually designated types when adjusting them anyway,
e.g. ...

> --- a/drivers/xen/events/events_2l.c
> +++ b/drivers/xen/events/events_2l.c
> @@ -42,48 +42,48 @@
>  
>  static DEFINE_PER_CPU(xen_ulong_t [EVTCHN_MASK_SIZE], cpu_evtchn_mask);
>  
> -static unsigned evtchn_2l_max_channels(void)
> +static unsigned int evtchn_2l_max_channels(void)
>  {
>  	return EVTCHN_2L_NR_CHANNELS;
>  }
>  
> -static void evtchn_2l_bind_to_cpu(struct irq_info *info, unsigned cpu)
> +static void evtchn_2l_bind_to_cpu(struct irq_info *info, unsigned int cpu)
>  {
>  	clear_bit(info->evtchn, BM(per_cpu(cpu_evtchn_mask, info->cpu)));
>  	set_bit(info->evtchn, BM(per_cpu(cpu_evtchn_mask, cpu)));
>  }
>  
> -static void evtchn_2l_clear_pending(unsigned port)
> +static void evtchn_2l_clear_pending(unsigned int port)

... evtchn_port_t here and elsewhere.

Jan
