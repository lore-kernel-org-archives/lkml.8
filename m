Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3794CC83007
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 23:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3A9F20737
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 23:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ecrgQDUm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbgD1XTF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 19:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725853AbgD1XTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 19:19:04 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A2AC03C1AC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 16:19:03 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id r14so147388pfg.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 16:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=FWNfpESHIrlctB2dwl7YeVqe4k+1KC/hfdOSv4N2eR8=;
        b=ecrgQDUmQiUgqDqwxETkiJePKv2EZR71UqZ9A84VugZwjknEAWph5SiAv5NhixbCng
         eynRkZ8Ma2qc+i1UaVy1ckfXtdrIoV1EgVftjP4j99SNksNBqxzaAHUK3aJwGRiIXCto
         U6QnZtpIXQHYhadvi8pytCZfuo6/J8fAWsLr7rFN8ItfrFNIxGLylVoISldnyS1tB+ir
         PCriSOdN/CwZs2USicquS3FSceLULBSapI/Qdy6Xydh9/2+DYlbZgc5UX6qfEnVVuAex
         ITeC/TPVs8Snl2AGfHNGg2J01813+B29VRNgSRW00ENKhzhWCqB9ZPbuExF1Crbddo1m
         E/Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=FWNfpESHIrlctB2dwl7YeVqe4k+1KC/hfdOSv4N2eR8=;
        b=cDL6YS7CQm6LyP+rQ/pg9bMnTIY5Fom64Ct01dRYrGLLMfJOJlUvMmNuy4KV2UFhYn
         ZDO2Fd9UThSw8MASYziJoIpHBGEVPXtYdoas6bJlsFaRQVT6gLqVvlFIjywkPxAhyi0Y
         JlD9kUizfJRa1l8S+CY49S3Wun6Bf33eSfPNyJogijcC0+R+7X2pVlnsx/FCgfHY4q11
         1VXakXrZ/zWUTQ9SfoKBkQIra9XY725Af1mxm3ylR4oAHJEZd9Hq8qz1Mt56jFENIo1b
         KyaP+wNQUhCTcUoNdvb25ALbLBc09MRtEq02S2UD30h2eqDmqzL1viFCAN/j3of2Ty/N
         EuGQ==
X-Gm-Message-State: AGi0PuYAxl+Vd+60gN96vBe+Jk5gQO6IG6lY9j/WFp/dl46N8unDG+rG
        cgvtOWjuprxtW2XVOcAqp5w=
X-Google-Smtp-Source: APiQypIsQwaRVm+rnDHnYJWxfmVDzcf1uVAMlK3kn5ex4yb+paZ+2dveupiR6/HRuvuW5PP3MLcMbQ==
X-Received: by 2002:a65:6704:: with SMTP id u4mr31348658pgf.263.1588115942389;
        Tue, 28 Apr 2020 16:19:02 -0700 (PDT)
Received: from mail.google.com ([149.248.10.52])
        by smtp.gmail.com with ESMTPSA id w69sm16017529pff.168.2020.04.28.16.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 16:19:01 -0700 (PDT)
Date:   Wed, 29 Apr 2020 07:18:55 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Changbin Du <changbin.du@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Pekka Enberg <penberg@kernel.org>,
        Waiman Long <longman@redhat.com>
Subject: Re: mm/slub: do not place freelist pointer to middle of object if
 redzone is on
Message-ID: <20200428231855.5czf4penpbowliz6@mail.google.com>
References: <ca36745b-1939-2640-aeed-390c8c39114e@web.de>
 <20200425235105.sye7fsbndbv24b46@mail.google.com>
 <dc9bcaad-ee13-5359-5d99-7ecb8cb1d46b@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dc9bcaad-ee13-5359-5d99-7ecb8cb1d46b@web.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 26, 2020 at 07:56:43AM +0200, Markus Elfring wrote:
> >>> Fixes: 3202fa62fb ("slub: relocate freelist pointer to middle of object")
> …
> > I used to give 12 charactors, but this time I lost two. :)
> 
> Would you like to improve details for the change description
> also at another place?
>
Waiman just posted another fix for this issue. Let's use that patch instead.
Thanks.

> Regards,
> Markus

-- 
Cheers,
Changbin Du
