Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFBFCC3F2CD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 15:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A27F121775
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 15:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SUIT7ybv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387600AbgCDPNl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 10:13:41 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35697 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbgCDPNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 10:13:40 -0500
Received: by mail-wr1-f65.google.com with SMTP id r7so2863053wro.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 07:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=fsgJGQMpQ1G9tftbB0Mps00ljMhlrkE3dAL7nSnd3vo=;
        b=SUIT7ybvralMQlOhJIjHu6ly0ZrFuMBji/zcuoM0lUme2+qnQIfCnvpMGvJy4bjzqE
         jjLsZAJziFoMM3AKjRXlddNWJPUuwwfWaOPOVzfgJtf0tPyS9kXqW/KaApFrz19w6HHu
         nskZiLoYB7+X9+SdAd9lrYl3Rtsa3eW2hwYXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=fsgJGQMpQ1G9tftbB0Mps00ljMhlrkE3dAL7nSnd3vo=;
        b=NpdeXgdKgtCWQRRxHz9bIDle0gS7BgIHXR9mgaUKvxTvcrE4u3Jj97Wxyh6Is306h9
         /bLVnfYD1bslYMQv48e/tgJnXHCRiGDlv93lF68WYEBqmCqLm7RdLV6zu0VCLdNcIIy+
         4X8Ithy2hctQEjLPDd2pKv+SBkumtFvTlqjWy3j1AN2IGrAa7BF+0OZQYI5BwVi3xx3i
         ttI6d7RvstZKUbFmsxvPHAhvPcAQ2knCysuXH64Bz2PyR0MeJOA6mVKdFrqk81hho8qW
         FIYF5rs3pjwXukCJwLNWHs98G7Jsuya276Nszw4fiYPhojw5z9w5aErF6rMpb/RuwIfU
         rGpQ==
X-Gm-Message-State: ANhLgQ1aD+gT8MNZ2mI/h5jyaNcaSoeexnjdUxdJ9/uAZpEtpWbC9thP
        sM88Apf7hIOLscH31Ez2a7UtLA==
X-Google-Smtp-Source: ADFU+vuLe5ALaEm7h3gtz45GbwJ5nu0Ea3aTrgxaP+bm5Zu/T7rBxy4ewEXTQPFiSC0nAd34IQszeA==
X-Received: by 2002:a5d:6086:: with SMTP id w6mr4494482wrt.224.1583334819160;
        Wed, 04 Mar 2020 07:13:39 -0800 (PST)
Received: from chromium.org ([2a00:79e1:abc:308:8ca0:6f80:af01:b24])
        by smtp.gmail.com with ESMTPSA id x13sm69264wmi.35.2020.03.04.07.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 07:13:38 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Wed, 4 Mar 2020 16:13:37 +0100
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     linux-security-module@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: Re: [PATCH bpf-next v2 4/7] bpf: Attachment verification for
 BPF_MODIFY_RETURN
Message-ID: <20200304151337.GD9984@chromium.org>
References: <20200304015528.29661-1-kpsingh@chromium.org>
 <20200304015528.29661-5-kpsingh@chromium.org>
 <CAEf4BzZdR-PTFZT5VJ7kMw=FNhsCUpbQvdypEWSF1JNuaye6Kw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZdR-PTFZT5VJ7kMw=FNhsCUpbQvdypEWSF1JNuaye6Kw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-Mär 21:12, Andrii Nakryiko wrote:
> On Tue, Mar 3, 2020 at 5:56 PM KP Singh <kpsingh@chromium.org> wrote:
> >
> > From: KP Singh <kpsingh@google.com>
> >
> > - Allow BPF_MODIFY_RETURN attachment only to functions that are:
> >
> >     * Whitelisted by for error injection i.e. by checking
> >       within_error_injection_list. Similar disucssions happened for the
> >       bpf_overrie_return helper.
> 
> 2 typos: discussions and bpf_override_return ;)

/me bows his head in shame ;) Fixed.

 -KP

> 
> >
> >     * security hooks, this is expected to be cleaned up with the LSM
> >       changes after the KRSI patches introduce the LSM_HOOK macro:
> >
> >         https://lore.kernel.org/bpf/20200220175250.10795-1-kpsingh@chromium.org/
> >
> > - The attachment is currently limited to functions that return an int.
> >   This can be extended later other types (e.g. PTR).
> >
> > Signed-off-by: KP Singh <kpsingh@google.com>
> > ---
> 
> Acked-by: Andrii Nakryiko <andriin@fb.com>
> 
> >  kernel/bpf/btf.c      | 28 ++++++++++++++++++++--------
> >  kernel/bpf/verifier.c | 31 +++++++++++++++++++++++++++++++
> >  2 files changed, 51 insertions(+), 8 deletions(-)
> >
> 
> [...]
