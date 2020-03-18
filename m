Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 928A3C5ACD7
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 13:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F07020767
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 13:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AwIcVtv+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbgCRN6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 09:58:51 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:29147 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726877AbgCRN6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 09:58:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584539929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F31yuOR6DS7mAZV1PpzPl5tjjIYKtGbdeccjup64HTg=;
        b=AwIcVtv++30rjahmGEw8BAPE0uhOgS+1TOAk97GEBPYCaI/2M2VfcQ1Mtoy2ExY/3on/+N
        tQ6tGZ8TvexrLi0P6K96JT/yXX0QfeXlFbT++4nC+xmRSCxC7i1K0O0glaOxZ9SpG7DHuM
        wMCi0nttwKtaE4FSTG+01GdKe6psRwc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-2opHq41zNweofLgKo3N0EQ-1; Wed, 18 Mar 2020 09:58:48 -0400
X-MC-Unique: 2opHq41zNweofLgKo3N0EQ-1
Received: by mail-wr1-f71.google.com with SMTP id u12so9964370wrw.10
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 06:58:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=F31yuOR6DS7mAZV1PpzPl5tjjIYKtGbdeccjup64HTg=;
        b=avhPo6w4epGm54Sgd6NDNeEBPdqkTcxgALI7R37S0psBBF2BCE2+u1ZRH/yvY+9ixm
         JifuG99l0Z57vj+BiK+cENKOaxW0trkeQTaCUpe/3gTScLzGCkYKdsSFxr+Xn4ZgoDxW
         mZXIJoMP1Cig50o8E9wQoU5jOc0TJVs21CdrKwArw2p3HfTnI6O0hF07PQF2EhRivUvf
         CqvPD9il2WWP8l/AAwh7zlZkcvQ/A8NlSZqvOcriVh/WPkwg0QoIDMkLsgzi8TjYQVUK
         tiIZFbf9fD/3zUMPGdGscBQIjhLLqKJHeRz/8iRWT5GFpW/3Xo1BF7gwGFrMzuhABKcm
         xrlg==
X-Gm-Message-State: ANhLgQ0CcVkXNwxpEtQ2gLYkYwjFL/meAJs1qLbh2hYB3PjairFYE3ll
        L9IRTaM83FSXBetq0FKmf9hfDzEfFyns0R3MfyWz4HEDODOENcuib/YWlNCSruJwSKxWXs+uWmU
        TxZsZR0r2D5QPOMR3c/3OJcIE
X-Received: by 2002:a1c:e442:: with SMTP id b63mr5559726wmh.174.1584539927046;
        Wed, 18 Mar 2020 06:58:47 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuOzuNgvDkbFkbElCg5edIwU+8StaNxg5QEC0tTkAdX0Cu7G9Ynuwj6chgem6WJSymuM5v0dQ==
X-Received: by 2002:a1c:e442:: with SMTP id b63mr5559631wmh.174.1584539925803;
        Wed, 18 Mar 2020 06:58:45 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id q10sm9136178wrx.12.2020.03.18.06.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 06:58:45 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Baoquan He <bhe@redhat.com>, David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org,
        Yumei Huang <yuhuang@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Eduardo Habkost <ehabkost@redhat.com>,
        Milan Zamazal <mzamazal@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Hocko <mhocko@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Paul Mackerras <paulus@samba.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Wei Yang <richard.weiyang@gmail.com>
Subject: Re: [PATCH v2 0/8] mm/memory_hotplug: allow to specify a default online_type
In-Reply-To: <20200318130517.GC30899@MiWiFi-R3L-srv>
References: <20200317104942.11178-1-david@redhat.com> <20200318130517.GC30899@MiWiFi-R3L-srv>
Date:   Wed, 18 Mar 2020 14:58:43 +0100
Message-ID: <87d0993gto.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Baoquan He <bhe@redhat.com> writes:

> On 03/17/20 at 11:49am, David Hildenbrand wrote:
>> Distributions nowadays use udev rules ([1] [2]) to specify if and
>> how to online hotplugged memory. The rules seem to get more complex with
>> many special cases. Due to the various special cases,
>> CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE cannot be used. All memory hotplug
>> is handled via udev rules.
>> 
>> Everytime we hotplug memory, the udev rule will come to the same
>> conclusion. Especially Hyper-V (but also soon virtio-mem) add a lot of
>> memory in separate memory blocks and wait for memory to get onlined by user
>> space before continuing to add more memory blocks (to not add memory faster
>> than it is getting onlined). This of course slows down the whole memory
>> hotplug process.
>> 
>> To make the job of distributions easier and to avoid udev rules that get
>> more and more complicated, let's extend the mechanism provided by
>> - /sys/devices/system/memory/auto_online_blocks
>> - "memhp_default_state=" on the kernel cmdline
>> to be able to specify also "online_movable" as well as "online_kernel"
>
> This patch series looks good, thanks. Since Andrew has merged it to -mm again,
> I won't add my Reviewed-by to bother. 
>
> Hi David, Vitaly
>
> There are several things unclear to me.
>
> So, these improved interfaces are used to alleviate the burden of the 
> existing udev rules, or try to replace it? As you know, we have been
> using udev rules to interact between kernel and user space on bare metal,
> and guests who want to hot add/remove.

With 'auto_online_blocks' interface you don't need the udev rule. David
is trying to make it more versatile.

>
> And also the OOM issue in hyperV when onlining pages after adding memory
> block. I am not a virt devel expert, could this happen on bare metal
> system?

Yes - in theory, very unlikely - in practice.

The root cause of the problem here is adding more memory to the system
requires memory (page tables, memmaps,..) so if your system is low on
memory and you're trying to hotplug A LOT you may run into OOM before
you're able to online anything. With bare metal it's usualy not the
case: servers, which are able to hotplug memory, are usually booted with
enough memory and memory hotplug is a manual action (you need to insert
DIMMs!). But, if you boot your server with e.g. 4G, almost exhaust it
and then try to hotplug e.g. 256G ... well, OOM is almost guaranteed.
With virtual machines it's very common (e.g. with Hyper-V VMs) to boot
them with low memory and hotplug it (automatically, by some management
software) when neededm thus the problem is way more common.

-- 
Vitaly

