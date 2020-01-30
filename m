Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4AFAC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 19:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8BDA20658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 19:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q6SkCaC8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbgA3TMa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 14:12:30 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42193 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgA3TMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 14:12:30 -0500
Received: by mail-pl1-f196.google.com with SMTP id p9so1699895plk.9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 11:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Xi1otSyD3nUiREFcsX3WomP4ANVRxh8JOt8EQSGwhSA=;
        b=q6SkCaC8jxep5Pr2qCOlaJdwrspZ5LewaxnL26u3jsX+2b24208BAXcvhBz4lK4+9f
         AVqiOwPCBQXnpPLdHytifoGtqT0NSJHwhzGj32GLJIl4WFyE8PqUEXeSQfV6hFoeEByh
         Ld51OqFq3baghqTx1OsLyH1nwWKC66a6C+jEy7OF0rPg+3MLxD8YjfdOsk2s02bOLLki
         v+lNIWWY/ImGvd8yAPAkdQKpFzgURVoJtmwRmIEnWJHJXdm1YwtdhPb5BkSSSUz+2DvX
         5A0vl44SAn7nUd/vVWsQ3boQLtgTkNrTjmDA6+9lzQI7n2sxnznq+u8ZQpQ9K0hoYrWP
         NNEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Xi1otSyD3nUiREFcsX3WomP4ANVRxh8JOt8EQSGwhSA=;
        b=B0r13b9cZIfYcFFxMNGbO0Znp08MMcKVUe3v4LWVAHdohzcyHNoy3qRdhlHNzc0z2W
         M7iEa/gspbOwN5VSRs/yuDhYJGPMZCL0Q9ZpV464vm7TECDUd+G6ZeiePQrnrLVcw6UW
         2xelzVV4Lr5O78HJxCrTd6D6pudy1MUk3eykoPewZbIDUoKqO99dceOyojL5u/DmneQZ
         PDH+rGH3kvBH+q0FO93IIlc4GHbdIDYuW1AlDISxBJpQCptCEQotpBS5DM+Kvci0/fXP
         rH4RdHQMN9Y+NGVxTiTq3uWsJAKb+/0ajkKTVJvoLCcRNBOytY33U/szixyQW+lyH/qC
         eg+w==
X-Gm-Message-State: APjAAAURinb32fx+k0CnIkf3khJSHFuK/3+IAL8A9AdbNr4Z4dS+UYxo
        zeOnac+iKuXt2NbR1pQLa7HQbxAW
X-Google-Smtp-Source: APXvYqzsYVe5dvCSon0un7A9gVj8k/TL7s5MfjVudCTxJYWSypYZZMkeb/Q26sTji8CcJtqRG0hreA==
X-Received: by 2002:a17:90a:e397:: with SMTP id b23mr7458573pjz.135.1580411549672;
        Thu, 30 Jan 2020 11:12:29 -0800 (PST)
Received: from ?IPv6:2001:df0:0:200c:24a0:dd2f:5dc3:c66a? ([2001:df0:0:200c:24a0:dd2f:5dc3:c66a])
        by smtp.gmail.com with ESMTPSA id a195sm7496505pfa.120.2020.01.30.11.12.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Jan 2020 11:12:28 -0800 (PST)
Subject: Re: [PATCH 0/5] Rewrite Motorola MMU page-table layout
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux/m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>
References: <20200129103941.304769381@infradead.org>
 <bbdb9596-583e-5d26-ac1c-4775440059b9@physik.fu-berlin.de>
 <20200129115412.GN14914@hirez.programming.kicks-ass.net>
 <CAOmrzkJ8dsuSnomcE7uhyY9ip6T9ADLT7LhjydvY-hizpikBiA@mail.gmail.com>
 <20200129193109.GS14914@hirez.programming.kicks-ass.net>
 <b72358cc-ddd2-52d6-7eed-c88bab46e6f1@gmail.com>
 <20200130081623.GW14879@hirez.programming.kicks-ass.net>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <c4d3efbe-2d91-c5e4-aa9e-680ffd0d5c89@gmail.com>
Date:   Fri, 31 Jan 2020 08:12:23 +1300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20200130081623.GW14879@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter,

On 30/01/20 9:16 PM, Peter Zijlstra wrote:
> Hi Michael,
>
> On Thu, Jan 30, 2020 at 08:31:13PM +1300, Michael Schmitz wrote:
>
>> Not much difference:
>>
>>               total       used       free     shared    buffers     cached
>> Mem:         10712      10120        592          0       1860       2276
>> -/+ buffers/cache:       5984       4728
>> Swap:      2097144       1552    2095592
>>
>>
>> vs. vanilla 5.5rc5:
>>               total       used       free     shared    buffers     cached
>> Mem:         10716      10104        612          0       1588       2544
>> -/+ buffers/cache:       5972       4744
>> Swap:      2097144       1296    2095848
>>
>> By sheer coincidence, the boot with your patch series happened to run a full
>> filesystem check on the root filesystem, so I'd say it got a good workout
>> re: paging and swapping (even though it's just a paltry 4 GB).
> Sweet!, can I translate this into a Tested-by: from you?

If the test coverage is sufficient, you may certainly do that.

Cheers,

     Michael

>
>> Haven't tried any VM stress testing yet (not sure what to do for that; it's
>> been years since I tried that sort of stuff).
> I think, this not being SMP, doing what you just did tickled just about
> everything there is.
>
> There is one more potential issue with MMU-gather / TLB invalidate on
> m68k (and a whole bunch of other archs) and I have patches for that
> (although I now need to redo the m68k one.
>
> Meanwhile the build robot gifted me with a build issue, and Will had
> some nitpicks, so I'll go respin and repost these patches.
