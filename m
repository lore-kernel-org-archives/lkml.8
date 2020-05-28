Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A69A2C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 09:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86CEB2088E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 09:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbgE1JhC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 05:37:02 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45792 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728393AbgE1JhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 05:37:01 -0400
Received: from mail-pf1-f198.google.com ([209.85.210.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jeEyB-0001dL-1y
        for linux-kernel@vger.kernel.org; Thu, 28 May 2020 09:36:59 +0000
Received: by mail-pf1-f198.google.com with SMTP id h137so597739pfe.18
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 02:36:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=uElBHPq9LpIquIfpjXBhIioWXJX+UOjzlFZ3l4h1urA=;
        b=pr0dckRK31Wym1HrGcDAOGVVvLkU6phYqWx0M8NWTIuuB5lZNSuljf1oiwBJHiiXth
         UNquKliQvcytaIhTjpTMsR8eW8YK+FxWfF3veIQbGG6n4Aw6Ar+sVtclvlFJl5GbJiPw
         6XH2NuUd7Ob9MWmn5qUr4ztmFmH2YeYNlBAy77jVBgLkAt8YJ6bats2gNl/y3HodKyqK
         iR/AWE+YcxbChtd3gcNw9/yadXn5SdNolQcadqTy6IM+ZLZRmcwUfVXIC5hDVl5zaz+o
         Y4I1WKxDeClXa5MSQkefDzsOPvZzyZwVMSANHo00GnJKaDLoA6U29q0ndRl0xFbHSp37
         TFDw==
X-Gm-Message-State: AOAM533IFfLBSmuf/kiB0tKOHp+tx6lsPfXa5PT6j9zXJ+f/2xyBYJ75
        mcQ3SsnsVlY51+dCv5v7iP4XiCXC/E4oGwEbp/9XL+p0akqmKFizdx/pj0mS4STq81vqmNkqMnc
        g/b3cIa4qJLq8whvZ+BBCte2eSGXvKIQcJ/CBsv215g==
X-Received: by 2002:a17:90a:2305:: with SMTP id f5mr2871473pje.57.1590658617436;
        Thu, 28 May 2020 02:36:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJysPG0b5q+A4iRcheu8QBU5PGgcYYiOBRMuyzD4TXDivrnJp03Dvjn0RzRDCh2cuifEeOrbfg==
X-Received: by 2002:a17:90a:2305:: with SMTP id f5mr2871458pje.57.1590658617053;
        Thu, 28 May 2020 02:36:57 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id l11sm5460023pjj.33.2020.05.28.02.36.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 May 2020 02:36:54 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] HID: multitouch: Remove MT_CLS_WIN_8_DUAL
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <CAO-hwJJCQbGV3cYjHNmiEi7rgoC5U9uq2ugkNJtRv=Z0wHsuag@mail.gmail.com>
Date:   Thu, 28 May 2020 17:36:50 +0800
Cc:     Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <E94C8C0C-BF5E-454E-8D2B-90854D635488@canonical.com>
References: <20200414091842.25972-1-kai.heng.feng@canonical.com>
 <nycvar.YFH.7.76.2005261023250.25812@cbobk.fhfr.pm>
 <CAO-hwJ+mTjVpBiY9vHXA2Y6D+cXYemixFJ++i+KwZZ25Z6LHHA@mail.gmail.com>
 <A51B9D28-88BF-42EB-9161-8E3081B128D2@canonical.com>
 <CAO-hwJJ=_2bn1BEshZ6URT813UAA6KRLaiEHt6bNPUcd9esskg@mail.gmail.com>
 <CAO-hwJJCQbGV3cYjHNmiEi7rgoC5U9uq2ugkNJtRv=Z0wHsuag@mail.gmail.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 27, 2020, at 20:15, Benjamin Tissoires <benjamin.tissoires@redhat.com> wrote:
> 
> On Wed, May 27, 2020 at 11:24 AM Benjamin Tissoires
> <benjamin.tissoires@redhat.com> wrote:
>> 
>> On Wed, May 27, 2020 at 8:19 AM Kai-Heng Feng
>> <kai.heng.feng@canonical.com> wrote:
>>> 
>>> 
>>> 
>>>> On May 26, 2020, at 16:43, Benjamin Tissoires <benjamin.tissoires@redhat.com> wrote:
>>>> 
>>>> On Tue, May 26, 2020 at 10:24 AM Jiri Kosina <jikos@kernel.org> wrote:
>>>>> 
>>>>> On Tue, 14 Apr 2020, Kai-Heng Feng wrote:
>>>>> 
>>>>>> After commit c23e2043d5f7 ("HID: multitouch: do not filter mice nodes"),
>>>>>> MT_CLS_WIN_8 also supports mouse nodes, hence make MT_CLS_WIN_8_DUAL
>>>>>> redundant.
>>>>>> 
>>>>>> Remove MT_CLS_WIN_8_DUAL accordingly.
>>>>> 
>>>>> Benjamin, can I get your Ack on this one please?
>>>> 
>>>> Heh, funny enough I was trying to fix
>>>> https://bugzilla.kernel.org/show_bug.cgi?id=207235 and was pondering
>>>> this one too.
>>>> 
>>>> To fix #207235, I'll likely need to add a new class and quirk in
>>>> hid-multitouch. I can't really find a generic solution for now, and we
>>>> better have a local quirk for the 2 devices we currently have and
>>>> backport those to stable. However, this patch will likely conflict
>>>> (trivially), with the new quirks, so I was thinking:
>>>> - submitting my quick and dirty quirk and mark it to stable
>>>> - apply this one on top of it (this one really doesn't need to go to stable)
>>>> 
>>>> How does that sound?
>>> 
>>> Sounds good. I'll resend this patch once your patch lands in the tree.
>> 
>> Great, thanks. Though I should be able to rebase it and push it
>> directly. I'll notify you if I can't get to it today.
> 
> Alright, rebased and pushed to for-5.8/multitouch.
> 
> Thanks a lot.

Thanks for your work :)

Kai-Heng

> 
> Cheers,
> Benjamin
> 
>> 
>> Cheers,
>> Benjamin
>> 
>>> 
>>> Kai-Heng
>>> 
>>>> 
>>>> Cheers,
>>>> Benjamin
>>>> 
>>>>> 
>>>>> Thanks,
>>>>> 
>>>>> --
>>>>> Jiri Kosina
>>>>> SUSE Labs

