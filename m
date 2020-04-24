Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71588C54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 18:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 497B8206B9
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 18:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PoZ6lCGn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbgDXSMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 14:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727059AbgDXSMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 14:12:37 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6FDC09B049
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 11:12:36 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id c63so11160012qke.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 11:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=605Xbs+AiEmxOBeIcLfW5J6eNXAc0Z5gnHisrr+d4y8=;
        b=PoZ6lCGn6LiX6Qvdv+7FE4MluvpJF+HdqsJGJVmXFqAgR8ibPXRqIT1861LhrLQ/f+
         RcgP4j3AFtvZInNCejsho15AEpTM+Qu+C+D2XfyERk9LaW2ci2hte2Asq7pqMbtY9xlP
         lE211DfGMhvzVgbdYOKKnATXTFL5RJdkpQOzaPVn5KkXECXM1fa9nC2j6foDnxuRIaUr
         N9fmGM0jD2GAEudg32qMP4WjYcVjqI58hVYHxOsfLa/uYQ9x2go4Gd00EKM/4e6yeXF7
         po4R9v9ZByAUD471FcGwqfLsXvGl4z1E5VsncqNcZrGWeXU+r4AgnwygbSxO3g4B19lJ
         62lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=605Xbs+AiEmxOBeIcLfW5J6eNXAc0Z5gnHisrr+d4y8=;
        b=Ua+BcLp/EvG73sOfY8KXQ+5/F6IK8EDCZcIhAuvYr/A9oueP6AiP/hIc0EE8tgw/cl
         q0/idjmCfQJ8GZJmTDMU/kHYktRLcd085xIipdrP0BykX+5BpS3wZ9lE7YYYuF7f8kAO
         unfXY9imlAPKvc5R5N4TrnsKoMY5IzzWDSPtxvGKIDD26WSr7yiIkTkmMMsb4qjedzXO
         Uq/HH6p0ZuHfCukcRLnI76377aLRyzxvPqF5icJQNz6k/hN/aQe7Uw37AQTDb2mBvy+n
         xNIfJRaF/eFtgQhvllX7LMHUK4L6112FCrd953RywPBEiTPe4b2SXvZXLEtQMi+VJ2Kc
         pBww==
X-Gm-Message-State: AGi0PubrtLJtWAmAO6k1vsDa2aVMwtj7SQqKIaETYexDPvYcuojW9TOf
        38MKIk32kj0HkFvarXi12tzbOWBo7Z6AJFTBMkdO4g==
X-Google-Smtp-Source: APiQypJ7jX6v4faCbJq6LaiZYV0y3khBI2i8+c6ld2Tla/w03R+TMANq3dhbmOA8LbECC3Cq5F02TcLexA9I9wc/TCY=
X-Received: by 2002:a05:620a:166d:: with SMTP id d13mr9476035qko.448.1587751955516;
 Fri, 24 Apr 2020 11:12:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200424174805.28b8d463@canb.auug.org.au> <f11ce3ab-9ede-6241-d648-1a2b34e1ea4b@infradead.org>
 <CAEf4BzaEjNKU0rV-im2aU1j0xrdYZhC61OLnu31iWy8G4S+yew@mail.gmail.com>
In-Reply-To: <CAEf4BzaEjNKU0rV-im2aU1j0xrdYZhC61OLnu31iWy8G4S+yew@mail.gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Fri, 24 Apr 2020 11:12:23 -0700
Message-ID: <CAKH8qBsBvKHswiX1nx40LgO+BGeTmb1NX8tiTttt_0uu6T3dCA@mail.gmail.com>
Subject: Re: linux-next: Tree for Apr 24 (kernel/bpf/cgroup.c)
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 24, 2020 at 11:07 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Apr 24, 2020 at 8:30 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> >
> > On 4/24/20 12:48 AM, Stephen Rothwell wrote:
> > > Hi all,
> > >
> > > Changes since 20200423:
> > >
> >
> > on i386:
> >
> > ld: kernel/bpf/cgroup.o: in function `cgroup_base_func_proto.isra.11':
> > cgroup.c:(.text+0x14a1): undefined reference to `bpf_event_output_data_proto'
> > ld: cgroup.c:(.text+0x14c1): undefined reference to `bpf_base_func_proto'
> >
>
> Stanislav, could you please take a look?
Sure, looking ...
