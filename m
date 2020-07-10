Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 837FFC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 07:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58CF9206A5
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 07:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bhgWT9dX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbgGJHrB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 03:47:01 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55439 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726288AbgGJHrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 03:47:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594367219;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JdHl2OiH4p6Iz0SiMtzkS/pKFwgmTmJSXShGkd+cqo8=;
        b=bhgWT9dXfOZunyjk5wJhq03ORQEslxL9haxb4mZUhteutC0KUUk7RkC42+LZ1PdFLmuLrO
        EZQnBFp1uBolqokSCfYDQSFX186EPkGvMVDyvH10QLc3qEc/YCBJMV+G11LPTWvohuuHCZ
        9ylikX4OoZAfJa/qX4acD8MVESgsyK4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-mxe7WY_uN1m_Oc_5D13rrA-1; Fri, 10 Jul 2020 03:46:57 -0400
X-MC-Unique: mxe7WY_uN1m_Oc_5D13rrA-1
Received: by mail-wr1-f69.google.com with SMTP id w4so5053651wrm.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 00:46:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JdHl2OiH4p6Iz0SiMtzkS/pKFwgmTmJSXShGkd+cqo8=;
        b=i8us0676LoLkeuBno3kA5GX3pQ0J4t9e54jdmxwfERoJgYgk7oslnZb2iNcIZbKgdO
         z09dqfem/AnQgn2EHJfPIBujBoWT88hPSSqZpOhBYQ2hbAwqBxlVJIxIhaQByzjIZa2I
         JmsYAubBmcx3qBqqhbGOQURRoBPn5Quoolj4aEalSjwW1f3gVL0jg9dMyV/mGp/VdZXT
         i5jCPiRCvL4W4L13RbNY31n284C6DdLnQT37gNPq7rWZPPl8KKI0r7nr1ovCzFXlpycp
         xdtSgXTmNXjHiXlOTdX1Meqeq9s2VwhXg21ZSTwWMhsofIqS0yuIBz3HfDwO1mvVgw+T
         YFtA==
X-Gm-Message-State: AOAM530kMkn2tZMLsXC2KE5j7blaaZfjBbhYVQb3PXEO+2qDehPpQpoz
        21oP2FeZiWPRWVGEqkkYlqOW/iWrV+zML44Lgaiy7IjSRKg21BWyFAl2UBwx3yZoUUd5KhVJoBk
        rQ1kHm9icade7W+o7tKL/T3kY
X-Received: by 2002:a1c:b686:: with SMTP id g128mr3986796wmf.145.1594367215831;
        Fri, 10 Jul 2020 00:46:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyuGy1axXIP4NvsxIBSy6jkXMCqPU4GtMCNiYKIfYo8qhu5JkSK8NP7Ezs/ydWQoVmvN6gUlw==
X-Received: by 2002:a1c:b686:: with SMTP id g128mr3986767wmf.145.1594367215569;
        Fri, 10 Jul 2020 00:46:55 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9541:9439:cb0f:89c? ([2001:b07:6468:f312:9541:9439:cb0f:89c])
        by smtp.gmail.com with ESMTPSA id k18sm8954712wrx.34.2020.07.10.00.46.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2020 00:46:55 -0700 (PDT)
Subject: Re: [PATCH] scsi: virtio_scsi: Remove unnecessary condition checks
To:     Markus Elfring <Markus.Elfring@web.de>,
        Xianting Tian <xianting_tian@126.com>,
        linux-scsi@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        "James E. J. Bottomley" <jejb@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
References: <a197f532-7020-0d8e-21bf-42bb66e8daec@web.de>
 <e87746e6-813e-7c0e-e21e-5921e759da5d@redhat.com>
 <8eb9a827-45f1-e71c-0cbf-1c29acd8e310@web.de>
 <58e3feb8-1ffb-f77f-cf3a-75222b3cd524@redhat.com>
 <9815ef2d-d0da-d197-49d7-83559d750ff1@web.de>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d052b441-cc4d-4b2b-1442-b1a30bed2fdb@redhat.com>
Date:   Fri, 10 Jul 2020 09:46:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <9815ef2d-d0da-d197-49d7-83559d750ff1@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/07/20 09:40, Markus Elfring wrote:
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/scsi/virtio_scsi.c?id=42f82040ee66db13525dc6f14b8559890b2f4c1c#n980
>>>
>>>  	if (!virtscsi_cmd_cache) {
>>>  		pr_err("kmem_cache_create() for virtscsi_cmd_cache failed\n");
>>> -		goto error;
>>> +		return -ENOMEM;
>>>  	}
>>
>> Could be doable, but I don't see a particular benefit.
> 
> Can a bit more “compliance” (with the Linux coding style) matter here?

No.

>> Having a single error loop is an advantage by itself.
> 
> I do not see that a loop is involved in the implementation of the function “init”.

s/loop/label/ sorry.

Paolo

