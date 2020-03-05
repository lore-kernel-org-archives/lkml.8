Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0578C3F2CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 12:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D20A20848
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 12:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="IaN3n+vc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbgCEMAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 07:00:50 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51057 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbgCEMAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 07:00:49 -0500
Received: by mail-wm1-f65.google.com with SMTP id a5so5985845wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 04:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=uObr8HTRJvvkPtZFYtcKx4WzpLxPFBuwzYX1IrBj3yc=;
        b=IaN3n+vcHlCFmj2FjcyBTvl5NWCPWY1Gq3x4HzQpuLkfxQZrzljTgj+k100BRs8Biy
         dF2wPK82zVVMQyv1oCHPn6LNrZf5C/2TPmww8bsfvMyR5BXOcwMqIQ4qnYlj5vqUVXCv
         H6N70701bHwnqBbmxSTsVxdBFveFAM3iPEP6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=uObr8HTRJvvkPtZFYtcKx4WzpLxPFBuwzYX1IrBj3yc=;
        b=BZrzGpODdx3qo84VL5sI7yrXR+OvJA650dHQ3qTltaWvz1xkser/pvyvDIXoQX8hdt
         lAhf8CqjE/E1MAROfPecon6PpQjaZJ2gN7Za6+rXTTQCe3xqaUQaZ40AOy7tswY2x4Fx
         zXNBp1emN4f9dcC+ajSCmLRmfMQnmMNSmpsh3iN3XWxQBsNz9BOm5qBKyghYFVz6PZZc
         w7PoCqgJFtL0SKUXB/KIJ4LIj5URwXO4kQiIR0NXdf616rvRdaeOc1vm9VYjZDUWQI5W
         MDqWDJ6sJ9ozqsV/Yz/CDyBJCX68qyexI7qdx2sMIck2l8/em8LEJIx80bcMe1nK436i
         vpGQ==
X-Gm-Message-State: ANhLgQ3fzjpNSQUQ7Offn/z8BObaQglUr6/rFcLOfg6wlEhKr3nncJFB
        cMq7xZu4zOSm9dkA5eWy4h1wXA==
X-Google-Smtp-Source: ADFU+vvhiNLXK/gmpiu0l+tLWMsxbL563AqkpPF0XFukxV+4vnxzUWtwy7ToAThcKQCy2Yn3Hx94cA==
X-Received: by 2002:a1c:df45:: with SMTP id w66mr9145048wmg.171.1583409645664;
        Thu, 05 Mar 2020 04:00:45 -0800 (PST)
Received: from cloudflare.com ([176.221.114.230])
        by smtp.gmail.com with ESMTPSA id w16sm10403375wrp.8.2020.03.05.04.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 04:00:44 -0800 (PST)
References: <20200304101318.5225-1-lmb@cloudflare.com> <20200304101318.5225-2-lmb@cloudflare.com>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     john.fastabend@gmail.com, Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Alexei Starovoitov <ast@kernel.org>,
        kernel-team@cloudflare.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 01/12] bpf: sockmap: only check ULP for TCP sockets
In-reply-to: <20200304101318.5225-2-lmb@cloudflare.com>
Date:   Thu, 05 Mar 2020 13:00:44 +0100
Message-ID: <87h7z3ypsj.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 04, 2020 at 11:13 AM CET, Lorenz Bauer wrote:
> The sock map code checks that a socket does not have an active upper
> layer protocol before inserting it into the map. This requires casting
> via inet_csk, which isn't valid for UDP sockets.
>
> Guard checks for ULP by checking inet_sk(sk)->is_icsk first.
>
> Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
> ---

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

[...]
