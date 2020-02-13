Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 627E9C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 07:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39E0C2168B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 07:14:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DnE4FjAN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729829AbgBMHOS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 02:14:18 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59061 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729383AbgBMHOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 02:14:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581578054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6hunoX5wQF60XLJ35mUusfrTVWgRBGAzv3UiGfBJ+Oc=;
        b=DnE4FjANm9GuefTD8lw79t1kyCI+zIFRVYbRXz4lEeyAYBN2hr/q6InmrNCo0eknF76i3q
        gzc7XqjxALwVbypz2iD39RiigccPcRTCj0AcOYAHjol0WYWjHZki3o++JuLJp7izojpz1b
        QqSS6/2p3/iNggkhSvlZ0uXAr5w2iy4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-qVoiPJDTNv-mUVX0iiNm7Q-1; Thu, 13 Feb 2020 02:14:13 -0500
X-MC-Unique: qVoiPJDTNv-mUVX0iiNm7Q-1
Received: by mail-wr1-f72.google.com with SMTP id 90so1959887wrq.6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 23:14:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6hunoX5wQF60XLJ35mUusfrTVWgRBGAzv3UiGfBJ+Oc=;
        b=E59mx8JQ2BLnANNRgv4nr8QXdlnVEI9dqSut/rd3s7rkZD+U2Rozh099oMuz+PtgcN
         Gymex4OTrkCz7gQT4O8pE8oJXKag1FT7feKPhGDBq3TfrbBh7bwWSKZlo/ufNqvI32Fa
         elu6LUBDZ9/nDRfKNJLFRBf1Kl6hHdZqv+0GyyVJC3jRoohJIxPjusgtcpGVLKSojkuY
         y86SQWw1vPHA/kuCjSOP5B4P+hgW0e88cBHZyiEUq4ljItSgLmWFoqpkxSPc+6NG/w/a
         6s2ia5J5gxIA7V+S7JDd35IGcMInYIO81G6+j45ypyqgcRJQ6wIweYrtt7yvhLWTFGS1
         6dSw==
X-Gm-Message-State: APjAAAUFizrG4DrZNL6qphzuRuNYvh/L3XDEJtfELg/TS18y2LMRe1ol
        bjcLwT4FEJONFJAMe57rMgSNOhMUOrHGNDBFJGXabe5nPsknIjuouGghdfz0elrtFdp+mzu2SgS
        B4PG5NJeWpGbX/GL3np1whTCO
X-Received: by 2002:adf:e550:: with SMTP id z16mr20333967wrm.5.1581578052125;
        Wed, 12 Feb 2020 23:14:12 -0800 (PST)
X-Google-Smtp-Source: APXvYqzZeei/p139PwnRmCikIMe1N1RgiEQOzIkw4az1GhFpgrkAy/udPkAVdbyi2zpKb9W1r6hbYg==
X-Received: by 2002:adf:e550:: with SMTP id z16mr20333936wrm.5.1581578051856;
        Wed, 12 Feb 2020 23:14:11 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:652c:29a6:517b:66d9? ([2001:b07:6468:f312:652c:29a6:517b:66d9])
        by smtp.gmail.com with ESMTPSA id e1sm1656927wrt.84.2020.02.12.23.14.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2020 23:14:11 -0800 (PST)
Subject: Re: [GIT PULL] KVM changes for Linux 5.6-rc2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>,
        Oliver Upton <oupton@google.com>
References: <20200212164714.7733-1-pbonzini@redhat.com>
 <CAHk-=wh6KEgPz_7TFqSgg3T29SrCBU+h64t=BWyCKwJOrk3RLQ@mail.gmail.com>
 <b90a886e-b320-43d3-b2b6-7032aac57abe@redhat.com>
 <CAHk-=wh8eYt9b8SrP0+L=obHWKU0=vXj8BxBNZ3DYd=6wZTKqw@mail.gmail.com>
 <23585515-73a9-596e-21f1-cbbcc9d7e7f9@redhat.com>
 <CAHk-=wjv2V==7jGwg2OkyX4F6Cdtt4qCpdGF56rOi-kVtjGCZQ@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d9f66725-993f-5434-5115-f173b36d52d7@redhat.com>
Date:   Thu, 13 Feb 2020 08:14:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wjv2V==7jGwg2OkyX4F6Cdtt4qCpdGF56rOi-kVtjGCZQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/02/20 21:13, Linus Torvalds wrote:
> On Wed, Feb 12, 2020 at 12:02 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> I know, but still I consider it.  There is no reason why the "build
>> test" should be anything more than "make && echo yes i am build-tested".
> 
> It damn well should check for warnings.
> 
> And if you can't bother eye-balling it or scripting it, then simply use
> 
>    make KCFLAGS=-Werror
> 
> but sadly I can't enforce that in general for all kernel builds simply
> because some people use compilers that cause new warnings (compiler
> updates etc commonly result in them, for example).

Shouldn't we _try_?  Compilers are not adding or triggering as many
warnings as they were a few years ago, when clang came out or GCC 4
rewrote their middle end.  Compiling the 10-year-old 2.6.32 these days
results in a couple warnings for the RHEL6 configuration.  Sometimes
there are even hard errors making -Wno-error moot.  We can fix them in
stable kernels.  For master, distro people and build bots would catch
that early and we can fix everything quickly.

For the odd case such as a bisection on old trees, _that_ is when you
add -Wno-error.  Special cases deserve special options, general cases
don't.  The issue percolates all the way down to the developers, Oliver
could have specified KCFLAGS too and he wouldn't have sent the bad
patch, but honestly I can't blame him.  You can blame me, :) but again
that doesn't mean Linux as a whole can't do better.

Anyway---sorry again for the screwup.  I'll send a revised pull request
soon.  Thanks,

Paolo

> So I can't add -Werror in general, but developers can certainly use it
> trivially.
> 
> No grep or other scripting required (although the above may cause
> problems for that one sample file that does cause warnings - I didn't
> check).
> 
>               Linus
> 

