Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31586C3F2D2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 17:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0467720848
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 17:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XyHzg8iL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbgCERux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 12:50:53 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:41356 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbgCERuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 12:50:52 -0500
Received: by mail-io1-f68.google.com with SMTP id m25so7421981ioo.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 09:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mBJW8gx1NwCYJZ6C32I3khXprWS5Apfr0LoAE1ulS3s=;
        b=XyHzg8iLZH7P0rhH3rE0jN5n16xEWeerk/1VglLKBH79VGIHzvfeKOHOeudeRDq3/d
         wy9Kv7/34MgHYuJyP0YVav7XXJZPjLmYpD1CxiOAQPx2fX44JFWVEm+dDtnYTO0/uqqK
         blg6BpKtRQ7v0FZKVYymkfPgrAwYEuG6V0DYd/ys2v/fw0o61OTRP0Q76V/Cn+S6+7UO
         fDk7M+YSeFQF754MJ9wGAopxvzr9ZfSf3xu9ZaRQgcfP5FnL/KaU5D0mITTB/z8vHF/o
         TXOWHnUe9yA7QRGpXk0rRNY6aXRwa2FXbGXBTH3j2vgwgI+KUFn8wnfeocl6ryR4lAUQ
         HFOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mBJW8gx1NwCYJZ6C32I3khXprWS5Apfr0LoAE1ulS3s=;
        b=tvR9443QdgGtZ4NNHRvc/pkNOcrXWWE3lBdtWEXGbdU4ovaPaVAEmG+TRJwTpFbvc0
         FQ0nzpHLtI6xZUUnHTN2yGXTs22LUqz2O3H0S4t4MI7S2W2X03nq4LPeFAt2GdfYEmb+
         /SkWGyenovjxrsBNzBOjV7DC1P+sjh9yDWpboiQW7kRS5OzlfA2hHbdRNSqzaWZc2/x3
         OZ8Aao8JnRkUJEHDU6Vj6oFOx2YuBCqf+zns+XZCJy54eXD52XBNHQfoCZV1EX/HRn76
         PVtm3u4ZnHBQsJKLu/sMAYK5tE7PlpP6eadXhPer57NxvRPz/+WZo8OtTwsFmuKvI70W
         Ba+w==
X-Gm-Message-State: ANhLgQ0F35+8cg7L/AMxV4+Wsi3cYRK/sYqG+bic1McK+xCBT+mjUYWH
        UXvj+uA2EYEP3iY9AKeN65gAmXFTqDuBgYtgy+loPw==
X-Google-Smtp-Source: ADFU+vs9mRG6buUFyFenHhZkZYsOCQR1UlmRJtgW3eoRkiYe2W3LQWoXjMdPel2HVF3er/yDD84olthYFESdHMl+Uhg=
X-Received: by 2002:a02:cf0f:: with SMTP id q15mr8987301jar.48.1583430651537;
 Thu, 05 Mar 2020 09:50:51 -0800 (PST)
MIME-Version: 1.0
References: <20200305013437.8578-1-sean.j.christopherson@intel.com> <20200305013437.8578-2-sean.j.christopherson@intel.com>
In-Reply-To: <20200305013437.8578-2-sean.j.christopherson@intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 5 Mar 2020 09:50:40 -0800
Message-ID: <CALMp9eRMxNWYOO3h70UV2gbC_bO8Qo0GqBmKHsduJRW8o_fV5Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] KVM: x86: Trace the original requested CPUID
 function in kvm_cpuid()
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Pu Wen <puwen@hygon.cn>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 4, 2020 at 5:34 PM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> Trace the requested CPUID function instead of the effective function,
> e.g. if the requested function is out-of-range and KVM is emulating an
> Intel CPU, as the intent of the tracepoint is to show if the output came
> from the actual leaf as opposed to the max basic leaf via redirection.
>
> Similarly, leave "found" as is, i.e. report that an entry was found if
> and only if the requested entry was found.
>
> Fixes: 43561123ab37 ("kvm: x86: Improve emulation of CPUID leaves 0BH and 1FH")
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> [Sean: Drop "found" semantic change, reword changelong accordingly ]
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
