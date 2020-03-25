Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC33C54FCF
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 15:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ED7A2073E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 15:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jf9VMJu8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgCYPe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 11:34:26 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42993 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727491AbgCYPe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 11:34:26 -0400
Received: by mail-pf1-f196.google.com with SMTP id 22so1194365pfa.9
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 08:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ehziNPeaBvtJLg13Ry2+oGWqU/h8Z30gqipX1jtupZo=;
        b=jf9VMJu8DVs0x+Z49kPRCZTQoMvHgkYdC9Kpmy0uQgm4UR9jFf/L7dIviuoIwP9ZNi
         iiac4DCON+0EuJPysY6VP8AqQwEHrl0R5fMHVBTeNtr8ohxjVd6nOXrFqQDEFIu5CDRY
         fxLV9xf1LaZTggHKl75w0RxgGrxFRHowY8HBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ehziNPeaBvtJLg13Ry2+oGWqU/h8Z30gqipX1jtupZo=;
        b=j+MbjCgVVDUTCPJ8UmdzIf4qYYccm9qw2Ivk/5h1N8ymZUJYx5sNaMsZ30PPNgfKss
         2ZYk6TcNAFN6+ia9WN+AGtdi8fuXy/mSSnc2F2X1ENmgtjXd/DiEAtNDYNv0SFhxX0EM
         bWYJGdJkuFfVNjLu1Pvldqm4sPNeRzfY+U1XfdpWicjMfO5CLeP+lCLfGK8sUxkRHsw3
         5M1r+Y3wuIMXwEsDjYyqN9z/YT0RUDqKt8rApWoAbCHcngjxhHfu6kwn47R+a4Lbphko
         VtdfbW1ubEeeoPL8NYNiCTJ2jS4bdxddgOI15d2HBafkk6jYh974wnMqmO1x2yPGP2jI
         UbGQ==
X-Gm-Message-State: ANhLgQ05y9bC4Mxf3A4DdAulHHZmKGx52Gv79A2U8h2PRO+n+uE0ZsnW
        uEpojB+CqBKpG77EN7SWVuiIks1yxn8=
X-Google-Smtp-Source: ADFU+vuE/OkWaSorz352VE4048NKpohcauVrFpF0sseKDb5HdyB0hC6/0vZ+ltQJWrYg+Ox9ctjKFw==
X-Received: by 2002:a62:7811:: with SMTP id t17mr4024383pfc.268.1585150465380;
        Wed, 25 Mar 2020 08:34:25 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a24sm18272569pfl.115.2020.03.25.08.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 08:34:24 -0700 (PDT)
Date:   Wed, 25 Mar 2020 08:34:23 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        arjan@linux.intel.com, rick.p.edgecombe@intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: Re: [RFC PATCH 05/11] x86: Makefile: Add build and config option for
 CONFIG_FG_KASLR
Message-ID: <202003250832.058B12D3@keescook>
References: <20200205223950.1212394-1-kristen@linux.intel.com>
 <20200205223950.1212394-6-kristen@linux.intel.com>
 <20200225175544.GA1385238@rani.riverdale.lan>
 <a01e6b2f0a19f0ace0b5f2c8a50cafccc9b4ef60.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a01e6b2f0a19f0ace0b5f2c8a50cafccc9b4ef60.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 02:24:51PM -0700, Kristen Carlson Accardi wrote:
> On Tue, 2020-02-25 at 12:55 -0500, Arvind Sankar wrote:
> > On Wed, Feb 05, 2020 at 02:39:44PM -0800, Kristen Carlson Accardi
> > wrote:
> > > Allow user to select CONFIG_FG_KASLR if dependencies are met.
> > > Change
> > > the make file to build with -ffunction-sections if CONFIG_FG_KASLR
> > > 
> > > Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> > > ---
> > >  Makefile         |  4 ++++
> > >  arch/x86/Kconfig | 13 +++++++++++++
> > >  2 files changed, 17 insertions(+)
> > > 
> > > diff --git a/Makefile b/Makefile
> > > index c50ef91f6136..41438a921666 100644
> > > --- a/Makefile
> > > +++ b/Makefile
> > > @@ -846,6 +846,10 @@ ifdef CONFIG_LIVEPATCH
> > >  KBUILD_CFLAGS += $(call cc-option, -flive-patching=inline-clone)
> > >  endif
> > >  
> > > +ifdef CONFIG_FG_KASLR
> > > +KBUILD_CFLAGS += -ffunction-sections
> > > +endif
> > > +
> > 
> > With -ffunction-sections I get a few unreachable code warnings from
> > objtool.
> > 
> > [...]
> > net/mac80211/ibss.o: warning: objtool:
> > ieee80211_ibss_work.cold()+0x157: unreachable instruction
> > drivers/net/ethernet/intel/e1000/e1000_main.o: warning: objtool:
> > e1000_clean.cold()+0x0: unreachable instruction
> > net/core/skbuff.o: warning: objtool: skb_dump.cold()+0x3fd:
> > unreachable instruction
> 
> I'm still working on a solution, but the issue here is that any .cold
> function is going to be in a different section than the related
> function, and when objtool is searching for instructions in
> find_insn(), it assumes that it must be in the same section as the
> caller.

Can we teach objtool about this? It doesn't seem too unreasonable.

-- 
Kees Cook
