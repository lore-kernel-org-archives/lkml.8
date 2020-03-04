Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A3CC3F2CD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 15:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51C4E21741
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 15:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HZFS1+E3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729652AbgCDPSd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 10:18:33 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36800 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729633AbgCDPSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 10:18:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583335111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GkHSzVp8bmma3Su8zlIo0I8lOwWNm++b2FMG0SY0gfM=;
        b=HZFS1+E3Ylrs/ghvP4abNxDfi0uwwLOazeLdomb9Jups0Pixnf+MEOSjMal5X1JETswgr/
        fypG1vCy1vV81/T7uHGgkSYrFfMrSMN7Ws8yViA3ogyuQLZ9cCD14/g0kPsk947tWviTb5
        8oy0KsFXf7r+QeuYKfh554oBEe/7fD8=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-eg-dk37ROVy7xQHnDeeoRw-1; Wed, 04 Mar 2020 10:18:27 -0500
X-MC-Unique: eg-dk37ROVy7xQHnDeeoRw-1
Received: by mail-qk1-f199.google.com with SMTP id t186so1525905qkf.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 07:18:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GkHSzVp8bmma3Su8zlIo0I8lOwWNm++b2FMG0SY0gfM=;
        b=bK78LjDOFJXmRK2D8Zmp2lDSpz0LXPy/2Q1fFqNSJxL/OvhM3xISyAdpSu58NVe4GP
         Bem+luk2IpW0PnvO9aRRKtm+lEletghJTTYxuWBK2J4fUbHFUuuP6a/yXNn9SweBc3ld
         IjPYpD3uX/ZwIhgKayHMWhksIIbu+Mp9aQzF/nGz5370BH4pP4v8Qe285JrUWC+vp45x
         D10VK60N/Qbwcioa+TLMfD0sCcVAeh4nWb0tw8zOB9XaC9Vp2nOs1QEthBxkSrFXnnXl
         UpNz0AK+aBmG4ALrfPsncIQFYFIUDPfgppl+AnuQ/RWb6EFwLZJMuQdvNgtXWeKmsQ+i
         qE/g==
X-Gm-Message-State: ANhLgQ0PMa4Ne+lgicuUMaloh1cmEblfoTydG1FCj5h5mbVPYRRbJnRa
        ROii2AEIjyhko4nSL+gwIyVNPr1q5ctSlFn3uzHWpx7Ou8vm0QJ9YGXUhdmZd/cQG7WmWkTwgJD
        YTfg0rAm0xu3+RhHR28gCHnUE
X-Received: by 2002:aed:2ee5:: with SMTP id k92mr2767098qtd.373.1583335107421;
        Wed, 04 Mar 2020 07:18:27 -0800 (PST)
X-Google-Smtp-Source: ADFU+vtQYGuhCn6y4jOYnVtHaVm1THfFPu8cJ2tiqlGcqwyccMi7LcH/Ht6thHqAW7lpUyEXX4OHAA==
X-Received: by 2002:aed:2ee5:: with SMTP id k92mr2767072qtd.373.1583335107167;
        Wed, 04 Mar 2020 07:18:27 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id l184sm13906536qkc.107.2020.03.04.07.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 07:18:26 -0800 (PST)
Date:   Wed, 4 Mar 2020 10:18:25 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linmiaohe <linmiaohe@huawei.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [PATCH] KVM: X86: Avoid explictly fetch instruction in
 x86_decode_insn()
Message-ID: <20200304151825.GA7146@xz-x1>
References: <05ca4e7e070844dd92e4f673a1bc15d9@huawei.com>
 <593e16d8-1021-29ef-11d0-a72d762db057@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <593e16d8-1021-29ef-11d0-a72d762db057@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 04, 2020 at 08:30:49AM +0100, Paolo Bonzini wrote:
> On 04/03/20 03:37, linmiaohe wrote:
> > Hi:
> > Peter Xu <peterx@redhat.com> writes:
> >> insn_fetch() will always implicitly refill instruction buffer properly when the buffer is empty, so we don't need to explicitly fetch it even if insn_len==0 for x86_decode_insn().
> >>
> >> Signed-off-by: Peter Xu <peterx@redhat.com>
> >> ---
> >> arch/x86/kvm/emulate.c | 5 -----
> >> 1 file changed, 5 deletions(-)
> >>
> >> diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c index dd19fb3539e0..04f33c1ca926 100644
> >> --- a/arch/x86/kvm/emulate.c
> >> +++ b/arch/x86/kvm/emulate.c
> >> @@ -5175,11 +5175,6 @@ int x86_decode_insn(struct x86_emulate_ctxt *ctxt, void *insn, int insn_len)
> >> 	ctxt->opcode_len = 1;
> >> 	if (insn_len > 0)
> >> 		memcpy(ctxt->fetch.data, insn, insn_len);
> >> -	else {
> >> -		rc = __do_insn_fetch_bytes(ctxt, 1);
> >> -		if (rc != X86EMUL_CONTINUE)
> >> -			goto done;
> >> -	}
> >>
> >> 	switch (mode) {
> >> 	case X86EMUL_MODE_REAL:
> 
> This is a a small (but measurable) optimization; going through
> __do_insn_fetch_bytes instead of do_insn_fetch_bytes is a little bit
> faster because it lets you mark the branch in do_insn_fetch_bytes as
> unlikely, and in general it allows the branch predictor to do a better job.

Ah I see, that makes sense.  Thanks!

-- 
Peter Xu

