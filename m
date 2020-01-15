Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39277C32771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 18:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DC33214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 18:33:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QJ4OWQ2L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbgAOSdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 13:33:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29485 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729037AbgAOSdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 13:33:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579113233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=va5ZZWbJX4SIzlOtIXmCKn6cD0Cw7eHyuV0gMLwZJ6Y=;
        b=QJ4OWQ2L/O8Y01kVtY7+VUP9UB86TUNlqpX/BgofzPtboIf8UCOYmx9cnqLZgVuukclZkB
        vHVVSSVYJO16vHFePrIasWcLESuzqXf22NOhFxT7/ugfULiQ2hyUIJ6lIWY896aBHmF7t6
        zttaP5F8glf8p62DEKwljHOb1gi+VEs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-OEUrftdnMPqyLrFi_g95wQ-1; Wed, 15 Jan 2020 13:33:52 -0500
X-MC-Unique: OEUrftdnMPqyLrFi_g95wQ-1
Received: by mail-wr1-f69.google.com with SMTP id z10so8242454wrt.21
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 10:33:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=va5ZZWbJX4SIzlOtIXmCKn6cD0Cw7eHyuV0gMLwZJ6Y=;
        b=JOJPU16dpbjVm3/LzcpzXGPBfd+WaK7SD6hwmpd9K47rwo2TV1H9IRJgIaYmfrCz4e
         jJQfQ0jxbZp1/h3DzyTVCrB4MYS+In2DDuaXPz/BoQK/lOc1aVPS345xVY4/E1/cd8Wg
         RaFuCgaRk1DBYwLdHchxPLDcZx2a8uTBwMItOQYDd2DNO8Y7G4vV6lXSFvTqBf4lYKfB
         1I7heLBQyNjGaV6v4gp0Y7a070EuoKKjgm0zsSLEIOcXiOi0aIX3nFEXjkdsObYUDyTU
         b3BouZNLDT7eJQdZdFy/NFKh6qxalsiuGmmLA4oYohLMvkT0QN+fkL+OfwcbZ7FxB4X0
         pHWw==
X-Gm-Message-State: APjAAAWX4XY8PeQTcLUqbpkrxPPbM+zidxmmjPTMfAVsDfhPeQLlqMW/
        uXmebUf4b9j4tBqlqHAQjZhXjf+29vIh+6KcWg0PfQYRNYHq0iENHg6+QCIiwYRX4W2NUai3k93
        e+bIDdeL22FJp/vbYt0kY4nB0
X-Received: by 2002:a05:600c:2503:: with SMTP id d3mr1330106wma.84.1579113231225;
        Wed, 15 Jan 2020 10:33:51 -0800 (PST)
X-Google-Smtp-Source: APXvYqztcB/kOoiO34HAkrYeLeRQT3xoOdqzZnz5pLsFhD3p5EtSAPbc8H6Dz1r3rQxrhzuHO0RdNQ==
X-Received: by 2002:a05:600c:2503:: with SMTP id d3mr1330076wma.84.1579113231023;
        Wed, 15 Jan 2020 10:33:51 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:436:e17d:1fd9:d92a? ([2001:b07:6468:f312:436:e17d:1fd9:d92a])
        by smtp.gmail.com with ESMTPSA id c17sm25545608wrr.87.2020.01.15.10.33.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2020 10:33:50 -0800 (PST)
Subject: Re: [PATCH v5 1/2] mm: make dev_pagemap_mapping_shift() externally
 visible
To:     Barret Rhoden <brho@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        linux-nvdimm@lists.01.org, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jason.zeng@intel.com
References: <20191212182238.46535-1-brho@google.com>
 <20191212182238.46535-2-brho@google.com>
 <20191213174702.GB31552@linux.intel.com>
 <e004e742-f755-c22c-57bb-acfe30971c7d@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <207bd03c-df82-f27b-bdb8-1aef33429dd7@redhat.com>
Date:   Wed, 15 Jan 2020 19:33:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <e004e742-f755-c22c-57bb-acfe30971c7d@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/12/19 18:59, Barret Rhoden wrote:
> Does KVM-x86 need its own names for the levels?  If not, I could convert
> the PT_PAGE_TABLE_* stuff to PG_LEVEL_* stuff.

Yes, please do.  For the 2M/4M case, it's only incorrect to use 2M here:

        if (PTTYPE == 32 && walker->level == PT_DIRECTORY_LEVEL && is_cpuid_PSE36())
                gfn += pse36_gfn_delta(pte);

And for that you can even use "> PG_LEVEL_4K" if you think it's nicer.

Paolo

