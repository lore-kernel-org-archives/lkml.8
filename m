Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A7BC3F2C6
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 01:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5F8C20661
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 01:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iPgccfS1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387435AbgCDBGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 20:06:23 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50817 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727854AbgCDBGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 20:06:22 -0500
Received: by mail-wm1-f68.google.com with SMTP id a5so89271wmb.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 17:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ctoiEBV7oYQ+Ec8vuMBepnjoi9mkX/M9Ee8Z3sCdCxE=;
        b=iPgccfS1xG4obi2LdzeZagYxTiUM5+2sjUgn03SpxHQENWRvN8ZboigVQDfXhAuwmZ
         LG85TxJex+PPxXCRpDkeZyMh0tPHllB+HZjkxzJp/RtbP4d3oS5BpJHKKH96iKC/a0ZG
         Jo4ERdUQY+Fz6m0HJ9lPq4EbJZRBNXcUGURXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ctoiEBV7oYQ+Ec8vuMBepnjoi9mkX/M9Ee8Z3sCdCxE=;
        b=ivnNgp7NVvwNMkR1zTc3Vtjv08m8I+OYnFpL6ASdKhuoEtOZJsArFN26DsFKswowhL
         lbFHDxKBesr7Q50Ye1C/tP2ug2Lc/6FT4R00vCbE+IvNOKHZ28bqjVMbV77S57y4MUkZ
         ZDiW0p8+mALJqdwVUTaSZ8Z5amVqL0WvoGYgWqed+C8+O1gNs8nlSseLGLoCR8wp7QUa
         PxrLNhkYSLpt6HzvHE91isoqS2bKRStbOXFI8ONddstNZnKVCrylkl8BfZ9mdKwimysd
         JDpvSn9Q3BjTKAup2kCZPfZ35ZnaPocE+gu/tpeB7263DoKSbbPJZGF5gNp7e36SiMD8
         HGaQ==
X-Gm-Message-State: ANhLgQ3mSPh20WeqMm3CJV8zw1pWhPNHC8Z4QZm+yWLPtQlCsAPa9/rl
        aN8ywANEFxybcX/T7F8n9KcdTw==
X-Google-Smtp-Source: ADFU+vtUHPgMakUmvktqI1lex+5NQgqVTinEGb8RQekmdzSLGOf/IWuJ0DbbaCOZJ/J1wWXQzu0BYQ==
X-Received: by 2002:a05:600c:4108:: with SMTP id j8mr367432wmi.188.1583283978996;
        Tue, 03 Mar 2020 17:06:18 -0800 (PST)
Received: from chromium.org (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id c14sm21550977wro.36.2020.03.03.17.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 17:06:18 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Wed, 4 Mar 2020 02:06:15 +0100
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: Re: [PATCH bpf-next 4/7] bpf: Attachment verification for
 BPF_MODIFY_RETURN
Message-ID: <20200304010615.GA14634@chromium.org>
References: <20200303140950.6355-1-kpsingh@chromium.org>
 <20200303140950.6355-5-kpsingh@chromium.org>
 <CAEf4BzaviDB+WGUsg1+aO5GAtkJuQ6aYSiB8VaKL0CoQRPs8Xw@mail.gmail.com>
 <20200303232151.GB17103@chromium.org>
 <20200304000326.nk7jmkgxazl3umbh@ast-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200304000326.nk7jmkgxazl3umbh@ast-mbp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-Mär 16:03, Alexei Starovoitov wrote:
> On Wed, Mar 04, 2020 at 12:21:51AM +0100, KP Singh wrote:
> > 
> > > > +                       t = btf_type_skip_modifiers(btf, t->type, NULL);
> > > > +                       if (!btf_type_is_int(t)) {
> > > 
> > > Should the size of int be verified here? E.g., if some function
> > > returns u8, is that ok for BPF program to return, say, (1<<30) ?
> > 
> > Would this work?
> > 
> >        if (size != t->size) {
> >                bpf_log(log,
> >                        "size accessed = %d should be %d\n",
> >                        size, t->size);
> >                return false;
> >        }
> 
> It will cause spurious failures later when llvm optimizes
> if (ret & 0xff) into u8 load.
> I think btf_type_is_int() is enough as-is.

Okay skipping the size check.

- KP

