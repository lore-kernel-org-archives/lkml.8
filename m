Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF5A6C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 16:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 915F120714
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 16:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ng1G/VSw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgBJQgc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 11:36:32 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46196 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727840AbgBJQgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 11:36:32 -0500
Received: by mail-qt1-f195.google.com with SMTP id e21so1572386qtp.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 08:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=B82P8bR5ozDn3yo+U/Bu+4ns+QtyTtYccr3OgXM2Xto=;
        b=ng1G/VSw9LRJOGQ1b6uRbkUgf37UT3j939mOC/5gYT9UUEFV3K9QbsTejURWL01vLe
         rmgHOjhlMXui4fo07OLbG88qSfkSbXMR0ti2l9a/Zu8qAtzhImtWAFOm4E9VCIcyf3ft
         +8VvpSZ7CXcUx/r+OE8G14NpzjP8nvDqR49PbWCEPFRMxE6MejJOT4VGgxdq5qSY31cL
         Tw9kxO4TfQ7bWh0xD9zJRZOpgUJe1D4j9zIxFSa9mHovxIAmZuVAdRfgHicFGiVwi4iU
         OUnL90cliCXC+I9LtanC8Q1JIFuXx5BdlxLeEX9DablDUFMfIS8auz1nJS4qx5bj6BA8
         d3lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=B82P8bR5ozDn3yo+U/Bu+4ns+QtyTtYccr3OgXM2Xto=;
        b=eapQsAuH6+dGuA+kdRuzsVMBRANsolo7xfGLR7zLZFxsdPwjh1D7nBreRhvZhsGNr7
         ZmLsKyupkThDPnhVKJATVh7sBWlSEWu1uP4efYEA1pbhQtpKNT3OvcUGHelob2xm4/Iv
         aa99WlXuOuXRUg08vHOT7ywxVDL/78/p7uDP6JOkZpOBon/b8MfzenO9oMX5s+j9JRUZ
         KSY8lI+BIc5FywnNCEbLyQ9UdLKKhzordjfV82No0mb5b1q5wGJchm0aWoICMlcpn1BU
         6um/CIIHmY2ItJpM/DWediNW3Q9LaWhoOatvZL/kMljF5HAaSFmLI+qEc7z65Ms+QldT
         8pcg==
X-Gm-Message-State: APjAAAU0boWp08Mxhb3Jj8pIT5bKyPLK4fNMDhQpMiItkr9XtgHOLHgi
        ilaHdRu5sUlEVZOAk2ikPXw=
X-Google-Smtp-Source: APXvYqzcAeFu0IQPSK1BaoWoskfgcIaIoF3n5FvQ9/vQqw2qowCXX07aaHHNTwtuTQh9RE43OOmpHQ==
X-Received: by 2002:aed:234a:: with SMTP id i10mr10644028qtc.155.1581352591251;
        Mon, 10 Feb 2020 08:36:31 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id 24sm395392qka.32.2020.02.10.08.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 08:36:30 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Mon, 10 Feb 2020 11:36:29 -0500
To:     Arjan van de Ven <arjan@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        rick.p.edgecombe@intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: Re: [RFC PATCH 06/11] x86: make sure _etext includes function
 sections
Message-ID: <20200210163627.GA1829035@rani.riverdale.lan>
References: <75f0bd0365857ba4442ee69016b63764a8d2ad68.camel@linux.intel.com>
 <B413445A-F1F0-4FB7-AA9F-C5FF4CEFF5F5@amacapital.net>
 <20200207092423.GC14914@hirez.programming.kicks-ass.net>
 <202002091742.7B1E6BF19@keescook>
 <20200210105117.GE14879@hirez.programming.kicks-ass.net>
 <43b7ba31-6dca-488b-8a0e-72d9fdfd1a6b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <43b7ba31-6dca-488b-8a0e-72d9fdfd1a6b@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 07:54:58AM -0800, Arjan van de Ven wrote:
> > 
> > I'll leave it to others to figure out the exact details. But afaict it
> > should be possible to have fine-grained-randomization and preserve the
> > workaround in the end.
> > 
> 
> the most obvious "solution" is to compile with an alignment of 4 bytes (so tight packing)
> and then in the randomizer preserve the offset within 32 bytes, no matter what it is
> 
> that would get you an average padding of 16 bytes which is a bit more than now but not too insane
> (queue Kees' argument that tiny bits of padding are actually good)
> 

With the patchset for adding the mbranches-within-32B-boundaries option,
the section alignment gets forced to 32. With function-sections that
means function alignment has to be 32 too.
