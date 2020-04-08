Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADCC2C2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 11:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C0B720747
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 11:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RoRVKKv8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728502AbgDHLeC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 07:34:02 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54358 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727902AbgDHLeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 07:34:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586345641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iMpv1Tcf8msq6CIz6hAZaaOwWt8dkcRjoWBRfrYNwKk=;
        b=RoRVKKv8OqqSmOdsNBjN+SXCfrC6dR9pT5+lcHua/Ex+qQDyNWTC0wvqN/+IE349BXb7rJ
        DCBWeZFn9iUKNIQDUzuUtaAMAA6z9vlh4Ms9L0viXFQDWQe+SJ8B+CXWwQ2YaPz53qEI2N
        eXIJPskYhxi9bTFUGZ8VFpj3Vk0JCfc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-50-LJQTftwPM5KjlQlkob7pvg-1; Wed, 08 Apr 2020 07:33:59 -0400
X-MC-Unique: LJQTftwPM5KjlQlkob7pvg-1
Received: by mail-wr1-f70.google.com with SMTP id o10so3805931wrj.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 04:33:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iMpv1Tcf8msq6CIz6hAZaaOwWt8dkcRjoWBRfrYNwKk=;
        b=DKmvBigkuLlNTY9IiGSUMqteaEQvjm73c8KR3NGQarPZKzDS0MKWab3Wv0VBu2tZsp
         7xp3ldWCPKlBsqQ6ghs8ufH+0wi6DRsqgnrsIzVUr0+G4ckinUMemGKlRcVWJ7Zptz4B
         tkno2xTtzqHZitf3TAz4xQLP7IZW4XcI+ZmNqAMw3qogO7F0CTV5Bes5xFUSya/ngVxW
         ckYvPWoR+7DhC3ZsBoDf0dehonJOUG4f8vjqHMaakMULXVsypeTLEPoA36hK6GyKdNbv
         LO7fQ2BK7yiEKerCxXYlj/8gZvQlvAIM9I8Ta66yYSoNibvdFfZjaMQW2lTJv7lIqZfE
         YlOg==
X-Gm-Message-State: AGi0PuYtRw0kqJfKOLObF6hJGq3hoGlLtbBWkpY39GUgjfbI/cAushlX
        +H1olVt1dFcfQ0MqZWAePPJ9UeQUCT4G+cLZ34HHkLt+3lEiO22zfSPH3UF/xu5qUP9BiDrmpYu
        WNZegaCfPw85wRo7pJDTUS74L
X-Received: by 2002:a1c:3281:: with SMTP id y123mr4239285wmy.30.1586345637884;
        Wed, 08 Apr 2020 04:33:57 -0700 (PDT)
X-Google-Smtp-Source: APiQypLT538fz8uSoawd2IFWIE2g4SRUOixPL/PauE1AvjtumpV89MF+Ihgn7usDfr2aRZ/BhKLoLQ==
X-Received: by 2002:a1c:3281:: with SMTP id y123mr4239265wmy.30.1586345637681;
        Wed, 08 Apr 2020 04:33:57 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
        by smtp.gmail.com with ESMTPSA id f63sm3148639wma.47.2020.04.08.04.33.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2020 04:33:57 -0700 (PDT)
Subject: Re: [PATCH 2/2] KVM: s390: Return last valid slot if approx index is
 out-of-bounds
To:     Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+d889b59b2bb87d4047a2@syzkaller.appspotmail.com
References: <20200408064059.8957-1-sean.j.christopherson@intel.com>
 <20200408064059.8957-3-sean.j.christopherson@intel.com>
 <20200408122138.71493308@p-imbrenda>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <40b325c7-ca24-3513-b2fa-1e9397c9e353@redhat.com>
Date:   Wed, 8 Apr 2020 13:33:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200408122138.71493308@p-imbrenda>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/04/20 12:21, Claudio Imbrenda wrote:
> on s390 memory always starts at 0; you can't even boot a system missing
> the first pages of physical memory, so this means this situation would
> never happen in practice. 
> 
> of course, a malicious userspace program could create an (unbootable) VM
> and trigger this bug, so the patch itself makes sense.
> 
> Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

What about using KVM just for isolation and not just to run a full-blown
OS (that is, you might even only have the guest run in problem state)?
Would that be feasible on s390?

Thanks,

Paolo

