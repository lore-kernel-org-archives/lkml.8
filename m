Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E95CCC3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 13:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C008C20717
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 13:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G7C+luge"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbgCCNih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 08:38:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60267 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728109AbgCCNig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 08:38:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583242715;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZIdK4y2508Xb+/mC7DM2rNqSWal4zqTlltB83tI+9ok=;
        b=G7C+lugeeOWU7/MM5faQwP6S+NzfH4PI05JHXUif1oYUwI8skwayJZQOZpY96YaCE1neLN
        qzHM0np3uAgkVT6hESCTVDqQD09cA8+8f37Vw81ox/az9KIL9WvVS3mT1JyjvuxNQI1rkx
        tDStJOMBpXhGPBd0BbvYYstQ0+oVghs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-7LaCyNrIPNub_LVv5lj0WA-1; Tue, 03 Mar 2020 08:38:31 -0500
X-MC-Unique: 7LaCyNrIPNub_LVv5lj0WA-1
Received: by mail-wr1-f71.google.com with SMTP id n12so1222075wrp.19
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 05:38:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=ZIdK4y2508Xb+/mC7DM2rNqSWal4zqTlltB83tI+9ok=;
        b=H6IVQGYeWhhQVvJMRmZvRwPv+w0xrY0CrbAKBbySydGISzf8bySHvKX8HGOV0JXM75
         305n0qaqGIMQ2SpCYmvd4kZuxrXqYX3rABMlF/FvafZCcgx+3KxKoa0MfEXitabRqQgH
         sNwZlZY2poZQ4v8B3eOVdbs8FxdCfe2RS9aMTc5PUj4RxvpGdxd7+MU1ZzJMw0e6hqT3
         98NPlWiVc/tdoeDX9g5Bqn51jHCvfb15r7dfyzMMLWFM0EoMzdF2VdVUy+8jvJK5CvdI
         ubm8typWsJxI5AIW+BtKaM+w4IYT/5lPvo+ZqkHvu6vQNWqbLkEYOUCkY7ofOiUPAcXB
         X99A==
X-Gm-Message-State: ANhLgQ3GCzBC81tLc+jsv2SKHqLUpxZC0eJ13ZZXW98e+QEi7YTv8JCn
        azgBCyEZka15dcyZyhL3yibP7OO3mN1Pot6vOCq4KiG17wLoEDv/Zcl7ZHIxwlntrf0VXq0bRSs
        MRYtv9dFU56MlR7g5aNIbuSZp
X-Received: by 2002:adf:e506:: with SMTP id j6mr5414694wrm.309.1583242710882;
        Tue, 03 Mar 2020 05:38:30 -0800 (PST)
X-Google-Smtp-Source: ADFU+vtH8R9P8o+Uo7AGDF83jLl43yugXJTyawCm8EZlL50uB6ig6MkWHi92L0GcizSfOo6phbXeew==
X-Received: by 2002:adf:e506:: with SMTP id j6mr5414680wrm.309.1583242710689;
        Tue, 03 Mar 2020 05:38:30 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id c8sm24438550wru.7.2020.03.03.05.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 05:38:30 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Oliver Upton <oupton@google.com>
Subject: Re: [GIT PULL] KVM changes for Linux 5.6-rc4
In-Reply-To: <9bb75cdc-961e-0d83-0546-342298517496@redhat.com>
References: <1582570669-45822-1-git-send-email-pbonzini@redhat.com> <87zhcyfvmk.fsf@vitty.brq.redhat.com> <8fbeb3c2-9627-bf41-d798-bafba22073e3@redhat.com> <87tv35fv5t.fsf@vitty.brq.redhat.com> <9bb75cdc-961e-0d83-0546-342298517496@redhat.com>
Date:   Tue, 03 Mar 2020 14:38:29 +0100
Message-ID: <87o8tdftii.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 03/03/20 14:02, Vitaly Kuznetsov wrote:
>> Right you are,
>> 
>> a big hammer like
>> 
>> diff --git a/arch/x86/include/asm/kvm_emulate.h b/arch/x86/include/asm/kvm_emulate.h
>> index 2a8f2bd..52c9bce 100644
>> --- a/arch/x86/include/asm/kvm_emulate.h
>> +++ b/arch/x86/include/asm/kvm_emulate.h
>> @@ -324,14 +324,6 @@ struct x86_emulate_ctxt {
>>          */
>>  
>>         /* current opcode length in bytes */
>> -       u8 opcode_len;
>> -       u8 b;
>> -       u8 intercept;
>> -       u8 op_bytes;
>> -       u8 ad_bytes;
>> -       struct operand src;
>> -       struct operand src2;
>> -       struct operand dst;
>>         union {
>>                 int (*execute)(struct x86_emulate_ctxt *ctxt);
>>                 fastop_t fop;
>> @@ -343,6 +335,14 @@ struct x86_emulate_ctxt {
>>          * or elsewhere
>>          */
>>         bool rip_relative;
>> +       u8 opcode_len;
>> +       u8 b;
>> +       u8 intercept;
>> +       u8 op_bytes;
>> +       u8 ad_bytes;
>> +       struct operand src;
>> +       struct operand src2;
>> +       struct operand dst;
>>         u8 rex_prefix;
>>         u8 lock_prefix;
>>         u8 rep_prefix;
>> 
>> seems to make the issue go away. (For those wondering why fielf
>> shuffling makes a difference: init_decode_cache() clears
>> [rip_relative, modrm) range) How did this even work before...
>> (I'm still looking at the code, stay tuned...)
>
> On AMD, probably because all these instructions were normally trapped by L1.
>
> Of these, however, most need not be zeroed again. op_bytes, ad_bytes,
> opcode_len and b are initialized by x86_decode_insn, and dst/src/src2
> also by decode_operand.  So only intercept is affected, adding
> "ctxt->intercept = x86_intercept_none" should be enough.

This matches my findings, thank you! Patch[es] are coming.

-- 
Vitaly

