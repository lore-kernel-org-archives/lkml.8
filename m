Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D809C35E01
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 15:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03AF82176D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 15:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RPxwIDFr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731033AbgBYPMf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 10:12:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21024 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730794AbgBYPMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 10:12:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582643553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n9AuFaGX+OfC1AhBs7I+WP0Y97RXtgeXjaWUzUUvUtc=;
        b=RPxwIDFrqzHguN9z6tUMnlAb93TCAuv1DqN8+JKtPNk8ltXPA7xGN/BcGsItFx7Su240fG
        ltziRip6AFIbP3LVdrdmg1cmS7MLKfzt5tLugw4l/LJ5Sqbk6k/2Or0GnXWr+1S4ZfWOqB
        njYI00KnB+MMUR2K2a59cS5qeMLy+Gg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-J9rh0gnhNlOEPrETzDfCNg-1; Tue, 25 Feb 2020 10:12:31 -0500
X-MC-Unique: J9rh0gnhNlOEPrETzDfCNg-1
Received: by mail-wm1-f72.google.com with SMTP id 7so1143828wmf.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 07:12:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n9AuFaGX+OfC1AhBs7I+WP0Y97RXtgeXjaWUzUUvUtc=;
        b=mRB0JDe2vbWx0/fslkwEVFQgh4wi8F2LH0GcqF9OW7HzKBsfe5nk+QL0HBMQCGSTKf
         8L1rrWxDKJiXODqj1DR1VmTFmwYZBkb1DzjDdAtZ7z376Bm1Nv1BAyW+cVsmozVoW7NK
         j1pR3t3Dmrnb1I9kP9cE1aUS6OYjQCesZavBY7JWZTPW2BswC1rlFDnFP2+mXU5AeYrn
         uDUsciX1CUzh2+dkdqwj7c3dTgWgz6sXK9tTv3aVEs/Y8RIEE7MB/50oXNCc6KzhkNrj
         nZYjJkIotJoprc74Dou7uq23N7NXN+rNux9fsHBpBIkx2Ge+wHNVTbewpWF9qVMDAEx5
         pr6w==
X-Gm-Message-State: APjAAAVIWfLbU5iD+WBnkJ/hhCPGe0Uk6laXxF4/yMkAvDWw/pXpipTD
        +7mXS0bzvyeSi9TkZU8e5D2+IK8HMYCtrWE5rps6iZyCR1PIV3tiS8AL5XIRpGC7DCsK9L4Hhsh
        jeRBi2zgDLlnz7SsM8spLvHuH
X-Received: by 2002:a1c:4c8:: with SMTP id 191mr5689497wme.148.1582643550167;
        Tue, 25 Feb 2020 07:12:30 -0800 (PST)
X-Google-Smtp-Source: APXvYqyPmXEjpuSQxnI4Q0UL9dt+lV+yrzN5FG9QIOg/h6vSPdSjGw8Qc+qU8/RjoS3W49r/+7syWQ==
X-Received: by 2002:a1c:4c8:: with SMTP id 191mr5689424wme.148.1582643548994;
        Tue, 25 Feb 2020 07:12:28 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:3577:1cfe:d98a:5fb6? ([2001:b07:6468:f312:3577:1cfe:d98a:5fb6])
        by smtp.gmail.com with ESMTPSA id f1sm24558217wro.85.2020.02.25.07.12.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2020 07:12:28 -0800 (PST)
Subject: Re: [PATCH 43/61] KVM: x86: Use KVM cpu caps to mark CR4.LA57 as
 not-reserved
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200201185218.24473-1-sean.j.christopherson@intel.com>
 <20200201185218.24473-44-sean.j.christopherson@intel.com>
 <8736azocyp.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <66467dd7-09f0-7975-5c4e-c0404d779d8d@redhat.com>
Date:   Tue, 25 Feb 2020 16:12:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <8736azocyp.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/02/20 23:08, Vitaly Kuznetsov wrote:
>> +
>> +static __always_inline bool kvm_cpu_cap_has(unsigned x86_feature)
>> +{
>> +	return kvm_cpu_cap_get(x86_feature);
>> +}
> I know this works (and I even checked C99 to make sure that it works not
> by accident) but I have to admit that explicit '!!' conversion to bool
> always makes me feel safer :-)

Same here, I don't really like the automagic bool behavior...

Paolo

