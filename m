Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A40A6C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 11:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 764C420675
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 11:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aqikuFHN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbgBLLpD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 06:45:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45294 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727987AbgBLLpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 06:45:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581507902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z/XW9HBv8g40NKs9Q4i4eHubCeo+923+Sg7WFrBrwCY=;
        b=aqikuFHNwD8PKxYAMCsEaQuKjBe39140DP7FR2OquRttFB1VR7pBMfM5ZJ1brKf+fAFMxL
        2eQlnOBuOMZwpRRBzHZ18QfhH9GzevudUoKKh5AgGpcgui5+NWDrNVk14JsslLXuy2Kjln
        CfDnN4gPLNsmr4uganRxhOovEUdAITM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-C2oxTt35MAWslsOHFG-b2g-1; Wed, 12 Feb 2020 06:45:00 -0500
X-MC-Unique: C2oxTt35MAWslsOHFG-b2g-1
Received: by mail-wm1-f69.google.com with SMTP id g26so612698wmk.6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 03:45:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Z/XW9HBv8g40NKs9Q4i4eHubCeo+923+Sg7WFrBrwCY=;
        b=YnUCtaPptq+UwbXzS+QphJk36XoUXHIbtZ2Z6vkBQFEql/zKYEtvIZN06PbB+ibjo3
         jGzDA4qRAqCH97j1nFzjHuQo8GRnj4LyDF2kZtgK8DhjJ5+iegjzpSBiOAcLWWkiEdNk
         OZwb4tUak7ZImbpH/r6dgeELjakxSHD5qTaRSZ8AUpfud1hnEk0AmgZSaso5jF/7LcBG
         9GIUfy46vDlae91sTmDM2kit/GJSblzNvBu2j0LdpXMv9CZ9pqZZAz/27yEXa76GXItk
         jdu/vxxaD8CaUeN+0za3wioIAOTNlryz5meZu8ygUM5fjJeib73lMvkDdJHswXff2axG
         FzjQ==
X-Gm-Message-State: APjAAAUXOXlf6d26Cin6pq9fEkxBMEwU+M3/Q+Nsze7rDo3N+FUTEwjh
        Rv2sCotXy7/mb/5bmbx6sTgzl0QWiMZOUMYCg0O3bPcFCp0Jt+XlIw9YjNd5AacfzUymkTSHD2A
        Z6m1mLfwkEV/jMO0RptuyCJZc
X-Received: by 2002:a1c:2786:: with SMTP id n128mr12005156wmn.47.1581507899078;
        Wed, 12 Feb 2020 03:44:59 -0800 (PST)
X-Google-Smtp-Source: APXvYqwNLEvraETcWc9irlpjFpNKiOUzmnEDzoDdQ3QMWGLuFUihhVD3y/6Sc35cwcZEI+Ez97BY6w==
X-Received: by 2002:a1c:2786:: with SMTP id n128mr12005134wmn.47.1581507898813;
        Wed, 12 Feb 2020 03:44:58 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:652c:29a6:517b:66d9? ([2001:b07:6468:f312:652c:29a6:517b:66d9])
        by smtp.gmail.com with ESMTPSA id l132sm451131wmf.16.2020.02.12.03.44.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2020 03:44:58 -0800 (PST)
Subject: Re: [PATCH v4 3/3] selftests: KVM: SVM: Add vmcall test
To:     Krish Sadhukhan <krish.sadhukhan@oracle.com>,
        Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        vkuznets@redhat.com
Cc:     thuth@redhat.com, drjones@redhat.com, wei.huang2@amd.com
References: <20200206104710.16077-1-eric.auger@redhat.com>
 <20200206104710.16077-4-eric.auger@redhat.com>
 <2469b52e-9f66-b19b-7269-297dbbd0ca27@oracle.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a30f5513-d80b-a4e9-0279-995bf5c6417a@redhat.com>
Date:   Wed, 12 Feb 2020 12:45:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <2469b52e-9f66-b19b-7269-297dbbd0ca27@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/02/20 23:46, Krish Sadhukhan wrote:
>>
>> +
>> +static inline void l2_vmcall(struct svm_test_data *svm)
>> +{
>> +    __asm__ __volatile__("vmcall");
> Is it possible to re-use the existing vmcall() function ?

Technically the AMD opcode is "vmmcall".  Using vmcall() still makes
sense as it tests KVM's emulation of the Intel opcode.

> Also, we should probably re-name the function to 'l2_guest_code' which
> is used in the existing code and also it matches with 'l1_guest_code'
> naming.

Ok.  I also removed the "inline" which is really not used since we take
the address of the function.

Paolo

