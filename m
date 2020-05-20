Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 221D0C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 07:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01995207D3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 07:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DArtThGf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgETHlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 03:41:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26107 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726566AbgETHlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 03:41:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589960469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rO9Y5Ec6p6UJIY190OJ9WK4iYIJu0z77oYDvlXTwxpQ=;
        b=DArtThGffieBxynBkN6jhmTqmqzgBlyso7h6DcI8H3LW+n6OEm95CVIXIH6QsM9AhOkc7m
        UzJySAySJxdkXyZ01aEjOjX8lW1A0dKDPPCtOwDwlbpWFp2rel2Bia9D2dC5vyWeFBKj8I
        XqwHi7hgSVjtGKLoKW9xvDJA9VRQCoM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-jAeC767DPOyGSem_yfkH5w-1; Wed, 20 May 2020 03:41:07 -0400
X-MC-Unique: jAeC767DPOyGSem_yfkH5w-1
Received: by mail-wr1-f72.google.com with SMTP id d16so1016048wrv.18
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 00:41:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rO9Y5Ec6p6UJIY190OJ9WK4iYIJu0z77oYDvlXTwxpQ=;
        b=bY2RakvUx76iOHCcjtA4C06G+Oirt+wvRP9cOtBFEfCGkv3mQGWcMCsJlL3zLtMIDS
         DTIVFY20PE+TA7wLbcc11IovXsjpPklns/ptvN515TtXinz4SlJjgFp/u0U1lYCogbRD
         /ksXtY+WqY+XPz+gctZdwkGzvubqMTwEYv0ruiw6WO2WF8jqT2KpDebdo9Ou+E8TSU6o
         F84VSKXkeBoCPH40TMmIjj63Wz9gnV243RclHU+D0am7CgMp7nrYbm6bEQLAKvhnlxoy
         xd5AL2mQTCCBjQFyd6QPMk3rhcaOqYywSgRZhesI6CjodScT+XVHTnFL3+0RJOBVigG2
         Xvag==
X-Gm-Message-State: AOAM531t46uMBHO97tcvBnhZe86NM9sLfTEt1P3SaI70iZr5jfQ2cHuP
        MpWHAA/xBQT8bwJtWyzzst+TnVixAiOo3kbGirc6+SVs4LMrFN6KOR3kXNIHs0W1qpUBGa/c6hD
        K3dK2AWz04VUP9oqhpBA7+qmc
X-Received: by 2002:a5d:4907:: with SMTP id x7mr2786732wrq.49.1589960466426;
        Wed, 20 May 2020 00:41:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz5fXvnE7V9n/E+0RBL3D0zq32eeT6Ow8Y+KKqcAB6ttQ/rkB40H3G29WCFq0hAvGbv+Ccm2g==
X-Received: by 2002:a5d:4907:: with SMTP id x7mr2786711wrq.49.1589960466218;
        Wed, 20 May 2020 00:41:06 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:591e:368f:1f3f:27d2? ([2001:b07:6468:f312:591e:368f:1f3f:27d2])
        by smtp.gmail.com with ESMTPSA id z7sm1940832wrl.88.2020.05.20.00.41.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2020 00:41:05 -0700 (PDT)
Subject: Re: [patch 0/7] x86/KVM: Async #PF and instrumentation protection
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, kvm@vger.kernel.org,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
References: <20200519203128.773151484@linutronix.de>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <dcc0bdab-3d5e-acde-1344-e82f5e84c3ca@redhat.com>
Date:   Wed, 20 May 2020 09:41:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200519203128.773151484@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/05/20 22:31, Thomas Gleixner wrote:
>   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git noinstr-x86-kvm-2020-05-16

Pulled, thanks.

Paolo

