Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A3F9C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 16:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C6B724670
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 16:33:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LboOsZjJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbgANQdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 11:33:01 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:44433 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbgANQdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 11:33:01 -0500
Received: by mail-qv1-f66.google.com with SMTP id n8so5927769qvg.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 08:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=g6fxF8GcJvzXVnTymdEpZbZyrCD6fVNCdWttfN1Q1PA=;
        b=LboOsZjJh3qyXMw4ezcr7+Gcjk0nh5gvAh1IikaRFjm5LbJsBpt5gC1k9NsjuoB+Zw
         TUitngO2txc3a/rvAgpoWIqZY0IpLk3u2mQLvF3V2VhrWpNp+NZFPQZanyBZ+lrIZwkX
         JGG/3Pb9mR7iKfMLbmlehKAz8a0cGCxesMsqeupMdwgD1fipv59VpA/oml8Wi0aVlt5C
         dJ05WGpsR1pjkVMbIYDmx986n225GLP3JOnLaV9is3+obQxXHrKJYpi5WWQCgqB1KN5p
         u116hcZoYXD6xAA1otsHsTEaIriwF4et7kMjodVancO6u9Wc2QZbG5CXmsh2sZCEQPNz
         u/bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=g6fxF8GcJvzXVnTymdEpZbZyrCD6fVNCdWttfN1Q1PA=;
        b=lJxIdw6dNFBpHKWqWXzzGT3PgUVqJJEDPoYGCxz/rilMEYIT1MEBe6r6FCEEbkHEKr
         gGWutxTUkRyJV4KuMeRM0X3RAlYhjODQXn4kUK7KDRvMW4ic2nzVSmUV/8Sf2O0suMEk
         3+ywyBomvvY/6g7ZeNtE4Qh1OiC6IPWRl/001nZH04S5LALUNrz8TpwWebimarOQbVKg
         QVAMgRhu4JRAZjvYbCsmM6PPq0/Yr6D8N5y54nMzGI79/Ig2otArh2u7BQ13sg7UQMnT
         msJe2RR6/s4BFiz3ocPpLI346BRc9adP4IFiaea41Dk2YrALivtFz04n88qnHEM8DDZd
         aP2A==
X-Gm-Message-State: APjAAAURmkrWLmXwTN8T7ppdsDaz7CqyK+KuKDrUEnbMT0Hwz1ypUXVn
        bQ1jP3PoAnaCI/cqyfLmkTY=
X-Google-Smtp-Source: APXvYqz0SaJa/I+hQg57kUX9faH1cUw48iFvDQr/D9QKlY34UYkM+4BtFw/IlWmBwaPauSechrF0dA==
X-Received: by 2002:a0c:ecc6:: with SMTP id o6mr21766905qvq.220.1579019580251;
        Tue, 14 Jan 2020 08:33:00 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id d143sm6932515qke.123.2020.01.14.08.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 08:32:59 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 14 Jan 2020 11:32:58 -0500
To:     Borislav Petkov <bp@alien8.de>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Michael Matz <matz@suse.de>
Subject: Re: [PATCH] x86/tools/relocs: Add _etext and __end_of_kernel_reserve
 to S_REL
Message-ID: <20200114163257.GD2536335@rani.riverdale.lan>
References: <20200110205028.GA2012059@rani.riverdale.lan>
 <20200111130243.GA23583@zn.tnic>
 <20200111172047.GA2688392@rani.riverdale.lan>
 <20200113134306.GF13310@zn.tnic>
 <20200113161310.GA191743@rani.riverdale.lan>
 <20200113163855.GK13310@zn.tnic>
 <20200113175937.GA428553@rani.riverdale.lan>
 <20200113180826.GN13310@zn.tnic>
 <20200114041725.GC2536335@rani.riverdale.lan>
 <20200114112538.GD31032@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200114112538.GD31032@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 12:25:38PM +0100, Borislav Petkov wrote:
> 
> FFS you're still missing the point: the question is whether this
> is a widespread issue - a distro shipping this funky binutils and
> therefore it being a problem on potentially more than one environment -
> or something people can only trigger by *specially* building themselves
> and thus a lot more seldom occurrence.
> 
> And I've answered the question myself by booting openSUSE 12.1 - i.e.,
> at least one distro has it.

This is just a misunderstanding on what you were asking to be added
then. I have no objections to noting that popular distros have shipped
with those problematic binutils versions, so keeping them in mind is
important.
