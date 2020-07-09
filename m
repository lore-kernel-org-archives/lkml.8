Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC4EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 18:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BAC62078B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 18:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QDOFoNDf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgGISbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 14:31:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24424 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726193AbgGISbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 14:31:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594319501;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8wPC1KCP3vcodNUQcDNiEe8+jRjBUgztwkFozwc2Ac0=;
        b=QDOFoNDfkagXrySWSf+Vy88ZteF+DBq85ybBp5ZQymrNSRWcFYcBXfHlYgacSrYVUQ7YNd
        GuEo20+jkhLLgtW0JITGUfz05Th1EtJxH+yJdvJLPW79Gm+jK23pjG0BZDJWZSSEfI0rle
        LsQULd2qiG7RhCYq4rPUfBfoN/Xw/N0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-m7T9HUcZNUmTmhgnt4ppzQ-1; Thu, 09 Jul 2020 14:31:40 -0400
X-MC-Unique: m7T9HUcZNUmTmhgnt4ppzQ-1
Received: by mail-wr1-f70.google.com with SMTP id b8so2713874wro.19
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 11:31:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8wPC1KCP3vcodNUQcDNiEe8+jRjBUgztwkFozwc2Ac0=;
        b=mhY8BjOIFJ4x3OfQS+mXvT3D8l04qP99ZxHL9lDDJqodIHcnf1hOBMqFRiag1qvazO
         aksQFBlAyUnXB1eXbyDrQQgHMdqUn0s1ZlExBsAPvmJcx3Ju7piXsoc4Ri0gf8MFptRx
         ++vi8UisngIoJwAnkVTPtLqrcyuvuCKLx0JoeE1QYoTHBWUShi8dgT/lX/cZadEdq4kk
         i+OZS/sGwPpYh+QatXTi8QNTL5+ydDQQNl2h8DSEnA+AmqpnSp17Zb98C6xqi+TPKQH/
         /ohpuzQA6LCTt/HCBZtug8wf0Ayf8IYlEfCg51Br1V8dh2yTXX03TXbvTxMjhwvdaLtQ
         0vrA==
X-Gm-Message-State: AOAM5313SGbWUhhklyHfswMHNCB5OogwdtTS2g/Den33BOzPmtNOf2l8
        90fLWEjxlwJyGql6iZ32g1czbrXxyRkWng4X0Y+oQPpJNeiHM2aYf4e1INK2g/wWNFYOK+pExmZ
        z4lP1b++oZeaoJnlLOiEv8dAc
X-Received: by 2002:a1c:c38a:: with SMTP id t132mr1255795wmf.1.1594319498979;
        Thu, 09 Jul 2020 11:31:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwSZg+9erfbpQ5Y6fhf8LvyCyl8XNa8tXzSYFRcL2WsnIUymBe2DGqS43th0JRX+WyCxaixPw==
X-Received: by 2002:a1c:c38a:: with SMTP id t132mr1255780wmf.1.1594319498789;
        Thu, 09 Jul 2020 11:31:38 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9541:9439:cb0f:89c? ([2001:b07:6468:f312:9541:9439:cb0f:89c])
        by smtp.gmail.com with ESMTPSA id n16sm6537735wrq.39.2020.07.09.11.31.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2020 11:31:38 -0700 (PDT)
Subject: Re: [PATCH] KVM: nSVM: vmentry ignores EFER.LMA and possibly
 RFLAGS.VM
To:     Jim Mattson <jmattson@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Maxim Levitsky <mlevitsk@redhat.com>
References: <20200709095525.907771-1-pbonzini@redhat.com>
 <CALMp9eREY4e7kb22CxReNV83HwR7D_tBkn2i5LUbGLGe_yw5nQ@mail.gmail.com>
 <782fdf92-38f8-c081-9796-5344ab3050d5@redhat.com>
 <CALMp9eRSvdx+UHggLbvFPms3Li2KY-RjZhjGjcQ3=GbSB1YyyA@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <717a1b5d-1bf3-5f72-147a-faccd4611b87@redhat.com>
Date:   Thu, 9 Jul 2020 20:31:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CALMp9eRSvdx+UHggLbvFPms3Li2KY-RjZhjGjcQ3=GbSB1YyyA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/20 20:28, Jim Mattson wrote:
>> That said, the VMCB here is guest memory and it can change under our
>> feet between nested_vmcb_checks and nested_prepare_vmcb_save.  Copying
>> the whole save area is overkill, but we probably should copy at least
>> EFER/CR0/CR3/CR4 in a struct at the beginning of nested_svm_vmrun; this
>> way there'd be no TOC/TOU issues between nested_vmcb_checks and
>> nested_svm_vmrun.  This would also make it easier to reuse the checks in
>> svm_set_nested_state.  Maybe Maxim can look at it while I'm on vacation,
>> as he's eager to do more nSVM stuff. :D
>
> I fear that nested SVM is rife with TOCTTOU issues.

I am pretty sure about that, actually. :)

Another possibility to stomp them in a more efficient manner could be to
rely on the dirty flags, and use them to set up an in-memory copy of the
VMCB.

Paolo

