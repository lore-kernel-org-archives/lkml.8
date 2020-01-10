Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA5D2C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 18:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB31920838
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 18:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578682490;
	bh=mzOA+R7C05TiE08jezsPzeo1ODXOUT/JCh3YkETUgvw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=k976T2g4Y9a9HOjzlGykG7Pq8O4pWPvRKDrvF+IVF4MIY+6eKH8yxXfQEt8pSPHYh
	 09aLRIYGVJRSB4Wr3qYOJqtaYoYQDx+g8SC6x4gyq6z3RZbkmHDOWDeliVxOeOdcwE
	 itGjYA2mmKEQhXpcViP3ON3rDNoiSXqhLo/euWjY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728681AbgAJSyt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 13:54:49 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36896 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728617AbgAJSyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 13:54:49 -0500
Received: by mail-lf1-f68.google.com with SMTP id b15so2253564lfc.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 10:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j1vUATzUBpIGtELb+vItTo1wkE0Sy8cpDXXVV9tUxg4=;
        b=Asi+Td2STF/mUZRXQIv70X1R92yzc9QNkF0hyVHvxy/vDF3BWUUgKG+s5bhHF8lXm1
         pmZ9SkxNAja2H57ghybZjnyXwh47Lcye5VyMq5jcdrYG12Nfwt5EvKEWCQIqZHBmZpkZ
         bLFLUI7/QsOh+k0bjEkN1VWI8BcVEG5fhLMlc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j1vUATzUBpIGtELb+vItTo1wkE0Sy8cpDXXVV9tUxg4=;
        b=UufJ/E7GO/57OF/XbGKILxBykOR1u1ECE0wx88GkbeqvZQ7UPtn71wRv6nKDocsdKw
         18slpLj2LoAnJUqH3IP+tiLV41+hv4rJn0G/nuLyOTVp3HZ+EXm2G3nv6l5hpScQwY6B
         nTO/ocTCEdJzngSbQ26shl7x8fDuiSDv3kx1HyrBxf0WPv6BkErvi/8X4sCoGfEulcVW
         i/Lpq3eo+aKTV/GfYN26lxY5xfgtR2TDMoZqvOhtcvqulg67IR+8XZdWCoCEny3agflM
         Kf42tFlBmsdCMd44jcMzQEXOga0waw/hHMHPI21uxdU52xtyjqldm+FYJVYcDo8l4ptY
         qAZQ==
X-Gm-Message-State: APjAAAXvPZT4780J+6Ps6mUuKbZ+M+So//KLI+yHDid36CsYPVlaJgKA
        W3gJ96yPdn0X+tjRngF4cZaaZJd1fFo=
