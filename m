Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A62C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 12:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9B1D2073A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 12:17:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="csT5DPkB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729409AbgAUMRU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 07:17:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56308 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727817AbgAUMRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 07:17:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579609038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C9ocdms8YQdaluyA27aUHa1CM8I9Y3XHULzORwIWhX4=;
        b=csT5DPkBfQOI1vRiQGYCf4hqOVec/OxEQKsuDD7Siz/QwMvlNY7Z5yXixfE87diev+DiZ7
        hf+VdN+zPQFTTHBs+20sIBeQzer45Fcl9yeY24BJlVq1vl2wIlbU0K8z1i+HwvbFxvLT+w
        fTHKaA9OGZSPZ/9Z/fPBp/mdMAqev+I=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-DQ3FHtEWM0WJypjFkDOA2A-1; Tue, 21 Jan 2020 07:17:17 -0500
X-MC-Unique: DQ3FHtEWM0WJypjFkDOA2A-1
Received: by mail-wr1-f69.google.com with SMTP id c17so1227944wrp.10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 04:17:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C9ocdms8YQdaluyA27aUHa1CM8I9Y3XHULzORwIWhX4=;
        b=m/otsfqe5cXA8rV8ah2o/IfT+P0djoy9+AT2GL4SE8JMqwlcYgM6uFDCOfRCGXKRX+
         ebOAo3Vab3C9SBbts8hiWDikX7nZg6ScVbO7LK2ab7WXIrcJ/rr3N35b4Axhygy1kOWi
         EiHDVoFWL2vaUFqSt6UhUrIp9ivCX+YTsfci2IGyKVNkt1WtFRt+8h93G5uen26i/1R+
         NWcsnph7+KrXKN0/HIOp9qxgi8ow5MJdCDDfpRaSybvkyZWwsoD+1VhJ8gA39TRQ7+m5
         zBnp3YY3Pw+Qflt7KuIyio55pqdSBd6xAbl3W0GJLTUC/9XXI0yxQV2eOXjh1BymJLy5
         JMBw==
X-Gm-Message-State: APjAAAVDbRouqOj7sPhsCSEn39gVEQhhBDesNjB+26T1KMxp7nVQz2mR
        kcsPky78KoROVqdY3PG9jhHeJoT+IOxCkIORaW8Pwddkmi98tsj4BIG6wG8lWck14wkUiKBbJ0P
        GFqNz0mdhVutsE7gcI6dDCVrv
X-Received: by 2002:a05:600c:210e:: with SMTP id u14mr4006436wml.28.1579609035979;
        Tue, 21 Jan 2020 04:17:15 -0800 (PST)
X-Google-Smtp-Source: APXvYqyjBmRSqaH7Hafu7I3Qvl9yQQESxj6q6oJyTXTzXfCwxSIMyeZy0TLITSzLFAXsYe6bR+nUbQ==
X-Received: by 2002:a05:600c:210e:: with SMTP id u14mr4006409wml.28.1579609035662;
        Tue, 21 Jan 2020 04:17:15 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:b509:fc01:ee8a:ca8a? ([2001:b07:6468:f312:b509:fc01:ee8a:ca8a])
        by smtp.gmail.com with ESMTPSA id j12sm53192472wrt.55.2020.01.21.04.17.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2020 04:17:15 -0800 (PST)
Subject: Re: [PATCH] selftests: KVM: AMD Nested SVM test infrastructure
To:     Auger Eric <eric.auger@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     thuth@redhat.com, drjones@redhat.com, eric.auger.pro@gmail.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20200117173753.21434-1-eric.auger@redhat.com>
 <87pnfeflgb.fsf@vitty.brq.redhat.com>
 <a288001b-56a6-363b-18c0-18a1e1876ccc@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f156e2e0-6c75-30c2-c295-b87ee1b36600@redhat.com>
Date:   Tue, 21 Jan 2020 13:17:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <a288001b-56a6-363b-18c0-18a1e1876ccc@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/01/20 12:12, Auger Eric wrote:
>>> +
>>> +static struct test tests[] = {
>>> +	/* name, supported, custom setup, l2 code, exit code, custom check, finished */
>>> +	{"vmmcall", NULL, NULL, l2_vmcall, SVM_EXIT_VMMCALL},
>>> +	{"vmrun", NULL, NULL, l2_vmrun, SVM_EXIT_VMRUN},
>>> +	{"CR3 read intercept", NULL, prepare_cr3_intercept, l2_cr3_read, SVM_EXIT_READ_CR3},
>>> +};
>> selftests are usualy not that well structured :-) E.g. we don't have
>> sub-tests and a way to specify which one to run so there is a single
>> flow when everything is being executed. I'd suggest to keep things as
>> simple as possibe (especially in the basic 'svm' test).
> In this case the differences between the tests is very tiny. One line on
> L2 and one line on L1 to check the exit status. I wondered whether it
> deserves to have separate test files for that. I did not intend to run
> the subtests separately nor to add many more subtests but rather saw all
> of them as a single basic test. More complex tests would be definitively
> separate.

I would just leave this deeper kind of test to kvm-unit-tests and keep
selftests for API tests.  So this would mean basically only keep (and
inline) the vmmcall test.

Paolo

