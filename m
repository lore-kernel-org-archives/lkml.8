Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A90C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 21:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7E8E2078B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 21:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729599AbgIAVkf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 17:40:35 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45125 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbgIAVkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 17:40:31 -0400
Received: by mail-oi1-f196.google.com with SMTP id d189so2487216oig.12
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 14:40:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HtDmdS2o4yWHgA155sIUrMDEsVQmMWq03sAjdZrfpNk=;
        b=IsLdozd6Pw6iEzE1ovnOp6TxuS/5nVmtGPRFzgbYJey4IbW4GpI2jQqXPHsqIT+7wA
         8/3XUsMnRe76hKcI/lzVX90yZYfIYHMN4UKIvR/bozAgCbq61seoG0WaGznw0JIM1e1g
         sAsqRkvWUaB8uHdPNKCiazNKxnAMszmZi0Fg0lFnFOa9FE+Yi88ecTUiZTdiLj32+bdu
         QxxwIwDe4ai8b6SX9hDyAjnCJGLXeVUvnV9SEc6WQZndBasCeVpY5Uy8bqCJKZADjj1p
         +FGYrHX8lTTQJ0jCAU/u6otOOOLa/2OS0qxcRGBeDwIzlf9m+Au2UQQTiOIHlr3gvh7x
         Pn2g==
X-Gm-Message-State: AOAM532Vt62ISFHZXXoV6CcNpFHd0kfIVLyutHUDFjABNRjSHU5YOUd5
        d+JiYCaI00f7aR0qGkcjsMADuDIxxi0=
X-Google-Smtp-Source: ABdhPJxenpaLsQUXRnF8a77NHv63bnGTVcmJ92/owODA9gm6QU4ssuZsaMiBall4T4sqA12IXi/6Ew==
X-Received: by 2002:aca:3d41:: with SMTP id k62mr120156oia.156.1598996430048;
        Tue, 01 Sep 2020 14:40:30 -0700 (PDT)
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com. [209.85.210.41])
        by smtp.gmail.com with ESMTPSA id 5sm398746otb.67.2020.09.01.14.40.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2020 14:40:29 -0700 (PDT)
Received: by mail-ot1-f41.google.com with SMTP id v16so2474992otp.10
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 14:40:29 -0700 (PDT)
X-Received: by 2002:a05:6830:12c3:: with SMTP id a3mr3039860otq.74.1598996428949;
 Tue, 01 Sep 2020 14:40:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200730125259.GA8948@gondor.apana.org.au> <VE1PR04MB6687FB075B9A6A0923F576978F2E0@VE1PR04MB6687.eurprd04.prod.outlook.com>
 <20200901015630.GA9065@gondor.apana.org.au>
In-Reply-To: <20200901015630.GA9065@gondor.apana.org.au>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Tue, 1 Sep 2020 16:40:16 -0500
X-Gmail-Original-Message-ID: <CADRPPNTt5dCX1pRUp5OenZBuMNJcN+k8jMVmUo5qw5g0VLZ4hQ@mail.gmail.com>
Message-ID: <CADRPPNTt5dCX1pRUp5OenZBuMNJcN+k8jMVmUo5qw5g0VLZ4hQ@mail.gmail.com>
Subject: Re: [PATCH] soc: fsl: Remove bogus packed attributes from qman.h
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 31, 2020 at 8:57 PM Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> On Tue, Sep 01, 2020 at 01:50:38AM +0000, Leo Li wrote:
> >
> > Sorry for the late response.  I missed this email previously.
> >
> > These structures are descriptors used by hardware, we cannot have _ANY_ padding from the compiler.  The compiled result might be the same with or without the __packed attribute for now, but I think keep it there probably is safer for dealing with unexpected alignment requirements from the compiler in the future.
> >
> > Having conflicting alignment requirements warning might means something is wrong with the structure in certain scenario.  I just tried a ARM64 build but didn't see the warnings.  Could you share the warning you got and the build setup?  Thanks.
>
> Just do a COMPILE_TEST build on x86-64:
>
> In file included from ../drivers/crypto/caam/qi.c:12:

Looks like the CAAM driver and dependent QBMAN driver doesn't support
COMPILE_TEST yet.  Are you trying to add the support for it?

I changed the Kconfig to enable the COMPILE_TEST anyway and updated my
toolchain to gcc-10 trying to duplicate the issue.  The issues can
only be reproduced with "W=1".

> ../include/soc/fsl/qman.h:259:1: warning: alignment 1 of ‘struct qm_dqrr_entry’ is less than 8 [-Wpacked-not-aligned]
>  } __packed;
>  ^
> ../include/soc/fsl/qman.h:292:2: warning: alignment 1 of ‘struct <anonymous>’ is less than 8 [-Wpacked-not-aligned]
>   } __packed ern;
>   ^

I think this is a valid concern that if the parent structure doesn't
meet certain alignment requirements, the alignment for the
sub-structure cannot be guaranteed.  If we just remove the __packed
attribute from the parent structure, the compiler could try to add
padding in the parent structure to fulfill the alignment requirements
of the sub structure which is not good.  I think the following changes
are a better fix for the warnings:

diff --git a/include/soc/fsl/qman.h b/include/soc/fsl/qman.h
index cfe00e08e85b..9f484113cfda 100644
--- a/include/soc/fsl/qman.h
+++ b/include/soc/fsl/qman.h
@@ -256,7 +256,7 @@ struct qm_dqrr_entry {
        __be32 context_b;
        struct qm_fd fd;
        u8 __reserved4[32];
-} __packed;
+} __packed __aligned(64);
 #define QM_DQRR_VERB_VBIT              0x80
 #define QM_DQRR_VERB_MASK              0x7f    /* where the verb contains; */
 #define QM_DQRR_VERB_FRAME_DEQUEUE     0x60    /* "this format" */
@@ -289,7 +289,7 @@ union qm_mr_entry {
                __be32 tag;
                struct qm_fd fd;
                u8 __reserved1[32];
-       } __packed ern;
+       } __packed __aligned(64) ern;
        struct {
                u8 verb;
                u8 fqs;         /* Frame Queue Status */


Regards,
Leo
