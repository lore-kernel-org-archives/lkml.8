Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46652C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 12:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D987206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 12:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EBZG0FZn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbgFHMvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 08:51:25 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28471 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728007AbgFHMvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 08:51:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591620681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NVMeqLaZj5lyXYDnWx/hOG/1m/ddxwQgh2GukSpwT7M=;
        b=EBZG0FZnhii4SzWsAn7JuZPxiddtEkA1kagbpkd8f1vvUULIdwCkzYug4dPhrp9w/7Dqqa
        QfYdrezc5n2Zms4W4FFt9ainiVlDpZlCNfCGyH9NXGXVUvYcSegqKSnXYOgJJCcg4sU34i
        G9Crda2O3sgTTqujcYejoG8pnOmAL4g=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-6do5kTHKP92CdjjlpjiwCQ-1; Mon, 08 Jun 2020 08:51:20 -0400
X-MC-Unique: 6do5kTHKP92CdjjlpjiwCQ-1
Received: by mail-ej1-f71.google.com with SMTP id m22so6060233ejn.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 05:51:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=NVMeqLaZj5lyXYDnWx/hOG/1m/ddxwQgh2GukSpwT7M=;
        b=WGTYIEWqPSc5YczSg8SbkJdX/dIIBveT/6q7s3kjZrEmL5X6FU4BtwMkEkNqWChW2c
         O8loglfaQ5bNgleLTscAK2AWXiq8P7s60vFWqryTUMOFxbxbBHXqWPVDCw+9I5cb9/DZ
         Ju9HclwWzLKXtBdllk/iHGvGX1ifXDhWp1SfmMnbLceFe3p8IwXs/ry7V4N1DcLngHAX
         q4RkctzbyxkhY1vhShDBB6VFOHWkNj5aFPt3Xf0NdiaQfPLkP9padjLYZLOVHG+gYHJO
         q8ynvsBT64w/W3UPt1aV7LVnCvovK7XCOIPxXpmQD2PGMzVCVFHASXAK8/leqFJOdYJD
         4c8Q==
X-Gm-Message-State: AOAM531Ev3Lq/Bw0183QHUqJNG7NakV7y0f5m9Wht0XlMwXUNcWnNL7J
        slVwdekwbLxQD4klLntxRE7i9yxcuTOkWxa3AYqeEtx6XsDuu8bImgxWI8zAT/dvO76WWWZ6IZo
        rsZRPzqrQZ1w7B3lBsmeER2RH
X-Received: by 2002:a17:906:5c0a:: with SMTP id e10mr6274850ejq.389.1591620678814;
        Mon, 08 Jun 2020 05:51:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwwznb3Q7pGSNhjg8K3PzgwiJgh47LL1CoCkfvLhLC73i7kpFcsGfbIbjtXZtfhoqoraDN5Qg==
X-Received: by 2002:a17:906:5c0a:: with SMTP id e10mr6274841ejq.389.1591620678637;
        Mon, 08 Jun 2020 05:51:18 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id ok21sm9905881ejb.82.2020.06.08.05.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 05:51:18 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Qian Cai <cai@lca.pw>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH] KVM: SVM: fix calls to is_intercept
In-Reply-To: <20200608121428.9214-1-pbonzini@redhat.com>
References: <20200608121428.9214-1-pbonzini@redhat.com>
Date:   Mon, 08 Jun 2020 14:51:17 +0200
Message-ID: <87wo4hbu0q.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> is_intercept takes an INTERCEPT_* constant, not SVM_EXIT_*; because
> of this, the compiler was removing the body of the conditionals,
> as if is_intercept returned 0.
>
> This unveils a latent bug: when clearing the VINTR intercept,
> int_ctl must also be changed in the L1 VMCB (svm->nested.hsave),
> just like the intercept itself is also changed in the L1 VMCB.
> Otherwise V_IRQ remains set and, due to the VINTR intercept being clear,
> we get a spurious injection of a vector 0 interrupt on the next
> L2->L1 vmexit.
>
> Reported-by: Qian Cai <cai@lca.pw>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
> 	Vitaly, can you give this a shot with Hyper-V?  I have already
> 	placed it on kvm/queue, it passes both svm.flat and KVM-on-KVM
> 	smoke tests.

Quickly smoke-tested this with WS2016/2019 BIOS/UEFI and the patch
doesn't seem to break anything. I'm having issues trying to launch a
Gen2 (UEFI) VM in Hyper-V (Gen1 works OK) but the behavior looks exactly
the same pre- and post-patch.

-- 
Vitaly

