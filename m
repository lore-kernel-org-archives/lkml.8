Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D9EC433E5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 07:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EB4E206C1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 07:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="SvqjbM1I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgGPHq6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 03:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbgGPHq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 03:46:57 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7470CC061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 00:46:57 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id 12so4395734oir.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 00:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3BUXUL9AKrDqMaBqwt9woIa2xKGZFsJ8thm8KS7GNOo=;
        b=SvqjbM1I8bN85zcWimONZ2ozTVklUFbPOB/mg5lt6Y+tKPILTkC89j1wv+TI/vHEWy
         PtYOQw0C9VRBd7uliQgJiZ1E2UFUYq0EGNJ77CLsmHLivGWnmB4naXdj+kJeicdi167z
         YDIvILeC4NZhNsBXtgsqUht1RvatrtdtATbVSG67GB2XyNBOgVjICI/1vyj4lpuxkVE+
         V3xvVI1wJWKylQD6RWYPdI0bgHS75tgDGStMjQlL2bXLjqwIthAF+AUEh1uH5tdS+pB4
         ac48QYZi+yViVAbeXObD7OnMDUTrquYdZJR7VorvbJ8XykuIPcpl92sBT0MGX8cKTLSR
         KKKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3BUXUL9AKrDqMaBqwt9woIa2xKGZFsJ8thm8KS7GNOo=;
        b=a2uDYhjjLGqs8b/IcEGTuJ2DWv5g/WskbAugKcMcB2ylzoqqVFHtKUBGko7EjHXzDS
         jj899/7SzcULQHHPIs2OGhMLkcODwS6qql2HDcFmwy6RIkaW326DS5TIw6tRmjDUiID7
         z3Xj+Byx+3CGZMJ/YwlTQyb3r22tdDrYKGesp6XGDLn0Z8+dMA7IKshxogIw7++1kNDk
         qt5Vdm8qYWI1FjnpI1dvLC5u1OvEf6P1FeInLpDsDbB9uw1lOnsuaw5BKZgGd6kRWplD
         CRJqvh/WW7qU2M+HkYj+7mPnHiheQE2P+PFLqbi+USqFRDuhvoep0/WPz9AdKbWZ78r0
         d1zw==
X-Gm-Message-State: AOAM5319DWUsWCXLiGyVEi0jmAHedC8GmNtPOFVVLRoztiH4j1s7e6yT
        0eb00xkrqRcSunGekRUfZ/CKnPbJqSAT2grexVk+X8Rr
X-Google-Smtp-Source: ABdhPJzCKBDq7dV4e8atqNGFS0KfPTtTyRSbv0GrxEGTjPSIOfpn+4bk/ky8L19DllK9NXe9m/wIBKvsRsRbgjA7I2U=
X-Received: by 2002:aca:be57:: with SMTP id o84mr2821993oif.32.1594885616879;
 Thu, 16 Jul 2020 00:46:56 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1594880014.git.zong.li@sifive.com> <28365b581b04d0237e127363a63c1ad72dbea683.1594880014.git.zong.li@sifive.com>
 <87sgdrx6qd.fsf@igel.home>
In-Reply-To: <87sgdrx6qd.fsf@igel.home>
From:   Zong Li <zong.li@sifive.com>
Date:   Thu, 16 Jul 2020 15:46:45 +0800
Message-ID: <CANXhq0omXrUCAFscZy5tDFisR29_4agA1ZTTYTezgZTmQg5Y3Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] riscv: fix build warning of mm/pageattr
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 3:24 PM Andreas Schwab <schwab@linux-m68k.org> wrote:
>
> On Jul 16 2020, Zong Li wrote:
>
> > Add hearder for missing prototype. Also, static keyword should be at
>
> s/hearder/header/
>
> Andreas.
>
> --
> Andreas Schwab, schwab@linux-m68k.org
> GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
> "And now for something completely different."

Hi all,

Let me describe the details in the commit message and fix the typo in
the next version.
Thanks for reviewing.
