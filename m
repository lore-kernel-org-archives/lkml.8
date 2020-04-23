Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B35D4C54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 17:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 973782076C
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 17:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q7kmrUSJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730042AbgDWRvU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 13:51:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57409 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729889AbgDWRvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 13:51:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587664279;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K4I4TQXbu0COs/qS0TdMrpO0BMmwvUdkWqtKkxdiZtg=;
        b=Q7kmrUSJztHIZqhpDgQ2Xk/v5fhpqOJEt3iGB0THxP1c91Qd19SW1IjlCg6VBWVh48mEVP
        7aPdszrzYrwRzFttCb9mQt8dPPs1cEQtWO0A8C+iM7xcCBszeSSjJ9z22h58TINQ0luhAl
        0g0HQLTxzhnLF7cHYmgO0A3JjnXsCWs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-mn-TdN1CPCC676oJ5djcYw-1; Thu, 23 Apr 2020 13:51:13 -0400
X-MC-Unique: mn-TdN1CPCC676oJ5djcYw-1
Received: by mail-wr1-f71.google.com with SMTP id p2so3246367wrx.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 10:51:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K4I4TQXbu0COs/qS0TdMrpO0BMmwvUdkWqtKkxdiZtg=;
        b=GkccjypMzZ7NG7mYqYiKIFp7buqO9Bd115k5v79lB9tOgrvvqafvhN3+oFP+s33kNe
         nyBC3jJiPRBnDeIGYGydwvX9wOCIMwWAxzx+1x6j/OFirRpUHTxs+vntvGzbFLfUQCl7
         phAPmr4VApYLEPzNsVgCgEMCgHIdjijihdGlDt8NL9K/IwUmqJhPRwA3Ce7vKpkACoYP
         4fh0sbO5RtYbwsGs8PGsduZkvgJxaeySB5s7wnAtFj9iPeZnIgF79Qef8P1OoRGJyCmi
         bfv0R8GONspngwKCSBaubTL70/bs7ITHW+CSH6SOSTxJedD6MSzOp3ESPk5vcJEZkSAx
         +HTQ==
X-Gm-Message-State: AGi0PuaqNf3ohrAQMRNDoIwSPs9EbTY+6v3bqiQ4EineMyEdF9+SyOE9
        zwYrHjtaCMODj7g5wiO3kAA009/xlHfCioCB8QZtISOqrD/w1QaRFj8YzDEjoWjnP3cpy6AVAir
        LQ5pTtMeCdt7Vhx6Rr3oHRkmC
X-Received: by 2002:a1c:9e51:: with SMTP id h78mr5726979wme.177.1587664272587;
        Thu, 23 Apr 2020 10:51:12 -0700 (PDT)
X-Google-Smtp-Source: APiQypK/wZjFY48hmQMwIAV2fQ6VxIkFz+VgDCtd7gu1Ykeal53v56KplZrYM0/Je0GgoY4i5twzKQ==
X-Received: by 2002:a1c:9e51:: with SMTP id h78mr5726937wme.177.1587664272275;
        Thu, 23 Apr 2020 10:51:12 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:f43b:97b2:4c89:7446? ([2001:b07:6468:f312:f43b:97b2:4c89:7446])
        by smtp.gmail.com with ESMTPSA id h137sm15720031wme.0.2020.04.23.10.51.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2020 10:51:11 -0700 (PDT)
Subject: Re: [PATCH v1 00/15] Add support for Nitro Enclaves
To:     "Paraschiv, Andra-Irina" <andraprs@amazon.com>,
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
 <18406322-dc58-9b59-3f94-88e6b638fe65@redhat.com>
 <ff65b1ed-a980-9ddc-ebae-996869e87308@amazon.com>
 <2a4a15c5-7adb-c574-d558-7540b95e2139@redhat.com>
 <1ee5958d-e13e-5175-faf7-a1074bd9846d@amazon.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f560aed3-a241-acbd-6d3b-d0c831234235@redhat.com>
Date:   Thu, 23 Apr 2020 19:51:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1ee5958d-e13e-5175-faf7-a1074bd9846d@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/04/20 19:42, Paraschiv, Andra-Irina wrote:
>>
>>>> - the initial CPU state: CPL0 vs. CPL3, initial program counter, etc.
> 
> The enclave VM has its own kernel and follows the well-known Linux boot
> protocol, in the end getting to the user application after init finishes
> its work, so that's CPL3.

CPL3 is how the user application run, but does the enclave's Linux boot
process start in real mode at the reset vector (0xfffffff0), in 16-bit
protected mode at the Linux bzImage entry point, or at the ELF entry point?

Paolo

