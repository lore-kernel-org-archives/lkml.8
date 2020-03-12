Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22DE4C2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD403206E7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KwTrpmBM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbgCLNek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 09:34:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43598 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726028AbgCLNek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 09:34:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584020078;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=41eb/2SI2+FnoiHgWaYoZTXTLv5Nitc94euoDRGIhgM=;
        b=KwTrpmBMpQdrklVa2I0jc/Nk34y0h+sHYysUdzEmO2uas7Rkqzg8aJyTFm0pSN3XjOAyIK
        sEQbBItedksZhv1YrkK9LprUjhWlSHo8cBhUrsay4+0NskrJO1rKbKw6WUxT4auL/7b3MT
        8nVWlFIX9OMdyWVv5fre4beDiaxQznQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-gV35SLz4NB-FhDKAgFk8pg-1; Thu, 12 Mar 2020 09:34:33 -0400
X-MC-Unique: gV35SLz4NB-FhDKAgFk8pg-1
Received: by mail-wr1-f69.google.com with SMTP id q18so2630642wrw.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 06:34:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=41eb/2SI2+FnoiHgWaYoZTXTLv5Nitc94euoDRGIhgM=;
        b=ieaYWm59dhfSCMKP01M7QZ9iAm8vvEiJ7xFTnEMNwMpLhi30VY3t6Z4MLbDs5Gr6fh
         3W6dxoW2IjEoYkYMpRTSf+afpv/MF3QcX4QERXW1qodPlYE1ulTmgdzu5H3H/Yy96UC/
         I3XdoUSyeyusej0RtGyZCG6don9HbY4Sy4SIFyk/buqouaWrXGdhpsUfIhq72lEhf5qR
         92DvnsSWM76P45zWsqi7EybyPHv8TebP3oTkdjYqftOoXhwzUyILqjkbgHiVnmGd+sb7
         jy/StY1X+E+vqLMcxVUmpoe+hpIgoyGXGphSMs6iykYu9lENCPS9NnyzTScYMsvNsLBs
         NoUQ==
X-Gm-Message-State: ANhLgQ0HrycEwr5/YK+sO9MhJ6DSgAxz1YCWG/L0cT9X0t8X10eaO2Dk
        ljg7IVfg81A4MLNNUgGBPwm/+OfbC/S6m8DMadYZsj4SRzRI+5XUJr7vxLm3luY8RV91p/Mtckh
        0uf3kmqfouPOPtUJDELGu4VWb
X-Received: by 2002:a05:6000:12cc:: with SMTP id l12mr11091436wrx.304.1584020071772;
        Thu, 12 Mar 2020 06:34:31 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvgRKybTNvU5D8ClB0t/j6B8LyV8smUvAmJkxk1f9Y1JlAMlcJWxF+RzpGkl6qLtdMpOKL48w==
X-Received: by 2002:a05:6000:12cc:: with SMTP id l12mr11091410wrx.304.1584020071561;
        Thu, 12 Mar 2020 06:34:31 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-fc7e-fd47-85c1-1ab3.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:fc7e:fd47:85c1:1ab3])
        by smtp.gmail.com with ESMTPSA id i10sm69482209wrn.53.2020.03.12.06.34.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2020 06:34:30 -0700 (PDT)
Subject: Re: [PATCH v4 2/2] x86/purgatory: Make sure we fail the build if
 purgatory.ro has missing symbols
To:     Borislav Petkov <bp@alien8.de>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20200311214601.18141-1-hdegoede@redhat.com>
 <20200311214601.18141-3-hdegoede@redhat.com>
 <20200312001006.GA170175@rani.riverdale.lan>
 <3d58e77d-41e5-7927-fe84-4c058015e469@redhat.com>
 <20200312114225.GB15619@zn.tnic>
 <899f366e-385d-bafa-9051-4e93dc9ba321@redhat.com>
 <20200312125032.GC15619@zn.tnic>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <8af51d90-27fa-6d2a-2159-ef0a9089453a@redhat.com>
Date:   Thu, 12 Mar 2020 14:34:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200312125032.GC15619@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/12/20 1:50 PM, Borislav Petkov wrote:
> On Thu, Mar 12, 2020 at 12:58:24PM +0100, Hans de Goede wrote:
>> My version of this patch has already been tested this way. It is
> 
> Tested with kexec maybe but if the 0day bot keeps finding breakage, that
> ain't good enough.

Which is why I have been fixing the issues which the 0day bot finds,
but then I get complaints about reving the patch set to quickly...

>> 1. Things are already broken, my patch just exposes the brokenness
>> of some configs, it is not actually breaking things (well it breaks
>> the build, changing a silent brokenness into an obvious one).
> 
> As I already explained, that is not good enough.

Right, which as I already said is why I'm fixing those issues.

>> 2. I send out the first version of this patch on 7 October 2019, it
>> has not seen any reaction until now. So I'm sending out new versions
>> quickly now that this issue is finally getting some attention...
> 
> And that is never the right approach.

In my experience once a patch-set has a maintainers attention,
quickly fixing any issues found usually is the right approach.
Because then usually it can get merged quickly and both the maintainer
and I can move on to other stuff. I'm sorry if you are finding this
annoying.

> Maintainers are busy as hell so !urgent stuff gets to wait. Spamming
> them with more patchsets does not help - fixing stuff properly does.

I am trying to fix this properly, the reason the 0daybot is
complaining is because of pre-existing bugs, not because of issues
with my original patch.

If I was not trying to fix this properly I would have long dropped
this patch to the floor and moved on.

TBH I'm quite unhappy that I'm being "yelled" at now (or so it
feels) while all I'm doing is trying to fix a long standing issue :(

> So, to sum up: if Arvind's approach is the better one, then we should do
> that and s390 should be fixed this way too. And all tested. And we will
> remove the hurry element from it all since it has not been noticed so
> far so it is not urgent and we can take our time and fix it properly.
> 
> Ok?

No not ok, I'm doing my best to help make things better here and
in return I'm getting what feels as a bunch of negativity and that
is NOT ok!

Now as how to move forward with this, I suggest that:

1) We wait a bit to see if the 0daybot finds any more existing issues
which are exposed by my patch

2) Change my patch to check for missing symbols to use the approach
which Arvind has suggested

3) Check that "kexec -l <kernel>" + "kexec -e" still work

4) Post v6.

Does that work for you ?

Regards,

Hans

