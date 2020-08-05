Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57914C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 18:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 184B922D2B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 18:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DC2dgjyq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbgHES65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 14:58:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55480 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728378AbgHES4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 14:56:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596653782;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hymn0Sfg1TJ19WBAjozBxwIK1aOHio4HHWImCGmRqUw=;
        b=DC2dgjyqrHtI8yFjA1OOHZqoBAQUWEujxddK7inq8eNMBc9DrNu83kJLUEJNbuv8NKCkjv
        pAwRCtMqviyD/dLW4kPzCsufXVOdwjH+2kgnmjOgsk1bHYSr+yxTT5V/U0KgBgC3wEibSJ
        zAjxh1rr9fN0zd85XBGt9fjrd5HgwaY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-dlubURh1Nr6aUsMiQHK_MA-1; Wed, 05 Aug 2020 14:48:06 -0400
X-MC-Unique: dlubURh1Nr6aUsMiQHK_MA-1
Received: by mail-wr1-f71.google.com with SMTP id r14so1787236wrq.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 11:48:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hymn0Sfg1TJ19WBAjozBxwIK1aOHio4HHWImCGmRqUw=;
        b=cE8LxQbZS5aa50+5s0adJsIGZb+L4QT2s/jfrR1/3gcAuWJNlLThITwrsF/hsPt604
         fvFet7DBrHp8m1S7v539qB3enn1jC3D607cTladWWSrhCuA9unzsTLthU5w0MU0ZlMUp
         IqoAQTO3zJAhvsPCBRRJcVaTQ5Ltht1cpSXZnuLKGV2Oj91KpLLyhxALdrKrTCOhrXQ/
         ELiHQrzDpEejtF+nR7pZaXiiyC8gHoNCt1Xh30bi7VzPayifzZ+v9FQJBYmMbRVsebia
         9RxPVhY25dD6URX6YY4SkuDFojVSloQEFcL+VaM6MdpcNkvnBOToHEM9A/C1zSEGnPAc
         plGw==
X-Gm-Message-State: AOAM5329VNpedX0sbeaUwsWI+RDbWPnUGDIh2xNCMNezw1H0lHZ4+vIM
        hDV+ncEQLaUFU0haAw8EJHepQzTBmuNUczWC+4QGL6/w5M7cwuAtJ2PjlB52o3mNPaPVeOD29+4
        cazCL864/QgmY/dow9rUkYtEM
X-Received: by 2002:a1c:286:: with SMTP id 128mr4206655wmc.37.1596653284954;
        Wed, 05 Aug 2020 11:48:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxMFtqWVfa9ps/xQ0YYj/MHXx500Q/j+ugxOTprbSKK6roqR5QcQxjQa6u8ZT4SfEKfWTMCUg==
X-Received: by 2002:a1c:286:: with SMTP id 128mr4206635wmc.37.1596653284682;
        Wed, 05 Aug 2020 11:48:04 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7841:78cc:18c6:1e20? ([2001:b07:6468:f312:7841:78cc:18c6:1e20])
        by smtp.gmail.com with ESMTPSA id l18sm3776157wrm.52.2020.08.05.11.48.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2020 11:48:03 -0700 (PDT)
Subject: Re: [PATCH 1/1] kvm: mmu: zap pages when zapping only parent
To:     Ben Gardon <bgardon@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Peter Xu <peterx@redhat.com>,
        Peter Shier <pshier@google.com>
References: <20200727203324.2614917-1-bgardon@google.com>
 <20200804211444.GA31916@linux.intel.com>
 <CANgfPd9kbnzW+eaBi+dwA1+E2VXEd6JfN4n2PstWrmh4VPRFjA@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cf54ab19-611c-c975-8080-b49e13c966f3@redhat.com>
Date:   Wed, 5 Aug 2020 20:48:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CANgfPd9kbnzW+eaBi+dwA1+E2VXEd6JfN4n2PstWrmh4VPRFjA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/08/20 19:10, Ben Gardon wrote:
>>
>> Alternatively, what about moving this logic into mmu_page_zap_pte()?  That
>> can be done with a little massaging of FNAME(invlpg) and would avoid what is
>> effectively redundant checks on is_shadow_present_pte() and is_last_spte().
>> Patches attached and somewhat tested.
> That seems like a good change to me and the patches you attached look
> good to me. I'm happy to review them more if you want to send them to
> the mailing list as their own series. Thanks for putting them
> together.
> 

Thanks, I'll wait for that.

Paolo

