Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4179BC47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 09:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CF87206A4
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 09:54:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bqa5SqIc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728580AbgEEJyX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 05:54:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25539 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725766AbgEEJyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 05:54:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588672461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TlhlzZcZdCKqn6uGJjCk/Di1gwjV8y+RUYlK2OkS3b4=;
        b=Bqa5SqIcV1nII0BTelOTfhZTtIOKP6qUxY2SaM9LfKHu2wo8HAAFogqnGRekfnNcquygr3
        fnMlvXcBcxbZkopZbheQiYBqhpJlVV+ul5IQy6eMqKlNSICWsuXx6w86azp37QnheFTEng
        OjMzSGggjhC7q1bYnOHoesZRoyU1kyw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-483-ixDoCfpxOeOfkDaXHVCj_A-1; Tue, 05 May 2020 05:54:16 -0400
X-MC-Unique: ixDoCfpxOeOfkDaXHVCj_A-1
Received: by mail-wr1-f69.google.com with SMTP id z5so949689wrt.17
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 02:54:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TlhlzZcZdCKqn6uGJjCk/Di1gwjV8y+RUYlK2OkS3b4=;
        b=UiauHPj4SsqM0rMIZcZGdDt1T1GoX6wvyYwyGIrayvXn14DgD01fG13OaApzoWPJXJ
         lilU7xuL0xig6SKlPAsCGH+MkyXl3fLYKhbj+GGJS4Qu6AFrTfc9ePSOlSU/XXrm4eRO
         W2A9CmJd88xf9Bgmnvfv3QaIquxcHzPP/lmgjR8oaEEAgWcvNz/AKA5wqYURxIL8rS+D
         0z0XzdoThnS4naTepV8ghjMamhibc8nBZMk9F73RN9H2DPOM2hjXqF4hWtpjOSVn/gKY
         BHRnRIRAsTNJBpTS5jlAsGrJ6Ljmyp396+UIdfgRnp/q32vsUv0R/9Ho1vaFFHqlNOz3
         0ydg==
X-Gm-Message-State: AGi0PubmJWSsCiG+sKElhMx/fCxCbuTyn7HUdh9SyeOiLvC22ReV8bgo
        9qimn9R8b+tlZgfk/PKa7K3Ab68MlwjsS7+PUQbUQguqgTOO5sCvY1MV/4Qy//3nVjPKBGtqtHS
        6mj/ydtsKEbpm+N7ALlFxCmDN
X-Received: by 2002:a1c:770f:: with SMTP id t15mr2334138wmi.178.1588672455600;
        Tue, 05 May 2020 02:54:15 -0700 (PDT)
X-Google-Smtp-Source: APiQypLwWpFo/EZANuablSCEtbPe77SC3Q23ygQMJ3/l0rAGmnTrMl4z0V4JetgLFE2GKMi+iRoCOg==
X-Received: by 2002:a1c:770f:: with SMTP id t15mr2334116wmi.178.1588672455367;
        Tue, 05 May 2020 02:54:15 -0700 (PDT)
Received: from [192.168.178.58] ([151.20.132.175])
        by smtp.gmail.com with ESMTPSA id y3sm2506687wrm.64.2020.05.05.02.54.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2020 02:54:14 -0700 (PDT)
Subject: Re: [PATCH RFC 4/6] KVM: x86: acknowledgment mechanism for async pf
 page ready notifications
To:     Gavin Shan <gshan@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, x86@kernel.org,
        kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>
References: <20200429093634.1514902-1-vkuznets@redhat.com>
 <20200429093634.1514902-5-vkuznets@redhat.com>
 <bdd3fba1-72d6-9096-e63d-a89f2990a26d@redhat.com>
 <87y2q6dcfm.fsf@vitty.brq.redhat.com>
 <f7e76889-a8fc-a348-90c2-2c27f3706585@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b0a48d7f-a71d-ab72-dccc-4fa1445c854d@redhat.com>
Date:   Tue, 5 May 2020 11:54:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <f7e76889-a8fc-a348-90c2-2c27f3706585@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/05/20 10:51, Gavin Shan wrote:
>> How does the guest know if host has any pending events or not?
> 
> One way would be through struct kvm_vcpu_pv_apf_data, which is visible
> to host and guest. In the host, the workers that have completed their
> work (GUP) are queued into vcpu->async_pf.done. So we need a bit in
> struct kvm_vcpu_pv_apf_data, written by host while read by guest to
> see if there pending work. I even don't think the writer/reader need
> to be synchronized.

No, this cannot work.  The problem is that you need a way to tell the
host "you can give me another ready page", and a memory location is not
enough for that.

Paolo

