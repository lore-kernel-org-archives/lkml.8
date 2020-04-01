Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF1BC2D0F1
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 10:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FB7B2077D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 10:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="ktrc8MpU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732223AbgDAKUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 06:20:15 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34131 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731839AbgDAKUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 06:20:14 -0400
Received: by mail-lj1-f194.google.com with SMTP id p10so24921651ljn.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 03:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ENHstGjuwW2yo3COsGAECyjpxrxaSoZPQXrr2CDIHqY=;
        b=ktrc8MpUEQ5QI60gYoRyEuvXwXfpEqx3M/fJrox89MhNAHgYG86XLaLOivQ4eQVGSK
         G89OY/Z844A8pm6YBWQeSS0CI0luQUhL0yFIhrDRDU5jwFln6jdw3yd593tYuFNvpFFy
         0Fq7m8s9XhFlbYHxrtmek5bt2Xh4APWdRr1dgaqv5KSP94GHOm7PRhJlpzgD6CXET2GK
         Oa3eVgsfIYfPHmP+KqTY9XrTNUYqMf1lNt5eWOT/gT8/2zATPWyIhGwf3GLewEcss9qg
         9AOKRvdVO/l5lA9eo+oCI4YtDu8dguLTOWS8IF6jTn5KrGbNF7S+8G2s8syNS+unUgSr
         24UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ENHstGjuwW2yo3COsGAECyjpxrxaSoZPQXrr2CDIHqY=;
        b=PvIp6y4XeBsMrqlNkejFNIO8/WTFjwL1b0FbNWXDAZc1AuBPBGK+1ZaJOVvgZhb2WH
         IdfEp0fhO2nzFHGwC+NvGSb2aIjy0kyVyb0/AA2JQrwfQfxLJgUQV2FLyrwiwxcH23jb
         lkjX3SP1D1Pjz/Qt+UejOxl0UubSdn91mb3ecnkq+AQQVJ7KsgdrfcL/fBXGxQQlFTzI
         7CKaT1GVSP2i/cXHx0sME2c7R3bpK3k7ct2fb4c1aCG5MUFjywzn58GAQuKaRphGQlTl
         tD63yYFqPVpwuBU9DHNVq6xZ4JMYD3+CjngiTl8jAsu/kBLRYYXffWe6BBlpnUw0wrhK
         9HjQ==
X-Gm-Message-State: AGi0Pua0ivg1gpM79FMVaEUXE9Dmg8ZYRN1X1Rl8mpd1j0M6OsNQ55vu
        zbRJWoi84aDZezSyAUHT5t7Ne786Y88=
X-Google-Smtp-Source: APiQypL9WDxbsq4oYKXr36Yb9n5DZ8OQKZ64pbm4DDxE1ew8kCL3RjSimoOmg9MTrlry5TTqx+bKuQ==
X-Received: by 2002:a2e:9a54:: with SMTP id k20mr12504657ljj.272.1585736411428;
        Wed, 01 Apr 2020 03:20:11 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:245:3fc8:782f:cdd9:3f89:e462? ([2a00:1fa0:245:3fc8:782f:cdd9:3f89:e462])
        by smtp.gmail.com with ESMTPSA id u30sm1307508lfn.2.2020.04.01.03.20.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2020 03:20:10 -0700 (PDT)
Subject: Re: [PATCH] KVM: MIPS: fix compilation
To:     Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     linux-mips@vger.kernel.org, peterx@redhat.com, rppt@linux.ibm.com
References: <20200331154749.5457-1-pbonzini@redhat.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <b2689d50-f5fe-c7ba-eede-f11920f1d012@cogentembedded.com>
Date:   Wed, 1 Apr 2020 13:20:02 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200331154749.5457-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 31.03.2020 18:47, Paolo Bonzini wrote:

> Commit 31168f033e37 is correct that pud_index() & __pud_offset() are the same

    You should also specify the commit's 1-line summary enclosed in ("").

> when pud_index() is actually provided, however it does not take into account
> the __PAGETABLE_PUD_FOLDED case.  Provide kvm_pud_index so that MIPS KVM
> compiles.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
[...]

MBR, Sergei
