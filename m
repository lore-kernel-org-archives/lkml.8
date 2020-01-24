Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE3C2C2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 08:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC76A2071A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 08:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EHaaj6Lb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729431AbgAXIWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 03:22:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36300 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726080AbgAXIWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 03:22:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579854138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JkbP5+LvgNJD8LbEa+fzcqZQFolNmASwwPkutJLSYdg=;
        b=EHaaj6LbA+0i6IiSVPTinUeySBOgXYGrn17VliLPjIGNA/j3aX5kboNY+hzzlfIS0SYl3H
        awaza8NGagWwmc9FPeNTI0BoI70yXtol3NhgDgBYYFu3sGI5nQOeR7vePYgSr5/7vyh00H
        wBCDvRyfCXCAUIFyNv0hyKfcT6JbyOA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-FbDlC6O8MY2Rw4M2qts25Q-1; Fri, 24 Jan 2020 03:22:16 -0500
X-MC-Unique: FbDlC6O8MY2Rw4M2qts25Q-1
Received: by mail-wm1-f71.google.com with SMTP id m21so366418wmg.6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 00:22:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JkbP5+LvgNJD8LbEa+fzcqZQFolNmASwwPkutJLSYdg=;
        b=UXCuMKcfqeZci8rPL+dRuiQck6QrojHvv/IUYzmIdyzzZ5GJfb1o1ZgV9Lrwt5b3DP
         aaNf2XXiX/7wroZHRBt66thi7fcxVbldjcK1K6P7ZIck3hMd+eU5z4iMZZgL+X2ALFU3
         SYQz1GF3HnszDQ32vXAEwRbnE/1BF6WSRVbt1uadm3pZiKjdYP/qha/rZMVZcbbg5ckS
         dO6wy76jXlwBcJ7ea3NOwhpwX6jbJ8o3sVnMfJWoPfUrEazHr3XK8UxepUsaqGjZwoJU
         CZjOBzcHcZ0eDmgz3DyHDQoBtCPtu/eDwi7O6472QrWqUjoNQ40JuHdAPNRhll5tNBQW
         iuWg==
X-Gm-Message-State: APjAAAUGLaf34sO7ubaxUJBitHOCAdCyNBo7iNW6cw132KHJ7+0kPiQQ
        oGd+5ig/MRa6TR39VS2YyjQfoa8fkq5oEEyurI5bV/nDE0KuXRVzI4UDzQFCujroqzxWRb+sgs6
        Aa/fnKXHfCW7Yy886pRsoqziV
X-Received: by 2002:a5d:6ca1:: with SMTP id a1mr2789748wra.36.1579854135490;
        Fri, 24 Jan 2020 00:22:15 -0800 (PST)
X-Google-Smtp-Source: APXvYqz10DrEvjEBKBDFT9OrSLCpjfy0GI6NWMPczTFepONKfqG3vqBFEl4fBzoVAQY9ySVL6vc6gg==
X-Received: by 2002:a5d:6ca1:: with SMTP id a1mr2789723wra.36.1579854135210;
        Fri, 24 Jan 2020 00:22:15 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:b8fe:679e:87eb:c059? ([2001:b07:6468:f312:b8fe:679e:87eb:c059])
        by smtp.gmail.com with ESMTPSA id u16sm5672516wmj.41.2020.01.24.00.22.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2020 00:22:14 -0800 (PST)
Subject: Re: [PATCH] KVM: x86: avoid incorrect writes to host
 MSR_IA32_SPEC_CTRL
To:     Xiaoyao Li <xiaoyao.li@intel.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Jim Mattson <jmattson@redhat.com>
References: <1579614487-44583-3-git-send-email-pbonzini@redhat.com>
 <8b960dfe-620b-b649-d377-e5bb1556bb48@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6b725990-f0c2-6577-be7e-44e101e540b5@redhat.com>
Date:   Fri, 24 Jan 2020 09:22:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <8b960dfe-620b-b649-d377-e5bb1556bb48@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/01/20 09:00, Xiaoyao Li wrote:
>>
>>   +bool kvm_spec_ctrl_valid_bits(struct kvm_vcpu *vcpu)
> 
> The return type should be u64.

Ugh... Thanks.

Paolo

