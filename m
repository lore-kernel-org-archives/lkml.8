Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A31DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 15:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0214520759
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 15:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fV9N6K4d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389309AbgF3POD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 11:14:03 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25416 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389254AbgF3POB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 11:14:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593530040;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZKG9midKxWXapiyhsCNvJA81s4+MOL+9sOnG0fsdr5k=;
        b=fV9N6K4de3YD4mme2gOQ7N/HzlFz29P1kIOZ1nwnIQ3q6N3izRpvJUOg7ooDDBLoADWXvl
        NVS3ioAAQ4mfg36th1VwYNz1e8bfDJHPbElqWDW4MNR1adTd9Y90GUwozrXAY2uYI9d7JM
        X6YDbqizUizjeaSFTzJaEmDPajq+ROI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-Mdczr8iiNquqqzT3WSBDFQ-1; Tue, 30 Jun 2020 11:13:58 -0400
X-MC-Unique: Mdczr8iiNquqqzT3WSBDFQ-1
Received: by mail-ej1-f69.google.com with SMTP id gz3so13267148ejb.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 08:13:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=ZKG9midKxWXapiyhsCNvJA81s4+MOL+9sOnG0fsdr5k=;
        b=huSO9EzsRZidFF3DBmqcXqundhAl6m/9jsopkvhLEiRiRYu7IXCUi6XWL0M8KYHaV2
         sUXp8H6N2hHd9cAYeZxep8euM2cePpWf0/MvcnrRE+qwG+T5TUUB8UXhMsuH/cnp3DZ7
         uK9JPEyoLgVTOXgnpt+s+m371rl2sISyHnotyLRlov1dU97Uof3WDNfMh9loTACtGjQZ
         jHRhO9u1fhXd2n9FM5HlJVGMJapqfDwst+RdXnhKffJQYKtTC4yjVBekNAf4D3sy3eO6
         tVp2eJdBRTQ3M9pCQNpW7pVatzbJNzTE0x3Dg7XsF0jquDMZYqn1VgxVBPYppZAe17+T
         uN3g==
X-Gm-Message-State: AOAM5304QKSaQF+Cwe7CHcPE+0zJMhaBwVawuwZnnQJCXNYg0S7iqPuq
        v9u87GApxto8WNM4P0avLg0XOamCzPQYDN/wzDWfKzG/2mSqYd7cng7Kp/AoayMrSXRiyQ+V9EY
        gaItSv45vzGYi39lho8TRXp7k
X-Received: by 2002:a17:906:4b59:: with SMTP id j25mr14217934ejv.301.1593530037379;
        Tue, 30 Jun 2020 08:13:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxWJGag6axKV5Mjrjn/LOB60MJyVmX4lA/dZrG+9uiRT0JIT08wQCFip7z0Hgpd36tFz9mSqQ==
X-Received: by 2002:a17:906:4b59:: with SMTP id j25mr14217917ejv.301.1593530037138;
        Tue, 30 Jun 2020 08:13:57 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id w24sm3145277edt.28.2020.06.30.08.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 08:13:55 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     kvm@vger.kernel.org, virtio-fs@redhat.com, pbonzini@redhat.com,
        sean.j.christopherson@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] kvm,x86: Exit to user space in case of page fault error
In-Reply-To: <20200630145303.GB322149@redhat.com>
References: <20200625214701.GA180786@redhat.com> <87lfkach6o.fsf@vitty.brq.redhat.com> <20200626150303.GC195150@redhat.com> <874kqtd212.fsf@vitty.brq.redhat.com> <20200629220353.GC269627@redhat.com> <87sgecbs9w.fsf@vitty.brq.redhat.com> <20200630145303.GB322149@redhat.com>
Date:   Tue, 30 Jun 2020 17:13:54 +0200
Message-ID: <87mu4kbn7x.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal <vgoyal@redhat.com> writes:

> On Tue, Jun 30, 2020 at 03:24:43PM +0200, Vitaly Kuznetsov wrote:

>> 
>> It's probably me who's missing something important here :-) but I think
>> you describe how it *should* work as I'm not seeing how we can leave the
>> loop in kvm_async_pf_task_wait_schedule() other than by 
>> "if (hlist_unhashed(&n.link)) break;" and this only happens when APF
>> completes.
>
> We don't leave loop in kvm_async_pf_task_wait_schedule(). It will happen
> before you return to user space.
>
> I have not looked too closely but I think following code path might be taken
> after aync PF has completed.
>
> __kvm_handle_async_pf()
>   idtentry_exit_cond_rcu()
>     prepare_exit_to_usermode()
>       __prepare_exit_to_usermode()
>         exit_to_usermode_loop()
> 	  do_signal()
>
> So once you have been woken up (because APF completed),

Ah, OK so we still need to complete APF and we can't kill the process
before this happens, that's what I was missing.

>  you will
> return to user space and before that you will check if there are
> pending signals and handle that signal first before user space
> gets a chance to run again and retry faulting instruction.

...

>
>> 
>> When guest receives the 'page ready' event with an error it (like for
>> every other 'page ready' event) tries to wake up the corresponding
>> process but if the process is dead already it can do in-kernel probing
>> of the GFN, this way we guarantee that the error is always injected. I'm
>> not sure if it is needed though but in case it is, this can be a
>> solution. We can add a new feature bit and only deliver errors when the
>> guest indicates that it knows what to do with them.
>
> - Process will be delivered singal after async PF completion and during
>   returning to user space. You have lost control by then.
>

So actually there's no way for kernel to know if the userspace process
managed to re-try the instruction and get the error injected or if it
was killed prior to that.

> - If you retry in kernel, we will change the context completely that
>   who was trying to access the gfn in question. We want to retain
>   the real context and retain information who was trying to access
>   gfn in question.

(Just so I understand the idea better) does the guest context matter to
the host? Or, more specifically, are we going to do anything besides
get_user_pages() which will actually analyze who triggered the access
*in the guest*?

-- 
Vitaly

