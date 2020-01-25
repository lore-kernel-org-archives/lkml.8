Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E12C35242
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 23:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F1ED20704
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 23:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vOPZ9CUo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbgAYXvf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 18:51:35 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35106 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727163AbgAYXve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 18:51:34 -0500
Received: by mail-qt1-f193.google.com with SMTP id e12so4649145qto.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jan 2020 15:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yCSzl3wZJyvIf1ej3K57ZTjsEsAx8PByYT8646oGumU=;
        b=vOPZ9CUoempSh9VSELv9rV0ir8l0kfF65BoMGVUJMDUmfCUxdPe/YepzgAAH/oEoWp
         wG+qvtoBvTkulga8zEfUXxw+cJtfI+fgj5ZmyQgcuT4eVJkvw6b+wPybeI2oHVwvJuWj
         hZmwrlugYfMnDcSay/6RctfqHGwCGVLzdUSgGdCWHxGwmjMgUb9fFP+Iqjxpbm+LmmZA
         Coz7AGBmYRko+kKO81CUvL7O1kvuLb6s+m3tJJZa7uCGZ+a7vaNHZik5J1/cTmBEZiLX
         5+ZRnT6Ao7kKVSrT8TsIgKwoB0Xjkp0E/c+xeMNaFxNXJBFM3tbjQgAk7jz6vzZt9Q5Z
         CVJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=yCSzl3wZJyvIf1ej3K57ZTjsEsAx8PByYT8646oGumU=;
        b=d922LDUthLK6Q/zWneDxS1jgwrWrwfZnCvgcuMhs/OM6gGzzU8zq+D1xATubcltwCK
         gDSZRqpZRqI4t9Omgj1cVz3egRqoP7iVRPTcPSixghEOtyEFhhFRbjnLprIIFDDlTAO0
         gxmpvWw7EjMhJ79Bp5BFw6RzX2PnePKzzfw4kAPysWVYw1Gll73ums5n522STfWAEgh9
         EBdufVDDQG1DPIoh/cuZocwNthqUICuW303CYabb4y7uL7AG+Lj+omxjj1zF4pfMPVUG
         QSAR64S6YaYjNPfrUMkgODK451PK3Jy7VfOHOBK+lJBfFnOGx6hLCHHgO3QJLKWBF6V5
         /APA==
X-Gm-Message-State: APjAAAV8LWaP5yR9da2l+ok+vwioHu3FGgstFvi2xHTXbNrlPjCIRPKW
        cnZIqz8QxsVAkuvb3MgtcZE=
X-Google-Smtp-Source: APXvYqxUFTSTKhLWmhocJEC9boB+D0YiUSWf1UUrNJoVDZV9gN13yzCHDlKlFY5DmPv85ZL2owEDew==
X-Received: by 2002:ac8:47d3:: with SMTP id d19mr9360725qtr.142.1579996293586;
        Sat, 25 Jan 2020 15:51:33 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id 124sm6141264qko.11.2020.01.25.15.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jan 2020 15:51:33 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Sat, 25 Jan 2020 18:51:31 -0500
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v15] x86/split_lock: Enable split lock detection by kernel
Message-ID: <20200125235130.GA565241@rani.riverdale.lan>
References: <20200122224245.GA2331824@rani.riverdale.lan>
 <3908561D78D1C84285E8C5FCA982C28F7F54887A@ORSMSX114.amr.corp.intel.com>
 <20200123004507.GA2403906@rani.riverdale.lan>
 <20200123035359.GA23659@agluck-desk2.amr.corp.intel.com>
 <20200123044514.GA2453000@rani.riverdale.lan>
 <20200123231652.GA4457@agluck-desk2.amr.corp.intel.com>
 <87h80kmta4.fsf@nanos.tec.linutronix.de>
 <20200125024727.GA32483@agluck-desk2.amr.corp.intel.com>
 <20200125212524.GA538225@rani.riverdale.lan>
 <20200125215003.GB17914@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200125215003.GB17914@agluck-desk2.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 25, 2020 at 01:50:03PM -0800, Luck, Tony wrote:
> > 
> > I might be missing something but shouldnt this be !nextflag given the
> > flag being unset is when the task wants sld?
> 
> That logic is convoluted ... but Thomas showed me a much better
> way that is also much simpler ... so this code has gone now. The
> new version is far easier to read (argument is flags for the new task
> that we are switching to)
> 
> void switch_to_sld(unsigned long tifn)
> {
>         __sld_msr_set(tifn & _TIF_SLD);
> }
> 
> -Tony

why doesnt this have the same problem though? tifn & _TIF_SLD still
needs to be logically negated no?
