Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A99ADC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 05:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88880206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 05:04:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbgEFFE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 01:04:29 -0400
Received: from relay.sw.ru ([185.231.240.75]:38978 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbgEFFE3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 01:04:29 -0400
Received: from vvs-ws.sw.ru ([172.16.24.21])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <vvs@virtuozzo.com>)
        id 1jWCDp-0007ZV-81; Wed, 06 May 2020 08:03:53 +0300
Subject: Re: [PATCH 7/7] sysvipc_find_ipc should increase position index
To:     Andreas Schwab <schwab@suse.de>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        NeilBrown <neilb@suse.com>, Waiman Long <longman@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>
References: <b7a20945-e315-8bb0-21e6-3875c14a8494@virtuozzo.com>
 <mvm4ksupdgr.fsf@suse.de>
From:   Vasily Averin <vvs@virtuozzo.com>
Message-ID: <ad24ee52-21a8-3ff0-e968-63d315472b91@virtuozzo.com>
Date:   Wed, 6 May 2020 08:03:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <mvm4ksupdgr.fsf@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/5/20 7:13 PM, Andreas Schwab wrote:
> I think this is causing this bug (seen on 5.6.8):

thank you for reporting,
yes, you are right, it's my fault
patch incorrectly updated *new_pos in case of found entry

> # ipcs -q
> 
> ------ Message Queues --------
> key        msqid      owner      perms      used-bytes   messages    
> 0x7c982867 3          root       644        0            0           
> 0x7c982867 3          root       644        0            0           
> 0x7c982867 3          root       644        0            0           
> 0x7c982867 3          root       644        0            0           

Thank you,
	Vasily Averin
