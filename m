Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86659C3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 15:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D84F2166E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 15:33:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VPyu0sm/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729447AbgCDPdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 10:33:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23981 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725897AbgCDPdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 10:33:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583335978;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DvMXhwaYEf1u8lhU5yD2w5KVrzZ7oi00fPBDP3UuBlI=;
        b=VPyu0sm/4C/xHixNW/EflzN6H0Q2JKnG4DqmNV4IYL05nLfoPzmRvWICQ3AGfW4rhTOBCu
        7/az4RtiN+l6fXMoUoPTNSRgog+zm5jtadKb96K+idXXVloNsvBt1DlvvTJyA40QzfWD5Z
        gKDjUTWBQHSyEpPeKXDPnEkkTLfF424=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-41TH1scaNtWcs88fk-GEcw-1; Wed, 04 Mar 2020 10:32:57 -0500
X-MC-Unique: 41TH1scaNtWcs88fk-GEcw-1
Received: by mail-qt1-f197.google.com with SMTP id d2so1680841qtr.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 07:32:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DvMXhwaYEf1u8lhU5yD2w5KVrzZ7oi00fPBDP3UuBlI=;
        b=PBxQXxf/tSLT0gJ34vIvUZDMY1dfc47qoSu2w89wVp42Ii8s0oA2XlwUhA5PtwCZvT
         FSHApTQIZS9bTfd4DXlD42mPBOqeN/fUKUYhZAe/7PclTOuL9Fr+IZrNt36F/Qwn1GSh
         4dk+yaahfYkestLWxcN1An3dzXVwwwtpnrt04uX3RLizaUX0JLmeA9ylhwU2++6YW+ct
         Pgn/notL3/W2oQBrXNUrc9nGPgFql7kVt0VrRjMiAST7+2anZOfp8GeaYx1ex4dsS6jK
         qa+1SPwS4WUEDoJU/QV1xRYjZZVFHSpriqUd7Gg+cbzgBrfFROkRks4NznUMkbz/BF84
         7P0A==
X-Gm-Message-State: ANhLgQ1/QBj1kJaWNo4x490K8Nr6lvXd61JQKG7k6qpyDMoxyD7cd7Ql
        O4c5uN3f7dnHpYWQQ+TiSAJN5CqnC0qks92i1n8l1jhUU3MYxxcQ7i7xKzobM1hNlGD7fcRTzDV
        f5XrKRleZt4jEXYR/EoNkRpTl
X-Received: by 2002:a05:6214:16c3:: with SMTP id d3mr2510370qvz.244.1583335976571;
        Wed, 04 Mar 2020 07:32:56 -0800 (PST)
X-Google-Smtp-Source: ADFU+vsWlCEhg5A5OIWwDFtxlNHlAgmp4hY10amevunpEqVD30iTAynmKtqHiq8Z/L6AG/8livfJPg==
X-Received: by 2002:a05:6214:16c3:: with SMTP id d3mr2510339qvz.244.1583335976173;
        Wed, 04 Mar 2020 07:32:56 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id c13sm8350268qtv.37.2020.03.04.07.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 07:32:55 -0800 (PST)
Date:   Wed, 4 Mar 2020 10:32:53 -0500
From:   Peter Xu <peterx@redhat.com>
To:     linmiaohe <linmiaohe@huawei.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [PATCH] KVM: X86: Avoid explictly fetch instruction in
 x86_decode_insn()
Message-ID: <20200304153253.GB7146@xz-x1>
References: <05ca4e7e070844dd92e4f673a1bc15d9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <05ca4e7e070844dd92e4f673a1bc15d9@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 04, 2020 at 02:37:06AM +0000, linmiaohe wrote:
> Hi:
> Peter Xu <peterx@redhat.com> writes:
> >insn_fetch() will always implicitly refill instruction buffer properly when the buffer is empty, so we don't need to explicitly fetch it even if insn_len==0 for x86_decode_insn().
> >
> >Signed-off-by: Peter Xu <peterx@redhat.com>
> >---
> > arch/x86/kvm/emulate.c | 5 -----
> > 1 file changed, 5 deletions(-)
> >
> >diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c index dd19fb3539e0..04f33c1ca926 100644
> >--- a/arch/x86/kvm/emulate.c
> >+++ b/arch/x86/kvm/emulate.c
> >@@ -5175,11 +5175,6 @@ int x86_decode_insn(struct x86_emulate_ctxt *ctxt, void *insn, int insn_len)
> > 	ctxt->opcode_len = 1;
> > 	if (insn_len > 0)
> > 		memcpy(ctxt->fetch.data, insn, insn_len);
> >-	else {
> >-		rc = __do_insn_fetch_bytes(ctxt, 1);
> >-		if (rc != X86EMUL_CONTINUE)
> >-			goto done;
> >-	}
> > 
> > 	switch (mode) {
> > 	case X86EMUL_MODE_REAL:
> 
> Looks good, thanks. But it seems we should also take care of the comment in __do_insn_fetch_bytes(), as we do not
> load instruction at the beginning of x86_decode_insn() now, which may be misleading:
> 		/*
>          * One instruction can only straddle two pages,
>          * and one has been loaded at the beginning of
>          * x86_decode_insn.  So, if not enough bytes
>          * still, we must have hit the 15-byte boundary.
>          */
>         if (unlikely(size < op_size))
>                 return emulate_gp(ctxt, 0);

Right, thanks for spotting that (even if the patch to be dropped :).

I guess not only the comment, but the check might even fail if we
apply the patch. Because when the fetch is the 1st attempt and
unluckily that acrosses one page boundary (because we'll only fetch
until either 15 bytes or the page boundary), so that single fetch
could be smaller than op_size provided.

Thanks,

-- 
Peter Xu

