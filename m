Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A0DAC3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 16:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BC9024681
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 16:29:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgA1Q3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 11:29:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:54148 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725974AbgA1Q27 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 11:28:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CCBB7AD29;
        Tue, 28 Jan 2020 16:28:57 +0000 (UTC)
Subject: Re: [PATCH] xen/gntdev: Do not use mm notifiers with autotranslating
 guests
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org
Cc:     jgg@mellanox.com, linux-kernel@vger.kernel.org,
        ilpo.jarvinen@cs.helsinki.fi, stable@vger.kernel.org
References: <1580228659-6086-1-git-send-email-boris.ostrovsky@oracle.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <9b1ae1c0-a80b-5ef4-5164-6bc74593c5c6@suse.com>
Date:   Tue, 28 Jan 2020 17:28:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <1580228659-6086-1-git-send-email-boris.ostrovsky@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.01.20 17:24, Boris Ostrovsky wrote:
> Commit d3eeb1d77c5d ("xen/gntdev: use mmu_interval_notifier_insert")
> missed a test for use_ptemod when calling mmu_interval_read_begin(). Fix
> that.
> 
> Fixes: d3eeb1d77c5d ("xen/gntdev: use mmu_interval_notifier_insert")
> CC: stable@vger.kernel.org # 5.5
> Reported-by: Ilpo Järvinen <ilpo.jarvinen@cs.helsinki.fi>
> Tested-by: Ilpo Järvinen <ilpo.jarvinen@cs.helsinki.fi>
> Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>

Acked-by: Juergen Gross <jgross@suse.com>


Juergen
