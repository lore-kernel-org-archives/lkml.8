Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C17C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 16:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2592F20707
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 16:17:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EqlAYXmr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729616AbgEDQRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 12:17:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24138 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729352AbgEDQRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 12:17:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588609029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uMOpMY0YQQxDGE9f6bszjh9mdyqywyqBT/HdaZYhvVA=;
        b=EqlAYXmrxWqot2LQ9TT9OBdFm9LuKtwh3XBXEB94qI7I6NslaSCb/9Owby/YsHF/54Evpp
        RJ0XGAnKbEMUTzEpzttqBOZ1hG/r8EcIpnkVWseBaQbQa9oWYX0aJo9Mayh//sMKfRxFRh
        8zreZTxI+SqGhdCv+MvoXBa3UDUISrk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-119-wqsaPLuwPhunJaN1IQENAg-1; Mon, 04 May 2020 12:17:07 -0400
X-MC-Unique: wqsaPLuwPhunJaN1IQENAg-1
Received: by mail-wm1-f69.google.com with SMTP id h184so47145wmf.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 09:17:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uMOpMY0YQQxDGE9f6bszjh9mdyqywyqBT/HdaZYhvVA=;
        b=DLholr7pJSAsIjQph3f4WqULVqLEsyO+qJfL1ztgRoiUg29Zce3ntjm9osGV7izudk
         hnomvHzUbtOId8dkJlpNkvtZVmMTF8BXKRFItDLREuJTAi81ZKnP10GKMWh8cO/rcl2f
         ioLRuWv7yfaU4Oo8fnR4UiY4mVg3iFFJLJlyrB5k0jJIr1gU5U0UyPUk2zXXftToPO3y
         6Ns8gkRyGTm52iuSqZDzcclaAIexSnu6Scl8Ran11zN6rFWh5nSfSPN2gO0SrUe9vqZr
         7koy0//yWNxQQhue8K0gP7KzKKfVKvZqT36Fg514WLqHnFof8ATtlxI2G52UnzmXpACd
         utNw==
X-Gm-Message-State: AGi0Pubsv8I8XDExeWGPYeIJiDd7QxTfFbkhwJSQUU+ZfU3Lkhr7aYb9
        AQ6s3yPezUBAPmWygRd0ZlvqWQiOA4LzkazHVEClNxspteX9AYeLFCDwupBFGFs8PSBhQOq6hz8
        POz48LC4CfclRfq5OMXCWzH9E
X-Received: by 2002:a1c:b70a:: with SMTP id h10mr15654223wmf.172.1588609026564;
        Mon, 04 May 2020 09:17:06 -0700 (PDT)
X-Google-Smtp-Source: APiQypKgIfENMjeXHov4dgLFDc1YKZsuljv/48zhE5QEqaw20gEpOMUq1qWoZAx/yY2/qjyGTCgIlA==
X-Received: by 2002:a1c:b70a:: with SMTP id h10mr15654201wmf.172.1588609026315;
        Mon, 04 May 2020 09:17:06 -0700 (PDT)
Received: from [192.168.178.58] ([151.20.132.175])
        by smtp.gmail.com with ESMTPSA id a205sm14990800wmh.29.2020.05.04.09.17.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2020 09:17:05 -0700 (PDT)
Subject: Re: [PATCH] KVM: x86: Fixes posted interrupt check for IRQs delivery
 modes
To:     Maxim Levitsky <mlevitsk@redhat.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     joro@8bytes.org, jon.grimm@amd.com,
        Alexander Graf <graf@amazon.com>
References: <1586239989-58305-1-git-send-email-suravee.suthikulpanit@amd.com>
 <35c7c404406729dc05d0977c9d322655f2b1c4a9.camel@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7b9e8091-d55b-5676-d5bf-c8bbe7ae171f@redhat.com>
Date:   Mon, 4 May 2020 18:17:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <35c7c404406729dc05d0977c9d322655f2b1c4a9.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/05/20 15:13, Maxim Levitsky wrote:
> Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
> Tested-by: Maxim Levitsky <mlevitsk@redhat.com>

Queued, thanks.

Paolo

