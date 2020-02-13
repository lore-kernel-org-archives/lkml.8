Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10129C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 17:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D70DF21734
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 17:24:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UiTlu+5u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728745AbgBMRYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 12:24:02 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57316 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728701AbgBMRYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 12:24:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581614640;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wMnTmMYnUeKTqStdF/IUayq9A998cBCRdlJrS4A6/Q0=;
        b=UiTlu+5uVhgG4pZuxGBiJHWD89Ew06s+qQrbBEW3kc3HFukPeo3ho2RMlwcd8lyJDWkdZM
        vit+A/PGJ7uzX5+uhfdZ1CjVZtDtX2DY2FUkSXxfemVHVUCAxn7KH8h3Gj/IMURRQ9/nuf
        43TlLMMQA6wnvj1VjpylLA3ayFfgwy8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-RW8dFjeKMDaZu1sEd-4vLg-1; Thu, 13 Feb 2020 12:23:58 -0500
X-MC-Unique: RW8dFjeKMDaZu1sEd-4vLg-1
Received: by mail-wr1-f71.google.com with SMTP id d8so2614771wrq.12
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 09:23:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wMnTmMYnUeKTqStdF/IUayq9A998cBCRdlJrS4A6/Q0=;
        b=JOI0vy23bs3Twyi2cGb2hOSFfbVDPlq3i81R3/2z4gmzpVgoxWvRklogME21V5JO6T
         aNuFQOneI+PRlRAEkjzxIAcTdjRMZ8XNGWuxNkX8KZEv9QcN04I6T2JVYN2eKmr8VmxO
         QWXpe/llN5bqRDDNJGJizb+/iGN6W/dblskTUMFb0KhGM9ZTJPdCcT+xGE5hjlHG2z9x
         rqWAJmRXwXZwOooKzPTISj8q08f9Q0/XQCPFP12dHiEWmgF7wBtSOHc1VSigEL4sD44V
         yoEURkKZcrXYFDST6vxkv1zoy5u0pCXnmJBIUR77Pq8MhflyrCUZeGKcExufCZvJdeco
         a5Ww==
X-Gm-Message-State: APjAAAWhS8syVLebSadtr/7oClfEcsYHsmtAhv01o7Zb3zmaQqWukbC6
        9O0p+xS0OGwx3nYUGc5AkTcZVROqqoN3bQFSv5rtAiXB7wEQ8lJ9dnDOH2bp2ymRq/tF4CCZRRw
        FngJAQ+5YrXoFIiRuRKQ6AWyX
X-Received: by 2002:a7b:c3d1:: with SMTP id t17mr6785661wmj.27.1581614637321;
        Thu, 13 Feb 2020 09:23:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqxit2af91QRwK+Xcb8iJKb3JILMHhzb3nO4ICHnub3DmetOWujwqeeuimZjBIc7F5KHwTvYgg==
X-Received: by 2002:a7b:c3d1:: with SMTP id t17mr6785636wmj.27.1581614637011;
        Thu, 13 Feb 2020 09:23:57 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:48f0:7b10:ad88:6d83? ([2001:b07:6468:f312:48f0:7b10:ad88:6d83])
        by smtp.gmail.com with ESMTPSA id 5sm3738471wrc.75.2020.02.13.09.23.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2020 09:23:56 -0800 (PST)
Subject: Re: "KVM: x86: enable -Werror" breaks W=1 compilation
To:     Qian Cai <cai@lca.pw>
Cc:     joe@perches.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1581601803.7365.57.camel@lca.pw>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ea7614c3-b917-a646-7e9f-27022062c9d7@redhat.com>
Date:   Thu, 13 Feb 2020 18:23:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1581601803.7365.57.camel@lca.pw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/02/20 14:50, Qian Cai wrote:
> People have been running W=1 to catch additional compilation warnings with an
> expectation that not all of warnings will be fixed, but the linux-next commit
> ead68df94d24 ("KVM: x86: enable -Werror") breaks the build for them.
> 
> arch/x86/kvm/../../../virt/kvm/kvm_main.c:663:12: error: no previous prototype
> for ‘kvm_arch_post_init_vm’ [-Werror=missing-prototypes]
>  int __weak kvm_arch_post_init_vm(struct kvm *kvm)
>             ^~~~~~~~~~~~~~~~~~~~~
> arch/x86/kvm/../../../virt/kvm/kvm_main.c:672:13: error: no previous prototype
> for ‘kvm_arch_pre_destroy_vm’ [-Werror=missing-prototypes]
>  void __weak kvm_arch_pre_destroy_vm(struct kvm *kvm)

Thanks, we already found two bugs, one of them real (it's from
-Wtype-limits).  But I'll leave out this commit for now from the pull
request, of course.

Paolo

