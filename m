Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82105C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 19:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 581F32077C
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 19:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579809502;
	bh=sU80fsOekxLpgaTif3qrfQ1Rkdape8dIBEkdI7tXP74=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=w/cWt44E8hwuRACzhMVhSW/hvTImBc4DDK0eHVn9Mp59uWrnTjKU1GzDVWN1Qzikg
	 FSADFl+6HkBksFcPRr19TOgWH4HNKcv6rMLZRpPOL4zQT5Q6cxtEhzdoGllWpVAn51
	 NLVQ6lAsKTjTHWNPpusMzrmn/y7SYLlDtPQ7WHMs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729076AbgAWT6V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 14:58:21 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40151 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727816AbgAWT6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 14:58:20 -0500
Received: by mail-lj1-f196.google.com with SMTP id n18so5038382ljo.7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 11:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8DVtOQwrFkEAE5or+ctC9NfF/UngBhO5F9zvyg/cwIE=;
        b=eQxTZQW0N74htNr8ZIoBTg2RQDPW3OjTEHCMc4sFe5oYhaOUGSJvrl6o1eL0CZRoF6
         x82sJpEoaWzhBeyAQr4AJVLWbXFgY8LgUhy1SsB1ddXX6DI1lqW3atZTfWsWptXew+SX
         fwPcf1xNLR3ZLFeVh0I0M9xVVUDiWrMIvhW4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8DVtOQwrFkEAE5or+ctC9NfF/UngBhO5F9zvyg/cwIE=;
        b=nz60ZZydGjb6yRtGCh/+n8IPl9xmaHyyF2ZkZithJwb6VoA91wN1bBsM7LPYM7yxz5
         n/Ui651k4rY14/BTWGFWqiZfOJl7MF8rAvWJpyxJGAfAe4+GNYg+unKyJu3/JFxsxP10
         Z+NfSI7ttjV+Jd4j/o8kkBxT4YUzkKitlr7ANAeeci02crVTrt/NN8ey/I7Jo6x/kKYn
         aJvvvGxC6l76K3yoB18SdSOEPOKNrOu1WCuqUv2UVVtJ2N+VvlegeYiZhRh3Rs2kBxQM
         GRFoSUobYPMGPiqlUNbbPmTPNMFJwisrMCW0mHj2KRdr3kyvr0myNDHDZCwfPzJRfSx4
         K5ZQ==
X-Gm-Message-State: APjAAAUukeKGXZLA2kJSqCrUAgIrSi9BQhHI4lUQs5R5/8Rab7ikKK55
        OufvGT5GxGXvg5PylOOhNq4xOqSjnDc=
X-Google-Smtp-Source: APXvYqyDSDXvFhTmR0tF393U+DNNQd+myVHpNKIs0TEOm8iWAExx4tHNKvp/+7cxvLCe3wPU/GI62w==
X-Received: by 2002:a2e:571d:: with SMTP id l29mr4254ljb.193.1579809498119;
        Thu, 23 Jan 2020 11:58:18 -0800 (PST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id a12sm1828308ljk.48.2020.01.23.11.58.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2020 11:58:14 -0800 (PST)
Received: by mail-lj1-f178.google.com with SMTP id o11so5058258ljc.6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 11:58:14 -0800 (PST)
X-Received: by 2002:a2e:88c5:: with SMTP id a5mr3682ljk.201.1579809493632;
 Thu, 23 Jan 2020 11:58:13 -0800 (PST)
MIME-Version: 1.0
References: <fed4f49349913cb6739dac647ba6a61d56b989d2.1579783936.git.christophe.leroy@c-s.fr>
 <e11a8f0670251267f87e3114e0bdbacb1eb72980.1579783936.git.christophe.leroy@c-s.fr>
 <CAHk-=wg4HEABOZdjxMzbembNmxs1zYfrNAEc2L+JS9FBSnM8JA@mail.gmail.com> <fc5c94a2-5a25-0715-5240-5ba3cbe0f2b2@c-s.fr>
In-Reply-To: <fc5c94a2-5a25-0715-5240-5ba3cbe0f2b2@c-s.fr>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 23 Jan 2020 11:57:57 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi8FvaeRv6PpisQ+L_Cv52yE6jCxZzUHQPZ_K7HzFkaBQ@mail.gmail.com>
Message-ID: <CAHk-=wi8FvaeRv6PpisQ+L_Cv52yE6jCxZzUHQPZ_K7HzFkaBQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] uaccess: Tell user_access_begin() if it's for a
 write or not
To:     christophe leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 23, 2020 at 11:47 AM christophe leroy
<christophe.leroy@c-s.fr> wrote:
>
> I'm going to leave it aside, at least for the time being, and do it as a
> second step later after evaluating the real performance impact. I'll
> respin tomorrow in that way.

Ok, good.

From a "narrow the access window type" standpoint it does seem to be a
good idea to specify what kind of user accesses will be done, so I
don't hate the idea, it's more that I'm not convinced it matters
enough.

On x86, we have made the rule that user_access_begin/end() can contain
_very_ few operations, and objtool really does enforce that. With
objtool and KASAN, you really end up with very small ranges of
user_access_begin/end().

And since we actually verify it statically on x86-64, I would say that
the added benefit of narrowing by access type is fairly small. We're
not going to have complicated code in that user access region, at
least in generic code.

> > Also, it shouldn't be a "is this a write". What if it's a read _and_ a
> > write? Only a write? Only a read?
>
> Indeed that was more: does it includes a write. It's either RO or RW

I would expect that most actual users would be RO or WO, so it's a bit
odd to have those choices.

Of course, often writing ends up requiring read permissions anyway if
the architecture has problems with alignment handling or similar, but
still... The real RW case does exist conceptually (we have
"copy_in_user()", after all), but still feels like it shouldn't be
seen as the only _interface_ choice.

IOW, an architecture may decide to turn WO into RW because of
architecture limitations (or, like x86 and arm, ignore the whole
RO/RW/WO _entirely_ because there's just a single "allow user space
accesses" flag), but on an interface layer if we add this flag, I
really think it should be an explicit "read or write or both".

So thus my "let's try to avoid doing it in the first place, but if we
_do_ do this, then do it right" plea.

                 Linus
