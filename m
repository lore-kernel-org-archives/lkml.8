Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 518E6C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2805C21473
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:22:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RXbEXwFV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbgEGSW2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 14:22:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34006 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728088AbgEGSW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 14:22:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588875747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uY7dbQBmsUoAzmKGSYRJNZ21+7owwaWmUZw/eXb9gjM=;
        b=RXbEXwFVZFySAUDYOl6RWsRj9l/YzMEskoJIODEjTrYt/I6wtUI5YPOV9Sw/NhlGStXXkF
        OfN72maKFpvF4GtVnbAEsFJaaIERlIltMV/JsCTRn5C2FTBMH7Gwn9AKJC5LkYkvY0Hq2J
        kSUG3P40nlC7Alz2xncaSrL6KvwmzTs=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-pe1UKnxIMry0FDjlwFavzA-1; Thu, 07 May 2020 14:22:23 -0400
X-MC-Unique: pe1UKnxIMry0FDjlwFavzA-1
Received: by mail-qt1-f197.google.com with SMTP id v18so7718579qtq.22
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 11:22:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uY7dbQBmsUoAzmKGSYRJNZ21+7owwaWmUZw/eXb9gjM=;
        b=Q1ULsw2GMNRtsvFOu5chBrPYZOpjY3+E6dd56vQzUTjxRsnYuT1pcngwA78Z/ztHpX
         6dlKSOS7yIr9BxRFEgW/6uKTiigkjn7Oe6akkf8ULWFSk/hXX2E2Mmp9+vdAMYoBUe4F
         sbkc8VHCe8m+piKQrs/6JMz2CRQdFwOxhr+ziYc0vRMWc4QyEEaTUH14QMWd8jS6zPBO
         rm60VHLZGTyYN0lRYFLQVnwMJYvLpciN7zUtKIIeB5yM9QYOG9+gXO2ixUPrQIXkFuZK
         UYJiQIVJcd5DV6EimrLuC9vYux2BQrHt6adhnTVGMvH7a9kH6SlWs+YmcGGw9fSgn5cx
         GQRg==
X-Gm-Message-State: AGi0PuYhIqqr46UbqPzGvJOQZH53iSqlPHNSaGsPIUTaBBEPrYLvr03E
        m98QjEM9rr/Kditv6bMCxSZxL5GmxCje0VBAuXTp/MAR65OI4+ScmdPZ2FqUTbIbPBZm5T0CkIz
        GIH7JgxrqahPYmtumh4OpLdMx
X-Received: by 2002:a05:620a:3c5:: with SMTP id r5mr16131928qkm.138.1588875742718;
        Thu, 07 May 2020 11:22:22 -0700 (PDT)
X-Google-Smtp-Source: APiQypJtNBFACRv+C675BBmb3U5pDjlBVo0aQUE1Kz2y73CScdi8+R9TWP79HmHhMhLl2mdB+odeyQ==
X-Received: by 2002:a05:620a:3c5:: with SMTP id r5mr16131906qkm.138.1588875742430;
        Thu, 07 May 2020 11:22:22 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id y3sm4857000qkc.4.2020.05.07.11.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 11:22:21 -0700 (PDT)
Date:   Thu, 7 May 2020 14:22:20 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v2 7/9] KVM: SVM: keep DR6 synchronized with
 vcpu->arch.dr6
Message-ID: <20200507182220.GI228260@xz-x1>
References: <20200507115011.494562-1-pbonzini@redhat.com>
 <20200507115011.494562-8-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200507115011.494562-8-pbonzini@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 07:50:09AM -0400, Paolo Bonzini wrote:
> @@ -267,7 +268,7 @@ void enter_svm_guest_mode(struct vcpu_svm *svm, u64 vmcb_gpa,
>  	svm->vmcb->save.rsp = nested_vmcb->save.rsp;
>  	svm->vmcb->save.rip = nested_vmcb->save.rip;
>  	svm->vmcb->save.dr7 = nested_vmcb->save.dr7;
> -	svm->vmcb->save.dr6 = nested_vmcb->save.dr6;
> +	svm->vcpu.arch.dr6  = nested_vmcb->save.dr6;

The rest looks very sane to me, but here I failed to figure out how arch.dr6
finally applied to save.dr6.  I saw it is applied in svm_vcpu_run() in the next
patch, but if that's the case then iiuc this commit may break bisection. Thanks,

-- 
Peter Xu

