Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D9CC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 18:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6887F206D9
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 18:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589221833;
	bh=iH2IIk8RRa3Dfi8YMD2r5/fFz7zTxf47LhjGkonFB+s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=I2dXQ6b45X6IP/uRMVCCTJl5WpgaRi3fooxOY5QsA0B4VlKEKLvBX8erEyg6eIajx
	 x6u86zUBHAl6lMdVccbEbKiUq850tkGBgUsx4hz/ZOELiITpgPw0s9rRBRh/gjX3AT
	 J3pqAoFP0WZ3CJHUnS4t2uAf4OemPrB8RL4nTEb0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731125AbgEKSac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 14:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729905AbgEKSac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 14:30:32 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74EAC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 11:30:31 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id d16so8846181edq.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 11:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xryJwG59JLB17PZEyr7DCd9/6LaHNOFAsde4B/bIMlo=;
        b=g/MBnQ5L6r5hjAiqwK3Lokfo6oOGGuM5QvnhrybDQ8sLEIE9qu0oU9BD1e40bwbjAC
         M+dhC4n2RQfKhcKsZNLukjmvWdhFWzFs4+nXX9dq4XhIt5ePh2P/IqRFgcbyzxa/All8
         k52VX6HiUg8D6PfcVMkdAhelN3aqeQxt4UIbs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xryJwG59JLB17PZEyr7DCd9/6LaHNOFAsde4B/bIMlo=;
        b=fYdknLbFWuMMXNj96oCYEvtBJUdIJOOHpJd8pXAkVJFXqhL8Vmt9OC8a3KlfIgB6qc
         YIVxUz9a3tyGuyYmS2Zq4Ud7xgLNKTvWS9AMk2hSEjtEzeCVjshDoiqbJ5nu0W1Lvukt
         CotuybGmOKjx4wft2Tp3ZkNwlGIQWBK6MLDyzMkEkxBi3A+5NMpb0nNCx1fl3WrHpjW6
         gl1jfwAK8LjTyarbI1A2ePH5V9Z+pgqtZTe5YpyDnxTMuM6cm+Oib4M1BAj/u3tYMW/8
         6x8Pq5ZO+CrJjbJ5wraYkgcbhV9s+dxLXDdaFfCxi9DmFhpXYFjdSuMASDiB1WrPVHIB
         UOpg==
X-Gm-Message-State: AGi0PuYxkOPJL6K+pyN38oWB+CXyZUYRGCE5yRo3TgIVQm+E1gS2MZNF
        3TdlQf74c7uuaNcV/g36zUkyM2U2QWM=
X-Google-Smtp-Source: APiQypLHUUGpJt9BHkMKa3OqnOfRmxbQIpX6fZ+QRNFwISKUxAvFOSP5yk6PURuT7Ul3APGr1CWe4g==
X-Received: by 2002:a50:9e6a:: with SMTP id z97mr13974085ede.375.1589221830071;
        Mon, 11 May 2020 11:30:30 -0700 (PDT)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id k21sm1283608ejr.61.2020.05.11.11.30.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2020 11:30:29 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id w7so12232043wre.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 11:30:29 -0700 (PDT)
X-Received: by 2002:a2e:9a54:: with SMTP id k20mr11787437ljj.265.1589221464037;
 Mon, 11 May 2020 11:24:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200504230309.237398-1-ndesaulniers@google.com>
 <CAKwvOdmspKUknbzDn9kY2jMgkFw=Ktvst0ZtwambDOfybqJGWw@mail.gmail.com> <CAHk-=wif=_ZomkWJAmQRCUAMHQ72V3NEQ-OteiPE56K7KoSjbQ@mail.gmail.com>
In-Reply-To: <CAHk-=wif=_ZomkWJAmQRCUAMHQ72V3NEQ-OteiPE56K7KoSjbQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 11 May 2020 11:24:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=whhCBvjXtRiFM2JEZ4XyBmuPprvdo5tpPVBqUhkRszxiQ@mail.gmail.com>
Message-ID: <CAHk-=whhCBvjXtRiFM2JEZ4XyBmuPprvdo5tpPVBqUhkRszxiQ@mail.gmail.com>
Subject: Re: [PATCH] x86: support i386 with Clang
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        David Woodhouse <dwmw2@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Golovin <dima@golovin.in>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: multipart/mixed; boundary="000000000000d91fe305a563741a"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000d91fe305a563741a
Content-Type: text/plain; charset="UTF-8"

On Mon, May 11, 2020 at 11:12 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Would using "__builtin_choose_expr()" be able to avoid this whole issue?

We actually have a fair amount of "pick expression based on size", so
with a few helper macros we could make the code look better than the
case statements too.

Something (ENTIRELY UNTESTED!) like the attached patch, perhaps?

NOTE! I only converted one single use to that "pick_size_xyz()" model.
If this actually works for clang too, we could do the others.

I guess I should just test it, since I have that clang tree.

                  Linus

--000000000000d91fe305a563741a
Content-Type: application/octet-stream; name=patch
Content-Disposition: attachment; filename=patch
Content-Transfer-Encoding: base64
Content-ID: <f_ka2tez6f0>
X-Attachment-Id: f_ka2tez6f0

