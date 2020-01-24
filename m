Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C20EC32771
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EB6E2071A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:11:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EaAOe95p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730192AbgAXJLn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 04:11:43 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34458 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729575AbgAXJLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 04:11:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579857101;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4rW7myJJ2GuW+fTx8x7EBJbhNaqxnzwmpTqYDBQ5SZU=;
        b=EaAOe95p3edOD5PbIwBI2TS/KwR7AuUqH40ElfmkMq04vj+NcudIYWqeGRiwHYVS1SoEtN
        OtsOwceZ9vV7CacwExZ0hQcjqMoWnK0+IMRAvj4hnpOs4j0uwoGbt+e9kl4JEvfklWeIqx
        Lu/fKR78Q8C9CVJ9JlgAHPex9ohu7J0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-G_QB2jjzPBSHoBQsZVvXYw-1; Fri, 24 Jan 2020 04:11:39 -0500
X-MC-Unique: G_QB2jjzPBSHoBQsZVvXYw-1
Received: by mail-wm1-f69.google.com with SMTP id m21so422173wmg.6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 01:11:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4rW7myJJ2GuW+fTx8x7EBJbhNaqxnzwmpTqYDBQ5SZU=;
        b=iiLSW8zsTX2CG073OJ9AJDYbpKXVuiLA8jSrDoDx53gyiaXhk8DtwXsQHRoPDqd8aU
         jtbL7cLLSfTQnOr216u57JleyUV01qh0t4eRLr70shqCEoQUyDDn2igD4rjGk8+DLoTe
         /XHAgX4oPOz9MWNpXB+uyyksJHaXqOIT8qOIrXpaSm7apjSz+Nb8rS7GfDzbLQnJ67Q2
         gus/TbKnUco8og2o8r3mcTzYqqV12LYq5t/OPk0g9aRZ1q0qSUq6GhwlgCLiOsR9gHnm
         gHBxVyguGgXmoNbX0NAI2qc6pYt7mducyOBeJwPK9+9gn/kmh2ZMlbCLTnYMISdPswhV
         4beQ==
X-Gm-Message-State: APjAAAUiNzow+vAN6Hhu6NjjTXib6QNCNLL+FVjeoYPTS8j/hwaVo0t8
        U3dBOmb4qKE2Q70ONW2RoUM8+cVNovO21lSaMFVP5WssutkwUJ43QCdG9d6r98wM8k1muKFBbQq
        GnoFS/8bKOI+TYwoLWPSLnxk7
X-Received: by 2002:adf:f885:: with SMTP id u5mr3083556wrp.359.1579857097051;
        Fri, 24 Jan 2020 01:11:37 -0800 (PST)
X-Google-Smtp-Source: APXvYqwHTA1utlLqgh3JNj/13z6suNbkceqhb5JYG+L0X3nT5kjvdpBpX5mJygE3kQEHccGMvWn7Cw==
X-Received: by 2002:adf:f885:: with SMTP id u5mr3083521wrp.359.1579857096726;
        Fri, 24 Jan 2020 01:11:36 -0800 (PST)
Received: from localhost.localdomain ([109.38.141.136])
        by smtp.gmail.com with ESMTPSA id g2sm6536988wrw.76.2020.01.24.01.11.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2020 01:11:35 -0800 (PST)
Subject: Re: [v3] x86/tsc: Unset TSC_KNOWN_FREQ and TSC_RELIABLE flags on
 Intel Bay Trail SoC
To:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        vipul kumar <vipulk0511@gmail.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org, Stable <stable@vger.kernel.org>,
        Srikanth Krishnakar <Srikanth_Krishnakar@mentor.com>,
        Cedric Hombourger <Cedric_Hombourger@mentor.com>,
        x86@kernel.org, Len Brown <len.brown@intel.com>,
        Vipul Kumar <vipul_kumar@mentor.com>
References: <1579617717-4098-1-git-send-email-vipulk0511@gmail.com>
 <87eevs7lfd.fsf@nanos.tec.linutronix.de>
 <CADdC98RJpsvu_zWehNGDDN=W11rD11NSPaodg-zuaXsHuOJYTQ@mail.gmail.com>
 <878slzeeim.fsf@nanos.tec.linutronix.de>
 <CADdC98TE4oNWZyEsqXzr+zJtfdTTOyeeuHqu1u04X_ktLHo-Hg@mail.gmail.com>
 <20200123144108.GU32742@smile.fi.intel.com>
 <df04f43d-8c6d-7602-cb50-535b85cf2aaa@redhat.com>
 <87iml11ccf.fsf@nanos.tec.linutronix.de>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <c06260e3-bd19-bf3c-89f7-d36bdb9a5b20@redhat.com>
Date:   Fri, 24 Jan 2020 10:11:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <87iml11ccf.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/24/20 9:35 AM, Thomas Gleixner wrote:
> Hans,
> 
> Hans de Goede <hdegoede@redhat.com> writes:
> 
>> Hi,
>>
>> Sorry for top posting, but this is a long and almost unreadable thread ...
>>
>> So it seems to me that a better fix would be to change the freq_desc_byt struct from:
>>
>> static const struct freq_desc freq_desc_byt = {
>>           1, { 83300, 100000, 133300, 116700, 80000, 0, 0, 0 }
>> };
>>
>> to:
>>
>> static const struct freq_desc freq_desc_byt = {
>>           1, { 83333, 100000, 133300, 116700, 80000, 0, 0, 0 }
>> };
>>
>> That should give us the right TSC frequency without needing to mess with
>> the TSC_KNOWN_FREQ and TSC_RELIABLE flags.
> 
> Where does that number come from? Just math?

Yes just math, but perhaps the Intel folks can see if they can find some
datasheet to back this up ?

I mean if the calculated freq is off by that much, then chances are that
my solution actuallly is not only "just math" but also correct :)

Regards,

Hans

