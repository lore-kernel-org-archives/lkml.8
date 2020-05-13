Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11BE8C47077
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 14:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D466C204EA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 14:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QxLceh/W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388967AbgEMOVx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 10:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388833AbgEMOVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 10:21:52 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA96EC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 07:21:52 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id t40so11041460pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 07:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RlT8e3GCcw8hqsPevwx5SIqz1Z9X5As8Uu5brShveGY=;
        b=QxLceh/WDthFGjTg4/6exTgHleziMeWKUUSJfvj/RtzIKlLnQApe+g4V+hjuaa1Ptp
         D1AYd9MsauMExL+1Z8/z/+5BoVGto5lXJMDUEKlWBRzB1pFyM978O2vmX12mDAMuTD+Z
         htCA7DVzxORVrTIu8CXpN6DiW/xa9toR47eNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RlT8e3GCcw8hqsPevwx5SIqz1Z9X5As8Uu5brShveGY=;
        b=om4uYZQJ16DxIqZXPQzh36xb96QzvW7p+ESvNIE4rvgOvGWoGO9IXDQMc7LPSC14Rj
         uK3hEnyYcLZSkC2Stnz2EgZOp1EpwoigaiVDrX3dxENR2dwkYeGWiyc0mk730s4IpRCh
         fVVmDfHkQWuMiADF4WG7Ib0sZ9f8yYtSV4fEK1/QACCYVBUHfyGuAg8eUlIe7BY0vOds
         gduv7InmZMb0C9OZhS5cBkRuMlRIUFPqkVCsoqeFaxi/w2OEEkU0KsxQIuQwCHqcgdTj
         PiMReUpKiSPONLPwZhw872FT8dUF6Lyhg7ybPcP6v6WbnICsl7IvxJWlVho4f372W/Pw
         VlAw==
X-Gm-Message-State: AGi0PubvLFaW7V6HyWOtbqLeprl7xMV8STKBRJd6JE1O3JwAj/REmxbV
        EZMy4lWEmHE4B3Q6PpPgzZPfF5zCQYM=
X-Google-Smtp-Source: APiQypJdzY+fA3+rJVRnMRvec4DRswjq8ep69zHO1V/o5zYGd3s+BVAqerFHF1mnq2G2/E61KFLc+w==
X-Received: by 2002:a17:90b:30cb:: with SMTP id hi11mr34795324pjb.103.1589379712177;
        Wed, 13 May 2020 07:21:52 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g9sm13282143pgj.89.2020.05.13.07.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 07:21:51 -0700 (PDT)
Date:   Wed, 13 May 2020 07:21:50 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Pavel Tatashin <pasha.tatashin@soleen.com>, jmorris@namei.org,
        sashal@kernel.org, linux-kernel@vger.kernel.org, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        anton@enomsg.org, ccross@android.com, tony.luck@intel.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 5/5] ramoops: add max_reason optional field to ramoops
 DT node
Message-ID: <202005130719.D9252B3867@keescook>
References: <20200505154510.93506-1-pasha.tatashin@soleen.com>
 <20200505154510.93506-6-pasha.tatashin@soleen.com>
 <20200513024230.GA3514@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513024230.GA3514@bogus>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 09:42:30PM -0500, Rob Herring wrote:
> On Tue, May 05, 2020 at 11:45:10AM -0400, Pavel Tatashin wrote:
> > Currently, it is possible to dump kmsges for panic, or oops.
> > With max_reason it is possible to dump messages for other
> > kmesg_dump events, for example reboot, halt, shutdown, kexec.
> > 
> > Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  .../devicetree/bindings/reserved-memory/ramoops.txt    | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/reserved-memory/ramoops.txt b/Documentation/devicetree/bindings/reserved-memory/ramoops.txt
> > index 0eba562fe5c6..886cff15d822 100644
> > --- a/Documentation/devicetree/bindings/reserved-memory/ramoops.txt
> > +++ b/Documentation/devicetree/bindings/reserved-memory/ramoops.txt
> > @@ -30,7 +30,7 @@ Optional properties:
> >  - ecc-size: enables ECC support and specifies ECC buffer size in bytes
> >    (defaults to 0: no ECC)
> >  
> > -- record-size: maximum size in bytes of each dump done on oops/panic
> > +- record-size: maximum size in bytes of each kmsg dump.
> >    (defaults to 0: disabled)
> >  
> >  - console-size: size in bytes of log buffer reserved for kernel messages
> > @@ -45,7 +45,13 @@ Optional properties:
> >  - unbuffered: if present, use unbuffered mappings to map the reserved region
> >    (defaults to buffered mappings)
> >  
> > -- no-dump-oops: if present, only dump panics (defaults to panics and oops)
> > +- max_reason: maximum reason for kmsg dump. Defaults to 2 (dump oops and
> 
> max-reason

Thanks! I caught this in later versions, so it's correct now. :)

-Kees

-- 
Kees Cook
