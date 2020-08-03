Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC85EC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87D902076B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gvcgTGXE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgHCMNX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 08:13:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52838 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726130AbgHCMNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 08:13:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596456799;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=appM4FpYQ7/4/6aPvIEgxRM7aNx7OK9phNGgIuLptOI=;
        b=gvcgTGXE/mZm2KKeBIuUuG0lOiuNfcuJIHbbZH5OObSdrQQgUAd6b+ESTL0UjVA0oxc4jn
        NDUxaG3qS5F8Z5bWVW858RZYe5MBK8C5skTe0oJhfhoool1Hrh74nlmuIFBcIA7r/hfHXe
        Fn5Qnsd4Oo+PBo1ZZoNsww44G9raAI8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-HosZtfNPNMC01RlUlVoNqA-1; Mon, 03 Aug 2020 08:13:18 -0400
X-MC-Unique: HosZtfNPNMC01RlUlVoNqA-1
Received: by mail-wr1-f69.google.com with SMTP id e12so11614042wra.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 05:13:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=appM4FpYQ7/4/6aPvIEgxRM7aNx7OK9phNGgIuLptOI=;
        b=A81jJmdBGubqPlNfxHACjkym/CPXtLViM2T2ghz7NSZC+rC9yFOqhxTgEx1W/ER9Q/
         ktIux0UuhgzIXH6Xe6ALxmT+t0P6Wb9jxoQ1lyxmNdTSaYPpX8VN/1KmyshrDl2TRym2
         cQ/aE+lolK7FAPjqVpUXuDWcteDqWZpkXvSYIYtQD9If1HJtzCqp2PD21xhC20Z2f9NF
         UTsI6wl22cfiozHFR9g//1LdXuRToVmQpzK22TZ/+F0aZU/P0O8PFwsnKF84jEzN5OOr
         ZL6SnwTSMrqqbwmFQClo3i+WKlfeOpeK4UOYR54dxvNZ64Gt7jeVBYZumtnCX6fJwj76
         9//w==
X-Gm-Message-State: AOAM533fLSNm1ZSb9HSTIGGQnpt3Wf1CzPJYU3N1lDVNGAEnrQrtZs7B
        akbi/EM2xldQUsY418f/lhJUdYpeTm6ZAB4K6Zan7axtAjE00oFkU62KG42JzESCE/hnLBsvqFU
        QHeYGsH7YfzSCJ75bOqYKtjRy
X-Received: by 2002:adf:b18d:: with SMTP id q13mr14790354wra.256.1596456797036;
        Mon, 03 Aug 2020 05:13:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwZMCW5jTrOv9dsiN8bHa1f/DBcAB3fvXNWgQ3GKBal87A1GFrnboDAZoFJvw9mM8rjUZ9Uww==
X-Received: by 2002:adf:b18d:: with SMTP id q13mr14790340wra.256.1596456796818;
        Mon, 03 Aug 2020 05:13:16 -0700 (PDT)
Received: from ?IPv6:2a01:cb14:499:3d00:cd47:f651:9d80:157a? ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id u6sm16367526wrn.95.2020.08.03.05.13.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2020 05:13:16 -0700 (PDT)
Subject: Re: [PATCH v2 9/9] objtool: Abstract unwind hint reading
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, mbenes@suse.cz,
        raphael.gault@arm.com, benh@kernel.crashing.org
References: <20200730094652.28297-1-jthierry@redhat.com>
 <20200730094652.28297-10-jthierry@redhat.com>
 <20200730150341.udqnykbw7yfsjvin@treble>
 <1a078563-001d-c666-d2f5-9291f0efd35a@redhat.com>
 <20200731140441.cpzr4lrlkcrmoz2c@treble>
From:   Julien Thierry <jthierry@redhat.com>
Message-ID: <6a314dba-4086-717b-d226-6c292240a3e9@redhat.com>
Date:   Mon, 3 Aug 2020 13:13:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200731140441.cpzr4lrlkcrmoz2c@treble>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/31/20 3:04 PM, Josh Poimboeuf wrote:
> On Fri, Jul 31, 2020 at 08:00:58AM +0100, Julien Thierry wrote:
>>>> +	cfa->offset = hint->sp_offset;
>>>> +	insn->cfi.hint_type = hint->type;
>>>> +	insn->cfi.end = hint->end;
>>>> +
>>>> +	insn->cfi.sp_only = hint->type == ORC_TYPE_REGS || hint->type == ORC_TYPE_REGS_IRET;
>>>
>>> What does "sp" mean here in sp_only?
>>>
>>
>> Stack pointer, like in CFI_SP. When objtool encounters one of these hints,
>> it starts to only track the stack frame with the stack pointer (no BP, no
>> drap register, no move to temporary registers). Just trying to make some
>> sense of this corner case.
> 
> I think that's not quite right, because ORC_TYPE_CALL could also be
> "sp_only" in some cases, by that definition.
> 

But in that case the code will still track when/if the CFI becomes 
pointed to by BP.

> The call to update_cfi_state_regs() is really regs-specific, not
> sp-specific.
> 

I must admit I don't really understand what "regs" is and why exactly 
such an exception in stack state tracking is made where only operations 
to SP are taken into account.

-- 
Julien Thierry

