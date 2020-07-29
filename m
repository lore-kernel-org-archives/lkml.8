Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F269C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 23:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2F412074B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 23:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SwQDxNTq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbgG2X2E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 19:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbgG2X2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 19:28:04 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F469C061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 16:28:04 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id s26so13942721pfm.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 16:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=T3yc8tDg3VlV2oqrZuDEqQGtfvUmkTNYJ+6JLOjuVTE=;
        b=SwQDxNTqxeMK0omSeTzVi9jiDoURbAqKvdi3Wx5sXWcaULsT52FQJl2xPKIdEO/1yi
         05uP8o76G9BWs3cvx4xZaeob7HOWNuypjOC9yRP1tQC3eaGuE66Gf5OLAnbh4piWhu0s
         6KIU/jlKhuRM0ynuAXkHmUDK0UghAv1oHb0B0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=T3yc8tDg3VlV2oqrZuDEqQGtfvUmkTNYJ+6JLOjuVTE=;
        b=Jx8HDuhg5p8fdfaGctDnI/qQ7j7SMexK4OZFaEbPb0ODNajFxcKg4WVgNp8DJP8lRL
         3m1oINJtZ6RTFIyyEqTidH+yxV8BOjUFrVp9FD7Znosf09C9i1Z6JIXytbWbLcQaSni/
         roEDh4QF6Kl0eqMhQhee0FI7QcFI7/3vObOeiSHfbvCp72dMoFXJTz/ATjAcWQ2hhyg4
         ETgNr28kDI2Zx2BPna5zPkzq/VueHuW9wVJNyuWuuoyovRMohDyXeN3N6cCvtNem5/EN
         gUghPoMJtFbevT+iwAT4vWuxZUowPg80/8TrDPdntPkJ9kjZSYhA2DbRX0yEgFje/iYW
         qT4A==
X-Gm-Message-State: AOAM5334W+9ck5VmSa/I4mE+4/r+DLB37w2UQVNRHuk/Z6wiQRYtG5yh
        dAc0pcWwUBp6BdELGPwIUwclam0W/N2Tzf4wIEmC2eK5PC0VFjl7O0RC+YgV90p8/wq9XiBT7Em
        17A1ZnJzH0svL1cTQXM+QjmAo++E2oBbJ1MQslRhCW7xXvzDYZ0gmY8Oo0aE3b7snelgnc503ie
        uqSPKdRghj
X-Google-Smtp-Source: ABdhPJx4brAJ1VsnzLDr5nULHDyBneBDtMd3Z6byU86XZ/F31o6IkFXxCpGlVCRx1gIe5NuTZdoXww==
X-Received: by 2002:aa7:9567:: with SMTP id x7mr378857pfq.235.1596065283082;
        Wed, 29 Jul 2020 16:28:03 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id a6sm3303641pje.8.2020.07.29.16.28.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2020 16:28:02 -0700 (PDT)
Subject: Re: Kernel panic - not syncing: IO-APIC + timer doesn't work!
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>, bp@alien8.de,
        x86@kernel.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org
References: <18cb4d48-6571-1fdb-5902-ba64c23eee75@broadcom.com>
 <87h7tsbs1n.fsf@nanos.tec.linutronix.de>
 <e0ce41cd-9149-e43e-f4ca-e75503cb82e3@broadcom.com>
 <87blk0aw1k.fsf@nanos.tec.linutronix.de>
 <cc298d3e-9a14-d3e1-025b-6bb1f8bfb4ae@broadcom.com>
 <87y2n2abv2.fsf@nanos.tec.linutronix.de>
 <e41ea714-a042-b29b-d22e-8ee71d23f2e9@amd.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <3f6879be-db6e-073d-6252-30d3c046e9e4@broadcom.com>
Date:   Wed, 29 Jul 2020 16:28:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e41ea714-a042-b29b-d22e-8ee71d23f2e9@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-CA
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

On 2020-07-29 11:29 a.m., Tom Lendacky wrote:
> On 7/29/20 4:50 AM, Thomas Gleixner wrote:
>> Scott,
>>
>> Scott Branden <scott.branden@broadcom.com> writes:
>>> On 2020-07-28 1:22 a.m., Thomas Gleixner wrote:
>>>> Scott Branden <scott.branden@broadcom.com> writes:
>>>>> Bios now updated to latest.  Same kernel panic issue.  Log below.
>>>>>
>>>>> I think it is related to power cycling quickly.
>>>>> Should APIC work if PC power cycled in a few seconds or is that the
>>>>> problem?
>>>> Yes, emphasis on should. Just to clarify, if you reboot it works and
>>>> cold start works as well if power was off long enough?
>>>>
>>> So far I have only been able to reproduce the issue by cold start with power off for only a few seconds
>>> before re-powering the system.  It has not failed via reboot yet that I remember.
>>> Will have to keep my eye on whether using reboot is an issue or not.
>>> And also keeping power off longer when doing a cold start.
>> Weird.
>>
>>> Please find attached the failed console log with ignore_loglevel.
>> Aside of the differences caused by the BIOS update there is nothing
>> related to the APIC/IO-APIC setup which is different between the working
>> and failing boot.
>>
>> TBH, I have no idea what's going wrong there. Maybe Tom has one.
> I asked around and was told this is most likely the motherboard has not
> decayed its DC rails. So it's quite possible that keeping it powered off
> for a longer period of time before powering back on may help.
It does appear that the APIC hardware or some other component does not reset
something and assumes the power up value is 0.

Too bad proper voltage monitoring/full reset is not in place.

I was just reporting the issue as instructed by the kernel panic.
I think the issue is avoided by leaving the system powered off longer.

> Thanks,
> Tom
>
>> Thanks,
>>
>>         tglx
>>

