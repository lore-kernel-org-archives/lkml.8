Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA82C35657
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 16:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 249BF208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 16:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EMEkTU0q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbgBUQ6R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 11:58:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27830 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726150AbgBUQ6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 11:58:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582304294;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p7XbHrCaOSwrBpqaeeYKNxlSBdnjl6OZnbi6u5hXQjU=;
        b=EMEkTU0qiWe9uQdLUD+MoUPIklGzc2E5g1LhnD33o0lljD1Ecq/nJIfS+iXkhOPGLdfCUx
        ATzbZqv9WdYYSo3BW+zp2kKdPtJ5SOLlQwk4nrWag8CDYeAz/yahqOS2DQORT/j3ZYcFFb
        l6vhQyu1YzML7926LYX7W8QM+r8E/bg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-OjTbVB6iM-2wZJAt4nmYmA-1; Fri, 21 Feb 2020 11:58:08 -0500
X-MC-Unique: OjTbVB6iM-2wZJAt4nmYmA-1
Received: by mail-wm1-f69.google.com with SMTP id b8so2055116wmj.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 08:58:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p7XbHrCaOSwrBpqaeeYKNxlSBdnjl6OZnbi6u5hXQjU=;
        b=UcpE4fpEWe5f5mBSxGZBb/hoSl0JA/I4ihp1BnwZwKxBD83pMEt/jBrSsLfB5s4hP7
         J0kpdKD+oXHEdwFZl6+yxB4Fb9Ojv4SGlaW03XrpSxR4GjfjmPUJXxVDaJoKUWOeaEoY
         c2qsiABRTKdWPbbRlju3PW+/XxZsNGsORmM00gig7/NqBCptidjnuPkgYo+BD69pifp9
         L7WPaH+j2udfcDltSeaz1gJNkXFRirN6zfZteyXVMblM3AYaSx+U24XSV/0C9Yi96Gio
         EgOqSaovwW1FuQiGurFVcOexm9zjl6HCrwKYZ5b5ZeL3gACL3i4qpuJSVqdc59WdQSDd
         90kg==
X-Gm-Message-State: APjAAAVKvu8Mv1KKUoIDU6DDRGM24a8crX85o57P4ZsrfI6UuZWGqn5g
        ItX94tGcDH7FGeGbXPQ+cslx+lVb0Ezd9gpe89zp3JB70iZcV9LBMXdOAShLS1UI83wgCqx3G9Z
        clN5ICfvtk0E6XQ6pBDo7uuhi
X-Received: by 2002:a1c:6a16:: with SMTP id f22mr4689108wmc.53.1582304286616;
        Fri, 21 Feb 2020 08:58:06 -0800 (PST)
X-Google-Smtp-Source: APXvYqzx8SYVdFspf+9GbrjK1CHBzdPkEu/p7HgFD9HSQD4u8DmNh/L0Ceyu9qjuA96m3QzgfpFyXA==
X-Received: by 2002:a1c:6a16:: with SMTP id f22mr4689097wmc.53.1582304286341;
        Fri, 21 Feb 2020 08:58:06 -0800 (PST)
Received: from [192.168.178.40] ([151.20.135.128])
        by smtp.gmail.com with ESMTPSA id h205sm4700577wmf.25.2020.02.21.08.58.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2020 08:58:05 -0800 (PST)
Subject: Re: [PATCH][resend] KVM: fix error handling in svm_cpu_init
To:     linmiaohe <linmiaohe@huawei.com>,
        "Li,Rongqing" <lirongqing@baidu.com>
Cc:     Liran Alon <liran.alon@oracle.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>
References: <b7a41c2ec0e644119180ba61d10ab4b9@huawei.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e77238c5-94a6-0695-b49a-6ce6f4ccab70@redhat.com>
Date:   Fri, 21 Feb 2020 17:58:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <b7a41c2ec0e644119180ba61d10ab4b9@huawei.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/02/20 09:40, linmiaohe wrote:
> Li,Rongqing <lirongqing@baidu.com> writes:
>>> Hi,
>>> Li RongQing <lirongqing@baidu.com> writes:
>>>>
>>>> sd->save_area should be freed in error path
>>> Oh, it's strange. This is already fixed in my previous patch : [PATCH v2] KVM:
>>> SVM: Fix potential memory leak in svm_cpu_init().
>>> And Vitaly and Liran gave me Reviewed-by tags and Paolo queued it one 
>>> month ago. But I can't found it in master or queue branch. There might 
>>> be something wrong. :(
>>
>> In fact, I send this patch 2019/02/, and get Reviewed-by,  but did not queue
>>
>> https://patchwork.kernel.org/patch/10853973/
>>
>> and resend it 2019/07
>>
>> https://patchwork.kernel.org/patch/11032081/
>>
> 
> Oh, it's really a pit. And in this case, we can get rid of the var r as '-ENOMEM' is actually the only possible outcome here, as
> suggested by Vitaly, which looks like this: https://lkml.org/lkml/2020/1/15/933

I queued your patch again, sorry to both of you.

Paolo

