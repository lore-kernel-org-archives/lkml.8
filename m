Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC83C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 12:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F12C20738
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 12:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tgoyj9Ug"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgHYMbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 08:31:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23102 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726633AbgHYMbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 08:31:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598358711;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CiFYE8jzaodhVA5L8Zma5x1CexylW0/iR0TiifPXNJU=;
        b=Tgoyj9Ug0JDpFUwEgqWJTuiVMzCPRowmQGAsMTwExrIl6UjlmHrG+en/b2CmEjzTjXtrvE
        7GRmBF5VCQWSqp0ZevLfjtliHYMgvukSN1hc4RPpOB/2KUPV3Gi6ARb9DzFMn5Z+UbHraG
        itiREyb/fC52HqpuzFxX0VIdrNgTY38=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-kGxfKyW5PS66R_ibxxfTOA-1; Tue, 25 Aug 2020 08:31:49 -0400
X-MC-Unique: kGxfKyW5PS66R_ibxxfTOA-1
Received: by mail-wm1-f69.google.com with SMTP id z1so666368wmf.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 05:31:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CiFYE8jzaodhVA5L8Zma5x1CexylW0/iR0TiifPXNJU=;
        b=I806nqQ9qd6RZ35I59pJ8EOLTxeKSjz6+fwfHYTFQFjz3LSIMsrZeuR27uytziMOCn
         /dh2bIiD9YHFbix+VZ0E0T8LDgggVkbcfSzBg/86/MBDsRy+yVsR4ZGrVr9/yc46uMf+
         ZOXKNn0V1DhJnocU5goayIxqxd/A4l06mTKX9K3UKCqSabUZyDSJwd1oe8/b6pOGoDFA
         lfP+E69rBbt+IY0uyoFgkArdiyGjf73WOOsSRfq8op/GfOytkJl50mZiWdGZGyiKzFUg
         jI6k4phc84FUqX+SIF+0Y1I0GIJQb6nJJ17v3c/ErrKIjEYmHZgiahJK8a8LHps6aroB
         e9nw==
X-Gm-Message-State: AOAM5334YwI3f4E1VOvLryts1dmuRkwKp0uHk+SaFTm2YcruQatKrRZ0
        215SWGzS0Ugr6C1sZWLfrIxzj/xhX7IlzZBxGFgC3MTUNNJqg+uwUeby/G2vgCfGrO5aotZo1AW
        VbTbnZBQm1Le4OMqKtL96O27n
X-Received: by 2002:a05:600c:2242:: with SMTP id a2mr1919348wmm.116.1598358708495;
        Tue, 25 Aug 2020 05:31:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyX8aYj0awXHHpnlkUQoNNKBBi3FAFHM/xNdLWzWuCdGkPsY2zIZ2JxN3LamkywklqNo/JmtQ==
X-Received: by 2002:a05:600c:2242:: with SMTP id a2mr1919332wmm.116.1598358708301;
        Tue, 25 Aug 2020 05:31:48 -0700 (PDT)
Received: from ?IPv6:2a01:cb14:499:3d00:cd47:f651:9d80:157a? ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id j7sm5927284wmj.38.2020.08.25.05.31.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2020 05:31:47 -0700 (PDT)
Subject: Re: [PATCH v2 9/9] objtool: Abstract unwind hint reading
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, mbenes@suse.cz,
        raphael.gault@arm.com, benh@kernel.crashing.org
References: <20200730094652.28297-1-jthierry@redhat.com>
 <20200730094652.28297-10-jthierry@redhat.com>
 <20200730150341.udqnykbw7yfsjvin@treble>
 <1a078563-001d-c666-d2f5-9291f0efd35a@redhat.com>
 <20200731140441.cpzr4lrlkcrmoz2c@treble>
 <6a314dba-4086-717b-d226-6c292240a3e9@redhat.com>
 <20200803213506.hlbpdlitom7sjtqo@treble>
From:   Julien Thierry <jthierry@redhat.com>
Message-ID: <8fe8199e-a2f3-513f-6cdf-c61d7936dede@redhat.com>
Date:   Tue, 25 Aug 2020 13:31:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200803213506.hlbpdlitom7sjtqo@treble>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/3/20 10:35 PM, Josh Poimboeuf wrote:
> On Mon, Aug 03, 2020 at 01:13:14PM +0100, Julien Thierry wrote:
>>
>>
>> On 7/31/20 3:04 PM, Josh Poimboeuf wrote:
>>> On Fri, Jul 31, 2020 at 08:00:58AM +0100, Julien Thierry wrote:
>>>>>> +	cfa->offset = hint->sp_offset;
>>>>>> +	insn->cfi.hint_type = hint->type;
>>>>>> +	insn->cfi.end = hint->end;
>>>>>> +
>>>>>> +	insn->cfi.sp_only = hint->type == ORC_TYPE_REGS || hint->type == ORC_TYPE_REGS_IRET;
>>>>>
>>>>> What does "sp" mean here in sp_only?
>>>>>
>>>>
>>>> Stack pointer, like in CFI_SP. When objtool encounters one of these hints,
>>>> it starts to only track the stack frame with the stack pointer (no BP, no
>>>> drap register, no move to temporary registers). Just trying to make some
>>>> sense of this corner case.
>>>
>>> I think that's not quite right, because ORC_TYPE_CALL could also be
>>> "sp_only" in some cases, by that definition.
>>>
>>
>> But in that case the code will still track when/if the CFI becomes pointed
>> to by BP.
>>
>>> The call to update_cfi_state_regs() is really regs-specific, not
>>> sp-specific.
>>>
>>
>> I must admit I don't really understand what "regs" is and why exactly such
>> an exception in stack state tracking is made where only operations to SP are
>> taken into account.
> 
> "regs" is a special type of stack frame, usually for asm entry code,
> where the frame is actually an instance of 'struct pt_regs'.  So if
> there's a variable associated it with it, maybe it should have "regs" in
> the name.
> 
> Though I think non-x86 arches will also have regs frames, so would it
> make sense to just make the unwind hint types a global multiarch thing?
> They could be renamed to UNWIND_HINT_TYPE_REGS{_PARTIAL}.  Then there
> wouldn't really be a need for the "sp_only" thing.
> 

If having regs frame means having a pt_regs on the stack when procedure 
calls/return, then yes this will probably be the case on most archs (it 
is for arm64 at least.

However in that case, arm64 still builds a stack frame and sets the 
frame pointer, so only handling SP operations doesn't make much sense 
for arm64.

Also, things like ORC_TYPE_REGS_IRET don't have a use for arm64 (but 
maybe for other non-x86 arches it does?)

In the end that's why I left the unwind hint types as arch defined. It 
seems like every arch will have their specific semantics they might want 
to let objtool know about.

-- 
Julien Thierry

