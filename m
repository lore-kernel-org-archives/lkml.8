Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B66C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D52920771
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mcycau1C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbgGGOrD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 10:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbgGGOrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 10:47:02 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05691C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 07:47:03 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id 207so18339532pfu.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 07:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6tlOiGIRkrS9uWXKb/4KInO3FwOOML3Zfv95QQLQgxA=;
        b=mcycau1CA3PGVmuNd65V5tCGl3ApSPtJrbE/ErOVtSLMBEKaIR4lsuHbGx92fdWHQA
         z/4EKird63ykcm1xyAEG6izBjS654Gz1rwPI0q1EblqgXBOPDKdplyt6u7jjNq0DD7iR
         FYvB/1GCHPLIXwcet91Mzm+3H+hLd+mlVF7UdoO87wpwKwaotWPfQJ/lOvYZjKvc6T6u
         raiSWLiEFNvKQUN+xrtvb2OP+dQEzSQugcs5E7kLxlyy/p4eCE5MDh+HejzEh7kyFHwn
         I3V/qz1nvQ438WiWGP0pO/d2ANtJQKpFfy1GCpEXFzOakzsi16kjsHeAPVQyVN/IAMlb
         wBsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6tlOiGIRkrS9uWXKb/4KInO3FwOOML3Zfv95QQLQgxA=;
        b=BqsBPdRBFnZ2Pa8NDIFyNrL0sroyv/VqnkW+VVS1Xr67j4MiD6crMxgfRW/6SVaEAM
         Np6v1KmZzEdyZWL1tC4XtbLLjbvf5fAd8z3TDl9KrKCahtHxVDx0yq2CJdoT3LpdR47U
         RgUXm+mJC6f2XKNFyGVFElQ4lEz/vpMOWFy5RGDJLhzNdHFJBNDCrPf/wlXn6mYoNPXY
         Jmji+oDiNTjLUUt2CYCBrQFjD4AgH5wY6kRGyq0bR4EYwuAsP99o825TYEyg13bpiJ2P
         EN0IQFqZFU0eehe1L4XkiF2mM6d+BBPlD+fn4APP/vUhFevNTrDV+oXP1wW8SGV7SZw7
         6+zA==
X-Gm-Message-State: AOAM531Pw6PFOmc4H6+LX6WL+A3COwu0Rjton62u/4IzXQAut2xiNJUz
        6M3F1ZZKtAbZ4o6xz/a6yCoQi7vRlRvYWU3TyE2JDxWoKcw=
X-Google-Smtp-Source: ABdhPJzXNAP4zmLUgmxKEMa/hRZ66mp6ZCyan4bLWtEasorvKTD6iVoIohV68lGda+SNRbxu/67OxzRwYvQrHcuzcQM=
X-Received: by 2002:a63:924b:: with SMTP id s11mr43722681pgn.74.1594133222582;
 Tue, 07 Jul 2020 07:47:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200706093822.GC3874@shao2-debian> <BYAPR11MB263209A68F3804CC4436AB50FF690@BYAPR11MB2632.namprd11.prod.outlook.com>
 <20200707094724.GD4087@alley> <BYAPR11MB26321D30CD63D3A03C7CDDF9FF660@BYAPR11MB2632.namprd11.prod.outlook.com>
In-Reply-To: <BYAPR11MB26321D30CD63D3A03C7CDDF9FF660@BYAPR11MB2632.namprd11.prod.outlook.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 7 Jul 2020 17:46:46 +0300
Message-ID: <CAHp75Vd-HwRVYnp9-C3uQVY-7m7t2sDBsX_3pK0tk4Njs=NmWg@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW2t0aHJlYWRdIGE5MDQ3N2YwYzk6IFdBUk5JTkc6YXRfa2VybmVsLw==?=
        =?UTF-8?B?a3RocmVhZC5jOiNrdGhyZWFkX3F1ZXVlX3dvcms=?=
To:     "Zhang, Qiang" <Qiang.Zhang@windriver.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 7, 2020 at 1:05 PM Zhang, Qiang <Qiang.Zhang@windriver.com> wrote:
> Thanks for you  reply Pter, if the patch was add , like you said there are more work to do. so need remove the patch from -mm tree.

Please do, I spent some time to understand why I got it (I admit, that
most of it was direct investigation rather than googling, for which I
spent less than quarter an hour).

P.S. And please avoid top posting.



-- 
With Best Regards,
Andy Shevchenko
