Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06DA4C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 14:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCE742071C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 14:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BMCTDmm9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbgCLOia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 10:38:30 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:26345 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727359AbgCLOia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 10:38:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584023908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RWwK6IUdYRnqNPC8KqT1WwmV8MAzWningNKkG04QsFg=;
        b=BMCTDmm9lu/L0uA7qN0ufQZp4Z5/auLbB51pg7dPs3OEd4te7A41E23vnaprnjSvDbOLS8
        kIu+HFiCFn+yEVSkx+/zkIize9WPQadaXqmTi2xSW3AJ4TqIMykJbhFIdqjQr8uA6iz2h+
        0joyBMOOqe1ZB5nRoGOJax4CzaZOD+0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-zhnDCHdxNcKY3-rPimw8RA-1; Thu, 12 Mar 2020 10:38:25 -0400
X-MC-Unique: zhnDCHdxNcKY3-rPimw8RA-1
Received: by mail-wr1-f72.google.com with SMTP id z13so2698716wrv.7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 07:38:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RWwK6IUdYRnqNPC8KqT1WwmV8MAzWningNKkG04QsFg=;
        b=acYtJYo7w3npNApULEZ+x41GVpf2LVxXKnizsXtM580D5Qb1cKRE3iEilCfqBAI/3C
         mZTR2ddaY/LKSOjz9b58S4IBkRAmD9al6Oh0pG0T3HnykaHtoJkudT3a45R5FDK3/M8q
         kz5yhpZPEjV4vH3Tbw9ypArXk4FUWo7p5EWc1Gni0BfL5xHqoE5VsIuvXT+dsXscecsn
         A1+fyTUTBs8oK0xJ/LpWQk6wvWCoSPv2YGRai3pPFUIiaWNcOwKjMGFcFm0Idjam/4/m
         w1i/6JTTbLczW22LcXWf6wb9SMW9mnsMdHnICH2yI/SLnqu/Q7qeOxXF7fDBMEmZ2VyH
         Vulg==
X-Gm-Message-State: ANhLgQ3Z9zoJP67RL+VVWAEeWmKKUIVT/ddS5d3EE4Kliny+mAMKpH92
        X5BY2eAQ5Nkz5ijy/uYxUwEQyToE8hHj3H6GZlPiVphw88xShayNyUTatdNEb7AkXNXKmp2zY0Q
        1gYwYeC6NqtN/s1XEXOS9tTKa
X-Received: by 2002:adf:ee02:: with SMTP id y2mr10832310wrn.23.1584023903943;
        Thu, 12 Mar 2020 07:38:23 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsCyiNMu5UigVrpXztFr7FX9dh2gaJ801u9H/YxZqKbf8bqUI8lsg4DMfdHgWruzVs1DM4ekA==
X-Received: by 2002:adf:ee02:: with SMTP id y2mr10832287wrn.23.1584023903750;
        Thu, 12 Mar 2020 07:38:23 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-fc7e-fd47-85c1-1ab3.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:fc7e:fd47:85c1:1ab3])
        by smtp.gmail.com with ESMTPSA id w22sm12951369wmk.34.2020.03.12.07.38.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2020 07:38:23 -0700 (PDT)
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
 <8af51d90-27fa-6d2a-2159-ef0a9089453a@redhat.com>
 <20200312142553.GF15619@zn.tnic>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <94c6f903-7dca-503e-aca7-1ee4641bcdac@redhat.com>
Date:   Thu, 12 Mar 2020 15:38:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200312142553.GF15619@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/12/20 3:25 PM, Borislav Petkov wrote:
> On Thu, Mar 12, 2020 at 02:34:30PM +0100, Hans de Goede wrote:

<snip>

>> No not ok, I'm doing my best to help make things better here and
>> in return I'm getting what feels as a bunch of negativity and that
>> is NOT ok!
> 
> I have no clue what in my replies made you feel that. Please explain.
> How should I have replied so that it doesn't come across negative?

I posted v3 of this patch 5 months ago, then after 0day bot found
an issue after the resend I send a v4 honestly believing that that
was the only issue with it.

0day bot found another issue, so I send out v5, checking what special
options similar code (EFI libstub) uses to make sure I cover all special
cases this time.

So I've send out 2 versions, not 5 not 10, but only 2 versions in
the past 2 days and you start complaining about me rushing this and
not fixing it properly, to me that does not come across positive.

More specifically my intentions / motives on this were well intended
and I too believe in fixing things the proper way. Your reply suggested
that I just want to rush this through, which calls my motives into
question, for which in my mind there was no reason.

If you complain about 2 versions in 2 days, or 5 versions over 5 months
then that feels exaggerated and it certainly does not give me a feeling
that the effort which I'm putting into this is being appreciated.

Anyways we have a plan how to move forward with this now, so lets
focus on that.

>> Now as how to move forward with this, I suggest that:
>>
>> 1) We wait a bit to see if the 0daybot finds any more existing issues
>> which are exposed by my patch
>>
>> 2) Change my patch to check for missing symbols to use the approach
>> which Arvind has suggested
>>
>> 3) Check that "kexec -l <kernel>" + "kexec -e" still work
>>
>> 4) Post v6.
> 
> 5) Wait for 0day bot to chew on it too.
> 
>> Does that work for you ?
> 
> Yes, sounds ok.

Ok, then lets move forward with this.

Regards,

Hans

