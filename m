Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3333C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 17:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB0DF20B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 17:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592500573;
	bh=Id8Gjk+hM0G6UrJQDnbrDFUcw8fPZ5ZGRI5VwSvoODY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=mfKqILPyleibddbdNjUGVdTBGkgKTNak5ulJ+BWNsDH0VKIneVwvbbiYvnJ0G8G/n
	 XklvSONgAXyT2XJSQ+oF8dVofFS0k1czV01C9QANEGKppzfKodUwxt04u8eWzqquI2
	 RDb22aD4B3hS7FOofc8VoNKq1NJZf5Lf8ddUOqOQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732070AbgFRRQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 13:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727822AbgFRRQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 13:16:11 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59262C06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 10:16:10 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id c17so8158611lji.11
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 10:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r9B0DNNPzxgoPyAfRSYd3ZQODRChafMlEGcqG+QaP/o=;
        b=h52vOHaaEhC9DvyZeZVKRtkDsBNc1neXdsILt1AApD0+khpSnxXAdCDCgo2wU3M5h7
         PqD+tj2/3V6xVGY6ZCNUt1yeLJK2Pu5VDp9eAPX+IIHX7MqgaSDAH7sE1O3E7CEu8V+p
         RkBxiIt06D883sHelU68GdNIffT6LEJn+15dI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r9B0DNNPzxgoPyAfRSYd3ZQODRChafMlEGcqG+QaP/o=;
        b=ZglCsP3QXW+CKfEBVIAmwlAijRJ/NoPFhY8PVEp5/dJ52qk1x8qYfcmZ8z629jm4zI
         y9KMZFOMbX/EBs0EOT2N3m77E0cpIasFF+m99weWObcdDG7jJelDCXB2HvvfZ+iobv/L
         RGzl4mZF4YWyAlhfHl2Blk45yicZJJsaX5QfITNDyiOKPhElA4e8IAIuFFbE8GYDA0U0
         GIO9EH9RX6Ogj8eVmB1xutnZrogu4H4NfpP9zIijHOsInNbgwGLESz16RyXtpY3593Pj
         G+z8kKmAMfda5voGXa9rruQhmBIxr1JYtCpQ+k/vDn2O7kqd/gebO2zxZSMf/vQGxPne
         Mmzw==
X-Gm-Message-State: AOAM532X3BmWOC62JBEwwv0vHFNHSZiPv/ZmWXAwiHIN7CQbsxsx3xlc
        1UBF2Q/ljWVjoGm5Cu2pFHOxRP0MQGg=
X-Google-Smtp-Source: ABdhPJxCHkE+mHr/QCGzWFEw6UUFM0mPnnrLxXKLGv602f1XZpLMzAgFBQt2P2HPllUO147cbDlAOQ==
X-Received: by 2002:a2e:860f:: with SMTP id a15mr2926817lji.127.1592500568269;
        Thu, 18 Jun 2020 10:16:08 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id z22sm863257lfi.96.2020.06.18.10.16.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2020 10:16:07 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id g2so3959562lfb.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 10:16:07 -0700 (PDT)
X-Received: by 2002:ac2:4422:: with SMTP id w2mr2864426lfl.152.1592500566754;
 Thu, 18 Jun 2020 10:16:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200615221607.7764-1-peterx@redhat.com> <20200615221607.7764-8-peterx@redhat.com>
 <CAJF2gTSVSXO=phc1eeb-ZmDMrSDjSSLd3tN6ng_8n-pCSZh5zw@mail.gmail.com>
 <20200617154925.GC76766@xz-x1> <CAHk-=wi=58J7d5iyFyYyHrU+pzjWB55cit_LQCkSkavpH-trsg@mail.gmail.com>
 <20200617195807.GH76766@xz-x1> <CAHk-=wj_V2Tps2QrMn20_W0OJF9xqNh52XSGA42s-ZJ8Y+GyKw@mail.gmail.com>
 <20200618143801.GK76766@xz-x1>
In-Reply-To: <20200618143801.GK76766@xz-x1>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 18 Jun 2020 10:15:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=whFEZbTJZaNwEkyevUV2aqRwbeVmtp6hhk1sK2mW4vaGA@mail.gmail.com>
Message-ID: <CAHk-=whFEZbTJZaNwEkyevUV2aqRwbeVmtp6hhk1sK2mW4vaGA@mail.gmail.com>
Subject: Re: [PATCH 07/25] mm/csky: Use mm_fault_accounting()
To:     Peter Xu <peterx@redhat.com>
Cc:     Guo Ren <guoren@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        linux-csky@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 7:38 AM Peter Xu <peterx@redhat.com> wrote:
>
> GUP needs the per-task accounting, but not the perf events.  We can do that by
> slightly changing the new approach into:
>
>         bool major = (ret & VM_FAULT_MAJOR) || (flags & FAULT_FLAG_TRIED);
>
>         if (major)
>                 current->maj_flt++;
>         else
>                 current->min_flt++;
>
>         if (!regs)
>                 return ret;
>
>         if (major)
>                 perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1, regs, address);
>         else
>                 perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1, regs, address);

Ack, I think this is the right thing to do.

No normal situation will ever notice the difference, with remote
accesses being as rare and specialized as they are. But being able to
remote the otherwise unused 'tsk' parameter sounds like the right
thing to do too.

It might be worth adding a comment about why.

Also, honestly, how about we remove the 'major' variable entirely, and
instead make the code be something like

        unsigned long *flt;
        int event_type;
        ...

        /* Major fault */
        if ((ret & VM_FAULT_MAJOR) || (flags & FAULT_FLAG_TRIED)) {
                flt = &current->maj_flt;
                event_type = PERF_COUNT_SW_PAGE_FAULTS_MAJ;
        } else {
                flt = &current->min_flt;
                event_type = PERF_COUNT_SW_PAGE_FAULTS_MIN;
        }
        *flt++;
        if (regs)
                perf_sw_event(event_type, 1, regs, address);

instead. Less source code duplication, and I bet it improves code
generation too.

             Linus
