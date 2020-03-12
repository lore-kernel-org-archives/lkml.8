Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB40C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 18:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8A9220716
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 18:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GFtRQJZS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgCLSX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 14:23:27 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43715 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgCLSX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 14:23:27 -0400
Received: by mail-qk1-f196.google.com with SMTP id x1so3041551qkx.10
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 11:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KxnAiQqGtQG3PAEgS1iE2wCQbvzYL1ksqjGBfgm+opI=;
        b=GFtRQJZSHmlsoDyEoCHGWkgNm7BH3WIpjbXqhmdiheyppLCNcGmx2NSx0oSMzW5JZC
         RghZcr5DJf9CxKQWwxiSXD8jI0qVSBVwcZ+MwJdAx5im2mG0WhWl9jyNlNV1nE+Odjzv
         2Q3Vr1LTiu+q2WYSYUmkSWaktgJHehPVvgRzCqQAjVq4J7WcGndJtaYZVrapfrXx2RCa
         YM6opjYUX9T5I/aWoButEjM77tw2nPkQs+x8enJpbaWUtiiLqtTiWnhBJnkYILiwJqzI
         CWxPItbYZJ1G+S9t6vE/ZBFqMN7ICm0VRFAqYiLR1xk4br6kwzc6v6fAUB+AbRGVt8ng
         hUbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=KxnAiQqGtQG3PAEgS1iE2wCQbvzYL1ksqjGBfgm+opI=;
        b=I3EXskNG+JYqXRDQK7obDvOuNSPYxQAg90n+8kc2fSEAH/+XdQ1T0iJeLAxw4eRg0Z
         rnSpuwAlkwQu3ckJHGdUfA3BuOk3+oBNoTYgj08ZVXnZRn41S7Q0x48iNNUdX5mZ3Ax/
         VvpD2mOmsWLmKyF3Etc8gcx6gaBV+b8IXS9Wrzs8Kq0HqPwgJ6/DWByBQECEzVA8hRKh
         4U8J86KfXmdInDIARxDiQyWVcbm1zOAWflVzTOlMjBlOd3jwDJKLjfwGzwxE3Wlvf/Hr
         PAy2XPMgpzO8Wxchqc58LgTR+wiMPQWd7Zf9+KBmh+j9E7Og7s2RzkTeyKTE9v6UyqpT
         WcDg==
X-Gm-Message-State: ANhLgQ2tcD4j56UHhhHBdJ30WwlWMZKmIQ60+yHDSnxuu/HIW2yNknL4
        wv2/E1T5yuII1pgO+CEcq2o=
X-Google-Smtp-Source: ADFU+vslRaNPeMkRG8+MPPd6G9czHh+TZ9ms/k1DIW0/Y9yk+LcDfyqeX+y1eKNiVzn/MPxRwjSxmQ==
X-Received: by 2002:a37:aa46:: with SMTP id t67mr2232127qke.43.1584037405678;
        Thu, 12 Mar 2020 11:23:25 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id v126sm10740727qkb.107.2020.03.12.11.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 11:23:25 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Thu, 12 Mar 2020 14:23:23 -0400
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] x86/purgatory: Make sure we fail the build if
 purgatory.ro has missing symbols
Message-ID: <20200312182322.GA506594@rani.riverdale.lan>
References: <20200311214601.18141-1-hdegoede@redhat.com>
 <20200311214601.18141-3-hdegoede@redhat.com>
 <20200312001006.GA170175@rani.riverdale.lan>
 <e96ea0cc-954d-2cd3-8d9d-53d57856d8aa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e96ea0cc-954d-2cd3-8d9d-53d57856d8aa@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 06:46:44PM +0100, Hans de Goede wrote:
> Hi,
> 
> On 3/12/20 1:10 AM, Arvind Sankar wrote:
> > On Wed, Mar 11, 2020 at 10:46:01PM +0100, Hans de Goede wrote:
> >> Since we link purgatory.ro with -r aka we enable "incremental linking"
> >> no checks for unresolved symbols is done while linking purgatory.ro.
> >>
> > 
> > Do we actually need to link purgatory with -r? We could use
> > --emit-relocs to get the relocation sections generated the way the main
> > x86 kernel does, no?
> > 
> > Eg like the below? This would avoid the double-link creating
> > purgatory.chk.
> 
> So I've changed the patch for this in my local tree over to the version
> suggested below and tested kexec with this (and I can confirm that it
> still works)
> 
> I'm wondering though if it would not be better to keep the purgatory.ro name ?  :
> 
> 1. The generated ELF binary should still be relocatable
> 2. .ro files are part of the global .gitignore settings, for the
>     new purgatory name we need to add an arch/x86/purgatory/.gitignore file
> 3. Keeping the purgatory.ro name will make the diff easier to read
> 
> Regards,
> 
> Hans
> 

No objections to the name, we can change it later to purgatory.elf or
something if we want in a separate patch.

There is one issue I noticed -- x86_64 kernel default LDFLAGS have
max-page-size=0x200000. If purgatory is linked into a real executable
this makes kexec-purgatory.o become quite large, from about 25k to just
over 4Mb.  Adding -z max-page-size=4096 to the LDFLAGS lowers this back
down to around 29k. arch/x86/entry/vdso/Makefile adds this flag too.
