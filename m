Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 535CBC2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 12:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FD5120714
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 12:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ckVzScOd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbgBLMJh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 07:09:37 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48792 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727041AbgBLMJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 07:09:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581509376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xd/aWZzMFcT2m+1AWV4ND535kCy+Z0OTFOLbnwiLlgs=;
        b=ckVzScOdUnDCqVLWNIo3CmvWReOg9OqqxdDahL5pXmDQQAG/pBfc5pJBFQRPdORRVGRNu9
        jNpg45Ne4UFTp1BzUZzDTUr7Vt5fx8d+TGfT4E6LMZnRnBq9iWXK+01NTC2vuScxo3eEyY
        k8TH+h2NpdxicqvLgizP+Z2sdazI/8M=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-oSPDT2-AN-WaS1fMYuu5Lg-1; Wed, 12 Feb 2020 07:09:32 -0500
X-MC-Unique: oSPDT2-AN-WaS1fMYuu5Lg-1
Received: by mail-wr1-f70.google.com with SMTP id c6so716038wrm.18
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 04:09:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Xd/aWZzMFcT2m+1AWV4ND535kCy+Z0OTFOLbnwiLlgs=;
        b=ou6gAHI2zD6KDh333BScBj79Fd/D5c3q1PPvwKQh1Eig1hDLbSyygm+foO0waKYltd
         7yVrkcTgI8hYn1bTHQMXbFnb5ovrNBDTS4ivHac4e/d3YBDxwsxf3TvK74jjMzSnebIs
         c+N3USsSpsnObfnbtstJexuhxK5evgdZcp2oha2NMz+nRTKorswoH2RoLvGxm9KH3lZJ
         bcsB3Js3Y4fJQWA0pNl+2z7/Ed74B99cl8PO9V692+kM7BbgJrL2wY3HAYHuA3XKhbS/
         u6F7c1xow/pw45awkj5gMUYNeX1AelYevBNUB5xJ2ez5yCvv1G0rw6XLwL7z20WOpcAU
         6NrA==
X-Gm-Message-State: APjAAAWtr63Kd6iVB0BibMHUuGkYxFXNzcAKeiW37KdObQ1QVK/xtEy7
        7MGqIOE4Y2E7Uzp1ePktGEOyodvQzRDmFuEuuzKud6m+6QpcmqHG7N8aPAceDHD27oHmImjnxFK
        /bOtAyG9kfHizIUSzo1ZuBHp3
X-Received: by 2002:adf:fa50:: with SMTP id y16mr14208929wrr.183.1581509371261;
        Wed, 12 Feb 2020 04:09:31 -0800 (PST)
X-Google-Smtp-Source: APXvYqx6TYfL9d2yFQecMXw4gyRiHYC5y321fzdvM79+ALHl/QjW1BQHVMfN+wEmFYOAi7Yh7hfiRg==
X-Received: by 2002:adf:fa50:: with SMTP id y16mr14208902wrr.183.1581509370981;
        Wed, 12 Feb 2020 04:09:30 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:652c:29a6:517b:66d9? ([2001:b07:6468:f312:652c:29a6:517b:66d9])
        by smtp.gmail.com with ESMTPSA id a198sm501253wme.12.2020.02.12.04.09.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2020 04:09:29 -0800 (PST)
Subject: Re: [PATCH v5 0/4] selftests: KVM: AMD Nested SVM test infrastructure
To:     Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        vkuznets@redhat.com
Cc:     thuth@redhat.com, drjones@redhat.com, wei.huang2@amd.com,
        krish.sadhukhan@oracle.com
References: <20200207142715.6166-1-eric.auger@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <25441007-2b1a-f98a-3ca8-ffe9849d7031@redhat.com>
Date:   Wed, 12 Feb 2020 13:09:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200207142715.6166-1-eric.auger@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/20 15:27, Eric Auger wrote:
> 
> History:
> v4 -> v5:
> - Added "selftests: KVM: Remove unused x86_register enum"
> - reorder GPRs within gpr64_regs
> - removed vmcb_hva and save_area_hva from svm_test_data
> - remove the naming for vmcb_gpa in run_guest

I preferred v4. :)  I queued the patch to remove the unused enum though.

Paolo

