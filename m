Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE9FC55181
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 21:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4619B2078C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 21:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IaLKHa1P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgDTVKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 17:10:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27830 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725774AbgDTVKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 17:10:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587417005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7lDCFaFUw4R9AWRYUPjaGqLtTptNqr4/gsP5Cs91YoI=;
        b=IaLKHa1PFuA/zjjdIBFLmKdRMKCVJ9lh0yPCN6+ZetUHxOnTosHhGYu4brxt1WnXm/oo7y
        FRclpDVS+1/h6W22/9AgfqGkd+8lazk1c9VuZ8ORrEZXgD+Mt8C0bvqoiTbf4AJ7dPd554
        9YU52jBnpEuTHckXhMP/vbSxbQCDe4M=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-SGX-p1vmMweJlmMJgTzKJA-1; Mon, 20 Apr 2020 17:09:57 -0400
X-MC-Unique: SGX-p1vmMweJlmMJgTzKJA-1
Received: by mail-wr1-f72.google.com with SMTP id i10so6373886wrq.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 14:09:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7lDCFaFUw4R9AWRYUPjaGqLtTptNqr4/gsP5Cs91YoI=;
        b=b4WX2Mk+mEnH1LV3llhLOxyVQVqRSyTSto3S7y+NEZ7QEDIGaFSVStSuSKGAboKd8d
         MBvqMBMvdoq/aWI476FUxEpYunls/QUFP/3ohbd/lMum9ee1HvWyHkaHxjxrFnM+ylVS
         0QQ7hagKLr0ywXd5Zksb+OLT4tFFPNQnV0VUGIw3BbaptYjjnryfYvYa0/gklrX4tpqU
         QKJbbGzzrK889NZsl+yr2kN36fBHV6lx02PWgN7sDmSxnOYAgmPtGXDtea/pNA2KGNS4
         OsRR8uS3xtr9jNZT1afwq4h5G0LZkHhgyuMlS0sSThb7A+7QlTb0uV6H2uXz5x5cIc0w
         5OiA==
X-Gm-Message-State: AGi0PuYvCdSj6lBFYBIz9DsHSKvHC/d8PdObRIzefLU9zPx+zVMicfLq
        O8rJdHJ38H3ulzn267OhGSty4Ps174z4z2gzn0ccCs5ddnTzLqTo7PBu+RFFW5nvfY/Ot2YUk1G
        Gd+FwUlaJ7X292zEIgEZ8CvHV
X-Received: by 2002:a1c:2e0a:: with SMTP id u10mr1274789wmu.119.1587416995501;
        Mon, 20 Apr 2020 14:09:55 -0700 (PDT)
X-Google-Smtp-Source: APiQypK6od6W0dj1gZbWeyxDBs/v6PJZ1fc/3Z8V3Hi0ONmnXmb1L3h9dzlN2r24n5ADl1uYH1Bh5A==
X-Received: by 2002:a1c:2e0a:: with SMTP id u10mr1274770wmu.119.1587416995274;
        Mon, 20 Apr 2020 14:09:55 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5c18:5523:c13e:fa9f? ([2001:b07:6468:f312:5c18:5523:c13e:fa9f])
        by smtp.gmail.com with ESMTPSA id j13sm901220wro.51.2020.04.20.14.09.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2020 14:09:54 -0700 (PDT)
Subject: Re: [PATCH] kvm: add capability for halt polling
To:     Jon Cargille <jcargill@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     David Matlack <dmatlack@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200417221446.108733-1-jcargill@google.com>
 <87d083td9f.fsf@vitty.brq.redhat.com>
 <CANxmayg3ML5_w=pY3=x7_TLOqawojxYGbqMLrXJn+r0b_gvWgA@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <02039a7b-01b4-ea5c-bd73-100ea753bf5e@redhat.com>
Date:   Mon, 20 Apr 2020 23:09:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CANxmayg3ML5_w=pY3=x7_TLOqawojxYGbqMLrXJn+r0b_gvWgA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/04/20 20:47, Jon Cargille wrote:
>> Is it safe to allow any value from userspace here or would it maybe make
>> sense to only allow [0, global halt_poll_ns]?
> I believe that any value is safe; a very large value effectively disables
> halt-polling, which is equivalent to setting a value of zero to explicitly
> disable it, which is legal.

Doesn't a large value make KVM poll all the time?  But you could do that
just by running "for (;;)" so there's no reason to limit the parameter.

Paolo

