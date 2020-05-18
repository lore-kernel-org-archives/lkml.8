Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76195C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 06:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 572222070A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 06:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbgERGZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 02:25:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:52482 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726378AbgERGZQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 02:25:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 33E34AC49;
        Mon, 18 May 2020 06:25:17 +0000 (UTC)
Subject: Re: next-20200514 - build issue in drivers/md/dm-zoned-target.c
To:     =?UTF-8?Q?Valdis_Kl=c4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Cc:     dm-devel@redhat.com, linux-kernel@vger.kernel.org
References: <367320.1589627953@turing-police>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <7bb0d1c8-b164-d5f3-0218-5c71047c3a8c@suse.de>
Date:   Mon, 18 May 2020 08:25:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <367320.1589627953@turing-police>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/16/20 1:19 PM, Valdis Klētnieks wrote:
> Am seeing a build error in next-0514.  -0420 built OK.
> building a 'make allmodconfig' on a RPi4 in 32-bit mode.
> 
>    MODPOST 7575 modules
> ERROR: modpost: "__aeabi_uldivmod" [drivers/md/dm-zoned.ko] undefined!
> 
> objdump and 'make drivers/md/dm-zoned-target.s' tells
> me that the problem is in function dmz_fixup_devices(), near here:
> 
> @ drivers/md/dm-zoned-target.c:806:             reg_dev->nr_zones = DIV_ROUND_UP(reg_dev->capacity,
>          ldr     r0, [r6, #56]   @ reg_dev_166->capacity, reg_dev_166->capacity
>          adds    r1, r3, r1      @ tmp316, _227, reg_dev_166->capacity
>          adc     r0, r2, r0      @ tmp315, _227, reg_dev_166->capacity
>          subs    r1, r1, #1      @, tmp316,
> @ drivers/md/dm-zoned-target.c:805:             reg_dev->zone_nr_sectors = zoned_dev->zone_nr_sectors;
>          strd    r2, [r6, #80]   @, reg_dev,
> @ drivers/md/dm-zoned-target.c:806:             reg_dev->nr_zones = DIV_ROUND_UP(reg_dev->capacity,
>          sbc     r0, r0, #0      @, tmp315,
>          bl      __aeabi_uldivmod                @
> @ drivers/md/dm-zoned-target.c:806:             reg_dev->nr_zones = DIV_ROUND_UP(reg_dev->capacity,
>          str     r1, [r6, #64]   @ tmp306, reg_dev_166->nr_zones
> 
> git blame points at this commit:
> 
> commit 70978208ec91d798066f4c291bc98ff914bea222
> Author: Hannes Reinecke <hare@suse.de>
> Date:   Mon May 11 10:24:30 2020 +0200
> 
>      dm zoned: metadata version 2
> 
> Reverting that commit lets the build complete.
> 
> 
I thought I've send a patch to fix that up; DIV_ROUND_UP() needs to be 
changed to DIV_ROUND_UP_ULL().
I'll be checking and will be sending a patch if necessary.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
