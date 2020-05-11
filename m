Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B92C8C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 09:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AD492075E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 09:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Or824gsh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729495AbgEKJhL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 05:37:11 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21744 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729459AbgEKJhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 05:37:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589189828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9/z8oJy0DrW82NKQzFo0pYOXFvWx+Vn3ieQ420AJ3lc=;
        b=Or824gshAxJh9WOS+X/WmIVuhaACN/xsBpOMow3E7W7/tNv3v5zydn5wBdNRVYnKgMGqZd
        hIRYGEyJpBX3pyvj0YrEdtX07AhYX1+AuEUmgX4kjIaQKr6/Viugg2zG5STQwWBQA2NORY
        y0JlmGkDpG9l4Oc4H8vCPart9d87y9U=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-x5Nmtl54NsWQZnneZiV0WA-1; Mon, 11 May 2020 05:37:05 -0400
X-MC-Unique: x5Nmtl54NsWQZnneZiV0WA-1
Received: by mail-wr1-f69.google.com with SMTP id h12so4974576wrr.19
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 02:37:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9/z8oJy0DrW82NKQzFo0pYOXFvWx+Vn3ieQ420AJ3lc=;
        b=Hl1jGuS0jcszVkZrJO7WH6+lXfzY+ATvvXITD7cIstzNDzlAmWhUTw3WVYOog3mD0W
         LZGBPJjpSbZAHYMSvPMYegSZ45CK67ZM9r2gj7tdHa9G1/GeLXr4Jdc88UmOwwL/CRfN
         V78PUVaX3PqTqw8pOW3gTtim4+AMs3eIaZ/xZtZTODa6PfQC2/DvoXK7yrI4EZS8M7SF
         t8212+DAfxsjIYbfid44dBMrhiwN7JcBHgoR2neo2rHOVunx+hEQwRUNpNv6q0CC6quZ
         EdQzpnVlum95dsRWANKEM8VlvFEe0x5UVCKtHfKXs+eIZthJ4pfgu0i6rSAVDztSz21L
         x2tQ==
X-Gm-Message-State: AGi0PuZ/artx+fFUlHh99l0bQcWZd011MKCYZBjCNv+4DWTK8Hq7ytQd
        ubLtaBbZpqJyW1kZ2qZyfHTyH91mRGgGq678ZZqwxa5KnoM+6ziVdWzEKjw9+vknMbuLN6BlKvW
        WirbBgUL7xcm08WnGwpdZPzam
X-Received: by 2002:adf:9447:: with SMTP id 65mr18006254wrq.331.1589189824501;
        Mon, 11 May 2020 02:37:04 -0700 (PDT)
X-Google-Smtp-Source: APiQypLgXJL2J4QG833y891iupVzJ12ZpeHXWlbbAPxxD6jgWVlOjQHWoAXK6Z1hUwl6JqLwXHJL/w==
X-Received: by 2002:adf:9447:: with SMTP id 65mr18006221wrq.331.1589189824311;
        Mon, 11 May 2020 02:37:04 -0700 (PDT)
Received: from localhost.localdomain ([194.230.155.159])
        by smtp.gmail.com with ESMTPSA id r14sm1636537wmb.2.2020.05.11.02.37.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2020 02:37:03 -0700 (PDT)
Subject: Re: [PATCH v2 0/5] Statsfs: a new ram-based file sytem for Linux
 kernel statistics
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Adams <jwadams@google.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mips@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        David Rientjes <rientjes@google.com>
References: <20200504110344.17560-1-eesposit@redhat.com>
 <CA+VK+GN=iDhDV2ZDJbBsxrjZ3Qoyotk_L0DvsbwDVvqrpFZ8fQ@mail.gmail.com>
 <29982969-92f6-b6d0-aeae-22edb401e3ac@redhat.com>
From:   Emanuele Giuseppe Esposito <eesposit@redhat.com>
Message-ID: <20c45f7b-3daa-c300-a8e7-0fd26664080b@redhat.com>
Date:   Mon, 11 May 2020 11:37:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <29982969-92f6-b6d0-aeae-22edb401e3ac@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/8/20 11:44 AM, Paolo Bonzini wrote:
> So in general I'd say the sources/values model holds up.  We certainly
> want to:
> 
> - switch immediately to callbacks instead of the type constants (so that
> core statsfs code only does signed/unsigned)
> 
> - add a field to distinguish cumulative and floating properties (and use
> it to determine the default file mode)
> 
> - add a new argument to statsfs_create_source and statsfs_create_values
> that makes it not create directories and files respectively
> 
> - add a new API to look for a statsfs_value recursively in all the
> subordinate sources, and pass the source/value pair to a callback
> function; and reimplement recursive aggregation and clear in terms of
> this function.

Ok I will apply this, thank you for all the suggestions. 
I will post the v3 patchset in the next few weeks. 

In the meanwhile, I wrote the documentation you asked (even though it's 
going to change in v3), you can find it here:

https://github.com/esposem/linux/commit/dfa92f270f1aed73d5f3b7f12640b2a1635c711f

Thank you,
Emanuele

