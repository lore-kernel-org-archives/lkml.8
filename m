Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01214C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 17:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3B8D206DC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 17:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QhfXAUdT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730365AbgFDR5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 13:57:11 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60200 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730008AbgFDR5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 13:57:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591293429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YRb6tBftcN4ywgPXESWRYJJkk+CvsoyUYJ93rzfhMU4=;
        b=QhfXAUdTo/ZjQaQVePzBnjnNdpEQJ8p1VYupb16+4jN7EIQb8NBJ4uO7TjjWVJ0Yhil2MW
        7fvzfiZc1QaEcPDgGKEdctu6/reho6aIgYH+VeKnYvbfaxyWxGuK0VLsNJnbtxcx+UVPbn
        RkzgU2gmNnmDSq2Qf9tynK7Fus8txAE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-Or5tijpwPeCjB1lupJcYhA-1; Thu, 04 Jun 2020 13:56:41 -0400
X-MC-Unique: Or5tijpwPeCjB1lupJcYhA-1
Received: by mail-wr1-f70.google.com with SMTP id p9so2724128wrx.10
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 10:56:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YRb6tBftcN4ywgPXESWRYJJkk+CvsoyUYJ93rzfhMU4=;
        b=OYtJLUW91jSg+rhtVRr9Hk59JdfuLyl52xNZdLgwE8JGqhd08QVti2y/mPhJEOSQS0
         2FMmRsk1nqLZYAU8v9eu0oge6wReOF4Ex9a6QTbOqCOqg/WFS8LUW+KMYFyyRa5eEVje
         qITfPCVySGSCcmyG/m7JoqDW4oJ1IBjVtGfRYiaNQMmfKK/Yiz07rEmW7QYkg5W1RMEY
         cccDOvSl4GqYQ9WZ2d0NEPFSfVqFXWlO/3aWx9jpe/UgZ9uKSOmWUphogHTNpebG5FtD
         XrY34unt/tsWzZoUwrfGtGMFxc71EMlfmyL2ogUXyK8pUB/PnrNQ++yALHcUU0EbvW6n
         7/tQ==
X-Gm-Message-State: AOAM533+3zYPvqLbu55Zjsjz5XCs1aeot4HZdfhDYg1MWP0pgLx9utaM
        f3NsynTonpmPvyw1uNmQiScrsn4TxARvkxmLxihNRMw+EPVhMhqfCpJjxEFsOGxoXYZhba6hu5q
        pdAPOmdoWO0KCvz3Jv1moCida
X-Received: by 2002:a5d:548c:: with SMTP id h12mr5492271wrv.120.1591293400612;
        Thu, 04 Jun 2020 10:56:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwlNwMQCPzZScok4aBC3SMcPaIZjURMRw+b5itxwYHzx4gbOSCjJlzT3dBoJesPlCEZMtDUEg==
X-Received: by 2002:a5d:548c:: with SMTP id h12mr5492252wrv.120.1591293400383;
        Thu, 04 Jun 2020 10:56:40 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:a0c0:5d2e:1d35:17bb? ([2001:b07:6468:f312:a0c0:5d2e:1d35:17bb])
        by smtp.gmail.com with ESMTPSA id q13sm8582433wrn.84.2020.06.04.10.56.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2020 10:56:39 -0700 (PDT)
Subject: Re: [PATCH v2 00/10] KVM: x86: Interrupt-based mechanism for async_pf
 'page present' notifications
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
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
 <3be1df67-2e39-c7b7-b666-66cd4fe61406@redhat.com>
 <20200604174534.GB99235@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <673d2612-53d2-4f86-1b88-dd9d8d974307@redhat.com>
Date:   Thu, 4 Jun 2020 19:56:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200604174534.GB99235@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/06/20 19:45, Vivek Goyal wrote:
>> I'll do another round of review and queue patches 1-7; 8-9 will be
>> queued later and separately due to the conflicts with the interrupt
>> entry rework, but it's my job and you don't need to do anything else.
> Hi Paolo,
> 
> I seee 1-7 got merged for 5.8. When you say patch 8-9 will be queue later,
> you mean later in 5.8 or it will held till 5.9 merge window opens.

I hope to get them in 5.8.  They have some pretty nasty conflicts that
are too much for Linus to resolve.  So my plan is to put 8-9 in a topic
branch and do the merge myself.  Whether this works out depends on the
timing of the tip pull request.

Paolo

