Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC94C54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 09:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 061BE20663
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 09:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FYefhIan"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbgD0JtP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 05:49:15 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:54308 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726349AbgD0JtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 05:49:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587980953;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qLuzVeIGtHjNnvhWI7G809z76fTCxCvUxioh1QTBMgc=;
        b=FYefhIan+SRhLZQI5L60x5FZRF49LfqtWtf+tKfwLFOIWOKkAL11yrgGyoPGu54/LsBteX
        h0mLHkwPNHLDRWfhyj+UDkXPlaDPm/aH6Y23H6HcsNgFul/oKjFBKdT8jfOeSpSZAe1Lg8
        d6bQPBd4l62gHnwstIdyUbJnNS9958U=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-WBwc64CSMJuM0TqGEqGQww-1; Mon, 27 Apr 2020 05:49:09 -0400
X-MC-Unique: WBwc64CSMJuM0TqGEqGQww-1
Received: by mail-wr1-f71.google.com with SMTP id r11so10247574wrx.21
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 02:49:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qLuzVeIGtHjNnvhWI7G809z76fTCxCvUxioh1QTBMgc=;
        b=ZrBPUfga0NQJ8CyeEH5R0RA+8Ef8kO592rW7I7nyRQVigrqCcO7HHXiQx8bCvRhPwT
         QbUDsrqiDZaMxU8fkQMD1ftzb583/FEm8TseKV0BBqWxK5iuiA0pwbGP2m/X0iYHrPK1
         JRFB/6LTq8pUYS92xaPWXKO2u155/hiWJJR75mD7kXg2R0bwR/Dx1oZmZxcDGEybpvav
         +UHaveUs2/LgVVJlSkT+Gedn51p0zz7BFxSIdHcfIUlaBhIXA00PVvUJ9ne2szGRM0U1
         KLXuRA/c4PcTCLu+3hxpUpVBXtdUqDlBpj3PTDhmD2XXXUHHBb/lp0zgYNlYsaF1nMNf
         EW0g==
X-Gm-Message-State: AGi0PubB8QQpBuG+2cFZdvSbjdadM4/3Vy0Z5F5sWWLiPV0W9++SsN19
        k0eB2yG3M0hS5HmV8EUwksAPL5fk3BiOrQCOLaE7ZtyqX5BeGQuPux+B/geYneDE28cpfYrBptz
        BD/cB++RoF3/vjIHnGgzRyNvb
X-Received: by 2002:a7b:c84f:: with SMTP id c15mr23872494wml.166.1587980947748;
        Mon, 27 Apr 2020 02:49:07 -0700 (PDT)
X-Google-Smtp-Source: APiQypKSCCSEo/IUap21LF/LKNKSXQ68wlspkJLGATRQxBBAxTNotluNK9KtvIErIgkKA34OdFkAfg==
X-Received: by 2002:a7b:c84f:: with SMTP id c15mr23872476wml.166.1587980947509;
        Mon, 27 Apr 2020 02:49:07 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
        by smtp.gmail.com with ESMTPSA id s14sm15057222wme.33.2020.04.27.02.49.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2020 02:49:07 -0700 (PDT)
Subject: Re: [PATCH v1 00/15] Add support for Nitro Enclaves
To:     "Paraschiv, Andra-Irina" <andraprs@amazon.com>,
        Alexander Graf <graf@amazon.com>, linux-kernel@vger.kernel.org
Cc:     Anthony Liguori <aliguori@amazon.com>,
        Benjamin Herrenschmidt <benh@amazon.com>,
        Colm MacCarthaigh <colmmacc@amazon.com>,
        Bjoern Doebel <doebel@amazon.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Frank van der Linden <fllinden@amazon.com>,
        Martin Pohlack <mpohlack@amazon.de>,
        Matt Wilson <msw@amazon.com>, Balbir Singh <sblbir@amazon.com>,
        Stewart Smith <trawets@amazon.com>,
        Uwe Dannowski <uwed@amazon.de>, kvm@vger.kernel.org,
        ne-devel-upstream@amazon.com
References: <20200421184150.68011-1-andraprs@amazon.com>
 <18406322-dc58-9b59-3f94-88e6b638fe65@redhat.com>
 <ff65b1ed-a980-9ddc-ebae-996869e87308@amazon.com>
 <2a4a15c5-7adb-c574-d558-7540b95e2139@redhat.com>
 <1ee5958d-e13e-5175-faf7-a1074bd9846d@amazon.com>
 <f560aed3-a241-acbd-6d3b-d0c831234235@redhat.com>
 <80489572-72a1-dbe7-5306-60799711dae0@amazon.com>
 <0467ce02-92f3-8456-2727-c4905c98c307@redhat.com>
 <5f8de7da-9d5c-0115-04b5-9f08be0b34b0@amazon.com>
 <095e3e9d-c9e5-61d0-cdfc-2bb099f02932@redhat.com>
 <602565db-d9a6-149a-0e1a-fe9c14a90ce7@amazon.com>
 <fb0bfd95-4732-f3c6-4a59-7227cf50356c@redhat.com>
 <fe8940ff-9deb-1b2b-8f30-2ecfe26ce27b@amazon.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <617eb49c-0ad9-8cf4-54bc-6d2cdfbb189a@redhat.com>
Date:   Mon, 27 Apr 2020 11:46:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <fe8940ff-9deb-1b2b-8f30-2ecfe26ce27b@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/04/20 11:22, Paraschiv, Andra-Irina wrote:
>>
>>
>> 1) having the kernel and initrd loaded by the parent VM in enclave
>> memory has the advantage that you save memory outside the enclave memory
>> for something that is only needed inside the enclave
> 
> Here you wanted to say disadvantage? :)Wrt saving memory, it's about
> additional memory from the parent / primary VM needed for handling the
> enclave image sections (such as the kernel, ramdisk) and setting the EIF
> at a certain offset in enclave memory?

No, it's an advantage.  If the parent VM can load everything in enclave
memory, it can read() into it directly.  It doesn't to waste its own
memory for a kernel and initrd, whose only reason to exist is to be
copied into enclave memory.

Paolo

