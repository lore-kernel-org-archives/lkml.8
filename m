Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E83CC433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 04:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E07C620848
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 04:51:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A+VsjOtC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgH1Eve (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 00:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgH1Evc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 00:51:32 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B9BC06121B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 21:51:32 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id c15so1350193plq.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 21:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=G0VefugDvgS42hjIAoPJ8ISUdYbIoXgY2KSJmzSYe5M=;
        b=A+VsjOtC36XhaswB06qIx+rbBgUaaLAIjugHfk+EIrxxf4Rh5nbZYd0sn+aQtsKlfY
         nI9mB5700rbFAZTsXSZ+96t94xs6IB+ScLwy+1S3V6oQb7Js698iK3VMpGOhjbSYp0Br
         6WwFiKajog8Xw7dxvUboaQGw4BG36xj8dgRZSh0B820UEB8iH6uIxHvhdDN1f6X/jwd/
         VlOwxwNNKKXDlMVl2M4tf78pvRKuYn6CwP/C/56Ri+v7X9xtpM/YQP4qUWpS1Ku7DT8n
         PesbyiHrNtHyOjveB5croFlMlZFiuFxBJg4g7Mp6STEx+HHJkOwpa5xI7beKz2pRG+8t
         n2fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=G0VefugDvgS42hjIAoPJ8ISUdYbIoXgY2KSJmzSYe5M=;
        b=QQB/7MKTYWc3g3g5iF3wceRT0uL1dNpkfFLKlK4HS11NMH4st8G4+U3wVk57nf/++T
         4jemjVt98C4dDPz10t7fR5JSfJCp8gC9mrQdBamYVwd5QjYH/UqXqPX1+XpC9Mr7Ltm+
         MMFGGNAYmLdrqyg7gxJeUXQJzla/4EEs47lYbJxVPvaRfVVojh8ggxoNMspo0Q5Y3Y7Y
         RcVaFWgwe+MvnsFVLGdGyJoOA/qgNE5P2CQynDFlunDdSn7qFTW3/OO7I0kng/3Xwc6f
         Iruqfc8rx3VmVEwGAXzc9ceorOfldaQLMsEvgTGAUcPl5ZhDC+JzWx0c8fHb/HcAkUCE
         rSGw==
X-Gm-Message-State: AOAM531ahcVLIpGLi5VG+nnw6XtdBfNOOWVSXmnds6gTpBCCSqZbYBxy
        aD/o6VNdfxcxntfmSOeMD6TJVw==
X-Google-Smtp-Source: ABdhPJy3YVFbXTROjqz+6HxX2wvPQtcLh2VQes+fyTjs7QckGVTwa69aPqxaHfs4We6PGYSEGpfmiA==
X-Received: by 2002:a17:902:820b:: with SMTP id x11mr19055375pln.229.1598590291450;
        Thu, 27 Aug 2020 21:51:31 -0700 (PDT)
Received: from localhost ([122.167.135.199])
        by smtp.gmail.com with ESMTPSA id m7sm4433763pfm.31.2020.08.27.21.51.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Aug 2020 21:51:30 -0700 (PDT)
Date:   Fri, 28 Aug 2020 10:21:28 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Stephan Gerhold <stephan@gerhold.net>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>, sbhanu@codeaurora.org,
        Sibi Sankar <sibis@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephen Boyd <sboyd@kernel.org>, nm@ti.com
Subject: Re: WARNING: at drivers/opp/core.c:678
 dev_pm_opp_set_rate+0x4cc/0x5d4 - on arm x15
Message-ID: <20200828045128.y7ybkd7dnvn4h6dt@vireshk-i7>
References: <CA+G9fYvK5UkERLuBSRH5t2=j5==dbtw45GTMta9MafyJDqFsFA@mail.gmail.com>
 <20200827094651.3grvs6ungv3dh7y3@vireshk-i7>
 <20200827211832.3ebeda8a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827211832.3ebeda8a@canb.auug.org.au>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27-08-20, 21:18, Stephen Rothwell wrote:
> Hi Viresh,
> 
> On Thu, 27 Aug 2020 15:16:51 +0530 Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 27-08-20, 15:04, Naresh Kamboju wrote:
> > > While boot testing arm x15 devices the Kernel warning noticed with linux next
> > > tag 20200825.
> > > 
> > > BAD:  next-20200825
> > > GOOD:  next-20200824
> > > 
> > > metadata:
> > >   git branch: master
> > >   git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> > >   git commit: 3a00d3dfd4b68b208ecd5405e676d06c8ad6bb63
> > >   git describe: next-20200825
> > >   make_kernelversion: 5.9.0-rc2
> > >   kernel-config:
> > > https://builds.tuxbuild.com/LDTu4GFMmvkJspza5LJIjQ/kernel.config
> > > 
> > > We are working on git bisect and boot testing on x15 and get back to you.  
> > 
> > Was this working earlier ? But considering that multiple things
> > related to OPP broke recently, it may be a OPP core bug as well. Not
> > sure though.
> > 
> > Can you give me delta between both the next branches for drivers/opp/
> > path ? I didn't get these tags after fetching linux-next.
> 
> Yeah, you need to explicitly fetch the tags as only the latest tag is
> part of the branches in the tree.

Ah, I see. Thanks.

-- 
viresh
