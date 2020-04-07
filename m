Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A00C2D0EC
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 22:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DFC220747
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 22:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cJvZ2cKD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgDGWMV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 18:12:21 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48657 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726380AbgDGWMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 18:12:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586297539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+76ohg15yjGQ53/NYcOF5gb3ZEmpJpgNPDQ8a4CriK8=;
        b=cJvZ2cKD9vAmengtppjIJwffVhqyeghHQlz0rCyAkqEeSPren99wtmjOh0HnM4PRcMPdv8
        608GSntEd6webY9G30Yj/4TwrrcszZb0oVj5orw+grelGfClgPt0tGd375p48EOA7aoHVn
        ioofkjkV41U1MvM9s3AzZfMTBBkzncc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-sd9nioGrNL6JI8fe_7fs1g-1; Tue, 07 Apr 2020 18:12:18 -0400
X-MC-Unique: sd9nioGrNL6JI8fe_7fs1g-1
Received: by mail-wr1-f70.google.com with SMTP id v14so2924975wrq.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 15:12:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+76ohg15yjGQ53/NYcOF5gb3ZEmpJpgNPDQ8a4CriK8=;
        b=o8W6g4JWJ4hZK9yh7Kle6nTfJOgISj5ITxNOJBZTd4BFC1nOZrTj4sEUbrqPXUnVbO
         tgbyzCjNNzL9HIv7jCgz1WWl5o11djLdtTPllgXCElxAsXFmenEWxu4p+1cCedMPnBnD
         2DcCFBFM3HgSNNyYw8+VpcGgFgb1vCWpc6QgeDtq/5fYCfiXyo5EXWKyOmEzuka6vOCd
         cKK138uoc9EUfKGmJP70n2Fjw7llM3W71TlcoWUGsz28kHYsC+04iSzTmOrpsunseKlG
         zyQ3UbUlhYr5NHDiuJAenp6SrSXRPvneU9rTSVMZGJWFsIt2JjJpAPEyfXBSAP2B1Wm9
         n9Ww==
X-Gm-Message-State: AGi0PuYR4+9Xtum7gijASpefoeZj5bLG6Q2kSUXitZ+6ggsg3c63R1Xf
        xFAeU5OEEiyxg308Xmc+IWAU8GKozH14N3MiLqDnvr8cq+qIx+1XN4qUZoEeOADtIntBrr8Bv2V
        amSlnZbaikuHeXkvRh0UX0gfk
X-Received: by 2002:adf:fecb:: with SMTP id q11mr5011771wrs.350.1586297537084;
        Tue, 07 Apr 2020 15:12:17 -0700 (PDT)
X-Google-Smtp-Source: APiQypI0zozENDA68wZyj1/iNoo3CrP+2oVdM1VBIHx12vKyt4p4dwm7FtNvUEYgy9ORH06Ztxvdpw==
X-Received: by 2002:adf:fecb:: with SMTP id q11mr5011744wrs.350.1586297536865;
        Tue, 07 Apr 2020 15:12:16 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:bd61:914:5c2f:2580? ([2001:b07:6468:f312:bd61:914:5c2f:2580])
        by smtp.gmail.com with ESMTPSA id n6sm6483443wrs.81.2020.04.07.15.12.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2020 15:12:16 -0700 (PDT)
Subject: Re: [PATCH 4/4] x86,module: Detect CRn and DRn manipulation
To:     Peter Zijlstra <peterz@infradead.org>,
        Nadav Amit <nadav.amit@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, hch@infradead.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        mingo <mingo@redhat.com>, bp <bp@alien8.de>, hpa@zytor.com,
        x86 <x86@kernel.org>, "Kenneth R. Crudup" <kenny@panix.com>,
        Jessica Yu <jeyu@kernel.org>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Tony Luck <tony.luck@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        jannh@google.com, keescook@chromium.org, David.Laight@aculab.com,
        Doug Covelli <dcovelli@vmware.com>, mhiramat@kernel.org
References: <20200407110236.930134290@infradead.org>
 <20200407111007.429362016@infradead.org>
 <10ABBCEE-A74D-4100-99D9-05B4C1758FF6@gmail.com>
 <20200407193853.GP2452@worktop.programming.kicks-ass.net>
 <90B32DAE-0BB5-4455-8F73-C43037695E7C@gmail.com>
 <20200407205042.GT2452@worktop.programming.kicks-ass.net>
 <96C2F23A-D6F4-4A04-82B6-284788C5D2CC@gmail.com>
 <20200407212754.GU2452@worktop.programming.kicks-ass.net>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e390a895-cc09-0e9b-a05d-0c9b7bc6bfbd@redhat.com>
Date:   Wed, 8 Apr 2020 00:12:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200407212754.GU2452@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/20 23:27, Peter Zijlstra wrote:
> On Tue, Apr 07, 2020 at 02:22:11PM -0700, Nadav Amit wrote:
>> Anyhow, I do not think it is the only use-case which is not covered by your
>> patches (even considering CRs/DRs alone). For example, there is no kernel
>> function to turn on CR4.VMXE, which is required to run hypervisors on x86.
> That needs an exported function; there is no way we'll allow random
> writes to CR4, there's too much dodgy stuff in there.

native_write_cr4 and pv_ops (through which you can do write_cr4) are
both exported, and so is cpu_tlbstate which is used by __cr4_set_bits
and friends.  Am I missing something glaringly obvious?

Paolo

