Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D791DC35E15
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 18:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3C192469F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 18:38:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hFULuJDQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729434AbgB0Sim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 13:38:42 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38246 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729120AbgB0Sim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 13:38:42 -0500
Received: by mail-ed1-f66.google.com with SMTP id e25so253328edq.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 10:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+Pu8YZT4WecVSREo/VFJSkPifBBBkzcaXDpj+HPmkyU=;
        b=hFULuJDQMIXYJvp+pi9tKg6lmcMRVl/G4c828g/jDHnGGrmgxDk6ojp7mr5eMv2xRO
         6kjAHVJ1dVS7MND7yDvtzxHGMvjonGL4cIzkpONdV/wZdmHBUpUjIHdwUqeB8fQiUCNG
         wU0fCuK/S7Hqz0cecg/bvsHP1my8IkyrPP1oyj3nSjML3MRayAz0iArbCJ5g0Sdfttzl
         6EnbWIs0+0YAT29guM4twTQ73VBUayqkEzef+YyXG6IdB0h/NC51Tx15cFHqcvvhr/RC
         ACYHVmjg3w84Y1x/GEQGo8CQSrQsEHsYSKsKHqt/T8FPLUciC4X3eDrneW93RBKSo60a
         dvfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+Pu8YZT4WecVSREo/VFJSkPifBBBkzcaXDpj+HPmkyU=;
        b=l0NwBpYMpEYbtuc2XJqE/pgneGH8nOh3ZHyRKESy3uewtdOCRT8vlMRafsDZ+TKIoH
         VVCONdOVNUgmD5cnoVmYw52oGL9peVaY1+POBA9PHZCXSoQXAs0d6mhIelPlPdR8wYWO
         YGQJBAM8y0+cMQY+PwmpQs3UhYP5AGiP02t7WQsAoyFYGfNhloLk8FXML49BcCjYl561
         7CU66sE3xTfRli1glNjTqtlbRPeu4MOT9Het875K1vvKAiUqMsa6UbIaBhK74stlhcW4
         hl1SVYnAMLeVSWqyPogdT4kMatKGI9eNXy73vUGyAGYvWwtmffCrxBY5hmZsSsomhUKJ
         tkHw==
X-Gm-Message-State: APjAAAXd46aypOTtlylOFnXYuBOjn9VNXDRvZjpE9DxvzPrLcwNkQCab
        MYaJdLSeRBdjS0eDcG1fu3k=
X-Google-Smtp-Source: APXvYqyDdoq3iSo+IzNbpfI/a4XgeNjcr4wtzQybEnC+XrHvfsb54aJdwBA9g8frn61J9u9VB+6Ivg==
X-Received: by 2002:a17:906:bd2:: with SMTP id y18mr403219ejg.161.1582828719623;
        Thu, 27 Feb 2020 10:38:39 -0800 (PST)
Received: from smtp.gmail.com ([2001:818:e238:a000:51c6:2c09:a768:9c37])
        by smtp.gmail.com with ESMTPSA id d23sm315293ejt.53.2020.02.27.10.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 10:38:38 -0800 (PST)
Date:   Thu, 27 Feb 2020 15:38:31 -0300
From:   Melissa Wen <melissa.srw@gmail.com>
To:     Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian Konig <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] drm/amd/display: dc_link: cleaning up some code
 style issues
Message-ID: <20200227183831.hchdotzbbaq5uyvd@smtp.gmail.com>
References: <cover.1582752490.git.melissa.srw@gmail.com>
 <20200227150518.tchch32d4lcjripr@outlook.office365.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227150518.tchch32d4lcjripr@outlook.office365.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rodrigo,

On 02/27, Rodrigo Siqueira wrote:
> Hi Melissa,
> 
> First of all, thank you very much for this patchset; in general,
> everything looks good to me.
> 
> I noticed that your patchset does not apply because you made your
> changes based on `drm-misc-next`; when you send patches to amdgpu, use
> the following repository:
> 
>  git://people.freedesktop.org/~agd5f/linux 
> 
> Could you prepare a V2?
Yes.

Thanks for reviewing my patches.
Soon, I will send a V2 with the changes suggested by you. 
> 
> Thanks!
> 
> On 02/26, Melissa Wen wrote:
> > This patchset solves some coding style issues on dc_link for readability
> > and cleaning up warnings. Change suggested by checkpatch.pl. 
> > 
> > Melissa Wen (2):
> >   drm/amd/display: dc_link: code clean up on enable_link_dp function
> >   drm/amd/display: dc_link: code clean up on detect_dp function
> > 
> >  drivers/gpu/drm/amd/display/dc/core/dc_link.c | 67 +++++++++----------
> >  1 file changed, 32 insertions(+), 35 deletions(-)
> > 
> > -- 
> > 2.25.0
> > 
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Fdri-devel&amp;data=02%7C01%7CRodrigo.Siqueira%40amd.com%7C7a3e02e3f43447ed4fab08d7bb080d9b%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637183515885211986&amp;sdata=bnipkrUtKdO1oOKxdt1th4iIG1%2BBgl2wMPVrdmn3P1U%3D&amp;reserved=0
> 
> -- 
> Rodrigo Siqueira
> https://siqueira.tech

Melissa Wen
