Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6747C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 11:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 935782074B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 11:11:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AKkTRRkp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729557AbgFHLLL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 07:11:11 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57747 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729544AbgFHLLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 07:11:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591614668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6UtZMmgd9hnL+iwknrZAm1Gp605OoCu4kNlweeMxR6w=;
        b=AKkTRRkplfryGJvJn6iZigBYbsx93Vs4kRQPT9PhioEu4e4OTG76K8bIaLyFD+5wIYI+Zs
        J5k3egdf9H/ovjXMvdBvqzLG7UaZwNTe8TfABZJJmtqWqnrojLFtj99XiWnnaxP3xLgSlF
        e3mu8FQE1g2W08qK1zQg5nIEQxmUffA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-PkqjGafvM9-M4QqDPyDiMQ-1; Mon, 08 Jun 2020 07:11:07 -0400
X-MC-Unique: PkqjGafvM9-M4QqDPyDiMQ-1
Received: by mail-wm1-f72.google.com with SMTP id a18so344717wmm.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 04:11:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6UtZMmgd9hnL+iwknrZAm1Gp605OoCu4kNlweeMxR6w=;
        b=kocKGjI8IdN4c1/O0S81JjTiwM5h87wNktjfksVDIcgmZsAiIU1Sjt5lUbRE3qICOk
         YfFVlh64ZJLiD30PGnAMkeV7HNxgduqVsPMikctzroz9ISJfl6+VjN9PpSx4QrIdYJ3n
         GrLyfqNvmEpdfe5mjmSZYJOFvnwdDYGlnR7pQrLbdphFbfV/32WyiFO6J7XfNtqusUQp
         NQaLLT+I9WT7MHW1wv369DUbjwuruS0cy5IqaBHbannye6/p9Rs3xVBbER3AsZxLT4bk
         QgNg5ocgSH7wEz80NvXVhkbGFShy8NaMhxC0HWGnddnPjH/4TWzWntI+u0SXYLmkE5Lp
         T/QQ==
X-Gm-Message-State: AOAM530vldyauXdr+tZuEc5u7OcfqvdtHkTIlGnLI6NryYuRMsGX638Z
        DKTulSe/7RHT+2IaQpe+R7iF0FK/QXfIhBx/9klzF136cyNtwEqVLIUe9K5EaabrGZUppiJuxcb
        TKXNRBWjMqME3gAFG3nNesbi1
X-Received: by 2002:a7b:c1ce:: with SMTP id a14mr14798178wmj.144.1591614665751;
        Mon, 08 Jun 2020 04:11:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzv5u6HDK1/x+RarSMh01GURLAzTYLbxMBVZTOhO0ZDSZmDyVGktQuM1b3EGK6O2JN7nu/vVw==
X-Received: by 2002:a7b:c1ce:: with SMTP id a14mr14798158wmj.144.1591614665568;
        Mon, 08 Jun 2020 04:11:05 -0700 (PDT)
Received: from [192.168.178.58] ([151.30.87.23])
        by smtp.gmail.com with ESMTPSA id y66sm22490920wmy.24.2020.06.08.04.11.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2020 04:11:04 -0700 (PDT)
Subject: Re: [PATCH 19/30] KVM: nSVM: extract svm_set_gif
To:     Qian Cai <cai@lca.pw>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        torvalds@linux-foundation.org
References: <20200529153934.11694-1-pbonzini@redhat.com>
 <20200529153934.11694-20-pbonzini@redhat.com> <20200605203356.GC5393@lca.pw>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2a798f4c-5782-2e7c-7c87-ca7a3c576ff8@redhat.com>
Date:   Mon, 8 Jun 2020 13:11:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200605203356.GC5393@lca.pw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/06/20 22:33, Qian Cai wrote:
>> +	if (value) {
>> +		/*
>> +		 * If VGIF is enabled, the STGI intercept is only added to
>> +		 * detect the opening of the SMI/NMI window; remove it now.
>> +		 * Likewise, clear the VINTR intercept, we will set it
>> +		 * again while processing KVM_REQ_EVENT if needed.
>> +		 */
>> +		if (vgif_enabled(svm))
>> +			clr_intercept(svm, INTERCEPT_STGI);
>> +		if (is_intercept(svm, SVM_EXIT_VINTR))
> A simple qemu-kvm will trigger the warning. (Looks like the patch had
> already been pulled into the mainline quickly.)

You're right, that should have been INTERCEPT_VINTR.  I'll post a fix.

Thanks,

Paolo

