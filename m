Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E0EDC4CEC1
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 16:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F7EF20736
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 16:55:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a7WHphIs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730326AbgCKQz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 12:55:57 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29026 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730159AbgCKQz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 12:55:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583945754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HSgjM26zIX3PavBkrCBluq3yJAmMXPt5zdmFUceEPUk=;
        b=a7WHphIs2iyqNmAWxX2m13PXrUahHxgzcm4LkO+93c2zN719y8osdOdtqhujLwsXEVd9LI
        Dn5zo2oSHaywbLQUYB4hPixoPjKnwYJLafucvh6WHubfOT/r26wZpmPUqe7KnDp3od4cLp
        0FJVUxXF2IO3ZaEDJJXZ94uINwuO0JU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-rlBfrxeDPV-P9-cs3OnWGg-1; Wed, 11 Mar 2020 12:55:52 -0400
X-MC-Unique: rlBfrxeDPV-P9-cs3OnWGg-1
Received: by mail-wm1-f72.google.com with SMTP id p17so854928wmc.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 09:55:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=HSgjM26zIX3PavBkrCBluq3yJAmMXPt5zdmFUceEPUk=;
        b=ZaFOZa7aXnO2Vrh64rYB1ZGmH6gPESn8OMl83LFJWhEOiTyJkJhuQeeFbl9lMNn7Jh
         wwfCC7GRywMAURkfWv0XX0Sfzt9TaTUqVCOJNbAVLheoyiGv8RYKpn1NL11E9wDviPXp
         9AtQyI3owqodIZazVAeTz3I9MXkheH3M1xaq/1CdWsu6CZ5UTtmEII0OKqP1Cc1DnXdn
         +5ksheqJG4pYvPkESO4R9tkkbThZcnxQbN+FROCxodB/pgO00SIVYw3O09Y11I4FBnYR
         BqYfCYRqlsKNfaJl9sDGlzGKR7zNjBp44DpOzF5i5LOe1MTnuhd3A4a6I8dcE06cJjQb
         U0/w==
X-Gm-Message-State: ANhLgQ2F/vVKbN5y42vRKlZyFFCgyOTg0tYdqNp5EHhJmlegWZtce5NH
        exfT9vhdWc5MnKjEQOANlmyTf3/MGB8VbV7mrzlfvcnW4FesJ90g2Gri+Co2PBFyZQWb/FT1jP2
        yYM6NxMtm8q0ga3TYQsyJmUF5
X-Received: by 2002:a5d:63c7:: with SMTP id c7mr5326981wrw.384.1583945751467;
        Wed, 11 Mar 2020 09:55:51 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsW35ore7Qm3vjEYXtbIoqC8m+BW/xNy5Vy9kjOPP+WoiYbSKW84175pQgJX/okAmoW7A9FTg==
X-Received: by 2002:a5d:63c7:: with SMTP id c7mr5326967wrw.384.1583945751193;
        Wed, 11 Mar 2020 09:55:51 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id p10sm7252926wru.4.2020.03.11.09.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 09:55:49 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-hyperv@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Baoquan He <bhe@redhat.com>,
        Wei Yang <richard.weiyang@gmail.com>
Subject: Re: [PATCH v1 5/5] mm/memory_hotplug: allow to specify a default online_type
In-Reply-To: <20200311123026.16071-6-david@redhat.com>
References: <20200311123026.16071-1-david@redhat.com> <20200311123026.16071-6-david@redhat.com>
Date:   Wed, 11 Mar 2020 17:55:48 +0100
Message-ID: <877dzqsuej.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Hildenbrand <david@redhat.com> writes:

