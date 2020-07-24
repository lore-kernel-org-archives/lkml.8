Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97109C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 00:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C612206D7
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 00:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FCgBIDO4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+72kDR/M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbgGXAq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 20:46:29 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34170 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727783AbgGXAq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 20:46:29 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595551586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Rtfgquq0SEtwZ4k84B82DPLcPpqLHnp8JJ3FWAcLToc=;
        b=FCgBIDO4dFsTETDUU2z/PvMVPTNfhdLwM5G/qDHHhVn2Gs40PUDpnDpAOj3DEVrkHdll98
        7wAgbLI/+nDwQpJDtNYgT6mqBoKwiCRV4gyxmHfMOtUSi7DN6ICz3XPdRgrJd4EoAiLdpp
        eQ/9G7ynZYGbAB2vUMWGo+xiVHX0Hz7DVsxZFMJfYt3v/iLlq0+S/2M+h9DvO+DChPsK0Y
        wzni2LKKB+siE3TZ1Jv0QkYIOAqk+OMRaDafmvVfG3K0GT5ORqNRnL9fBOGKa8xDVq6LiJ
        7ihiBQyTB+GsD+mLaNyW79iXXxNhjvTggArcGvrEnykstAVlNf+queHKwAEqKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595551586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Rtfgquq0SEtwZ4k84B82DPLcPpqLHnp8JJ3FWAcLToc=;
        b=+72kDR/MnJXvaBvbhjSwQo5IS35v9oHJhgRGmkKtKtzg6sQLvwVBCrjHDfoUoWBVBeX80p
        sslkbtIwIa5O9sCA==
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Keno Fischer <keno@juliacomputing.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: [patch V5 15/15] x86/kvm: Use generic xfer to guest work function
In-Reply-To: <20200724001736.GK21891@linux.intel.com>
References: <20200722215954.464281930@linutronix.de> <20200722220520.979724969@linutronix.de> <20200724001736.GK21891@linux.intel.com>
Date:   Fri, 24 Jul 2020 02:46:26 +0200
Message-ID: <87eep1vixp.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean,

Sean Christopherson <sean.j.christopherson@intel.com> writes:
> On Thu, Jul 23, 2020 at 12:00:09AM +0200, Thomas Gleixner wrote:
>> +		if (xfer_to_guest_mode_work_pending()) {
>>  			srcu_read_unlock(&kvm->srcu, vcpu->srcu_idx);
>> -			cond_resched();
>> +			r = xfer_to_guest_mode(vcpu);
>
> Any reason not to call this xfer_to_guest_mode_work()?  Or handle_work(),
> do_work(), etc...  Without the "work" part, it looks like a function that
> should be invoked unconditionally.  It's obvious that's not the case if
> one looks at the implementation, but it's a bit confusing on the KVM side
> of things.

The reason is probably lazyness. The original approach was to have this
as close as possible to user entry/exit but with the recent changes
vs. instrumentation and RCU this is not longer the case.

I really want to keep the notion of transitioning in the function name,
so xfer_to_guest_mode_handle_work() makes a lot of sense.

I'll change that before merging the lot into the tip tree if your
Reviewed-by still stands with that change made w/o reposting.

Thanks,

        tglx
