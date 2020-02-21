Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 398E6C35646
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 14:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A26C206EF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 14:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VZSFSvky"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728704AbgBUOU3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 09:20:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38874 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728011AbgBUOU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 09:20:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582294828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SoBzR7ZqtKjiFmct3fll5NpKOfUjalkqOXKRmpcWspU=;
        b=VZSFSvky/bkERBNFezM0ug9UgZkYMQeDf9QlZ5DViaPLbYJ84W062qVSHssTTRBziDc+Ew
        skUjF4fR4WPz4WRhJ5nfbMn9yKhHRY0MA0Wv8rV++BzzhtYbuskbOChZWPg/Oel//SC8Ox
        /F22Bd1u2+4Hsr/KbOHhJ5qewpPG1yg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-127-YVBBz6jYNXam4nLV2b_ivg-1; Fri, 21 Feb 2020 09:20:26 -0500
X-MC-Unique: YVBBz6jYNXam4nLV2b_ivg-1
Received: by mail-wr1-f71.google.com with SMTP id r1so1074894wrc.15
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 06:20:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=SoBzR7ZqtKjiFmct3fll5NpKOfUjalkqOXKRmpcWspU=;
        b=LCUkc87lWcpjurwCr05WLGyKEgu7URlbsFI9eelEvxhdwa8D6v+C61H6utarWTmoYl
         7JWrTLuoWdCmbsjFHnYaLV/xkFY0ZI8EyHdXRRPxsQ/w++nZTTDHEFKwJ08e3hgeFmZZ
         6A43dAmTMF1aajKBKekroQ0vsk8xQCQo4EjVOS4wI5jQlSSTlreMT9Nhq5b91gJeXLwi
         IEMvSZzGjQ9G18zuTpyTWRuHVWchoQfFuOgpVy8W5ct1m8Uxa/+NjEyE8sIhA74EG26w
         b1qyJ5Sob4HXB4aipywAJLR+Hor4Ll82wZXYmUQXic0CQdQk4vNWYRGRlXy8g9cChnJQ
         VtEA==
X-Gm-Message-State: APjAAAVypnGNvrY/vs3Wb+rZadixiiXAZH0NBp7kR3wTqSF+6sKFSnT+
        wuTTOBVIYqpjQGB/x22ok4F+WwUYrafM5qd/Fdm+RGVZV3UlkAb7mte9Hi6unja2wIuSzq0DHnf
        x3z2O2aQvfgX5K2/h3oLWoKX5
X-Received: by 2002:adf:e68d:: with SMTP id r13mr48476863wrm.349.1582294825409;
        Fri, 21 Feb 2020 06:20:25 -0800 (PST)
X-Google-Smtp-Source: APXvYqyeALhvpOT47CPYypy+gYe7rOAhcLd8Q3GisyBu9lp+EJJr+DkWBh6I7CXgvgL3PbKUdTP0tg==
X-Received: by 2002:adf:e68d:: with SMTP id r13mr48476740wrm.349.1582294823532;
        Fri, 21 Feb 2020 06:20:23 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id n3sm4158922wmc.27.2020.02.21.06.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 06:20:22 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/61] KVM: x86: Clean up CPUID 0x7 sub-leaf loop
In-Reply-To: <20200201185218.24473-11-sean.j.christopherson@intel.com>
References: <20200201185218.24473-1-sean.j.christopherson@intel.com> <20200201185218.24473-11-sean.j.christopherson@intel.com>
Date:   Fri, 21 Feb 2020 15:20:21 +0100
Message-ID: <87ftf4rpi2.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Refactor the sub-leaf loop for CPUID 0x7 to move the main leaf out of
> said loop.  The emitted code savings is basically a mirage, as the
> handling of the main leaf can easily be split to its own helper to avoid
> code bloat.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/cpuid.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 6e1685a16cca..b626893a11d5 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -573,16 +573,16 @@ static inline int __do_cpuid_func(struct kvm_cpuid_entry2 *entry, u32 function,
>  	case 7: {
>  		int i;
>  
> -		for (i = 0; ; ) {
> +		do_cpuid_7_mask(entry, 0);
> +
> +		for (i = 1; i <= entry->eax; i++) {
> +			if (*nent >= maxnent)
> +				goto out;
> +
> +			do_host_cpuid(&entry[i], function, i);
> +			++*nent;
> +
>  			do_cpuid_7_mask(&entry[i], i);
> -			if (i == entry->eax)
> -				break;
> -			if (*nent >= maxnent)
> -				goto out;
> -
> -			++i;
> -			do_host_cpuid(&entry[i], function, i);
> -			++*nent;
>  		}
>  		break;
>  	}

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

