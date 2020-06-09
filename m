Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFDDFC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 20:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAC7820737
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 20:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UXCkAYCC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388286AbgFIUbh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 16:31:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36836 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732795AbgFIUbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 16:31:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591734690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KEH5ES29dspwzWzD9R3UfAcYz+Md+T39kv30W9yHTos=;
        b=UXCkAYCC2l7Hu6ZtJNdolN6MWNMOeA/u65InToAILAXkDVyIpVjBiJkS3CD01Egc/ApETR
        NJx+Eb/9nm5wDpSwI8WoBWF+qqKOMQpc3Cb6GiW/+Eq2So5Re9F6kSFpm3cg6mIe+sbPF4
        +pCaJQawhUvmFqK/+vhjTlLZq5h09VQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-vyiVX2cNP4OZ6mROpyi0Ag-1; Tue, 09 Jun 2020 16:31:29 -0400
X-MC-Unique: vyiVX2cNP4OZ6mROpyi0Ag-1
Received: by mail-wr1-f72.google.com with SMTP id m14so35708wrj.12
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 13:31:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KEH5ES29dspwzWzD9R3UfAcYz+Md+T39kv30W9yHTos=;
        b=bAP3tpNsXz2g5kbBla6agb1WbApY1levoFuA9/7as+aPGQMfk1m6v1o0rhgS09eDeQ
         sN+euZjcG/MR1U4MTc+APfsYIwzcLz669l3dHDK9oKBPamhP9sp6Rio29vWpAnnf05xV
         oyQ5NmJEd+UF4qCgn4dspNEF17T7NefkpD6CgTdXl04AtrE70TEKST8EJdHfdAkp/9+S
         yhmDBn0VrRA3IuAapUeYYeV72p2vzFlsfDU06dljzvtxQMjaIjAAX/lzlvT7DMT+qeqW
         pnhQpFP5Zn+5NyCoz6xzheBe5FI1afIvVqLlhuZ5twCDlH8rdAak2fHizLx3b8TDluD9
         sP8Q==
X-Gm-Message-State: AOAM530/3iMQPJhn+HjjVgkG6sCcT3HXTevghd6bA00IbL/+07RmYtEd
        1UUN6kxzVUkA5QzV03ELrbcTvTQJ90UxrN6SrzOwMJtsZaJQO/NCC09OpQr54GgvzeQMzCC1oUh
        pGXZEXUkus4jTc49NqOfUHnCK
X-Received: by 2002:a5d:5351:: with SMTP id t17mr6156468wrv.287.1591734687727;
        Tue, 09 Jun 2020 13:31:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzU7S6RgssO4So7xK5AEwaniOKS/T+uTUiN9P8P46IPWjTCUaoOuKpdhLRvZRnsxMmePD+jDQ==
X-Received: by 2002:a5d:5351:: with SMTP id t17mr6156435wrv.287.1591734687404;
        Tue, 09 Jun 2020 13:31:27 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:29ed:810e:962c:aa0d? ([2001:b07:6468:f312:29ed:810e:962c:aa0d])
        by smtp.gmail.com with ESMTPSA id y5sm5007069wrs.63.2020.06.09.13.31.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2020 13:31:26 -0700 (PDT)
Subject: Re: [PATCH v2 05/10] KVM: x86: interrupt based APF 'page ready' event
 delivery
To:     Vivek Goyal <vgoyal@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jim Mattson <jmattson@google.com>,
        Gavin Shan <gshan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
References: <20200525144125.143875-1-vkuznets@redhat.com>
 <20200525144125.143875-6-vkuznets@redhat.com>
 <20200609191035.GA223235@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <dcdda87c-cf2f-da6f-3166-e2d0bfefce06@redhat.com>
Date:   Tue, 9 Jun 2020 22:31:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200609191035.GA223235@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/06/20 21:10, Vivek Goyal wrote:
> Hi Vitaly,
> 
> Have a question about page ready events. 
> 
> Now we deliver PAGE_NOT_PRESENT page faults only if guest is not in
> kernel mode. So say kernel tried to access a page and we halted cpu.
> When page is available, we will inject page_ready interrupt. At
> that time we don't seem to check whether page_not_present was injected
> or not. 
> 
> IOW, we seem to deliver page_ready irrespective of the fact whether
> PAGE_NOT_PRESENT was delivered or not. And that means we will be
> sending page present tokens to guest. Guest will not have a state
> associated with that token and think that page_not_present has
> not been delivered yet and allocate an element in hash table for
> future page_not_present event. And that will lead to memory leak
> and token conflict etc.

Yes, and this is https://bugzilla.kernel.org/show_bug.cgi?id=208081
which I was looking at right today.

> While setting up async pf, should we keep track whether associated
> page_not_present was delivered to guest or not and deliver page_ready
> accordingly.

Yes, I think so.

Paolo

