Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA99C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 17:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94ED0206D6
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 17:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dIc53VR2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731018AbgEKRem (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 13:34:42 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23536 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730960AbgEKRel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 13:34:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589218480;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jCAJG5qvZrEQpE9xVUmgEKkY6ZGLKpgEhGop1JiyIl0=;
        b=dIc53VR2sD98xVcGm7/NzRUMxKrOmsaiadtecNUEztPcSObavKmSWGUtST7hrU93ifCLyP
        He+4xXgfGDpotx3IoKiT91bXSWxzzB4lT57ywtX7OnSQt7AXwOamAcslSscbiK5XffmY5u
        bZ/5HW5MHVgeL8zKf4OnGZUzc0w+gSw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-fy9GUWn9P3qCWDKHFG1cFg-1; Mon, 11 May 2020 13:34:32 -0400
X-MC-Unique: fy9GUWn9P3qCWDKHFG1cFg-1
Received: by mail-wm1-f72.google.com with SMTP id w189so4970251wmg.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 10:34:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jCAJG5qvZrEQpE9xVUmgEKkY6ZGLKpgEhGop1JiyIl0=;
        b=O25PyhuUQTKrQuzcFAIp0eJm//ji2Yv2PyrEhVJfZ6G3hP/wsiJssS5XfOPGUZDe8S
         uVk8udNlOHekkwnMO+tk9a6gC22Mz55RPV9NHL+jWG86yHFGH7m5psrGo9lyJ3EsEWMu
         yooOsHsrESS1DuIX3ucwH7m0yhn8s6S9EsGc5g3S53TuJXupVQDabBIrU7iMHryKEbur
         Yh/X7sRaf0v/RCclX+gBS9KMLoTncQIzpPci2dlfYfPYlVKVe2fWl1Q7xabaDuYQFxFu
         oLSxRSKwhjc2/JeTyIua0JPHor1SliWCoMtcYtCZEg5Un+vgaB5WbeGX+Q8Sum9hwdSe
         JBLA==
X-Gm-Message-State: AGi0Pua/vAJbwdB7UN/XqBUxVAjKpjK0OTbZrVqi4/eipEQ4qdGoVcIr
        YEPX+anldPVBNv+rSGssQSHp9e3+q6GcBCtYNgZJN2fvaWifRK7iEJE17AxgMvKfbbg2z80kPCs
        cercuEDw9Ur6hMCjopQ2S5WaG
X-Received: by 2002:a5d:49ca:: with SMTP id t10mr12469225wrs.285.1589218471440;
        Mon, 11 May 2020 10:34:31 -0700 (PDT)
X-Google-Smtp-Source: APiQypJNe6I7z0SbQYOHpqyl28aME7TxGvpzSGiIlzFVueJrlC+GRcVDtQgQEgjyS86Oa3oOuu0xgw==
X-Received: by 2002:a5d:49ca:: with SMTP id t10mr12469194wrs.285.1589218471191;
        Mon, 11 May 2020 10:34:31 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:4c95:a679:8cf7:9fb6? ([2001:b07:6468:f312:4c95:a679:8cf7:9fb6])
        by smtp.gmail.com with ESMTPSA id 89sm18102311wrj.37.2020.05.11.10.34.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2020 10:34:30 -0700 (PDT)
Subject: Re: [PATCH v2 0/5] Statsfs: a new ram-based file sytem for Linux
 kernel statistics
To:     Jonathan Adams <jwadams@google.com>
Cc:     Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mips@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20200504110344.17560-1-eesposit@redhat.com>
 <CA+VK+GN=iDhDV2ZDJbBsxrjZ3Qoyotk_L0DvsbwDVvqrpFZ8fQ@mail.gmail.com>
 <29982969-92f6-b6d0-aeae-22edb401e3ac@redhat.com>
 <CA+VK+GOccmwVov9Fx1eMZkzivBduWRuoyAuCRtjMfM4LemRkgw@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fe21094c-bdb0-b802-482e-72bc17e5232a@redhat.com>
Date:   Mon, 11 May 2020 19:34:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CA+VK+GOccmwVov9Fx1eMZkzivBduWRuoyAuCRtjMfM4LemRkgw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan, I think the remaining sticky point is this one:

On 11/05/20 19:02, Jonathan Adams wrote:
> I think I'd characterize this slightly differently; we have a set of
> statistics which are essentially "in parallel":
> 
>   - a variety of statistics, N CPUs they're available for, or
>   - a variety of statistics, N interfaces they're available for.
>   - a variety of statistics, N kvm object they're available for.
> 
> Recreating a parallel hierarchy of statistics any time we add/subtract
> a CPU or interface seems like a lot of overhead.  Perhaps a better 
> model would be some sort of "parameter enumn" (naming is hard;
> parameter set?), so when a CPU/network interface/etc is added you'd
> add its ID to the "CPUs" we know about, and at removal time you'd
> take it out; it would have an associated cbarg for the value getting
> callback.
> 
>> Yep, the above "not create a dentry" flag would handle the case where
>> you sum things up in the kernel because the more fine grained counters
>> would be overwhelming.
>
> nodnod; or the callback could handle the sum itself.

In general for statsfs we took a more explicit approach where each
addend in a sum is a separate stats_fs_source.  In this version of the
patches it's also a directory, but we'll take your feedback and add both
the ability to hide directories (first) and to list values (second).

So, in the cases of interfaces and KVM objects I would prefer to keep
each addend separate.

For CPUs that however would be pretty bad.  Many subsystems might
accumulate stats percpu for performance reason, which would then be
exposed as the sum (usually).  So yeah, native handling of percpu values
makes sense.  I think it should fit naturally into the same custom
aggregation framework as hash table keys, we'll see if there's any devil
in the details.

Core kernel stats such as /proc/interrupts or /proc/stat are the
exception here, since individual per-CPU values can be vital for
debugging.  For those, creating a source per stat, possibly on-the-fly
at hotplug/hot-unplug time because NR_CPUS can be huge, would still be
my preferred way to do it.

Thanks,

Paolo

