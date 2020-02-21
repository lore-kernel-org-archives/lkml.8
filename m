Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B071DC35669
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 23:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 847D720722
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 23:05:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZENXGE8+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729451AbgBUXFO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 18:05:14 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40486 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbgBUXFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 18:05:13 -0500
Received: by mail-qk1-f196.google.com with SMTP id b7so3445554qkl.7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 15:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JoSFFpTYFiaHmH8ulMoTAh2gcF7SkvLOnEEsmrgnXy8=;
        b=ZENXGE8+LPDYeYrm7qYCxS6xLDib/gu7943oikNBP6fHJuCB0/3w8R3eGXbzaLq++Z
         Qh41kBK8ftSyqNGIx8WZnBiuduCLirxIylRpNwjYqs0Mq986x4pbeN8k65/uU0HmiOPq
         pCimpCmlVvuQTsNKANhNIcKdl98gK9he2u19uPZyNtM8poRfsvotTHMrolUeJMaYck/k
         /NFBKzhm4zWgoqqdcvsw/6Sd+osJjx31ecscxw+zGC0zS62IWC9FMczxYpSEMBv+VsH0
         MfDehN4zjx+117b03RuK++j87aOZa2opFhnZ3mj0rIa24ce8zyzC8bE5By9Q2E+o2srm
         /UKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=JoSFFpTYFiaHmH8ulMoTAh2gcF7SkvLOnEEsmrgnXy8=;
        b=YOnZr2Cy0TSkNMMu7TmudoEw41G/7vAOtg8LFsLHJzco4hsKyc7OoA834NDPfXQMUt
         3CY1Jf1Jh+Wb0ehKuUCzri+yYvCezmUPJ6VnutUpycKfkIytzGD+dIUxfLYlUV36X3/0
         gtV0G6eRrI62M51kYy73cppDUdw+o3zchtOiqWwVh+nGIYZDX4jUvta65t3RJrnUtJP1
         m9csx6BW8O5fGI+X/aWhLnaa4p7L07TkMb2b25R5dCeh6xhwFBY4jmQmRze2dqddXQCf
         3QXaRWaOKe78FiIhPZDaZCgT9X1hqIFEANj8GdqPJjutL7fK1xDyZ9yG9E9i/ZNSqAXF
         QtTA==
X-Gm-Message-State: APjAAAUKKHeJfNx4vxlB985g9ZkNJrmBnjYQUMIzP5T14AjIs5/WxfqU
        y7S5lzchdrnGlAWGL+H84q8=
X-Google-Smtp-Source: APXvYqwaVqfXbV7TqYDvUgFLvjqxwL2ExERchNv7petey3SAoxE3PYNiAidZ+Xp96mfnbQUVuky0rA==
X-Received: by 2002:a37:6c5:: with SMTP id 188mr35749334qkg.277.1582326311881;
        Fri, 21 Feb 2020 15:05:11 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id e3sm2243206qtb.65.2020.02.21.15.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 15:05:11 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Fri, 21 Feb 2020 18:05:09 -0500
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        rick.p.edgecombe@intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: Re: [RFC PATCH 06/11] x86: make sure _etext includes function
 sections
Message-ID: <20200221230504.GA3001063@rani.riverdale.lan>
References: <75f0bd0365857ba4442ee69016b63764a8d2ad68.camel@linux.intel.com>
 <B413445A-F1F0-4FB7-AA9F-C5FF4CEFF5F5@amacapital.net>
 <20200207092423.GC14914@hirez.programming.kicks-ass.net>
 <202002091742.7B1E6BF19@keescook>
 <20200210105117.GE14879@hirez.programming.kicks-ass.net>
 <43b7ba31-6dca-488b-8a0e-72d9fdfd1a6b@linux.intel.com>
 <20200210163627.GA1829035@rani.riverdale.lan>
 <20200221195039.dptvoerfez4r76ay@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200221195039.dptvoerfez4r76ay@treble>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 01:50:39PM -0600, Josh Poimboeuf wrote:
> On Mon, Feb 10, 2020 at 11:36:29AM -0500, Arvind Sankar wrote:
> > On Mon, Feb 10, 2020 at 07:54:58AM -0800, Arjan van de Ven wrote:
> > > > 
> > > > I'll leave it to others to figure out the exact details. But afaict it
> > > > should be possible to have fine-grained-randomization and preserve the
> > > > workaround in the end.
> > > > 
> > > 
> > > the most obvious "solution" is to compile with an alignment of 4 bytes (so tight packing)
> > > and then in the randomizer preserve the offset within 32 bytes, no matter what it is
> > > 
> > > that would get you an average padding of 16 bytes which is a bit more than now but not too insane
> > > (queue Kees' argument that tiny bits of padding are actually good)
> > > 
> > 
> > With the patchset for adding the mbranches-within-32B-boundaries option,
> > the section alignment gets forced to 32. With function-sections that
> > means function alignment has to be 32 too.
> 
> We should be careful about enabling -mbranches-within-32B-boundaries.
> It will hurt AMD, and presumably future Intel CPUs which don't need it.
> 
> -- 
> Josh
> 

And past Intel CPUs too :) As I understand it only appears from Skylake
onwards.
