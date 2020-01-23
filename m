Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB3BC33CAA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 08:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 028EE21734
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 08:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M1nx35rY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbgAWIzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 03:55:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54867 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725785AbgAWIzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 03:55:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579769749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Zk983o09Ptf4EhRmMF4WXJnJTt4L7VbNZwtev+QYBaI=;
        b=M1nx35rYQNnIzzYOvPGXUPgwYUXfz+WS4bh7uYbMxVDlAmshsldwJwH5OcNF3J9KlK0FrS
        QLC4+mOdurhC5YhR9pRajs6VfFMeFFbHBF5eNNOgPK90TZzKPlQxNdExUiC49Sz58VEtlP
        Ermqxn1VJQu2tjE13cXy+2ubOnsTFwU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-5X-cez6MPMS_tqKhQd6eSw-1; Thu, 23 Jan 2020 03:55:48 -0500
X-MC-Unique: 5X-cez6MPMS_tqKhQd6eSw-1
Received: by mail-wr1-f69.google.com with SMTP id z10so1382136wrt.21
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 00:55:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Zk983o09Ptf4EhRmMF4WXJnJTt4L7VbNZwtev+QYBaI=;
        b=kOc3uFFdKsLa2x5y0ovyEHHBhG1y1b8PBhuIbyTq/ZgpLG6DyCEeICNBqbnlMb8CtP
         5KYsOz+n+oaslcY3DuwCyhW281M2PAXAnZNN4CVfkwMm/QzLTFvXnApAMOB7FFZ9MwKA
         8iXuUi4TBGEbJ9hCVq9EcpjUNyI2dnEc7rGjMQ3YbrC8mvuZKSn0wtCOJLy5xGiL+p3c
         Riza+WNfo05UXZ81C+EJ7C2bU/BAyx3mzw5Aq/l/5Y9MZBtU7R1nzesu8nizpqJoCAuM
         f1uZcSeGF5d+gYMDCBfRBpfIf3XuZoFiIy24KOJE5jTUvbjaXmVeSlfkJBivh0AZEYTv
         71DA==
X-Gm-Message-State: APjAAAXwxdM8qgwn3vb8jjOLm05F+rfBrLM2rROq0wkeXNFtubtqu+7g
        w1P3mws8owqjZI0wvyIJqF9ZExpRpohQTuh806I6X8WPXpHKh7Wj06+U/nXynTxJGLZBoJTbv5G
        /R5MBfYXlA0uHP5Fd5te7+0hJ
X-Received: by 2002:adf:ef4e:: with SMTP id c14mr16424022wrp.142.1579769747114;
        Thu, 23 Jan 2020 00:55:47 -0800 (PST)
X-Google-Smtp-Source: APXvYqwnuRG5Gyj3liW/33dXUeXlqykkdo4u0Q5K5x2W7UXL4cqcNjhOB7QGvEAUrNPuajc7OkoP3g==
X-Received: by 2002:adf:ef4e:: with SMTP id c14mr16423996wrp.142.1579769746853;
        Thu, 23 Jan 2020 00:55:46 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id o2sm1258790wmh.46.2020.01.23.00.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 00:55:46 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     linmiaohe <linmiaohe@huawei.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com,
        sean.j.christopherson@intel.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Subject: Re: [PATCH] KVM: nVMX: set rflags to specify success in handle_invvpid() default case
In-Reply-To: <1579749241-712-1-git-send-email-linmiaohe@huawei.com>
References: <1579749241-712-1-git-send-email-linmiaohe@huawei.com>
Date:   Thu, 23 Jan 2020 09:55:44 +0100
Message-ID: <8736c6sga7.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

linmiaohe <linmiaohe@huawei.com> writes:

> From: Miaohe Lin <linmiaohe@huawei.com>
>
> In handle_invvpid() default case, we just skip emulated instruction and
> forget to set rflags to specify success. This would result in indefinite
> rflags value and thus indeterminate return value for guest.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
> 	Chinese New Year is coming. Happy Spring Festival! ^_^

Happy Spring Festival!

> ---
>  arch/x86/kvm/vmx/nested.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 7608924ee8c1..985d3307ec56 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -5165,7 +5165,7 @@ static int handle_invvpid(struct kvm_vcpu *vcpu)
>  		break;
>  	default:
>  		WARN_ON_ONCE(1);
> -		return kvm_skip_emulated_instruction(vcpu);
> +		break;
>  	}
>  
>  	return nested_vmx_succeed(vcpu);

Your patch seems to do the right thing, however, I started wondering if
WARN_ON_ONCE() is the right thing to do. SDM says that "If an
unsupported INVVPID type is specified, the instruction fails." and this
is similar to INVEPT and I decided to check what handle_invept()
does. Well, it does BUG_ON(). 

Are we doing the right thing in any of these cases?

-- 
Vitaly

