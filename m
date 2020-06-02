Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D40D7C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 17:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8051206C3
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 17:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591117419;
	bh=NmxHHzmeXgBSqTQznbwVLX6fsWxKeOGY6mr4ppJx8Yw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=i+A9O4rC78Ixxlf6c64fNkWhBGcNtJ8zL8dNzbrwQXfU4GDQ6agMJEXKduB/WmV8L
	 HQb9GLQFPiFiebshzD/O6nWXijqb4lzAi162wvvtO+DY0rd1QSe8NY3YrVUWBmxRYT
	 6wiaoevA0MoXNs4CBdRh5pJ13JFBqlAKAjfiWxx4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgFBRDj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 13:03:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:43416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725969AbgFBRDh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 13:03:37 -0400
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0206206C3
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 17:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591117417;
        bh=NmxHHzmeXgBSqTQznbwVLX6fsWxKeOGY6mr4ppJx8Yw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SW7cpXwIpzc2gbnz20I9frQFGlfnXLhceDHrxY5V6P22eSYotRKMcvwxLQIG9M6q1
         N2QB1KB0/zIQZ2C81douga7HylX4hz0OeafwMvAdtZ4JnjIj6aROJnAfyfHPxgcI2m
         1kW4JHbtAvBVJji2GuaOjugvKzu7c+qiFPoXLjss=
Received: by mail-wm1-f52.google.com with SMTP id c71so3627690wmd.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 10:03:36 -0700 (PDT)
X-Gm-Message-State: AOAM530c+ZhkBwLNuNv3ZK24jHybW+Rk7ZDdUJ1vAgZLzKSU20pgYjaL
        dvlfxTfhAGyJSGb6qAa9dnPwlE1Mb+jc6/Tnc1hSLw==
X-Google-Smtp-Source: ABdhPJwsbBdwU0mxZQdAHY0YhYC1GKeVfvsHIPnvYuu8omrKDCbdn+yen7kyjKBOcFzxOvcj3b/93poVB89U2I7jV7E=
X-Received: by 2002:a1c:abc3:: with SMTP id u186mr4934933wme.21.1591117415542;
 Tue, 02 Jun 2020 10:03:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200602101119.GA11634@zn.tnic> <20200602102951.GE17423@lakka.kapsi.fi>
 <20200602105649.GB11634@zn.tnic>
In-Reply-To: <20200602105649.GB11634@zn.tnic>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 2 Jun 2020 10:03:24 -0700
X-Gmail-Original-Message-ID: <CALCETrURrz=L5f-HHF3kZtUqV0dw5hAEGqSxWTsOjoZvOKaccw@mail.gmail.com>
Message-ID: <CALCETrURrz=L5f-HHF3kZtUqV0dw5hAEGqSxWTsOjoZvOKaccw@mail.gmail.com>
Subject: Re: [PATCH] arch/x86: reset MXCSR to default in kernel_fpu_begin()
To:     Borislav Petkov <bp@alien8.de>, Shuah Khan <shuah@kernel.org>
Cc:     Petteri Aimonen <jpa@git.mail.kapsi.fi>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 2, 2020 at 3:56 AM Borislav Petkov <bp@alien8.de> wrote:
>
> Hi,
>
> On Tue, Jun 02, 2020 at 01:29:51PM +0300, Petteri Aimonen wrote:
> > The kernel module is not actually x86-specific, even though it is
> > currently only enabled for x86. amdgpu driver already does kernel mode
> > floating point operations on PPC64 also, and the same module could be
> > used to test the same thing there.
>
> Then make it generic please and put the user portion in, say,
> tools/testing/selftests/fpu/ and we can ask ppc people to test it too.
> People might wanna add more stuff to it in the future, which would be
> good.
>
> > To deterministically trigger the bug, the syscall has to come from the
> > same thread that has modified MXCSR. Going through /usr/sbin/modprobe
> > won't work, and manually doing the necessary syscalls for module loading
> > seems too complicated.
>
> Ok, fair enough. But put that file in debugfs pls.

I think I agree.  While it would be delightful to have general
selftest tooling for kernel modules, we don't have that right now, and
having the test just work with an appropriately configured kernel
would be nice.

How about putting the file you frob in
/sys/kernel/debug/selftest_helpers/something_or_other.  The idea would
be that /sys/kernel/debug/selftest_helpers would be a general place
for kernel helpers needed to make selftests work.

--Andy
