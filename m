Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A736CC2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 14:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A8252082E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 14:47:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UFycp+9+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbgBDOrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 09:47:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55224 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727260AbgBDOrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 09:47:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580827640;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lw+gzAo8DOLFDe3zbMMR3xycrnPKgKMJnAjOPL2s5GI=;
        b=UFycp+9+xTO0Z0TreDd4xLl0gkqsqikaaz3gc4AQx8O5r05BJ9B5PcXxRAf5U8jJqP26Te
        1PCX6GX0ipnZufrTrcqHcTwCLHneQUQhyyj3JzcrMgbOfCr5qFHr7BgesjfXr+9SLpdKr3
        ObAsXg8oq/gEd/sJkBduquS8OF/x0Wk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-MhnF8xvWM56iyP4i6U7IPw-1; Tue, 04 Feb 2020 09:47:18 -0500
X-MC-Unique: MhnF8xvWM56iyP4i6U7IPw-1
Received: by mail-wr1-f72.google.com with SMTP id s13so10245652wru.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 06:47:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=lw+gzAo8DOLFDe3zbMMR3xycrnPKgKMJnAjOPL2s5GI=;
        b=WSSAOOL00t+Ass62B3/06VFMDn1QTVqn1MX5SnC/dj+49dLhwu0rss5U35NRs5mZaC
         UJOHIHCXvUYjZckw/y2PYV4auSwCpvaZeElA0gTr5AvF2bpALLT7KHotlcUJc80jQl4c
         tLFVCadSbH6pduhxfOqkbA7wQhgM/Vh+LGc3EwIDzKqYzlll6NEXZU/YWDEN1iXYX8pk
         E9hiNo6C2G8oyFQrlo1BdksuwVDkW/+OFhziXOc1/W1Xjf4005uiFmS2xdB0b2j+rFz7
         HSV5m3x7g2U6qLkIeBfgLBU86IBI4g8hh5i0V6dluS7eYI9uEzaOAAuMlrOUo69lj6Eq
         yCKA==
X-Gm-Message-State: APjAAAX7iH5dTBtu0XaswUhDj6EL2TgXZzsJ8D7T1xuskzpkJXW00+AX
        NIapSYjvMoXpuqjXu1KUQlqQJxHynZVJmSx7GrLQyMHmlu8Kk9Xi7HGFPmpOPbhHwwtqHv0Pmie
        gFXS7Qa5Y8ibxOG0hrRI97Eyg
X-Received: by 2002:a1c:9c52:: with SMTP id f79mr6200721wme.30.1580827637172;
        Tue, 04 Feb 2020 06:47:17 -0800 (PST)
X-Google-Smtp-Source: APXvYqwGD6gTvtFqqoJhFfXZTOsvAgNVMBX4BDKiIn6c4VC9z32JT86bgANO8n+yzg5d3VzQcSYFJw==
X-Received: by 2002:a1c:9c52:: with SMTP id f79mr6200696wme.30.1580827636998;
        Tue, 04 Feb 2020 06:47:16 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id e17sm17425259wrn.62.2020.02.04.06.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 06:47:16 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Andy Lutomirski <luto@amacapital.net>
Cc:     David Laight <David.Laight@aculab.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "x86\@kernel.org" <x86@kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm\@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [PATCH 1/2] KVM: x86: Emulate split-lock access as a write
In-Reply-To: <20200131200134.GD18946@linux.intel.com>
References: <db3b854fd03745738f46cfce451d9c98@AcuMS.aculab.com> <777C5046-B9DE-4F8C-B04F-28A546AE4A3F@amacapital.net> <20200131200134.GD18946@linux.intel.com>
Date:   Tue, 04 Feb 2020 15:47:15 +0100
Message-ID: <87y2timmto.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Exiting to host userspace with "emulation failed" is the other reasonable
> alternative, but that's basically the same as killing the guest.  We're
> arguing that, in the extremely unlikely event that there is a workload out
> there that hits this, it's preferable to *maybe* corrupt guest memory and
> log the anomaly in the kernel log, as opposed to outright killing the guest
> with a generic "emulation failed".
>

FWIW, if I was to cast a vote I'd pick 'kill the guest' one way or
another. "Maybe corrupt guest memory" scares me much more and in many
cases host and guest are different responsibility domains (think
'cloud').

-- 
Vitaly

