Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF55C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 08:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B4CD2070A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 08:24:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KiS63N3C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbgEUIY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 04:24:28 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:29559 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728374AbgEUIY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 04:24:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590049467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UgPlPKwQ78SmEvwlM+tSnD4eOCAOdkr7Ntl2fCb3Qdo=;
        b=KiS63N3Cn7Czi5DVNZGyjNaxec7dLbyPv4piB4gVvc776I0UdY/hFDUKDkwLBrApkfuT/U
        3FB8opFdS3gpc9WHzuLuJqx+ltoawgPsWDMFqvEQc0uWHdRK70kjlzGu8njB9Rfu59nSYt
        ggQAeYpz9afFTmSC+O3b2rdqJjCxkzo=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-HFw0fZHhMRSxz11tr1JoSA-1; Thu, 21 May 2020 04:24:25 -0400
X-MC-Unique: HFw0fZHhMRSxz11tr1JoSA-1
Received: by mail-ed1-f70.google.com with SMTP id a18so2509819eds.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 01:24:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UgPlPKwQ78SmEvwlM+tSnD4eOCAOdkr7Ntl2fCb3Qdo=;
        b=rBAvkKt+RFxH8/MxsuJUZf8Rm4mO5XkzTOOVfeCng32vC5SxKI+LUw7DK/Yw6VJBMc
         SmyxjLFmgwoAFTD7ztBRcQaBgtKRc5S3Vkwce2B/6Tx1D3+xhbqYqRCwPKZjHqmqoU9q
         vSV1eJRzKy7+fOPHvVfWpty0DyTEXcx5DHRgyfAiPHcRxfJrah1Ssg/bAi5RElRE2CID
         O+doqONUFYuv+aZ3qGI0zs8owX1jou65ahbs9TqwgkCrCT6P1s9vySHF1IwWVSB+yCzY
         Kt8qRvbWuKrRE8/Fc5ybKz5vjAkQJjd1O7WfA1b3Fl3uzx8w5au+su82MXKYJYj8QnC9
         TtQQ==
X-Gm-Message-State: AOAM530FeFDuTQwmRQNQ2reC8OxcdkJ5jhehsNXxYVTEHRlGmXcgnS03
        bYaXgHLE+QVixBnyVOQQiFaeifyoVaF5o358eGRfRVn5jVAbqpOU5TjOdyAEhBkCyigzjGZXvWh
        9JG1JY0H9GGlzIjqXXbNL3OQw
X-Received: by 2002:a17:907:9d5:: with SMTP id bx21mr2366556ejc.510.1590049464362;
        Thu, 21 May 2020 01:24:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyoFKBT/y+lQ+LBEKa1W8bfwlzO4IvlNszMAjhIGGbGZEJr2l2PRpnaSFM+8x03wohqDEKpng==
X-Received: by 2002:a17:907:9d5:: with SMTP id bx21mr2366545ejc.510.1590049464136;
        Thu, 21 May 2020 01:24:24 -0700 (PDT)
Received: from [192.168.178.58] ([151.30.94.134])
        by smtp.gmail.com with ESMTPSA id s20sm4204784eju.96.2020.05.21.01.24.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2020 01:24:23 -0700 (PDT)
Subject: Re: [PATCH 2/2] kvm/x86: don't expose MSR_IA32_UMWAIT_CONTROL
 unconditionally
To:     Xiaoyao Li <xiaoyao.li@intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org,
        Tao Xu <tao3.xu@intel.com>
Cc:     linux-kernel@vger.kernel.org
References: <20200520160740.6144-1-mlevitsk@redhat.com>
 <20200520160740.6144-3-mlevitsk@redhat.com>
 <b8ca9ea1-2958-3ab4-2e86-2edbee1ca9d9@redhat.com>
 <81228a0e-7797-4f34-3d6d-5b0550c10a8f@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <13f16f34-ce01-4207-1d1d-775b15a1e0f7@redhat.com>
Date:   Thu, 21 May 2020 10:24:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <81228a0e-7797-4f34-3d6d-5b0550c10a8f@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/05/20 06:33, Xiaoyao Li wrote:
> I remember there is certainly some reason why we don't expose WAITPKG to
> guest by default.

That's a userspace policy decision.  KVM_GET_SUPPORTED_CPUID should
still tell userspace that it's supported.

Paolo

> Tao, please help clarify it.

