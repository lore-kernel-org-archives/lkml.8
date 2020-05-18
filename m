Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C76C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 13:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DCBE207F9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 13:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="jSi74qdC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbgERNfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 09:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbgERNe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 09:34:59 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47EA1C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 06:34:59 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id f6so4809970pgm.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 06:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GQYIfFlSp7tZJq6oV7LQdQDI1JsACLwiIo6iDjBJA/Q=;
        b=jSi74qdCp01j6agYC3/nSZbM1FysxNQp7ifQfkD1AvuwZVVfLh+WR5Q8VCkm02Nyjq
         fCWC9a/QdlkCrJfUZ5Ax7GkFBACD1ePRLGCprNMaIJpoAxLeTwd/Tp1WKIS9HVRkdNfX
         WIc/l0yZBlueuZOOV7lW7u7aEiKmHMPjLMhh4Ni4ouhQtOSC6BfShXMctyT+3FJziU0d
         xQMAE9+8sJOaHSRME+PPmSYBS1uUcEs/WO17khUbY1Zue0xSs4dbUP5BcOuZ5gcBSxTp
         9T93RPE+t0bxV+IOu1ZXJEpltzODls6J0QyaEYjzl30RVvNA6Pf1sUJe5ueu1bGS8r11
         kQaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GQYIfFlSp7tZJq6oV7LQdQDI1JsACLwiIo6iDjBJA/Q=;
        b=W6kMe0O0MZwbgrflv9qiGS/9mRplrHFEHtNwcYp+IvGukqBiInGILiepNGV3wc5W/K
         U8xDyY6aqFkM4hIFe/ERVpTtz6OnaRBc2T+DSvKfMBR1cSRn/r9JWIfT/2mQQJoEGxeR
         3GV0OKczCbcUhoe1uviQpQqxBevU2X7WFMUWJJ8rDeC6DpwdwpxyXIacY77Mt3THBMnW
         UgICRfMIe2uBJ1PYeByvQqPj8q133NKwkQvfrtBnxwxxnRlIr9PncvPWYEWR4xcGFsKe
         8DXCeEvZuRG8Wx5REHo9giEdAgI+VI6od5KZeNYgNZ3OcbrV/NtsayBVjr5rmgNJ45D/
         iM2A==
X-Gm-Message-State: AOAM533ZTCWGtugFHffIKtwJSDUsepOPrVJndZAmCMeFx4h7NPfrphSF
        vh1SN0paTG8SBnGD3K6YuPzTcg==
X-Google-Smtp-Source: ABdhPJySpriIDJeajS+hklUSBQxHyVem2gUbCBTY5WTj6YG1ozk+6rq4FIDO+K9UA+m1Lel4x6bVxw==
X-Received: by 2002:a63:145f:: with SMTP id 31mr6940036pgu.383.1589808898760;
        Mon, 18 May 2020 06:34:58 -0700 (PDT)
Received: from ?IPv6:2a02:8084:e84:2480:228:f8ff:fe6f:83a8? ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id c2sm7845969pgj.93.2020.05.18.06.34.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2020 06:34:57 -0700 (PDT)
Subject: Re: [PATCHv3 12/50] csky: Add show_stack_loglvl()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Guo Ren <guoren@kernel.org>
References: <20200418201944.482088-1-dima@arista.com>
 <20200418201944.482088-13-dima@arista.com>
 <20200515122340.d0d93b7a29846934e161ef41@linux-foundation.org>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <fb27b64b-f0a0-b969-40dc-578f24426e41@arista.com>
Date:   Mon, 18 May 2020 14:34:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200515122340.d0d93b7a29846934e161ef41@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On 5/15/20 8:23 PM, Andrew Morton wrote:
> On Sat, 18 Apr 2020 21:19:06 +0100 Dmitry Safonov <dima@arista.com> wrote:
> 
>> Currently, the log-level of show_stack() depends on a platform
>> realization. It creates situations where the headers are printed with
>> lower log level or higher than the stacktrace (depending on
>> a platform or user).
>>
>> Furthermore, it forces the logic decision from user to an architecture
>> side. In result, some users as sysrq/kdb/etc are doing tricks with
>> temporary rising console_loglevel while printing their messages.
>> And in result it not only may print unwanted messages from other CPUs,
>> but also omit printing at all in the unlucky case where the printk()
>> was deferred.
>>
>> Introducing log-level parameter and KERN_UNSUPPRESSED [1] seems
>> an easier approach than introducing more printk buffers.
>> Also, it will consolidate printings with headers.
>>
>> Introduce show_stack_loglvl(), that eventually will substitute
>> show_stack().
> 
> The csky code has changed a lot in linux-next due to 18c07d23da5a
> ("csky: Fixup calltrace panic").  I redid this patch as below.  Can we
> please review and test?

The result looks good to me, thanks for the rebase!

Thanks,
          Dmitry
