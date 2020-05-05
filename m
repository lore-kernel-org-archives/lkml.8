Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84ACEC47257
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 17:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FE11206CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 17:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O5i7do4i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730723AbgEERHd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 13:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729209AbgEERHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 13:07:32 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A086C061A41
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 10:07:32 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id o18so1279286pgg.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 10:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=vBqzVx+qxfalnXJK7KTGtarAHizzhkjQWkeOeL25v0I=;
        b=O5i7do4icdhMgjwpo9TCdui1mhr1arbAoT6CXE/FL4FNU3azDor8xRsQqnf1oekzW/
         7Qdnbc7WereNZhHIyoLYjd3kSqw20Zgo4WpUa6FDM3lp00UVK8MuXDFlE01cNDiRoL/O
         EAJ+Ut2sB0upkwibNjvyQBcsbJtaD+jjUHszOCYm3fAaoq1qP93jucL3eyvdClOkn4r9
         aH+4c51iqcLP9pbxn4M3XH4t32uYqryQbnelLqdVh/XN7PZz087P/5s0HNVg2D8n0IWM
         Us9QoDxYRHRAsocKaYP+GGGf+vkaem3+rBmS0NeZS6uvBlq/NtEMkGqiIrBNdRSUHVrW
         Rf/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=vBqzVx+qxfalnXJK7KTGtarAHizzhkjQWkeOeL25v0I=;
        b=DIGI+Bn2LzsmtatwNObpMbBIsT/JFVvKORmtcsJataYhyCqHFeKM7HU64I7gt4nEnE
         5u7OnZ41tEvCWR3bC16/hu5z2U3KMVRq/EZCRbRCxHLjdOz+5touTgjKyOxwh3bXM3Pr
         jmXabYD8E675m7uxvIKxtAntVytCpiCS3dDMq8JtZYKxdeLXX9owrve4+M6aqBGA3LHp
         ly39r+uH0iBfSBI+CZCUstxXN3XUuirGbUN42T+PG0MLEoffphOTOp3yRQ/IcNu6/wLx
         EgAyO/8jRkCgGKt+9mUMPJz4jIHGGDQImxycGmcSvjRYwl1ube4bKPT8xE9Eo4ZVNmZ5
         CQzw==
X-Gm-Message-State: AGi0Pua7a9coJsf84NvNIs7bGM3fBjTHouKnG3d0n38aW3sfFLLmn17n
        D/PSxaZicdvEVt7WBShqBwH7WA==
X-Google-Smtp-Source: APiQypL1cJk6Ptxu94QvTpoApcHVyzDf/w6RUKic+BQutwZLjzt9TVLdFv2iA8r9azHBa6jgEpe/WQ==
X-Received: by 2002:a63:778d:: with SMTP id s135mr3848663pgc.238.1588698451129;
        Tue, 05 May 2020 10:07:31 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id z190sm2471532pfb.1.2020.05.05.10.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 10:07:30 -0700 (PDT)
Date:   Tue, 5 May 2020 10:07:29 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Paolo Bonzini <pbonzini@redhat.com>
cc:     Jim Mattson <jmattson@google.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        Jonathan Adams <jwadams@google.com>,
        kvm list <kvm@vger.kernel.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mips@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 0/5] Statsfs: a new ram-based file sytem for Linux
 kernel statistics
In-Reply-To: <1d12f846-bf89-7b0a-5c71-e61d83b1a36f@redhat.com>
Message-ID: <alpine.DEB.2.22.394.2005051003380.216575@chino.kir.corp.google.com>
References: <20200504110344.17560-1-eesposit@redhat.com> <alpine.DEB.2.22.394.2005041429210.224786@chino.kir.corp.google.com> <f2654143-b8e5-5a1f-8bd0-0cb0df2cd638@redhat.com> <CALMp9eQYcLr_REzDC1kWTHX4SJWt7x+Zd1KwNvS1YGd5TVM1xA@mail.gmail.com>
 <1d12f846-bf89-7b0a-5c71-e61d83b1a36f@redhat.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 May 2020, Paolo Bonzini wrote:

> >>> Since this is becoming a generic API (good!!), maybe we can discuss
> >>> possible ways to optimize gathering of stats in mass?
> >> Sure, the idea of a binary format was considered from the beginning in
> >> [1], and it can be done either together with the current filesystem, or
> >> as a replacement via different mount options.
> > 
> > ASCII stats are not scalable. A binary format is definitely the way to go.
> 
> I am totally in favor of having a binary format, but it should be
> introduced as a separate series on top of this one---and preferably by
> someone who has already put some thought into the problem (which
> Emanuele and I have not, beyond ensuring that the statsfs concept and
> API is flexible enough).
> 

The concern is that once this series is merged then /sys/kernel/stats 
could be considered an ABI and there would be a reasonable expectation 
that it will remain stable, in so far as the stats that userspace is 
interested in are stable and not obsoleted.

So is this a suggestion that the binary format becomes complementary to 
statsfs and provide a means for getting all stats from a single subsystem, 
or that this series gets converted to such a format before it is merged?

> ASCII stats are necessary for quick userspace consumption and for
> backwards compatibility with KVM debugfs (which is not an ABI, but it's
> damn useful and should not be dropped without providing something as
> handy), so this is what this series starts from.
> 
