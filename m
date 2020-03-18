Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C53C5ACD8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 14:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9E7820714
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 14:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KxMvDqah"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbgCROx0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 10:53:26 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:52067 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726638AbgCROx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 10:53:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584543205;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8WKtJ0NoeW5X7Z6TZZcRE25TjkVLqGWMqe9mT+XKLH4=;
        b=KxMvDqaho/8gR34f2Z0QSgoB7Xg14MwS+Tm/IArEN3oeHdOmCUHFZ3cCqwCcSErL6Nf9cJ
        L/Kbv/lo6425+j37wDzlGxXTyjy8bwhGYgxSoZDACm14FxHvpaovMBmOUBGHnjUG0WSCWK
        wQ0JnLKYgz+Dfgv83U9bfNXEytZQNPc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-A0-5DACsPqqLYNW4_G35cg-1; Wed, 18 Mar 2020 10:53:22 -0400
X-MC-Unique: A0-5DACsPqqLYNW4_G35cg-1
Received: by mail-wr1-f70.google.com with SMTP id d17so676233wrw.19
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 07:53:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=8WKtJ0NoeW5X7Z6TZZcRE25TjkVLqGWMqe9mT+XKLH4=;
        b=SViTuiScot+ZGIifvVKD/HkWPdLml51pYCWTdLpw5VnE4AyrUkOzlc1CtIRnqOdym0
         a9aT5RnlwXzUkdsqe/fXE9GYeXJOP5+7UI9ksyCtKAQcYYz5fXOd7o/cpPAdXn/Z053M
         q9j91wO30+IkSp2eLd650Zm8i3xi2htGGwEL9Z8Hs1LA8JykxHuARBDZgJzdRrchOGvx
         Gngu1+3j3Pw4pdxmdbJxZ0G5nNSZAs7OuNpUV0sbi7+cnbVG0tft9sDGf0tCnwu4hLF+
         5dbudRKVpyonfziKS9M25HQ3FRs3LvsaYWqMWlBEyGcemevTp7faktTEzegQbnZEQTUG
         0C6Q==
X-Gm-Message-State: ANhLgQ3pcqk3v3vQkaZJdGZPEyKr6Sh48SrBZR3kKDAIVq/DGo7SFXBE
        vEkuXZSQGablr3U/ILb6z1XRk7xO1C0Zd5xrkxsWkOGTbNNrQSXWyWwHtvsBsAEMI72NDin2XFb
        10hLpxvI7fREOQHhW7TGciRWb
X-Received: by 2002:a1c:2701:: with SMTP id n1mr5686045wmn.180.1584543201132;
        Wed, 18 Mar 2020 07:53:21 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsEFavcmZ92zPR5GFapmD2k6UNbKOWgwr1iImA3etdVN9BHmNhPJHNXPkEEJZIZmcDqYJmUaA==
X-Received: by 2002:a1c:2701:: with SMTP id n1mr5686021wmn.180.1584543200952;
        Wed, 18 Mar 2020 07:53:20 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id q10sm9326043wrx.12.2020.03.18.07.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 07:53:20 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH] KVM: nSVM: check for EFER.SVME=1 before entering guest
In-Reply-To: <1584535300-6571-1-git-send-email-pbonzini@redhat.com>
References: <1584535300-6571-1-git-send-email-pbonzini@redhat.com>
Date:   Wed, 18 Mar 2020 15:53:19 +0100
Message-ID: <877dzh3eao.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> EFER is set for L2 using svm_set_efer, which hardcodes EFER_SVME to 1 and hides
> an incorrect value for EFER.SVME in the L1 VMCB.  Perform the check manually
> to detect invalid guest state.
>
> Reported-by: Krish Sadhukhan <krish.sadhukhan@oracle.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  arch/x86/kvm/svm.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> index 08568ae9f7a1..2125c6ae5951 100644
> --- a/arch/x86/kvm/svm.c
> +++ b/arch/x86/kvm/svm.c
> @@ -3558,6 +3558,9 @@ static bool nested_svm_vmrun_msrpm(struct vcpu_svm *svm)
>  
>  static bool nested_vmcb_checks(struct vmcb *vmcb)
>  {
> +	if ((vmcb->save.efer & EFER_SVME) == 0)
> +		return false;
> +
>  	if ((vmcb->control.intercept & (1ULL << INTERCEPT_VMRUN)) == 0)
>  		return false;

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