IGFyY2gveDg2L2luY2x1ZGUvYXNtL3BlcmNwdS5oIHwgMzEgKysrKysrKysrKysrKysrKy0tLS0t
LS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKyksIDE1IGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3BlcmNwdS5oIGIvYXJjaC94
ODYvaW5jbHVkZS9hc20vcGVyY3B1LmgKaW5kZXggMjI3ODc5N2M3NjlkLi5iNDc5YTBlNjUwZTUg
MTAwNjQ0Ci0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3BlcmNwdS5oCisrKyBiL2FyY2gveDg2
L2luY2x1ZGUvYXNtL3BlcmNwdS5oCkBAIC04Niw2ICs4NiwxNyBAQAogLyogRm9yIGFyY2gtc3Bl
Y2lmaWMgY29kZSwgd2UgY2FuIHVzZSBkaXJlY3Qgc2luZ2xlLWluc24gb3BzICh0aGV5CiAgKiBk
b24ndCBnaXZlIGFuIGx2YWx1ZSB0aG91Z2gpLiAqLwogZXh0ZXJuIHZvaWQgX19iYWRfcGVyY3B1
X3NpemUodm9pZCk7CitleHRlcm4gdm9pZCBfX2JhZF9leHByX3NpemUodm9pZCk7CisKKyNkZWZp
bmUgcGlja190eXBlX2V4cHJlc3Npb24oeCwgZTgsIGUxNiwgZTMyLCBlNjQpCVwKKwlfX2J1aWx0
aW5fY2hvb3NlX2V4cHIoc2l6ZW9mKHgpPT0xLCBlOCwJCVwKKwlfX2J1aWx0aW5fY2hvb3NlX2V4
cHIoc2l6ZW9mKHgpPT0yLCBlMTYsCVwKKwlfX2J1aWx0aW5fY2hvb3NlX2V4cHIoc2l6ZW9mKHgp
PT00LCBlMzIsCVwKKwlfX2J1aWx0aW5fY2hvb3NlX2V4cHIoc2l6ZW9mKHgpPT04LCBlNjQsCVwK
KwlfX2JhZF9leHByX3NpemUoKSkpKSkKKworI2RlZmluZSBwaWNrX3R5cGVfc3RhdGVtZW50KHgs
IHM4LCBzMTYsIHMzMiwgczY0KSBcCisJcGlja190eXBlX2V4cHJlc3Npb24oeCwgKHtzODswO30p
LCAoe3MxNjswO30pLCh7czMyOzA7fSksKHtzNjQ7MDt9KSkKIAogI2RlZmluZSBwZXJjcHVfdG9f
b3AocXVhbCwgb3AsIHZhciwgdmFsKQkJXAogZG8gewkJCQkJCQlcCkBAIC05NSwyOSArMTA2LDE5
IEBAIGRvIHsJCQkJCQkJXAogCQlwdG9fdG1wX18gPSAodmFsKTsJCQlcCiAJCSh2b2lkKXB0b190
bXBfXzsJCQlcCiAJfQkJCQkJCVwKLQlzd2l0Y2ggKHNpemVvZih2YXIpKSB7CQkJCVwKLQljYXNl
IDE6CQkJCQkJXAorCXBpY2tfdHlwZV9zdGF0ZW1lbnQodmFyLAkJCVwKIAkJYXNtIHF1YWwgKG9w
ICJiICUxLCJfX3BlcmNwdV9hcmcoMCkJXAogCQkgICAgOiAiK20iICh2YXIpCQkJXAotCQkgICAg
OiAicWkiICgocHRvX1RfXykodmFsKSkpOwkJXAotCQlicmVhazsJCQkJCVwKLQljYXNlIDI6CQkJ
CQkJXAorCQkgICAgOiAicWkiICgocHRvX1RfXykodmFsKSkpLAkJXAogCQlhc20gcXVhbCAob3Ag
IncgJTEsIl9fcGVyY3B1X2FyZygwKQlcCiAJCSAgICA6ICIrbSIgKHZhcikJCQlcCi0JCSAgICA6
ICJyaSIgKChwdG9fVF9fKSh2YWwpKSk7CQlcCi0JCWJyZWFrOwkJCQkJXAotCWNhc2UgNDoJCQkJ
CQlcCisJCSAgICA6ICJyaSIgKChwdG9fVF9fKSh2YWwpKSksCQlcCiAJCWFzbSBxdWFsIChvcCAi
bCAlMSwiX19wZXJjcHVfYXJnKDApCVwKIAkJICAgIDogIittIiAodmFyKQkJCVwKLQkJICAgIDog
InJpIiAoKHB0b19UX18pKHZhbCkpKTsJCVwKLQkJYnJlYWs7CQkJCQlcCi0JY2FzZSA4OgkJCQkJ
CVwKKwkJICAgIDogInJpIiAoKHB0b19UX18pKHZhbCkpKSwJCVwKIAkJYXNtIHF1YWwgKG9wICJx
ICUxLCJfX3BlcmNwdV9hcmcoMCkJXAogCQkgICAgOiAiK20iICh2YXIpCQkJXAotCQkgICAgOiAi
cmUiICgocHRvX1RfXykodmFsKSkpOwkJXAotCQlicmVhazsJCQkJCVwKLQlkZWZhdWx0OiBfX2Jh
ZF9wZXJjcHVfc2l6ZSgpOwkJCVwKLQl9CQkJCQkJXAorCQkgICAgOiAicmUiICgocHRvX1RfXyko
dmFsKSkpKTsJCVwKIH0gd2hpbGUgKDApCiAKIC8qCg==
--000000000000d91fe305a563741a--
