Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 688F8C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 04:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FE222137B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 04:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbgIGE1h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 00:27:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:55960 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725823AbgIGE1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 00:27:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8DB4BAC6E;
        Mon,  7 Sep 2020 04:27:36 +0000 (UTC)
Subject: Re: [GIT PULL] xen: branch for v5.9-rc4
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        xen-devel@lists.xenproject.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
References: <20200906044433.24820-1-jgross@suse.com>
 <CAHk-=wiTZ3V-Jn5xmHTKafZ-vRw-E0n8EMz+PyHKz4CMRwmYxw@mail.gmail.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <65f878b3-2a46-4781-29b8-9472da500bb2@suse.com>
Date:   Mon, 7 Sep 2020 06:27:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wiTZ3V-Jn5xmHTKafZ-vRw-E0n8EMz+PyHKz4CMRwmYxw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.09.20 19:01, Linus Torvalds wrote:
> On Sat, Sep 5, 2020 at 9:44 PM Juergen Gross <jgross@suse.com> wrote:
>>
>> It contains a small series for fixing a problem with Xen PVH guests
>> when running as backends (e.g. as dom0). Mapping other guests' memory
>> now is working via ZONE_DEVICE, thus not requiring to abuse the memory
>> hotplug functionality for that purpose.
> 
> Tssk. This really isn't a bug-fix, it's clearly new development.
> 
> I'm going to let it slide since it seems so contained, but don't do this.

Thanks for taking it.

I agree I should have spelled out the nature of the patch more clearly
and add more reasoning why you might consider taking it.


Juergen
