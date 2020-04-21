Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B1C2C55186
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 21:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68D73206D9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 21:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bjdZIl2J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbgDUVqq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 17:46:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54160 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725850AbgDUVqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 17:46:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587505603;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r6wLjzLOuj6c5+cLaZodMgIgcvGXF3pN8d/Rer3Rx78=;
        b=bjdZIl2JORfUOvFk0IbMlyQvWBV+e6f1NtET/dItpqCAFt8gA4ZhuNLmcAgaB2GDK4R9dx
        e7s0FGwIliJ03f23RKhjui9jsp7NL644Jvv2m3jPv701Tv3jJv0dDLjWuC0UhQTqXq9tVH
        wgtySWOXW5BixeNUWPqXf2dlIeZAUf4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-JJHx4uFLO5epw0zW2Jpz8g-1; Tue, 21 Apr 2020 17:46:42 -0400
X-MC-Unique: JJHx4uFLO5epw0zW2Jpz8g-1
Received: by mail-wr1-f69.google.com with SMTP id s11so8433482wru.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 14:46:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r6wLjzLOuj6c5+cLaZodMgIgcvGXF3pN8d/Rer3Rx78=;
        b=teSD0xatrXdJzjyuV/DwscosAT+f9IxJ29h4CsOu3cs5QBvLeAVXzfAiSIEdZWnad2
         ejYb7sCa45+2UFhIy8cMaVbamzobrvtpzR2mr2VbYYd765OoagFqXiP5JEdX9DLfhW4V
         PTeyE4B391gRx1VvBBzgNEKpfqVImvCId94fOnzn/W26MuiFmdlVIb0bJ/FmDLzf8Lks
         sYbObb5z108OmoFmWbklCzGs8jWjG2kZ33xu1OuqQPFU5GN7pFwE+ufF4M4AVdKmgBDE
         qcBwe6IXNg6ti36+3JrJDO+UI0FOH4t1umfi5I+olUOrYLINNmE/jvIpONOvL8ceADZF
         Y2lQ==
X-Gm-Message-State: AGi0PuaDc/hlR3Ic+50/0/yIQtYhX9jzXYS+2rImxdGaXxPK48OKvTJ4
        J5DongBiTIh3IqlWKmqUa7lSwfW0+gR4WsFY3ZGpBMhCxiY/DWnIYiL7t0MNcnBwK+9TGfqg1Z9
        Xs9z8yQbyarVUHA+FLvFbtvwY
X-Received: by 2002:a5d:49c7:: with SMTP id t7mr24817048wrs.22.1587505601033;
        Tue, 21 Apr 2020 14:46:41 -0700 (PDT)
X-Google-Smtp-Source: APiQypJuj94xnF2FaQAuHLXoLoDejHCjWzP12FOd9j0iSkP/LXHBmTsnLGv5NL3YplxjISyisn1r+g==
X-Received: by 2002:a5d:49c7:: with SMTP id t7mr24817028wrs.22.1587505600785;
        Tue, 21 Apr 2020 14:46:40 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:f43b:97b2:4c89:7446? ([2001:b07:6468:f312:f43b:97b2:4c89:7446])
        by smtp.gmail.com with ESMTPSA id v1sm5314818wrv.19.2020.04.21.14.46.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2020 14:46:40 -0700 (PDT)
Subject: Re: [PATCH v1 00/15] Add support for Nitro Enclaves
To:     Andra Paraschiv <andraprs@amazon.com>, linux-kernel@vger.kernel.org
Cc:     Anthony Liguori <aliguori@amazon.com>,
        Benjamin Herrenschmidt <benh@amazon.com>,
        Colm MacCarthaigh <colmmacc@amazon.com>,
        Bjoern Doebel <doebel@amazon.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Frank van der Linden <fllinden@amazon.com>,
        Alexander Graf <graf@amazon.de>,
        Martin Pohlack <mpohlack@amazon.de>,
        Matt Wilson <msw@amazon.com>, Balbir Singh <sblbir@amazon.com>,
        Stewart Smith <trawets@amazon.com>,
        Uwe Dannowski <uwed@amazon.de>, kvm@vger.kernel.org,
        ne-devel-upstream@amazon.com
References: <20200421184150.68011-1-andraprs@amazon.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <18406322-dc58-9b59-3f94-88e6b638fe65@redhat.com>
Date:   Tue, 21 Apr 2020 23:46:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200421184150.68011-1-andraprs@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/04/20 20:41, Andra Paraschiv wrote:
> An enclave communicates with the primary VM via a local communication channel,
> using virtio-vsock [2]. An enclave does not have a disk or a network device
> attached.

Is it possible to have a sample of this in the samples/ directory?

I am interested especially in:

- the initial CPU state: CPL0 vs. CPL3, initial program counter, etc.

- the communication channel; does the enclave see the usual local APIC
and IOAPIC interfaces in order to get interrupts from virtio-vsock, and
where is the virtio-vsock device (virtio-mmio I suppose) placed in memory?

- what the enclave is allowed to do: can it change privilege levels,
what happens if the enclave performs an access to nonexistent memory, etc.

- whether there are special hypercall interfaces for the enclave

> The proposed solution is following the KVM model and uses the KVM API to be able
> to create and set resources for enclaves. An additional ioctl command, besides
> the ones provided by KVM, is used to start an enclave and setup the addressing
> for the communication channel and an enclave unique id.

Reusing some KVM ioctls is definitely a good idea, but I wouldn't really
say it's the KVM API since the VCPU file descriptor is basically non
functional (without KVM_RUN and mmap it's not really the KVM API).

Paolo

