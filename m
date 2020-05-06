Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EADE1C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 05:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C783E206E6
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 05:12:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgEFFM1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 01:12:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:59278 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbgEFFM1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 01:12:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E896DACD5;
        Wed,  6 May 2020 05:12:28 +0000 (UTC)
Subject: Re: [PATCH] xenbus: avoid stack overflow warning
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Yan Yankovskyi <yyankovskyi@gmail.com>, Wei Liu <wl@xen.org>,
        xen-devel <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
References: <20200505141546.824573-1-arnd@arndb.de>
 <30d49e6d-570b-f6fd-3a6f-628abcc8b127@suse.com>
 <CAK8P3a0mWH=Zcq180+cTRMpqOkGt05xDP1+kCTP6yc9grAg2VQ@mail.gmail.com>
 <48893239-dde9-4e94-040d-859f4348816d@suse.com>
 <CAK8P3a2_7+_a_cwDK1cwfrJX4azQJhd_Y0xB18cCUn6=p7fVsg@mail.gmail.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <2c6e4b36-6618-1889-55c4-16eeb1ef6f57@suse.com>
Date:   Wed, 6 May 2020 07:12:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2_7+_a_cwDK1cwfrJX4azQJhd_Y0xB18cCUn6=p7fVsg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.05.20 22:57, Arnd Bergmann wrote:
> On Tue, May 5, 2020 at 6:02 PM Jürgen Groß <jgross@suse.com> wrote:
>> On 05.05.20 17:01, Arnd Bergmann wrote:
>>> On Tue, May 5, 2020 at 4:34 PM Jürgen Groß <jgross@suse.com> wrote:
>>>> On 05.05.20 16:15, Arnd Bergmann wrote:
>>>
>>> I considered that as well, and don't really mind either way. I think it does
>>> get a bit ugly whatever we do. If you prefer the union, I can respin the
>>> patch that way.
>>
>> Hmm, thinking more about it I think the real clean solution would be to
>> extend struct map_ring_valloc_hvm to cover the pv case, too, to add the
>> map and unmap arrays (possibly as a union) to it and to allocate it
>> dynamically instead of having it on the stack.
>>
>> Would you be fine doing this?
> 
> This is a little more complex than I'd want to do without doing any testing
> (and no, I don't want to do the testing either) ;-)
> 
> It does sound like a better approach though.

I take this as you are fine with me writing the patch and adding you as
"Reported-by:"?


Juergen
