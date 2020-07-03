Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A74A6C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 15:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80BA720884
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 15:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F2LHPoy/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgGCPqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 11:46:38 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29134 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726035AbgGCPqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 11:46:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593791195;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kZamksu9q4RTlXzhEF7oeFMOgoJ1Qb6qWkOIgdiQa7I=;
        b=F2LHPoy/ikCLvo0s1d72nWd28RN64dszEs7ihUpMT/FcwiSvjN3iGuwsoIq0MHsTmYJavi
        wQrl0nyPHGQaEAFAfg0Ok3LTsZ4V66QXRWa1VOkhn1fiS9Oyt7/h/AKrDBLoC87U3TYVH7
        F14PHyOj8vJSfWZAnEdX3uTXlCNg5W4=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-qyKEGxILOF26Ily46xh4yQ-1; Fri, 03 Jul 2020 11:46:34 -0400
X-MC-Unique: qyKEGxILOF26Ily46xh4yQ-1
Received: by mail-qv1-f69.google.com with SMTP id r19so20686082qvz.7
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 08:46:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=kZamksu9q4RTlXzhEF7oeFMOgoJ1Qb6qWkOIgdiQa7I=;
        b=ZENqXioCIEkm27aeRWgRL+epKFkqG/f6Tg1l/weme7hqT+6nguV1XE/dS2d/mhr0xL
         FcuehKw5bGmcseSUXhvJv4UNOD53lXfsG63M38eZAe+qqVzlzRhxDXToSKrGG1s/dSgM
         UObOAQiqskWUdGrKpa0n0lYHef3Ie1NENHuFOZcRsO5vzPa7Ho67QRqWyqfkcCC76Xb4
         HhYroL4skeWTVpLUjAAEcLpioKscgCbkNYCuZlh8nkFvMNet5A6Ti+9EymvMUs1P2YVd
         pU/QLcBg3G+6tzoSmnxalUHoj3DiYg6Z5UYBNvJlbw86Rm4OPNpb174mr3uCXE8Jd8Q6
         ycow==
X-Gm-Message-State: AOAM532nfr14GJQT9WHujJkbHYthHdT9PcxzUglNwqyvgHGBMuNiF6oe
        4CsndrQy8oTcZm3yGYghkpo8K6VwQKz2zZehufjDxYzUqL3Mg91EBINJgYQCsrXK/siCwrCOu/J
        xB9ar8iiKwct5QhkS250F87GF
X-Received: by 2002:a05:6214:884:: with SMTP id cz4mr21705039qvb.3.1593791193268;
        Fri, 03 Jul 2020 08:46:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwPFteIG/zDmV9OhkFZB+1yp9sGcAuhAQc+YY9Q88SZ8CcE37BbpMKtTkvgBPVirzToeV7QFw==
X-Received: by 2002:a05:6214:884:: with SMTP id cz4mr21705023qvb.3.1593791193050;
        Fri, 03 Jul 2020 08:46:33 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id k45sm13334427qtc.62.2020.07.03.08.46.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2020 08:46:32 -0700 (PDT)
Subject: Re: [PATCH] mm: initialize return of vm_insert_pages
To:     Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20200703145202.10629-1-trix@redhat.com>
 <20200703145454.GH25523@casper.infradead.org>
From:   Tom Rix <trix@redhat.com>
Message-ID: <7b6eb14b-bbdc-dedb-c989-5e705cb9a453@redhat.com>
Date:   Fri, 3 Jul 2020 08:46:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200703145454.GH25523@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/3/20 7:54 AM, Matthew Wilcox wrote:
> On Fri, Jul 03, 2020 at 07:52:02AM -0700, trix@redhat.com wrote:
>> From: Tom Rix <trix@redhat.com>
>>
>> clang static analysis reports a garbage return
>>
>> In file included from mm/memory.c:84:
>> mm/memory.c:1612:2: warning: Undefined or garbage value returned to caller [core.uninitialized.UndefReturn]
>>         return err;
>>         ^~~~~~~~~~
>>
>> The setting of err depends on a loop executing.
>> So initialize err.
> I'd argue that returning zero is wrong.  If someone's asked to insert
> zero pages, that's a nonsense thing to do so it should return -EINVAL..
>
good point, i'll respin.