X-Google-Smtp-Source: APXvYqwq5YuYRTbF/i//odQ6g238v4URTdY0vFVnB5AU5KB8tSQi0TwsD8igL6bnpELpN+VcahBh8w==
X-Received: by 2002:a19:84d:: with SMTP id 74mr3200730lfi.122.1578682486144;
        Fri, 10 Jan 2020 10:54:46 -0800 (PST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id s13sm1441633lje.35.2020.01.10.10.54.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2020 10:54:44 -0800 (PST)
Received: by mail-lj1-f169.google.com with SMTP id o13so3184157ljg.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 10:54:43 -0800 (PST)
X-Received: by 2002:a05:651c:282:: with SMTP id b2mr3531333ljo.41.1578682483466;
 Fri, 10 Jan 2020 10:54:43 -0800 (PST)
MIME-Version: 1.0
References: <20200110165636.28035-1-will@kernel.org> <20200110165636.28035-7-will@kernel.org>
In-Reply-To: <20200110165636.28035-7-will@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 10 Jan 2020 10:54:27 -0800
X-Gmail-Original-Message-ID: <CAHk-=wia5ppBsfHLMx648utCjO01JAZiME0K0eSHmhWuRyL+6w@mail.gmail.com>
Message-ID: <CAHk-=wia5ppBsfHLMx648utCjO01JAZiME0K0eSHmhWuRyL+6w@mail.gmail.com>
Subject: Re: [RFC PATCH 6/8] READ_ONCE: Drop pointer qualifiers when reading
 from scalar types
To:     Will Deacon <will@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: multipart/mixed; boundary="000000000000a42d9d059bcda82d"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000a42d9d059bcda82d
Content-Type: text/plain; charset="UTF-8"

On Fri, Jan 10, 2020 at 8:56 AM Will Deacon <will@kernel.org> wrote:
>
> +/* Declare an unqualified scalar type. Leaves non-scalar types unchanged. */
> +#define __unqual_scalar_typeof(x) typeof(                                      \

Ugh. My eyes. That's horrendous.

I can't see any better alternatives, but it does make me go "Eww".

Well, I do see one possible alternative: just re-write the bitop
implementations in terms of "atomic_long_t", and just avoid the issue
entirely.

IOW, do something like the attached (but fleshed out and tested - this
patch has not seen a compiler, much less any thought at all).

                   Linus

--000000000000a42d9d059bcda82d
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_k58is1210>
X-Attachment-Id: f_k58is1210

IGluY2x1ZGUvYXNtLWdlbmVyaWMvYml0b3BzL2xvY2suaCB8IDEyICsrKysrKysrKy0tLQogMSBm
aWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS9pbmNsdWRlL2FzbS1nZW5lcmljL2JpdG9wcy9sb2NrLmggYi9pbmNsdWRlL2FzbS1nZW5lcmlj
L2JpdG9wcy9sb2NrLmgKaW5kZXggM2FlMDIxMzY4ZjQ4Li4wNzFkOGJmZDg2ZTUgMTAwNjQ0Ci0t
LSBhL2luY2x1ZGUvYXNtLWdlbmVyaWMvYml0b3BzL2xvY2suaAorKysgYi9pbmNsdWRlL2FzbS1n
ZW5lcmljL2JpdG9wcy9sb2NrLmgKQEAgLTYsNiArNiwxMiBAQAogI2luY2x1ZGUgPGxpbnV4L2Nv
bXBpbGVyLmg+CiAjaW5jbHVkZSA8YXNtL2JhcnJpZXIuaD4KIAorLyogRHJvcCB0aGUgdm9sYXRp
bGUsIHdlIHdpbGwgYmUgZG9pbmcgUkVBRF9PTkNFIGJ5IGhhbmQgKi8KK3N0YXRpYyBpbmxpbmUg
YXRvbWljX2xvbmdfdCAqYXRvbWljX2xvbmdfYml0X3dvcmQodW5zaWduZWQgaW50IG5yLCB2b2xh
dGlsZSB1bnNpZ25lZCBsb25nICpwKQoreworCXJldHVybiBCSVRfV09SRChucikgKyAoYXRvbWlj
X2xvbmdfdCAqKXA7Cit9CisKIC8qKgogICogdGVzdF9hbmRfc2V0X2JpdF9sb2NrIC0gU2V0IGEg
Yml0IGFuZCByZXR1cm4gaXRzIG9sZCB2YWx1ZSwgZm9yIGxvY2sKICAqIEBucjogQml0IHRvIHNl
dApAQCAtMjAsMTIgKzI2LDEyIEBAIHN0YXRpYyBpbmxpbmUgaW50IHRlc3RfYW5kX3NldF9iaXRf
bG9jayh1bnNpZ25lZCBpbnQgbnIsCiB7CiAJbG9uZyBvbGQ7CiAJdW5zaWduZWQgbG9uZyBtYXNr
ID0gQklUX01BU0sobnIpOworCWF0b21pY19sb25nX3QgKmxvYyA9IGF0b21pY19sb25nX2JpdF93
b3JkKG5yLCBwKTsKIAotCXAgKz0gQklUX1dPUkQobnIpOwotCWlmIChSRUFEX09OQ0UoKnApICYg
bWFzaykKKwlpZiAoYXRvbWljX3JlYWQobG9jKSAmIG1hc2spCiAJCXJldHVybiAxOwogCi0Jb2xk
ID0gYXRvbWljX2xvbmdfZmV0Y2hfb3JfYWNxdWlyZShtYXNrLCAoYXRvbWljX2xvbmdfdCAqKXAp
OworCW9sZCA9IGF0b21pY19sb25nX2ZldGNoX29yX2FjcXVpcmUobWFzaywgbG9jKTsKIAlyZXR1
cm4gISEob2xkICYgbWFzayk7CiB9CiAK
--000000000000a42d9d059bcda82d--
