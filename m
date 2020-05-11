Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA91C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 08:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49CF2207DD
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 08:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729022AbgEKIQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 04:16:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:42626 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726319AbgEKIQK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 04:16:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3810CB07B;
        Mon, 11 May 2020 08:16:11 +0000 (UTC)
Subject: Re: [PATCH] xen/cpuhotplug: Fix initial CPU offlining for PV(H)
 guests
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     sstabellini@kernel.org
References: <1588976923-3667-1-git-send-email-boris.ostrovsky@oracle.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <8a94d819-5143-58e2-9bd2-1cc341ba3a80@suse.com>
Date:   Mon, 11 May 2020 10:16:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1588976923-3667-1-git-send-email-boris.ostrovsky@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.05.20 00:28, Boris Ostrovsky wrote:
> Commit a926f81d2f6c ("xen/cpuhotplug: Replace cpu_up/down() with
> device_online/offline()") replaced cpu_down() with device_offline()
> call which requires that the CPU has been registered before. This
> registration, however, happens later from topology_init() which
> is called as subsys_initcall(). setup_vcpu_hotplug_event(), on the
> other hand, is invoked earlier, during arch_initcall().
> 
> As result, booting a PV(H) guest with vcpus < maxvcpus causes a crash.
> 
> Move setup_vcpu_hotplug_event() (and therefore setup_cpu_watcher()) to
> late_initcall(). In addition, instead of performing all offlining steps
> in setup_cpu_watcher() simply call disable_hotplug_cpu().
> 
> Fixes: a926f81d2f6c (xen/cpuhotplug: Replace cpu_up/down() with device_online/offline()"
> Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen
