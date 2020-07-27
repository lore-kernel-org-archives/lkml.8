Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9299C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 16:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 932672073E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 16:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b2xjOflb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbgG0QJm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 12:09:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58460 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726942AbgG0QJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 12:09:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595866179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OPQOqiZCF/CXGUjGCPsDuUPFb0RD1RJET28Zyk3zKE4=;
        b=b2xjOflb8J5fau5CigoAJ+8yPx7kJ4zb32IRj5U9rAts3KjDTpPhT2WX1Pozsg4LtMTFWV
        OYsVbKJ9QS6gtAADNlqyzba98v1WDpjB0URTytJCmdszab7Tyz6qJwJXmhyiYnbVQmnM8P
        AMvb+d0KdSyAcaGclpav6+CV18pcI+A=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-hINEtqRlNgyWkwDA0yu2Ug-1; Mon, 27 Jul 2020 12:09:35 -0400
X-MC-Unique: hINEtqRlNgyWkwDA0yu2Ug-1
Received: by mail-ed1-f70.google.com with SMTP id m12so5768528edv.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 09:09:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=OPQOqiZCF/CXGUjGCPsDuUPFb0RD1RJET28Zyk3zKE4=;
        b=nZHyS5kx8XFtxAZC00IyFtiCErTUbKQpTh+QxHIYhyTaJYRIz3N7orRYIFHS+L9yy1
         SCWuHnADlT3cdGpP5/QVSoa8MiBj4YXN6u3J1xFEdA0M9YDcR2AFEUeqDjHcqifbRdAd
         R8/k6jD5LCBn/BXKzlu7Qnsq6ZrNsDDQzmEfJVd5tZTiZb80oyryRQ0oQWUvE/VmjdBO
         VsPjp0LDnT9Nxraxu41V2XvLQfmtwV5s659VOAkOw2XxVQYT+EQl7DPBVV/T1Ji4cJGN
         mxqNMkkiS6BmJrusG3raeKoCNtUSar4KdbaYZbPQeyNNon6eP9GNYce5uMVgjocXsMen
         JXHQ==
X-Gm-Message-State: AOAM533NkmTreF6aauXpb3fozudQf5PhiIiPUo8JXTzMmVsHeHejBebb
        7Zy3lp6HHaUIUtwpRajn4iqBw2KrMJ0XsHzurLvRIRL1HDZExMc0cFe1B/6WiRs1RI6HMo2KqzS
        WTE698FCZEH3I/rpEfiTB/In2
X-Received: by 2002:a05:6402:cb:: with SMTP id i11mr9374789edu.372.1595866174517;
        Mon, 27 Jul 2020 09:09:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx/hhArY+P/WnFI9GEc6R3AlSG06qBpjRYmUOuaXpr8IMw0UcMbxhNf3VfCAhBOae5V8WHpqw==
X-Received: by 2002:a05:6402:cb:: with SMTP id i11mr9374774edu.372.1595866174365;
        Mon, 27 Jul 2020 09:09:34 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id gh25sm1891816ejb.109.2020.07.27.09.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 09:09:33 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     virtio-fs-list <virtio-fs@redhat.com>, pbonzini@redhat.com,
        sean.j.christopherson@intel.com
Subject: Re: [PATCH v4] kvm,x86: Exit to user space in case page fault error
In-Reply-To: <20200727135603.GA39559@redhat.com>
References: <20200720211359.GF502563@redhat.com> <20200727135603.GA39559@redhat.com>
Date:   Mon, 27 Jul 2020 18:09:32 +0200
Message-ID: <87ft9dlz2b.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal <vgoyal@redhat.com> writes:

> On Mon, Jul 20, 2020 at 05:13:59PM -0400, Vivek Goyal wrote:
>> Page fault error handling behavior in kvm seems little inconsistent when
>> page fault reports error. If we are doing fault synchronously
>> then we capture error (-EFAULT) returned by __gfn_to_pfn_memslot() and
>> exit to user space and qemu reports error, "error: kvm run failed Bad address".
>
> Hi Vitaly,
>
> A gentle reminder. How does this patch look now?
>

Sorry, I even reviewd it but never replied. It looks good to me!

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

