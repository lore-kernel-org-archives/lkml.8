Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A88BC3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 14:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F8DC20732
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 14:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QLAkZEDC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbgCEO20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 09:28:26 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46504 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726087AbgCEO20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 09:28:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583418504;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DwSWf5gcDIK8rHvZ3dTTXzEwGyOQdSLUTzEqTud8Y4Y=;
        b=QLAkZEDCqZay/5A5WgJIs/PmyaV9ScV6B3PGVV4SSeljBC7GM9Kjfr2cnm9C5otdQScT0y
        rOMG7kJYQCk2tHVUJlA97c5i0t9jJOJRbP0I9pCKcPIj22YCqoXjo6usxzxQIljgvfK59z
        i3Fp+2nF4E1MsiQntD802X3ifFN0sWM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-_AXYxjWMMK-fZSL6gHXx-w-1; Thu, 05 Mar 2020 09:28:22 -0500
X-MC-Unique: _AXYxjWMMK-fZSL6gHXx-w-1
Received: by mail-wr1-f72.google.com with SMTP id o9so2375364wrw.14
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 06:28:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DwSWf5gcDIK8rHvZ3dTTXzEwGyOQdSLUTzEqTud8Y4Y=;
        b=og+9ZXIi0nTvheNr5QbQiVBLhidQjwYJKar83IcwEkvlBdYFDYEZNAopb1INkH3vFb
         h4XAfY85xeQc5NQHXQRiGTOS/9yaHG5MqFBgleXF3mhVPx+6zuaz6BOL8UorWcPsNkqv
         /HjSbRNvz8X6IeZN309jrQdkW8fmW4YRyXBHJDYD6+Z125HBDqHzY6WuvZRzjf/qkkJ2
         BV7bEP/xYJ2FIZMoadgudVZcYTZGkPRPGr93qekuC22OREV5SJM4d3Xatw1kGOUNouA+
         GZCJq3W5kurIAw0KKJxWN1WCiY6bd9UvOuV/VZ1vR77G/LqzXpznnzV4vb/y96zxgYMP
         WoIw==
X-Gm-Message-State: ANhLgQ20c2qg/eHRDg4hQWLQwCoQWeR1U2Rwr/UZBXRoZ+CSkLNN8xEg
        9TsLnwHRMm49k9QpNT7hil7+DzhvqfxIXytkCh9leDMJR5KJaeyC+rp3Oqo3HBVKdPdGxDKl6gu
        5+2lJfnD+1exRfaw/GOX3XW7M
X-Received: by 2002:a1c:20c6:: with SMTP id g189mr10305395wmg.163.1583418501561;
        Thu, 05 Mar 2020 06:28:21 -0800 (PST)
X-Google-Smtp-Source: ADFU+vs/bJEaaJUnyfNbv5KieLHoHhabXSJtVqhoXbEBlrF2s+MLkXrwZ0CSseLMTlczfe9ACLb8mQ==
X-Received: by 2002:a1c:20c6:: with SMTP id g189mr10305356wmg.163.1583418501078;
        Thu, 05 Mar 2020 06:28:21 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:9def:34a0:b68d:9993? ([2001:b07:6468:f312:9def:34a0:b68d:9993])
        by smtp.gmail.com with ESMTPSA id t131sm299663wmf.19.2020.03.05.06.28.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2020 06:28:20 -0800 (PST)
Subject: Re: [PATCH v2] KVM: fix Kconfig menu text for -Werror
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, sean.j.christopherson@intel.com
References: <20200304190750.GF21662@linux.intel.com>
 <20200305060604.8076-1-Jason@zx2c4.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e716d8e4-4cda-0c0c-ebf3-f32a2c2870ae@redhat.com>
Date:   Thu, 5 Mar 2020 15:28:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200305060604.8076-1-Jason@zx2c4.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/03/20 07:06, Jason A. Donenfeld wrote:
> This was evidently copy and pasted from the i915 driver, but the text
> wasn't updated.
> 
> Fixes: 4f337faf1c55 ("KVM: allow disabling -Werror")
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  arch/x86/kvm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
> index 1bb4927030af..9fea0757db92 100644
> --- a/arch/x86/kvm/Kconfig
> +++ b/arch/x86/kvm/Kconfig
> @@ -68,7 +68,7 @@ config KVM_WERROR
>  	depends on (X86_64 && !KASAN) || !COMPILE_TEST
>  	depends on EXPERT
>  	help
> -	  Add -Werror to the build flags for (and only for) i915.ko.
> +	  Add -Werror to the build flags for KVM.
>  
>  	  If in doubt, say "N".
>  
> 

Queued, thanks.

Paolo

