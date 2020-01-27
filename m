Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D57C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 17:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2475D20CC7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 17:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OnGjfEK2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgA0Rxs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 12:53:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20005 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726026AbgA0Rxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 12:53:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580147627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9Eyp+gBd/lJZeZthsn+gHU0ABezhEFbHfNSRAsM4Qa4=;
        b=OnGjfEK2LPoZCE9r2c6+9hBhj/GMLesyb3Jsh05q/CMuCOQQbPieHLal8AAZxIfZt0b+PZ
        eXA/jAIUS0+cSh8ZoAGBZD1LUVAAGElquexisT5mF2rwb9MTYeEwNHlDARuj6WmMTD7ZSp
        G9Mh3HkVo0E01orjQi11RlJlzQW80Q8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-Gkn7p7rnORu97vHeNnt4pQ-1; Mon, 27 Jan 2020 12:53:45 -0500
X-MC-Unique: Gkn7p7rnORu97vHeNnt4pQ-1
Received: by mail-wr1-f69.google.com with SMTP id w6so6516462wrm.16
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 09:53:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9Eyp+gBd/lJZeZthsn+gHU0ABezhEFbHfNSRAsM4Qa4=;
        b=LiHULJMUi23o4fpiOu5ekIK5FUfXE579Z+zUerfAKal6F4nAJfMYBgVesTQdXkdX+l
         m0NbArpVQq36+pEBZIIf4Wzt3vU1tOeFJSWlMZSiSb4eWWzlyrrzMIwADnhxQFdZuVRn
         tlSjz9AJZYKkg6hjL276rh8McIGww7Btvx1TtavfpDo0wlCx2wDAMYbOMRoEUC/57wRS
         ap4xuxcDh9DudMq2DSTgGI0BmG58zfgOr3lGiDP+0sTYNyyUJ/gpLEVjBmZBqdlr3Es6
         3a5H/SPs24MFD2yQmV6nbywgHeOaASK+q6L4J9NzSXqTIHLvHwcOoGGMZLRFDxsa0Lew
         o3wg==
X-Gm-Message-State: APjAAAXkqk/h7OWKA1SvrFrIMVLajcdTXEEvaKJ0MB85RrwlTQWXZg6f
        Krduan3tBiAe7AJLX80E+4FPAgeZVpnvK23fEn48hXrtBnYcYgHimwaNpEGaiZo78nnShAs31hl
        pizcwSBc5d4euUKTGTeCNpQ4z
X-Received: by 2002:adf:ed83:: with SMTP id c3mr22504371wro.51.1580147624560;
        Mon, 27 Jan 2020 09:53:44 -0800 (PST)
X-Google-Smtp-Source: APXvYqwDyZu7O8Ip0GFjqb+I/zY1VyXtXAX7/ZMPbRpU5lebbCj5fe1qEWUjUyaXZ4uCY/QW8VLlRA==
X-Received: by 2002:adf:ed83:: with SMTP id c3mr22504354wro.51.1580147624305;
        Mon, 27 Jan 2020 09:53:44 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:b8fe:679e:87eb:c059? ([2001:b07:6468:f312:b8fe:679e:87eb:c059])
        by smtp.gmail.com with ESMTPSA id o4sm22140756wrx.25.2020.01.27.09.53.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2020 09:53:43 -0800 (PST)
Subject: Re: [PATCH RFC 2/3] x86/kvm/hyper-v: move VMX controls sanitization
 out of nested_enable_evmcs()
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     kvm@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        linux-kernel@vger.kernel.org, Liran Alon <liran.alon@oracle.com>,
        Roman Kagan <rkagan@virtuozzo.com>
References: <20200115171014.56405-3-vkuznets@redhat.com>
 <6c4bdb57-08fb-2c2d-9234-b7efffeb72ed@redhat.com>
 <20200122054724.GD18513@linux.intel.com>
 <9c126d75-225b-3b1b-d97a-bcec1f189e02@redhat.com>
 <87eevrsf3s.fsf@vitty.brq.redhat.com> <20200122155108.GA7201@linux.intel.com>
 <87blqvsbcy.fsf@vitty.brq.redhat.com>
 <f15d9e98-25e9-2031-2db5-6aaa6c78c0eb@redhat.com>
 <87zheer0si.fsf@vitty.brq.redhat.com> <87lfpyq9bk.fsf@vitty.brq.redhat.com>
 <20200124172512.GJ2109@linux.intel.com> <875zgwnc3w.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <437c2710-7148-a675-8945-71dc7a90f7dd@redhat.com>
Date:   Mon, 27 Jan 2020 18:53:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <875zgwnc3w.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/01/20 16:38, Vitaly Kuznetsov wrote:
>>> If there are no objections and if we still think it would be beneficial
>>> to minimize the list of controls we filter out (and not go with the full
>>> set like my RFC suggests), I'll prepare v2. (v1, actually, this was RFC).
>> One last idea, can we keep the MSR filtering as is and add the hack in
>> vmx_restore_control_msr()?  That way the (userspace) host and guest see
>> the same values when reading the affected MSRs, and eVMCS wouldn't need
>> it's own hook to do consistency checks.
> Yes but (if I'm not mistaken) we'll have then to keep the filtering we
> currently do in nested_enable_evmcs(): if userspace doesn't do
> KVM_SET_MSR for VMX MSRs (QEMU<4.2) then the filtering in
> vmx_restore_control_msr() won't happen and the guest will see the
> unfiltered set of controls...
> 

Indeed.  The place you used in the RFC is the best we can do, I am afraid.

Paolo

