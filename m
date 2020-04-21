Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74038C55182
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 19:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55F72206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 19:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bw7FfE6R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgDUTvw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 15:51:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54663 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725930AbgDUTvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 15:51:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587498710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qGYpXz6VdCPTKs7yYyKCHLyhRb5XfP8CRNgtLy4ommU=;
        b=Bw7FfE6RTuKgjurtcFw7VywuN9Gnvcg7eDmOQZeBUseVx6kpHqoi2BgcAKbmUFwxmoc5cY
        9fcIHB71HAcAhxKGtwTAFgeWUsnFVbYkoPbId6o79HLNQtSk66d/nbQMUQSzWjqEzkW/AJ
        38Pf6aPXUvSSBVrR6abVQz/k2F/w2XI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-77OFOxSsMqegJYPXc6u6dg-1; Tue, 21 Apr 2020 15:51:46 -0400
X-MC-Unique: 77OFOxSsMqegJYPXc6u6dg-1
Received: by mail-wr1-f69.google.com with SMTP id h95so8257478wrh.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 12:51:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qGYpXz6VdCPTKs7yYyKCHLyhRb5XfP8CRNgtLy4ommU=;
        b=Gvpu1tIixNWjVT2VSY8Ce7m/ztuP7H6NlHVhKOrglFtA3Ccs5ItUKWpUuTUxHX22uW
         f6SVNcsMPzZd9EMtBvpYCFFJB+Cyk4xHmntIPLs8cUCRixjJRghzaiW9DoPjyBAJP5aA
         pIZAJPd/VvaTRUYhNhEYzNNV483XvF0mH5ocAjQR3MNcv1bFHOrQbah1rFUD/wtOBlvp
         KabNg8fzy8XYWw0HZzr0v7GUrCmE+/9coSbuxZ4r43vhj5HNwBfcxNbwEaIRHoGq8I4R
         R7wyAgcalf+BcK4/+T9eWB0Jq7INP3cCkKtcz8XhtcdftizzXMzpFg3M8ZwiR7WZvICm
         w8KQ==
X-Gm-Message-State: AGi0Pua4zJUNzjIjClFm1w496byHabE0/HbWP/holEeJ6nwVfVKJCWD7
        jM4cu8m45OIgUYuxKJiwr4hLqn9DfPqxFFuA9S7UFXJsNuODYjpRUaxVD4WO4dUHUhzNWT23Oyz
        oBGKxSbgeRMXQ7t+xI82WlhDx
X-Received: by 2002:a1c:9dd1:: with SMTP id g200mr6999170wme.82.1587498705645;
        Tue, 21 Apr 2020 12:51:45 -0700 (PDT)
X-Google-Smtp-Source: APiQypKCm0OdoTbIs/9fTEnN7H+32sVw2+Ijze7xR/UCwljoIR89/XFefVi/yu08ILmptP0S3k6XUA==
X-Received: by 2002:a1c:9dd1:: with SMTP id g200mr6999153wme.82.1587498705368;
        Tue, 21 Apr 2020 12:51:45 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:f43b:97b2:4c89:7446? ([2001:b07:6468:f312:f43b:97b2:4c89:7446])
        by smtp.gmail.com with ESMTPSA id d7sm4918133wrn.78.2020.04.21.12.51.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2020 12:51:44 -0700 (PDT)
Subject: Re: [GIT PULL] KVM changes for Linux 5.7-rc3
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>
References: <20200421160651.19274-1-pbonzini@redhat.com>
 <CAHk-=whVo7CzzjEYp+G7+MjNSg4cURR4SeUTvQSYVBFn3o5TPw@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <04150cae-6fbf-70c6-d968-b287f478a674@redhat.com>
Date:   Tue, 21 Apr 2020 21:51:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=whVo7CzzjEYp+G7+MjNSg4cURR4SeUTvQSYVBFn3o5TPw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/04/20 21:35, Linus Torvalds wrote:
> On Tue, Apr 21, 2020 at 9:07 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>>   https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus
>>
>> for you to fetch changes up to 00a6a5ef39e7db3648b35c86361058854db84c83:
> 
> Did you perhaps forget to force-update that tag?
> 
> That tree still shows the tag from April 7 (that I merged in commit
> 0339eb95403f).

Oops, yes I did.  /me goes and adds "set -e" to the script.

Paolo

