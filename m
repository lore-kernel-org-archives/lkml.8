Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3857C55192
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 13:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFC5320724
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 13:43:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gZpp/2JU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbgDWNnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 09:43:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37028 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728158AbgDWNnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 09:43:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587649398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KkSCE0JzSlg9odwhbBRC3mYNWh8RC/9N7mx5EiFBY6g=;
        b=gZpp/2JUWi5QUn/vHMBSeBIrQ320dgrcdJmWw+M8T0x+PsAEnzQ9yEW84e25ym71HjxlIO
        Z7dsBL5Zh5xI9sKFzybIdoF00PsfK1dNmveRQIU7fH/jqfiWmOEBsa+7s5jQEy61CRpDV2
        xeB8iyPU4RExXkmkEiSIDdQoEdorp8E=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-505-HPflkxVsMgydodlFIR7WGg-1; Thu, 23 Apr 2020 09:43:14 -0400
X-MC-Unique: HPflkxVsMgydodlFIR7WGg-1
Received: by mail-wr1-f70.google.com with SMTP id f4so1419934wrp.14
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 06:43:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KkSCE0JzSlg9odwhbBRC3mYNWh8RC/9N7mx5EiFBY6g=;
        b=ALsBbMV+tmCwwGUsdG4xkU1CdLdmPN/pSoy9LRrJtv1FlEa1LUCB5rJjCsg7wraY97
         sUc4jr07LLub/zQinOPoDbDu7CPxO3WPMckcgHGlIf7D2tlwjtGU+6Z7wtDPk6lPhYgh
         UJHntn2/bnLaWk12YNXOIP+CxVQOrcfhTp36R4JyutSw+ATYvPueZYE/ud7NOLKc2Sa0
         BDYSCLWewKWpjscNBlznJwPqnYBMlrs56QApuiIMimhx40ADTwzNQifKT9AtthJcfo+N
         Tj1oeluRPgl4kQ8pKRQ1dJQSBO2OTLxjiqB7sAePqFL5pEh2WQJ0s+iK5tjUI14M1Yxe
         FDLQ==
X-Gm-Message-State: AGi0PuZ4m9H/racU7fraUiFa4tboNNM04TeX31ZlZGadgoS9IYvEwbJs
        5x5IuAWTIKOnZ3M5xWPMDIQ74hC3LNywPNPseK/FRlsu02jQWFvRhdn/fUBg+T4uOn2FxxYDKL/
        PqGtmAkYHv6mwjWnF8fQQldge
X-Received: by 2002:a5d:6607:: with SMTP id n7mr5326239wru.150.1587649393478;
        Thu, 23 Apr 2020 06:43:13 -0700 (PDT)
X-Google-Smtp-Source: APiQypJa1WY71QlS4JoH4ExfIQ/Mcb3+xBPD0CWFeuWO/5cLjqXMXckSK/nstqWU4jJUxZY0ARTRPA==
X-Received: by 2002:a5d:6607:: with SMTP id n7mr5326219wru.150.1587649393280;
        Thu, 23 Apr 2020 06:43:13 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
        by smtp.gmail.com with ESMTPSA id o7sm3582902wmh.46.2020.04.23.06.43.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2020 06:43:12 -0700 (PDT)
Subject: Re: [PATCH 0/2] KVM: SVM: Implement check_nested_events for NMI
To:     Cathy Avery <cavery@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     vkuznets@redhat.com, wei.huang2@amd.com
References: <20200414201107.22952-1-cavery@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8c3f87de-525a-63d5-0134-606250d8c945@redhat.com>
Date:   Thu, 23 Apr 2020 15:43:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200414201107.22952-1-cavery@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/20 22:11, Cathy Avery wrote:
> Moved nested NMI exit to new check_nested_events.
> The second patch fixes the NMI pending race condition that now occurs.
> 
> Cathy Avery (2):
>   KVM: SVM: Implement check_nested_events for NMI
>   KVM: x86: check_nested_events if there is an injectable NMI
> 
>  arch/x86/kvm/svm/nested.c | 21 +++++++++++++++++++++
>  arch/x86/kvm/svm/svm.c    |  2 +-
>  arch/x86/kvm/svm/svm.h    | 15 ---------------
>  arch/x86/kvm/x86.c        | 15 +++++++++++----
>  4 files changed, 33 insertions(+), 20 deletions(-)
> 

Thanks, I've integrated this in Sean's event reinjection series and will
post soon my own take on both.

Paolo

