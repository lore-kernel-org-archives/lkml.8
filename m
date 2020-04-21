Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D383C54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 21:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 776772072D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 21:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S7zywpEM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgDUVp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 17:45:59 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55164 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725850AbgDUVp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 17:45:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587505557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hrPqSHzvDqHMhPjGbnbzUJQXRgekl0cm+3+Jn2/BimY=;
        b=S7zywpEMd7LEqFHACldR0UmYKqhAVgxcOOIZuUkbC0818+3Qms+c2mRTXy0/JTGC9gx1Sk
        AoBCXT6yWFNJkl9Y2ER3A+VkuAvq2JguC2LuMd6LCMgCLzmuqGDzW4JXJ4bXIVrFcrOs1h
        9E0JAGMf17J72kgtlo05TgNbyzk5upw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-juOgthchOb2J8RT3L4P7Wg-1; Tue, 21 Apr 2020 17:45:55 -0400
X-MC-Unique: juOgthchOb2J8RT3L4P7Wg-1
Received: by mail-wm1-f72.google.com with SMTP id o5so15244wmo.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 14:45:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hrPqSHzvDqHMhPjGbnbzUJQXRgekl0cm+3+Jn2/BimY=;
        b=oebIipWZjTZ9NJ8oMLNyuRUpExxc0zqj4Gda76Pw1yxI8rVamuXNIVYEah33cyWdoZ
         ks/mK936YYTX2xfJiN+CX04kP3qZGFweRpEFBT1ofS9+htrLAaqftWTsDgDT9EKgbNm2
         J1wR+RUmPoAHd6yXqvMdby2nSQNc1SxFdzJWH6i7xTzznBw98OkznVGj2Aa4DFPfbr+c
         37d+mJ05BpRvfK7fFJlDYTnSKtfcHa3XklvsLDUdmBTrNLJ2IwShNZzaC/PwuBuG8QGh
         R54BhWlMmWfylbj0fNeaXqdYfq/F7Qyf35fiQ0E59DKCQuxlb7g3zupcKzhH5sM64gUe
         gY9w==
X-Gm-Message-State: AGi0PuYC8ADmFIxzm6wXqsrLdgYngw403uL38EhV+PldqKatholH3uXi
        rv+/kEyJh7PrW6FyUs2yL6P7eEmuU/xyZKPAkXLePLI9L5EaytBIY/A/bXA3ZS0C9TR83wbFOD1
        BEc+c7sD/+7ixgXpDrHTeaE0k
X-Received: by 2002:a1c:bc05:: with SMTP id m5mr6487210wmf.143.1587505554206;
        Tue, 21 Apr 2020 14:45:54 -0700 (PDT)
X-Google-Smtp-Source: APiQypKxMSa7I7p8Lu5YsI0+4oCtBwBPlOn5btcgzQhE21NXEYuoD2a64Zx/AKYlzP5XHQXGdM+iIA==
X-Received: by 2002:a1c:bc05:: with SMTP id m5mr6487200wmf.143.1587505553982;
        Tue, 21 Apr 2020 14:45:53 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:f43b:97b2:4c89:7446? ([2001:b07:6468:f312:f43b:97b2:4c89:7446])
        by smtp.gmail.com with ESMTPSA id q187sm4918951wma.41.2020.04.21.14.45.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2020 14:45:53 -0700 (PDT)
Subject: Re: [PATCH v1 01/15] nitro_enclaves: Add ioctl interface definition
To:     Randy Dunlap <rdunlap@infradead.org>,
        Andra Paraschiv <andraprs@amazon.com>,
        linux-kernel@vger.kernel.org
Cc:     Anthony Liguori <aliguori@amazon.com>,
        Benjamin Herrenschmidt <benh@amazon.com>,
        Colm MacCarthaigh <colmmacc@amazon.com>,
        Bjoern Doebel <doebel@amazon.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Frank van der Linden <fllinden@amazon.com>,
        Alexander Graf <graf@amazon.de>,
        Martin Pohlack <mpohlack@amazon.de>,
        Matt Wilson <msw@amazon.com>, Balbir Singh <sblbir@amazon.com>,
        Stewart Smith <trawets@amazon.com>,
        Uwe Dannowski <uwed@amazon.de>, kvm@vger.kernel.org,
        ne-devel-upstream@amazon.com
References: <20200421184150.68011-1-andraprs@amazon.com>
 <20200421184150.68011-2-andraprs@amazon.com>
 <7e0cb729-60ca-3b2e-909b-8883b24908a8@infradead.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <716e0cfb-fa4a-5fc5-f198-6574fa8dc046@redhat.com>
Date:   Tue, 21 Apr 2020 23:45:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <7e0cb729-60ca-3b2e-909b-8883b24908a8@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/04/20 20:47, Randy Dunlap wrote:
>> +
>> +/**
>> + * The command is used to trigger enclave start after the enclave resources,
>> + * such as memory and CPU, have been set.
>> + *
>> + * The enclave start metadata is an in / out data structure. It includes
>> + * provided info by the caller - enclave cid and flags - and returns the
>> + * slot uid and the cid (if input cid is 0).
>> + */
>> +#define NE_ENCLAVE_START _IOWR('B', 0x1, struct enclave_start_metadata)
> Please document ioctl major ('B' in this case) and range used in
> Documentation/userspace-api/ioctl/ioctl-number.rst.
> 

Since it's really just a couple ioctls, I can "donate" part of the KVM
space, for example major 0xAE minor 0x20-0x3f.

Paolo

