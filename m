Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8C9C0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 21:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D7B92074C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 21:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJVymAgn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729332AbgCKVUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 17:20:06 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46037 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbgCKVUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 17:20:05 -0400
Received: by mail-qt1-f193.google.com with SMTP id a4so2726451qto.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 14:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QrR6IkxbfB/5ffdnPqJAfi5wAANIcwpGNJdV+0yyLdE=;
        b=HJVymAgnYNpp0H9H2fG1EpM9HBNGIVbg7acU0APh6f5Yk9gueinXfSMRtSNG866FaV
         bULm8TjLgRbSfMnXDgLibjxcg7Bf8JrxOCtHUETjHSmqxC8fBGVmcw8p+hgjb3f4FzHD
         FCP+dYFRJlf/fPhnRTn/g1FfSpKIulL8PXWRJs1HeXXdCmRQXz+9fahyiAhIhS7RYC4C
         tggHxa/VVWVHIk3HbByQJFvKK69nEo12/0HtOR5QX45gho7f+JLc5G3bVc8Glgfa9oz5
         xiKhK5diZGmN3GoihAAc2pQX872fzB2AbIwg9tzi/WJJe3gaaRmiZ4FCOEi7QPPd9Efw
         753w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=QrR6IkxbfB/5ffdnPqJAfi5wAANIcwpGNJdV+0yyLdE=;
        b=jNegV+3xsTkt0qr9La9MkTrseRaJIG+dtH117f4pMkRXdQ9Z9VeBY0Amgbrh1zKr+H
         VuAJ/Cq0Se+xqbOvKXu07q8U4BOXcoPdljr4aFTgA7eGhueXCKrVVl9d13G8t+utxwbm
         FQhIJbYpacm5CSe4agvIP0z0apNseJbjmQerTiuarVLsMS83kv8pVDxwyp1gpK2YVdAk
         LXwgW42AoK4kpXsGq/sSS1ZFt6wgE4QtlagO6ZPw9Ow/ycSAQ8anKVfmyMYqNy26YXeS
         tSOiQFIw9RpkBggJ447HvLiUM3LZZ0bqRTJYAIV3GQh7tJz2dQ8H368/ajoSJYXV+V5a
         QK8g==
X-Gm-Message-State: ANhLgQ3gXVkHXm/qG7vtXpzNuIy5XzYXP9flgHIMimoG3LuTVjk490jT
        L1IumJUrseBr9Na3pYlRC6waot+XXgA=
X-Google-Smtp-Source: ADFU+vvwNWe54LWCG1kbwgZ+neaGkcg/wjvgZkU0yes0SQnMQ1kaDfq0gTo3L3CQqHVoebP7wDS7mA==
X-Received: by 2002:ac8:c4f:: with SMTP id l15mr4533613qti.177.1583961604617;
        Wed, 11 Mar 2020 14:20:04 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id x19sm25848523qtm.47.2020.03.11.14.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 14:20:04 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 11 Mar 2020 17:20:02 -0400
To:     Borislav Petkov <bp@alien8.de>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH resend] x86/purgatory: Make sure we fail the build if
 purgatory.ro has missing symbols
Message-ID: <20200311212000.GA4022430@rani.riverdale.lan>
References: <20200221165941.508653-1-hdegoede@redhat.com>
 <202003010150.eyjF3gp0%lkp@intel.com>
 <b9a34773-ab38-a3c7-3e35-7da95dc625f4@redhat.com>
 <20200311204813.GM3470@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200311204813.GM3470@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 09:49:54PM +0100, Borislav Petkov wrote:
> On Sat, Feb 29, 2020 at 07:12:57PM +0100, Hans de Goede wrote:
> > Hi,
> > 
> > On 2/29/20 6:16 PM, kbuild test robot wrote:
> > > Hi Hans,
> > > 
> > > I love your patch! Yet something to improve:
> > > 
> > > [auto build test ERROR on tip/x86/core]
> > > [also build test ERROR on v5.6-rc3 next-20200228]
> > > [cannot apply to tip/auto-latest]
> > > [if your patch is applied to the wrong git tree, please drop us a note to help
> > > improve the system. BTW, we also suggest to use '--base' option to specify the
> > > base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> > > 
> > > url:    https://github.com/0day-ci/linux/commits/Hans-de-Goede/x86-purgatory-Make-sure-we-fail-the-build-if-purgatory-ro-has-missing-symbols/20200223-040035
> > > base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 248ed51048c40d36728e70914e38bffd7821da57
> > > config: x86_64-randconfig-s1-20200229 (attached as .config)
> > > compiler: gcc-4.9 (Debian 4.9.2-10+deb8u1) 4.9.2
> > > reproduce:
> > >          # save the attached .config to linux build tree
> > >          make ARCH=x86_64
> > > 
> > > If you fix the issue, kindly add following tag
> > > Reported-by: kbuild test robot <lkp@intel.com>
> > > 
> > > All errors (new ones prefixed by >>):
> > > 
> > >     ld: arch/x86/purgatory/purgatory.ro: in function `kstrtoull':
> > > > > (.text+0x2b0e): undefined reference to `ftrace_likely_update'
> > 
> > AFAICT this is the patch working as intended and pointing out an actual issue
> > with the purgatory code. Which shows that we really should get this
> > patch merged...
> 
> ... and break the build? I don't think so.
> 
> I know, it would fail silently now but I don't recall anyone complaining
> about it. So it was a don't care so far.
> 
> IOW, first this ftrace_likely_update thing needs to be sorted out and
> then this merged.
> 
> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

Hans, I think adding -DDISABLE_BRANCH_PROFILING to PURGATORY_CFLAGS
might fix this.

Thanks.
