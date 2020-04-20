Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 466F5C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 17:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22EBE2078C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 17:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgDTRZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 13:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726729AbgDTRZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 13:25:34 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A3BC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 10:25:34 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jQaAb-00032c-0O; Mon, 20 Apr 2020 19:25:21 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 32130101623; Mon, 20 Apr 2020 19:25:20 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Kees Cook <keescook@chromium.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [patch 02/15] x86/cpu: Uninline CR4 accessors
In-Reply-To: <20200420090102.GB24518@infradead.org>
References: <20200419203137.214111265@linutronix.de> <20200419203335.856333226@linutronix.de> <20200420090102.GB24518@infradead.org>
Date:   Mon, 20 Apr 2020 19:25:20 +0200
Message-ID: <87v9luax33.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:
>> --- a/arch/x86/kernel/cpu/common.c
>> +++ b/arch/x86/kernel/cpu/common.c
>> @@ -387,7 +387,30 @@ void native_write_cr4(unsigned long val)
>>  			  bits_missing);
>>  	}
>>  }
>> -EXPORT_SYMBOL(native_write_cr4);
>> +#if IS_MODULE(CONFIG_LKDTM)
>> +EXPORT_SYMBOL_GPL(native_write_cr4);
>> +#endif
>
> While this is better than what we had before we really need to have
> a discussion on lkdtm - it needs a lot of crap that otherwise wouldn't
> be exported, and I'm really worried about people enabling it and thus
> adding exports even if they are conditional.  Can we force the code
> to be built in require a boot option for it to be activated?

I can live with that :)

