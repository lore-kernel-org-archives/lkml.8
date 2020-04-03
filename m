Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C6D8C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 07:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3689320721
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 07:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390222AbgDCHha (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 03:37:30 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:39897 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730759AbgDCHha (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 03:37:30 -0400
Received: from [192.168.1.6] (x590ea470.dyn.telefonica.de [89.14.164.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id C112C206442DE;
        Fri,  3 Apr 2020 09:37:26 +0200 (CEST)
Subject: Re: [Intel-wired-lan] [PATCH] e1000e: bump up timeout to wait when ME
 un-configure ULP mode
To:     Aaron Ma <aaron.ma@canonical.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        davem@davemloft.net, intel-wired-lan@lists.osuosl.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        sasha.neftin@intel.com
References: <20200323191639.48826-1-aaron.ma@canonical.com>
 <4f9f1ad0-e66a-d3c8-b152-209e9595e5d7@redhat.com>
 <1c0e602f-1fe7-62b1-2283-b98783782e87@canonical.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <2d7c1890-9cd8-8134-af12-5c55cd7e1a8e@molgen.mpg.de>
Date:   Fri, 3 Apr 2020 09:37:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1c0e602f-1fe7-62b1-2283-b98783782e87@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linux folks,


Am 03.04.20 um 05:15 schrieb Aaron Ma:

> I have received the email that you apply this patch to next-queue branch
> dev-queue.
> 
> But after this branch is rebased to v5.6, I can't find it.
> 
> Will you apply again?

I really urge you to write more elaborate commit messages.

The exact error is not listed. The known regressed devices are not 
listed, so possible testers cannot easily test or affected people cannot 
find it, when searching the Linux git history.

How did you find out, that ME takes more than two seconds?

Also, it’s not clear, what effect increasing the timeout has. Does the 
whole resume process take longer or just getting the Ethernet device 
back up?

Lastly, in case of the timeout, an error message should be printed, so 
people with even more broken ME devices, get a clue.

Without this information, how can anybody know, if this is the right fix 
and distributions, if it should be backported?


Kind regards,

Paul
