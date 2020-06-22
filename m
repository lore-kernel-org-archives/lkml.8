Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3022BC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 13:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08DAB20706
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 13:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OWC2KKWl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbgFVN5R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 09:57:17 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:36002 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728070AbgFVN5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 09:57:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592834235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7Dbcv+orP1bMR1kWsR7V/IGamiGGqbmfinxnIa4z8Z8=;
        b=OWC2KKWlLvU44SM1CP6L7YSgYRb35aMV+0o0Srv1R3nIoouex/xrMR/3SRIE5BXQXSLeGB
        Q2la6CjXBGV4/gfMW6dohPzpz0QdZw5sVFAIcTBx56Wj+d56fTkdHJGerXnhcPgc8JUCsd
        ZrSn3nw2mByz9DwE0OmDg1TsdfNQbjc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-2cpSOS5EMYC6zwA_LmfFbw-1; Mon, 22 Jun 2020 09:57:13 -0400
X-MC-Unique: 2cpSOS5EMYC6zwA_LmfFbw-1
Received: by mail-wr1-f72.google.com with SMTP id p10so10888710wrn.19
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 06:57:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7Dbcv+orP1bMR1kWsR7V/IGamiGGqbmfinxnIa4z8Z8=;
        b=Ydv1VEqSu679H1NUWmeIRTGyyQhDHFX1Y0+XOArIBwCmthd3ek9t+RserP9ev3aT2t
         GhNdbUrnm1flY80pKEYOpbB79SKbdkoLrw+i4cXaSfSnoj5wv4UycD8dY8g/BlVZDenl
         Hwdlz6iUmDlf2ZOe+Qi5am7UYZbs4etgq46ens0DZO4neFt5ufWDeDKT4JhDwT4P8vv8
         qj05SbhZxZaGwumHeQAmJBD4htrGkSVuzKxR0SBY75U0TW+h/C7XsfZGAAIq/VH4tVLz
         if3fPYfAItpyv6ahpx03vbNlTpNLU5NBnrxHlln5WZilZoirfgMz9VtFSLa/PzA+7BYx
         PMdA==
X-Gm-Message-State: AOAM531Ns46KYp/EchgqWw/FawejPegvV+PTT9eWjmEqcT6A9OWwSBGj
        70hj1sXYRZhuco5oavl9xANaaFrD5VreAZr/3Q32xs0MobQhf9SIHNPZ+jO5d5OgMb1bO/V74lM
        Svp68scWnzGxEQ73RLkrHLc7/
X-Received: by 2002:a5d:404e:: with SMTP id w14mr16864019wrp.268.1592834232343;
        Mon, 22 Jun 2020 06:57:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzuiM5HVFFPZD2gO2bgU4gQGbG7Bmz3Bvz9UhRdqeO2XWn6d0+3uQ8RW9PJMUn0dHE7+zS8lQ==
X-Received: by 2002:a5d:404e:: with SMTP id w14mr16863993wrp.268.1592834232066;
        Mon, 22 Jun 2020 06:57:12 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:fd64:dd90:5ad5:d2e1? ([2001:b07:6468:f312:fd64:dd90:5ad5:d2e1])
        by smtp.gmail.com with ESMTPSA id e5sm18457392wrw.19.2020.06.22.06.57.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2020 06:57:11 -0700 (PDT)
Subject: Re: [PATCH v2 06/11] KVM: VMX: introduce vmx_need_pf_intercept
To:     Jim Mattson <jmattson@google.com>,
        Mohammed Gamal <mgamal@redhat.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Moger, Babu" <babu.moger@amd.com>
References: <20200619153925.79106-1-mgamal@redhat.com>
 <20200619153925.79106-7-mgamal@redhat.com>
 <CALMp9eQYRoB5vmxL0U7Mn0rWqotxLpUAJD15YX0DDYop1ZmuEg@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f0078376-dbd6-dc0a-6a7f-a05ebaadba11@redhat.com>
Date:   Mon, 22 Jun 2020 15:57:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CALMp9eQYRoB5vmxL0U7Mn0rWqotxLpUAJD15YX0DDYop1ZmuEg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/06/20 00:45, Jim Mattson wrote:
>> +               /*
>> +                * TODO: if both L0 and L1 need the same MASK and MATCH,
>> +                * go ahead and use it?
>> +                */
> I'm not sure there's much "TODO", since L0's MASK and MATCH are both
> 0. So, if L1's MASK and MATCH are also both 0, we would go ahead and
> use 0's, which it seems we already do here:

True, the comment should be moved to patch 8.

Paolo

>> +               vmcs_write32(PAGE_FAULT_ERROR_CODE_MASK, 0);
>> +               vmcs_write32(PAGE_FAULT_ERROR_CODE_MATCH, 0);

