Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E552C5518B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 16:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EC5D2098B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 16:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MU42T4eq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgDVQtM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 12:49:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40290 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726413AbgDVQtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 12:49:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587574148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SYqq55jpNG38qRRIFw7acQIWp2Eu+K77BU0ArhjzWnY=;
        b=MU42T4eq7dyrgisZvenjpxPpMaxKmUhU+Kwb7zO5ufEGvrdGmS/7sCn27AP4IFA4sxvqK5
        jeSuEhoPM2T5T61oydjnVO+1/6Lw8tJo034BDrM84uj4p7SD+ovyITouY0yAI8RZDq/qF4
        KbQ/Ogu5nDWqJ6bzuERBvE9zMeJjVE4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-eYUnlMDPOdiyVTtk0MukeQ-1; Wed, 22 Apr 2020 12:49:04 -0400
X-MC-Unique: eYUnlMDPOdiyVTtk0MukeQ-1
Received: by mail-qv1-f72.google.com with SMTP id d2so2827843qve.11
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 09:49:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SYqq55jpNG38qRRIFw7acQIWp2Eu+K77BU0ArhjzWnY=;
        b=fDuEmJPhJicWAoqIqNvkSN1YGksnd9GRqbjevhLAr0jT/8UO16RPh15BnagzIJOBZH
         8gAhV0hQ940TeQnEKjis9cFlSSAQWJk2bcpG1wVq75nLK/UVbG2SLTgOjMR6tl31TWdR
         0w76xHSPiywhfqi7byJBwrVPF7TurBqObq1krSEGvfMedu2YMMIBjqhgazgzzSocAbXF
         yLLREqKqS/N+71H8NExnVLy8glDIxlP9H2DwDtfHtJZ4M9vXBLtMNN5a1K04wBnqPM0h
         ICqyNCWMfNfWKs3q/gkkR+TFtkwC0fslJD4kKKaPNpxam9o2YGLrPpC506tDYdxG6CO4
         +WDg==
X-Gm-Message-State: AGi0PuZ3/Eq+XnJ5erXgpZVcqpcxMt/GZKqfpWDuly+KlzHtxhMkRH//
        7wWbf0iJRKl9aiu2gfOvkDpYIHyHMx3LXr6emkDu53YAkiS7ISo98ygy/FfuxzcsGeOgCy8waCL
        7dnIBOf3xiSHrnsqLln22I+Pf
X-Received: by 2002:ac8:550c:: with SMTP id j12mr27718228qtq.22.1587574143661;
        Wed, 22 Apr 2020 09:49:03 -0700 (PDT)
X-Google-Smtp-Source: APiQypLykwvtylHrDcgIvH0Y7W9cU1MCrXPi+7bW8iApdAIU/TbNCwQJxaG0noJLhR9KpUestzs+pg==
X-Received: by 2002:ac8:550c:: with SMTP id j12mr27718197qtq.22.1587574143382;
        Wed, 22 Apr 2020 09:49:03 -0700 (PDT)
Received: from [192.168.0.172] (c-71-63-171-240.hsd1.or.comcast.net. [71.63.171.240])
        by smtp.gmail.com with ESMTPSA id c69sm4244840qkg.104.2020.04.22.09.49.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2020 09:49:02 -0700 (PDT)
Subject: Re: [PATCH v29 00/20] Intel SGX foundations
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-sgx@vger.kernel.org
Cc:     akpm@linux-foundation.org, dave.hansen@intel.com,
        sean.j.christopherson@intel.com, nhorman@redhat.com,
        npmccallum@redhat.com, haitao.huang@intel.com,
        andriy.shevchenko@linux.intel.com, tglx@linutronix.de,
        kai.svahn@intel.com, bp@alien8.de, josh@joshtriplett.org,
        luto@kernel.org, kai.huang@intel.com, rientjes@google.com,
        cedric.xing@intel.com, puiterwijk@redhat.com
References: <20200421215316.56503-1-jarkko.sakkinen@linux.intel.com>
From:   Connor Kuehl <ckuehl@redhat.com>
Message-ID: <72e8fd3e-5d35-669c-3186-43754333fceb@redhat.com>
Date:   Wed, 22 Apr 2020 09:48:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200421215316.56503-1-jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/21/20 2:52 PM, Jarkko Sakkinen wrote:
> v29:
> * The selftest has been moved to selftests/sgx. Because SGX is an execution
>    environment of its own, it really isn't a great fit with more "standard"
>    x86 tests.
> 
>    The RSA key is now generated on fly and the whole signing process has
>    been made as part of the enclave loader instead of signing the enclave
>    during the compilation time.
> 
>    Finally, the enclave loader loads now the test enclave directly from its
>    ELF file, which means that ELF file does not need to be coverted as raw
>    binary during the build process.
> * Version the mm_list instead of using on synchronize_mm() when adding new
>    entries. We hold the write lock for the mm_struct, and dup_mm() can thus
>    deadlock with the page reclaimer, which could hold the lock for the old
>    mm_struct.
> * Disallow mmap(PROT_NONE) from /dev/sgx. Any mapping (e.g. anonymous) can
>    be used to reserve the address range. Now /dev/sgx supports only opaque
>    mappings to the (initialized) enclave data.
> * Make the vDSO callable directly from C by preserving RBX and taking leaf
>    from RCX.

Hi all,

I've been producing Fedora 32 kernel builds with the SGX patches applied 
for a few of weeks and I've just produced a build with this latest 
revision[1]. We've been using these kernels to enable SGX for some of 
our development/test machines.

We wanted to offer them here in the hopes that others might find them 
useful for testing the SGX patchsets on their own machines to send 
feedback to this list. Please note that these are *not* meant to replace 
your distro kernel and these are for testing purposes only.

I'll continue to upload builds to a Fedora Copr[2] as long as the 
patches continue to apply cleanly to the Fedora kernels.

Best,

Connor

[1] 
https://download.copr.fedorainfracloud.org/results/npmccallum/enarx/fedora-32-x86_64/01344404-kernel/

[2] https://copr.fedorainfracloud.org/coprs/npmccallum/enarx/

[3] This is the packaging branch that I work from and rebase on top of 
the f32 kernels: 
https://github.com/connorkuehl/fedora-kernel-enarx-pkg/commits/f32-enarx

