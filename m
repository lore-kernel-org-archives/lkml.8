Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E65C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 16:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DD57206C3
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 16:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V3x+dZb0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgFBQ0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 12:26:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35672 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726000AbgFBQ0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 12:26:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591115190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lxwhO1exzutRwzeUtw6dZLYIa64l9wkIQ9KC8Et54ug=;
        b=V3x+dZb0nvkSqUSMn5AK6OHzVsGJL/uo8W8RivFjcTDnABxqcnEtIDUX6Kp2EkDiz1N863
        A230+5Q/O+2vugK3PyQIiINIBhoyHUGXv3zjUXiGO0DcAkSEWEI8tGTdgWA22mJOXYVhb4
        b+PKYi23GlOZR+NDquAStLaVd86ZgLI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-a3-4U4VkMuKfpKXguHpZZQ-1; Tue, 02 Jun 2020 12:26:28 -0400
X-MC-Unique: a3-4U4VkMuKfpKXguHpZZQ-1
Received: by mail-wr1-f69.google.com with SMTP id s7so1577931wrm.16
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 09:26:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lxwhO1exzutRwzeUtw6dZLYIa64l9wkIQ9KC8Et54ug=;
        b=TT5AD2kSZXMl/kNXL/fn9sXz5jrUv/73HLvm1+2SLassQ2yIss5ukVbOQHPOwBz3a1
         Iep5rviwZX3Vv0U8bsSMEQRuaBdGnb8t6yyQ5EOXKfubYExBXrUWExZ6lntaPlq0D9er
         M/gLgTiAQrLUWCKHKWTp3uS/42YBahomd9hSt9VLTAH1HDoVPPEQ0D8LOwqhvw92YEzL
         WCdnHiudvJ2joIFoKNPjxboc07mUDZZweNZXGuHkWrUeJfWru2zzZZn1Sar/JBJ5gTgw
         2wIKMGMupjOp7zATc1bVbMGQt9IoK7gkLuyryLggwG2AbUjJgsTBDL6F5/G210Th6b8n
         5JvQ==
X-Gm-Message-State: AOAM5315dHlzDMZyG3UgJm2Hzyv+zsbV28V+G8NKg6/zjwE2LU6djfNw
        a7WhxJ1BTk4+GHbUX+NLlAPGezfe8LAiNnqq3DzC0kK+KxbWG76FoR2Ay0xo0Tv5/TKLY82FuEZ
        thaEGJX/hZ0GZI4yGDqQBXlGe
X-Received: by 2002:adf:b355:: with SMTP id k21mr20202843wrd.76.1591115187445;
        Tue, 02 Jun 2020 09:26:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxBnLBOPdE3PHIXiidRK8EYw7wGULW73adAiJNldsEPiDl9iHSw2WfwVqfSXm3HWkszF4QGhA==
X-Received: by 2002:adf:b355:: with SMTP id k21mr20202827wrd.76.1591115187131;
        Tue, 02 Jun 2020 09:26:27 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:a973:d537:5f93:b58? ([2001:b07:6468:f312:a973:d537:5f93:b58])
        by smtp.gmail.com with ESMTPSA id u74sm361365wmu.13.2020.06.02.09.26.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2020 09:26:26 -0700 (PDT)
Subject: Re: linux-next: manual merge of the hyperv tree with the kvm tree
To:     Wei Liu <wei.liu@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     KVM <kvm@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jon Doron <arilou@gmail.com>,
        Michael Kelley <mikelley@microsoft.com>
References: <20200602171802.560d07bc@canb.auug.org.au>
 <20200602135618.5iw6zd2jqzqqcwxm@liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <feb8e292-8dff-58ad-0bb2-5006bf475e6b@redhat.com>
Date:   Tue, 2 Jun 2020 18:26:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200602135618.5iw6zd2jqzqqcwxm@liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/06/20 15:56, Wei Liu wrote:
>>
>> between commit:
>>
>>   22ad0026d097 ("x86/hyper-v: Add synthetic debugger definitions")
>>
> Paolo
> 
> As far as I can tell you merged that series a few days ago. Do you plan
> to submit it to Linus in this merge window? How do you want to proceed
> to fix the conflict?

Hi, Linus can fix this conflict.

Paolo

