Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 288C0C2D0EC
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 00:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F418F206F7
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 00:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f+eLHzx/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgDHAWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 20:22:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48451 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726406AbgDHAWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 20:22:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586305371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r0EEUAh9SaIWVAObARcwt3pD5wm74dMy36jPGATVLxc=;
        b=f+eLHzx/VBL0arP1/IDkLZheAwVCbN+R5ItEnTCJIm8B9rpR0YO313pxINBotqHIhCUM3K
        s1vrP/fBUIAT107gFW/0/hmjwAU8YvuXeJ/OKKOeCYM0CbPWkqY0e0SfGoiV+s8Jgg2Y7R
        6zN9bSpOU1o4iZcCtg6ujsPOCTTxFtc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-dI8PU-K_NDOsOr7NAXK0Jg-1; Tue, 07 Apr 2020 20:22:49 -0400
X-MC-Unique: dI8PU-K_NDOsOr7NAXK0Jg-1
Received: by mail-wr1-f71.google.com with SMTP id k11so3079012wrm.19
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 17:22:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r0EEUAh9SaIWVAObARcwt3pD5wm74dMy36jPGATVLxc=;
        b=Ac0H0qjlmmctQf5PWzrOlnTTLrotNfbYFNaOyq6R8gjUOBOw4SJxcrp8Aa2P44J38F
         EyJW8KcQQ+a+00CfdKGEGQ3/ju7Oz/W07Co6P68692eu0q/Hrbq9dTNFcNaJyobz98jw
         esbaBFSpdvteW6AspOkKPkropyc/KnEVfm58DjRlAkoY2RABggqKGXD2IChtyJJ2/htw
         8LiP+FOePRVVKjHlVbyjsl5g9UW4XypZbQBUEtu++wkFa+A9Ict7+9r7PNNdi2vKGjJu
         IlR44nt0kPvje9/14KAROKP4YRwL8/trbSxucip5zMLcajHNKs2+uxvVwAc/RN2hCENh
         airA==
X-Gm-Message-State: AGi0Pub0xisE8P0l2l7nVS34bTDtPeS+VUCuJuYiMaZoW4cqZZNaOJu1
        JtvOtVbM6jIWyAzzhzBoPDtMMiwG+vLWfd9DwhryIZqyPkorc9GiqAi6dQcyWdlv+pkTLq3dfV7
        uWhuoyFYEf02+3IYJjTO91uq6
X-Received: by 2002:adf:a548:: with SMTP id j8mr5363964wrb.331.1586305368448;
        Tue, 07 Apr 2020 17:22:48 -0700 (PDT)
X-Google-Smtp-Source: APiQypKFMjOrcOZKAoTFIgLTPn6YQdpFR8diJgwoXqqq/gJbuaVD8SBld8xN04m9bL3kCVqUYOAxmg==
X-Received: by 2002:adf:a548:: with SMTP id j8mr5363946wrb.331.1586305368221;
        Tue, 07 Apr 2020 17:22:48 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:bd61:914:5c2f:2580? ([2001:b07:6468:f312:bd61:914:5c2f:2580])
        by smtp.gmail.com with ESMTPSA id v16sm4451759wml.30.2020.04.07.17.22.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2020 17:22:47 -0700 (PDT)
Subject: Re: [PATCH 4/4] x86,module: Detect CRn and DRn manipulation
To:     Andrew Cooper <andrew.cooper3@citrix.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, hch@infradead.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        mingo <mingo@redhat.com>, bp <bp@alien8.de>, hpa@zytor.com,
        x86 <x86@kernel.org>, "Kenneth R. Crudup" <kenny@panix.com>,
        Jessica Yu <jeyu@kernel.org>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Tony Luck <tony.luck@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        jannh@google.com, keescook@chromium.org, David.Laight@aculab.com,
        Doug Covelli <dcovelli@vmware.com>, mhiramat@kernel.org
References: <20200407110236.930134290@infradead.org>
 <20200407111007.429362016@infradead.org>
 <10ABBCEE-A74D-4100-99D9-05B4C1758FF6@gmail.com>
 <20200407193853.GP2452@worktop.programming.kicks-ass.net>
 <90B32DAE-0BB5-4455-8F73-C43037695E7C@gmail.com>
 <20200407205042.GT2452@worktop.programming.kicks-ass.net>
 <96C2F23A-D6F4-4A04-82B6-284788C5D2CC@gmail.com>
 <04f4fc03-95cd-df2e-e93d-e9c4fa221ae4@citrix.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a263df2d-6dd7-83c1-baff-301625ef60a2@redhat.com>
Date:   Wed, 8 Apr 2020 02:22:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <04f4fc03-95cd-df2e-e93d-e9c4fa221ae4@citrix.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/04/20 01:15, Andrew Cooper wrote:
>> Anyhow, I do not think it is the only use-case which is not covered by your
>> patches (even considering CRs/DRs alone). For example, there is no kernel
>> function to turn on CR4.VMXE, which is required to run hypervisors on x86.
> How about taking this opportunity to see if there is a way to improve on
> the status quo for co-existing hypervisor modules?

Almost serious question: why?  I can understand VMware, but why can't at
least VirtualBox use KVM on Linux?  I am not sure if they are still
running device emulation in ring zero, but if so do you really want to
do that these days?

Paolo

