Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB008C33CB3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 18:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 959A32187F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 18:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e3fFBVzO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729256AbgAOSU2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 13:20:28 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52507 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729016AbgAOSU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 13:20:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579112426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=17zGvszpS2X4BFkl2CiCggkEpVm2B9z6sEshLBKqEMs=;
        b=e3fFBVzOGQ2wSbLrL/7aqB7uE6xZP2JesqEilcrcdvH6kHNchFe79DSCK8K0I3GkMHXFR+
        J9danh0Wr7Uumhy9U6LJ7+XG4EXy2unX1O/kseicAdfRZ0vDFLUkIoae+fWTp850Sn6rRp
        1HrgeeZwRADkpFPn2BIBRiqh+HkrX1s=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-OItrfQ9xOhixuAew4QYfbA-1; Wed, 15 Jan 2020 13:20:25 -0500
X-MC-Unique: OItrfQ9xOhixuAew4QYfbA-1
Received: by mail-wr1-f69.google.com with SMTP id v17so8256786wrm.17
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 10:20:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=17zGvszpS2X4BFkl2CiCggkEpVm2B9z6sEshLBKqEMs=;
        b=fd8RZh1UnDrnaGAFmqkkiqKvxTLjCkKk+xZv2kKyAY0oID1OQ4cHwJIUehWMm2fur4
         WCXoR46ZC92gb6hxt9eCo22RaTV7QHjWwqialx29a7Jx7//9X4gj35APW2EM5nUkQdpS
         vXHvyVX2MBFFbRyOMqdMeMAC7Cj8PChpb5fiFia2WClkcWUgvkINerG2RLpwTCwq2tw8
         EYq+5ZGxr7jKAuOC2ZTekph+kRcuQx0F1fxRnkGHzO26KUi6JZEHgSaFgNm+8Twsq0KI
         IPxzeDnZTWVW4dWYggcmAxaYNpnucg6DYoNNxywtdU+NhsaHroOdfEutq16xMJa2JqFe
         3T1w==
X-Gm-Message-State: APjAAAUsihaRPQNdY63/Zw01ikKsojJATvOzMoXkQpIr8mGvS4xDYp9Q
        jT1uc+HSbsFmUHQgZxfymnWt//M5nQAx4yJ0JkW0cvcEJO+Iuwt1lVdsnkKY/8PzjAtxl7sddc8
        yYsGrVJRvHG3Hf2Io6ExgAsir
X-Received: by 2002:adf:eb46:: with SMTP id u6mr33317278wrn.239.1579112423904;
        Wed, 15 Jan 2020 10:20:23 -0800 (PST)
X-Google-Smtp-Source: APXvYqw/Qyejk/Pe57hiihIWH7LtW6xhsVMRE5PFvyRvUxM72lwLh4/4yWAz6JdsH05250/GZ594wQ==
X-Received: by 2002:adf:eb46:: with SMTP id u6mr33317258wrn.239.1579112423623;
        Wed, 15 Jan 2020 10:20:23 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:436:e17d:1fd9:d92a? ([2001:b07:6468:f312:436:e17d:1fd9:d92a])
        by smtp.gmail.com with ESMTPSA id e6sm26800599wru.44.2020.01.15.10.20.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2020 10:20:22 -0800 (PST)
Subject: Re: [PATCH] KVM: x86/mmu: Fix a benign Bitwise vs. Logical OR mixup
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Arvind Sankar <nivedita@alum.mit.edu>
Cc:     David Laight <David.Laight@ACULAB.COM>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20200108001859.25254-1-sean.j.christopherson@intel.com>
 <c716f793e22e4885a3dee3c91f93e517@AcuMS.aculab.com>
 <20200109152629.GA25610@rani.riverdale.lan>
 <20200109163624.GA15001@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <41a2328e-a64a-0131-920e-06328305919d@redhat.com>
Date:   Wed, 15 Jan 2020 19:20:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200109163624.GA15001@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/01/20 17:36, Sean Christopherson wrote:
>>> You also don't want to convert the expression result to zero.
>> The function is static inline bool, so it's almost certainly a mistake
>> originally. The != 0 is superfluous, but this will get inlined anyway.
> Ya, the bitwise-OR was added in commit 25d92081ae2f ("nEPT: Add nEPT
> violation/misconfigration support"), and AFAICT it's unintentional.

It may not be intentional in this case, but it's certainly the kind of
code that I would have fun writing. :)

Paolo

