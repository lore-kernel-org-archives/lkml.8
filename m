Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CFEBC2BA2B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 09:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13F422074F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 09:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZJoHCDJg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbgDHJIx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 05:08:53 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60034 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726980AbgDHJIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 05:08:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586336931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rUQ0HsWwrnHe34YtREcTfNzNUJOF3IAdDb38I5AaKxE=;
        b=ZJoHCDJgaFjuuv2te7kWdxqbeRup+jqTDMJhk1W1sRW30OiOw/pPZR/940JaIHkzO02RUP
        LRmpfDC7iXSwqfAb2seI3pfYvcGDoOJsKX0kpi6QhPyfNiis/FM3C/hf4TDbCNawIJIdG0
        XsCy4M/lcd9BCYijg0v5s8fDBXoQ1y0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-19dmcRemN-KwUGFqiFR8Eg-1; Wed, 08 Apr 2020 05:08:49 -0400
X-MC-Unique: 19dmcRemN-KwUGFqiFR8Eg-1
Received: by mail-wm1-f69.google.com with SMTP id s22so2080852wmh.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 02:08:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rUQ0HsWwrnHe34YtREcTfNzNUJOF3IAdDb38I5AaKxE=;
        b=ZsAOLFlpIpGzULwdFyJlqpJfLtwl0jAX7lR2tMJuquZoEzzaXnw8w9Q/7JiPRr0G3G
         BBkPIJss6Imi4yEg+U6yuDbBSlZpPfs1bBtZJv5NSFquEmDk0gGkCIodO6Pr/c7pGc0c
         bxZwzjcFpkBmBHRmbkzSEE668Hknc3j3UAxFfNlA6YIakrra6XF+oaNmTU5yec2RiW8Q
         33QZ/2UoqQLSZJ8PjIpABctq7uASR0KSa5jyFGV5KbPsOQRldux4jaFsm4QhhjJjkl89
         w9Vnk4CiuN6YNfZCGyQ2NaZocl2fONMg6BXQk6cESZspVecE5GtxSsKw6a23FGQvAXac
         84PA==
X-Gm-Message-State: AGi0PubSQITKyvx/6H2k4ZJoCSy+Gh0raU1nKVW5N43yCr83zZKDKifR
        cjjitH5Fmh4gjJ+3cFHPMnzRIBFoiRq7LjIf54BqnnB3NMwG25dEni6noGr0MpT6ZWahZ/tDYz9
        LJkV8Q0lQ6win5Z8PNBn+AAsb
X-Received: by 2002:a7b:cd89:: with SMTP id y9mr3752572wmj.102.1586336928251;
        Wed, 08 Apr 2020 02:08:48 -0700 (PDT)
X-Google-Smtp-Source: APiQypLe1s1nvra2eXvOVyXKoy+DeFW86EqO9pdanw+EMwQcEuocAwsAGqIDuWH/3Mfnb2xLGbG1mA==
X-Received: by 2002:a7b:cd89:: with SMTP id y9mr3752550wmj.102.1586336928006;
        Wed, 08 Apr 2020 02:08:48 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:bd61:914:5c2f:2580? ([2001:b07:6468:f312:bd61:914:5c2f:2580])
        by smtp.gmail.com with ESMTPSA id s6sm5804360wmh.17.2020.04.08.02.08.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2020 02:08:47 -0700 (PDT)
Subject: Re: [PATCH 2/2] KVM: s390: Return last valid slot if approx index is
 out-of-bounds
To:     Cornelia Huck <cohuck@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+d889b59b2bb87d4047a2@syzkaller.appspotmail.com
References: <20200408064059.8957-1-sean.j.christopherson@intel.com>
 <20200408064059.8957-3-sean.j.christopherson@intel.com>
 <20200408091024.14a0d096.cohuck@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2701fd49-4cf8-2b2d-daa8-96945ea4f233@redhat.com>
Date:   Wed, 8 Apr 2020 11:08:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200408091024.14a0d096.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/04/20 09:10, Cornelia Huck wrote:
> On Tue,  7 Apr 2020 23:40:59 -0700
> Sean Christopherson <sean.j.christopherson@intel.com> wrote:
> 
>> Return the index of the last valid slot from gfn_to_memslot_approx() if
>> its binary search loop yielded an out-of-bounds index.  The index can
>> be out-of-bounds if the specified gfn is less than the base of the
>> lowest memslot (which is also the last valid memslot).
>>
>> Note, the sole caller, kvm_s390_get_cmma(), ensures used_slots is
>> non-zero.
>>
> This also should be cc:stable, with the dependency expressed as
> mentioned by Christian.
> 

So,

Cc: stable@vger.kernel.org # 4.19.x: 0774a964ef56: KVM: Fix out of range accesses to memslots
Cc: stable@vger.kernel.org # 4.19.x

Paolo

