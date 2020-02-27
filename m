Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7090BC4BA06
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 06:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 482AD2467F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 06:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MODJHYQy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbgB0Gl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 01:41:57 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32763 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727131AbgB0Gl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 01:41:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582785715;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3WtQm8cciAT/fjByiLCd+SwYSU+Wsh17sH8Rz+Ha9TQ=;
        b=MODJHYQykxxNS+FBfRPvLvNT0EI5n2htEANVNDUF//+uRtyXorWZfEYPax19lWQdq6urez
        LGz2uUhrIPXN2VI2eHoRxJdquFXGkN/Zzi9hpwbAB6WhaV+J/ly3HMdNt9PrDnhWfXz0qR
        9XAh1BE6ZBuU2WVIN0pbKpBwwVgWCGk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-x4TapFPBOY-J7VrVtPooTg-1; Thu, 27 Feb 2020 01:41:53 -0500
X-MC-Unique: x4TapFPBOY-J7VrVtPooTg-1
Received: by mail-wr1-f69.google.com with SMTP id o9so868323wrw.14
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 22:41:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3WtQm8cciAT/fjByiLCd+SwYSU+Wsh17sH8Rz+Ha9TQ=;
        b=ISA8UhEydwJ//CfBSM3SaJPaL6mbR2uhMlZQfz/m/i51zhyQEtmrOHATOyYUzWda0a
         Vx/cU7dLHX1BDk3BgKqhkzSYRLpGtblw1qGZ9JSYUZHnQ6Eg2RiNV0SVj0eK86GsRjr/
         t0VbrpHovDj92w7e8HGjtKnq1R/MK+AzT+ocUypMe1MgrpMSa3PRcdQJIsG+6lw7yRhW
         xsMF2wxk2hcD/rUkeeTxhJjcPD1dSlPWfsUU3RukN9MJchbndgBZrFmsWAHlW7maJMwt
         ZycAVn/jRJw3KRNRKTtIsMIZ1n4984A5mW+viBcPB27Dn/jeMYTrseFVWl2GO8IblORV
         h+cA==
X-Gm-Message-State: APjAAAUR1nH+M7JPdV0UCL2EXhynL6ija1qJHccqEEbin8ZWL/FaIQVF
        QiepuGJVU2u24LfiJfNCtIiUlKtqjT3yVJx0vcfoSBFY3gKSSATtpzxFX0R9JNkBYpDVnf/ZwmB
        pJk5NAZKtGi/rTe0iRe+SSfJE
X-Received: by 2002:adf:f3d1:: with SMTP id g17mr2822676wrp.378.1582785712302;
        Wed, 26 Feb 2020 22:41:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqyArG/FMFCYBNGHUeD0cJCcpopv6q6Q0n5+XKSdmGhLCIy+1iyQ2uDjJJoigYpVcciUwPCVQg==
X-Received: by 2002:adf:f3d1:: with SMTP id g17mr2822649wrp.378.1582785711971;
        Wed, 26 Feb 2020 22:41:51 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:d0d9:ea10:9775:f33f? ([2001:b07:6468:f312:d0d9:ea10:9775:f33f])
        by smtp.gmail.com with ESMTPSA id g206sm5552090wme.46.2020.02.26.22.41.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2020 22:41:51 -0800 (PST)
Subject: Re: [PATCH] Revert "KVM: x86: enable -Werror"
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Christoph Hellwig <hch@lst.de>, torvalds@linux-foundation.org
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200226153929.786743-1-hch@lst.de>
 <87v9ns1z79.fsf@mpe.ellerman.id.au>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5f31e38e-2f78-7919-7c60-a1761b9abb2e@redhat.com>
Date:   Thu, 27 Feb 2020 07:41:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <87v9ns1z79.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/02/20 04:33, Michael Ellerman wrote:
> We've had -Werror enabled by default on powerpc for over 10 years, and
> haven't had many complaints. Possibly that's just because no one builds
> powerpc kernels ...

I looked for other cases of -Werror being always on in Linux before
writing this patch.  There are both unconditional cases and others like
PPC where it's governed by Kconfig.

I will add a Kconfig for now.  It probably should be made global instead
of having a dozen different Kconfig symbols.

kvm_timer_init should be fixed, though.

Paolo

> The key thing is that it's configurable, so if it does break the build
> for someone they can just turn it off. It's also off by default for
> allyes/allmod builds because the user-selectable option disables
> -Werror, eg:

