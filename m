Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B41C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 06:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBFF020723
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 06:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbgE0GTY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 02:19:24 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47650 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727990AbgE0GTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 02:19:23 -0400
Received: from mail-pf1-f198.google.com ([209.85.210.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jdpPN-0004YA-Or
        for linux-kernel@vger.kernel.org; Wed, 27 May 2020 06:19:21 +0000
Received: by mail-pf1-f198.google.com with SMTP id w24so14326827pfq.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 23:19:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=g3G10oTdQUGktU+UO7WQ3PW2TAHAFN2Zb3zq425YYyk=;
        b=LDfzCOtiVdKdmJsleHE+kvi0w+UyLSGQgfwY6QHEyVLgAOuVeQRVLna5gp4ia2jfpx
         ZavZcd4wrUvKYavPV79c+VEqXYypQpWoriFNO4KKLcUwcChtFNbDNPav+/Pw/nkmB4Vz
         YHPmwC0xHezGqSyltBnCp2NGalRFzpTltFjkdVGEHsvsZXaHvaP3bDAesy4XZUX2E8Xx
         S5dBzTyQ4CEgSYM7tWD1M4aIt8+zsJzVvbH/8Bveg/AWv2OpkB2/DAYsgyj9gCBiWfPy
         PSmwNQlKQ34wGwVw7r8e4kOYhDB7cOPl9jipRLvq4Me1LvugVfBya0AxCTWzKO+vprIQ
         AIaQ==
X-Gm-Message-State: AOAM532m/NIF/ao7grkxEjonOm5rLPvxo0xhF3nki+GxS91bSJkrg+fs
        8GCyTV5ImSDFYB4nyYnlPzb6BYRURERDJiFbhyROtncB7HLl/ZdU2zltMUmOVeSo+lNcafOE7m6
        xk0//1cTKZB0OpfBOw8peZdMm8Dhs5nXA/MaAgNPqBA==
X-Received: by 2002:a17:902:b110:: with SMTP id q16mr3231239plr.221.1590560360150;
        Tue, 26 May 2020 23:19:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwBIb9+Qpyu2p2CRX6M0xxGWgWILNhjV3F4UW8F6y8Qt/zVz7kocYeSWmjCgzKGw9FxwL0PDg==
X-Received: by 2002:a17:902:b110:: with SMTP id q16mr3231222plr.221.1590560359845;
        Tue, 26 May 2020 23:19:19 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id y4sm1165764pfq.10.2020.05.26.23.19.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 May 2020 23:19:19 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] HID: multitouch: Remove MT_CLS_WIN_8_DUAL
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <CAO-hwJ+mTjVpBiY9vHXA2Y6D+cXYemixFJ++i+KwZZ25Z6LHHA@mail.gmail.com>
Date:   Wed, 27 May 2020 14:19:16 +0800
Cc:     Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <A51B9D28-88BF-42EB-9161-8E3081B128D2@canonical.com>
References: <20200414091842.25972-1-kai.heng.feng@canonical.com>
 <nycvar.YFH.7.76.2005261023250.25812@cbobk.fhfr.pm>
 <CAO-hwJ+mTjVpBiY9vHXA2Y6D+cXYemixFJ++i+KwZZ25Z6LHHA@mail.gmail.com>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 26, 2020, at 16:43, Benjamin Tissoires <benjamin.tissoires@redhat.com> wrote:
> 
> On Tue, May 26, 2020 at 10:24 AM Jiri Kosina <jikos@kernel.org> wrote:
>> 
>> On Tue, 14 Apr 2020, Kai-Heng Feng wrote:
>> 
>>> After commit c23e2043d5f7 ("HID: multitouch: do not filter mice nodes"),
>>> MT_CLS_WIN_8 also supports mouse nodes, hence make MT_CLS_WIN_8_DUAL
>>> redundant.
>>> 
>>> Remove MT_CLS_WIN_8_DUAL accordingly.
>> 
>> Benjamin, can I get your Ack on this one please?
> 
> Heh, funny enough I was trying to fix
> https://bugzilla.kernel.org/show_bug.cgi?id=207235 and was pondering
> this one too.
> 
> To fix #207235, I'll likely need to add a new class and quirk in
> hid-multitouch. I can't really find a generic solution for now, and we
> better have a local quirk for the 2 devices we currently have and
> backport those to stable. However, this patch will likely conflict
> (trivially), with the new quirks, so I was thinking:
> - submitting my quick and dirty quirk and mark it to stable
> - apply this one on top of it (this one really doesn't need to go to stable)
> 
> How does that sound?

Sounds good. I'll resend this patch once your patch lands in the tree.

Kai-Heng

> 
> Cheers,
> Benjamin
> 
>> 
>> Thanks,
>> 
>> --
>> Jiri Kosina
>> SUSE Labs
>> 
> 

