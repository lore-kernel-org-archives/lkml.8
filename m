Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B69C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 00:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79FB2206BE
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 00:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aEzU+QQi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgGGAs3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 20:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbgGGAs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 20:48:28 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86987C061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 17:48:28 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id a6so43315234wrm.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 17:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PHhv6qtDtZXzF49Da3FQ68J1JWwelrTuXT4MT+d/caU=;
        b=aEzU+QQiyO+d/C5msmDuI178ZOTJym6eHcWcEGm52D2TkuE15w4Favr3Bmo8UNSa+a
         Q3Ko5g10x7/KSJAU2uh3TiWW6wgJ6FzkZf9WP6HyhxQ5dPpxWVBb0VX5IOJFc2pWrXQK
         J00fuUHT50dNMcadHz8Y8+TAIKeMPZO8ANyynChAQNU7hz7oK7QMWqAlbJRxO1QZLAkf
         S+ONIZEwX+pThxzgzf993qF2Vy4ONBhs7hJT6OlB2wivKfWfTSI2jBAlHobrtHvLO4L2
         PiGgGfrDzCZ3q+Hbn0aaMxnYc4tx2U/bOgzWNnQhKfFGHr4mh3x2SiRVtS0PM8i2kYW5
         N7lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PHhv6qtDtZXzF49Da3FQ68J1JWwelrTuXT4MT+d/caU=;
        b=Fio/Yt743oulCrjNPGWRbUwK/a2ZHLygki4XR4M/45buIJUeb6Nu4qYew/Y94M6m6y
         hLh8GlU2PAMU4jcYco1kEezs45yGTvakAWPlDmpjENhQZvksslrYTqzc4Qx2OrTUNTsV
         Cg2TzgBcTAyKcaKIZvkqrKQu515FvIGizcY4GtR+oD5q1w9eVBeN5cVglFyweAaKstAz
         VInsMhog9n08EFpuBBB3HT7SIObeAvdnet1cXrdIUII13Sm/KVodrVuwW9TQvk/mN6UT
         E9TC1CRnx4Q6glYeeNA4tnegy7WNeseRRFOh56m8K0kkJyeaE1xXLqsbD2MoLh0NotB6
         uFuA==
X-Gm-Message-State: AOAM531Do0lHosG/iy+1OP95koSd/Y3DRvFisanaSQsnrEfUaFNuCTSa
        bNycztImgtAsGg4BvQPkC4yrzL7R
X-Google-Smtp-Source: ABdhPJwde4GyvWgcYR6EKHS35BJJTV4Sg2r0YwQEk95QDzSvGpZtN7Nu75tw//9+e+6qASAkVU/Iqw==
X-Received: by 2002:adf:f707:: with SMTP id r7mr50492428wrp.70.1594082907285;
        Mon, 06 Jul 2020 17:48:27 -0700 (PDT)
Received: from [192.168.50.2] (178-164-237-246.pool.digikabel.hu. [178.164.237.246])
        by smtp.gmail.com with ESMTPSA id l18sm26362320wrm.52.2020.07.06.17.48.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2020 17:48:26 -0700 (PDT)
From:   Tibor Raschko <tibrasch@gmail.com>
Subject: Re: [Tech-board-discuss] [PATCH] CodingStyle: Inclusive Terminology
To:     linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org,
        ksummit-discuss@lists.linuxfoundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        tech-board-discuss@lists.linuxfoundation.org
References: <20200706191555.GD6176@sirena.org.uk>
Message-ID: <44713cf0-db41-bdd0-a41e-d710c346be12@gmail.com>
Date:   Tue, 7 Jul 2020 02:48:25 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200706191555.GD6176@sirena.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> More generally etymological arguments are just not super relevant here
> anyway, the issues people have are around current perceptions rather
> than where things came from.

This is where ignoring etymology in this case falls apart, claiming that the
current meaning is more important than the historical one. Yes it should be more
important, but it suggests that the current meaning is negative, which it is
not. In computer science (context!) these words do not have any negative
perception or connotation, and people in this field know this. Yes, outsiders
might not know this and could misunderstand them. But since when do experts in
computer science (or in any field of science for the matter) care if a layman
can correctly understand the field's technical terms? We never did and never
will, except in this particular case for some odd reason.

Be honest: "blacklist" is a technical term where the actual meaning has no
negative connotation despite what people outside the field might think. But
apparently we don't care about the actual meaning. We also don't care about the
historical meaning or etymology. We only care about... well if not about the
meaning in the past or present, then I don't know what. Looking good in the media?