> For now, distributions implement advanced udev rules to essentially
> - Don't online any hotplugged memory (s390x)
> - Online all memory to ZONE_NORMAL (e.g., most virt environments like
>   hyperv)
> - Online all memory to ZONE_MOVABLE in case the zone imbalance is taken
>   care of (e.g., bare metal, special virt environments)
>
> In summary: All memory is usually onlined the same way, however, the
> kernel always has to ask userspace to come up with the same answer.
> E.g., HyperV always waits for a memory block to get onlined before
> continuing, otherwise it might end up adding memory faster than
> hotplugging it, which can result in strange OOM situations.
>
> Let's allow to specify a default online_type, not just "online" and
> "offline". This allows distributions to configure the default online_type
> when booting up and be done with it.
>
> We can now specify "offline", "online", "online_movable" and
> "online_kernel" via
> - "memhp_default_state=" on the kernel cmdline
> - /sys/devices/systemn/memory/auto_online_blocks
> just like we are able to specify for a single memory block via
> /sys/devices/systemn/memory/memoryX/state
>

Thank you for picking this up! 

It's been awhile since I've added CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE
but I vaguely recall one problem: memory hotplug may happen *very* early
(just because some memory is presented to a VM as hotplug memory, it is
not in e820). It happens way before we launch userspace (including
udev). The question is -- which ZONE will this memory be assigned too?

'memhp_default_state=' resolves the issue but nobody likes additional
kernel parameters for anything but
debug. CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE was supposed to help, but it
is binary and distro-wide (so *all* deployments will get the same
default and as you validly stated we want it differently).

We could've added something like your example onlining script to the
kernel itself but this is likely going to be hard to sell: "policies
belong to userspace!" will likely be the answer. 

So if we don't want to start the endless discussions (again), your
proposal is 'good enough'.


> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Wei Yang <richard.weiyang@gmail.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  drivers/base/memory.c          | 11 +++++------
>  include/linux/memory_hotplug.h |  2 ++
>  mm/memory_hotplug.c            |  8 ++++----
>  3 files changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index 8d3e16dab69f..2b09b68b9f78 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -35,7 +35,7 @@ static const char *const online_type_to_str[] = {
>  	[MMOP_ONLINE_MOVABLE] = "online_movable",
>  };
>  
> -static int memhp_online_type_from_str(const char *str)
> +int memhp_online_type_from_str(const char *str)
>  {
>  	int i;
>  
> @@ -394,13 +394,12 @@ static ssize_t auto_online_blocks_store(struct device *dev,
>  					struct device_attribute *attr,
>  					const char *buf, size_t count)
>  {
> -	if (sysfs_streq(buf, "online"))
> -		memhp_default_online_type = MMOP_ONLINE;
> -	else if (sysfs_streq(buf, "offline"))
> -		memhp_default_online_type = MMOP_OFFLINE;
> -	else
> +	const int online_type = memhp_online_type_from_str(buf);
> +
> +	if (online_type < 0)
>  		return -EINVAL;
>  
> +	memhp_default_online_type = online_type;
>  	return count;
>  }
>  
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index c6e090b34c4b..ef55115320fb 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -117,6 +117,8 @@ extern int arch_add_memory(int nid, u64 start, u64 size,
>  			struct mhp_restrictions *restrictions);
>  extern u64 max_mem_size;
>  
> +extern int memhp_online_type_from_str(const char *str);
> +
>  /* Default online_type (MMOP_*) when new memory blocks are added. */
>  extern int memhp_default_online_type;
>  /* If movable_node boot option specified */
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 01443c70aa27..4a96273eafa7 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -75,10 +75,10 @@ EXPORT_SYMBOL_GPL(memhp_default_online_type);
>  
>  static int __init setup_memhp_default_state(char *str)
>  {
> -	if (!strcmp(str, "online"))
> -		memhp_default_online_type = MMOP_ONLINE;
> -	else if (!strcmp(str, "offline"))
> -		memhp_default_online_type = MMOP_OFFLINE;
> +	const int online_type = memhp_online_type_from_str(str);
> +
> +	if (online_type >= 0)
> +		memhp_default_online_type = online_type;
>  
>  	return 1;
>  }

-- 
Vitaly

