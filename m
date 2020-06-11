Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECEDBC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 14:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7DA92075F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 14:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H+m1ObQ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbgFKOfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 10:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728229AbgFKOfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 10:35:31 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E9DC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 07:35:31 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id z9so7159163ljh.13
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 07:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KWk0k65t0kOficvgdudXMmddBkNR1PEPUz9kdhfi4Ks=;
        b=H+m1ObQ8oA3mUjWkoURr+qG3kfHMQzxTcPyrFKEeKFLi6uzC/t9Hui5UZJJxG08xH6
         7rVdxBgDpCFUOJtSUKhIraQlbkRCokMmbht3vVYFAapq1COXAdtnr1PRIgkBrbYmlc1A
         Q077llttOxRstZhQXqv+DFJlQLw6Mi9WfCdhbL88BGeNx1D2I5qk17f6LkYZNXEr6LQD
         yde6uy2zS8EgnuXvCsCR2rxzDu/YqFDvDZHK1mN/ky43mZNJsFtLzzH7l/GXX7K1Veqj
         gq7LpoEZk8Hy3Fwcq5sivLjtdusU0/gbcevZ21LB6tTmHTE2ro17OEwx2Ve63dfzvVVL
         N1EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KWk0k65t0kOficvgdudXMmddBkNR1PEPUz9kdhfi4Ks=;
        b=VqaHylsdD+1dlZG59UCqj8dT66DMMlnAYRdcvibZIa8uqAwbYU+eaThHWypH79x8Nw
         Mha8N5H/hued/NGhBeDsAe6FzNK/Nj+XGP4ofKAeMYQPkOAzZQ9ROkKsXLdwGDSB3dwR
         uTiAz+Tm/Gd2KNC5rFqtZ4mD2FMDEAAVrr+hdxtbDQvPqjXtPo80XhuUr0odF1Mg47B8
         L+5nBq3xZSo6lqWKstEeI27onnedRSld7XjKfl8l3pGhzz1VeuDte8mJtkqZ60y24nSC
         0+lDRLi+l3Tfe7lwikMLQh/IVk5ybUo9Zwwc9MaMBe4SWik+dnV4Myf/T1eQsW3Tw1oC
         4TSg==
X-Gm-Message-State: AOAM530YR5Q2M7Ql4VfmZKUgamlRtUUBJnE/lBGKcAg7wrGaGjAyMQLr
        SNIIXMcyG1yLiDD6x0R8EgXZIRfHUWZkYDedIiAV
X-Google-Smtp-Source: ABdhPJybuCvUjX/x8Ef8beUk/vAnwQAMrkhFzQY6QulcBSIDD6yCU7He7Vh09xpStp55hBURCug01ltnDXo7IhR0q74=
X-Received: by 2002:a2e:974e:: with SMTP id f14mr4390482ljj.102.1591886129560;
 Thu, 11 Jun 2020 07:35:29 -0700 (PDT)
MIME-Version: 1.0
References: <159169282952.17951.3529693809120577424.tip-bot2@tip-bot2> <20200611140951.GD30352@zn.tnic>
In-Reply-To: <20200611140951.GD30352@zn.tnic>
From:   Anthony Steinhauser <asteinhauser@google.com>
Date:   Thu, 11 Jun 2020 07:35:18 -0700
Message-ID: <CAN_oZf16odNhpY6_LqkVY2wpy90jKM9-vgKo4LE8OJ-QTDCKiw@mail.gmail.com>
Subject: Re: [tip: x86/urgent] x86/speculation: Avoid force-disabling IBPB
 based on STIBP and enhanced IBRS.
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-tip-commits@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, stable@vger.kernel.org,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Borislav,

On Thu, Jun 11, 2020 at 7:09 AM Borislav Petkov <bp@alien8.de> wrote:
>
> Can we merge this test into the one above? Diff ontop:

Yes, I think it's fine.

> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
