Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66ECC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 23:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 984912073B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 23:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cimSHl5L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729084AbgGGXyL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 19:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727945AbgGGXyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 19:54:11 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC260C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 16:54:10 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id w16so48525229ejj.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 16:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4ld5yvYpZk3zrDDeHii0Vpu7Nclpj2nEfal4+E6ydBE=;
        b=cimSHl5Lyez14li/0K2of8HcC6aVDRfdr9xZWOModnFxJTJgDRf2ZiJqxCsmDRAGNY
         BaBL+Em7jQFwAq8pJDeqxFtL/ltLdrdBiGoPar4NS97JPfcZe7ahhJBRNHWxCgXR0Dmw
         /ikwBXIUuSt2w52ZYWKt3HGoC8Z/M0eoQoqBqFDaqHTrW3AEpV1RAi7/5mdulV1E7Y/P
         JsLxPW9x0XVi1ZeOVf1YjHh2Ks5S6CT2c97mTKQ69x3JyEy1g5qAMNhYDPt9+OLXuk3q
         ONr7sibqVU+YpiZRxEZ0pzcNYzLWaVd/Hf8GQmr14Gyf5Wm/UNXnOciOQLFeSDSmN7ZK
         GnAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4ld5yvYpZk3zrDDeHii0Vpu7Nclpj2nEfal4+E6ydBE=;
        b=X9591Co6rMMeJ3DiAQuMX6OCKkMvqAL7Iw1gOc9DkTwpx59EJcNsAcClmm06lHx4cp
         x2RUkZisvWsMmGD33KtFJ6176yPtNpSONGbvswjxkBM/enhczAqgBPjtSBuvkvu2xRd4
         1G9SrGpKL+X/taFLTHplYXco528Q6rGkjmEvmqzeXBylZXwudToKcvaBTFJSj60v2UT9
         WfK5SnXBuf24HY9/pnfRAkcT2lwntjRBk83l00/kfTEgW5grJR0vCLqkKPANWRhjYvcL
         FEC0rznof2opNQBeSI0KTdSiygJtcpob77km4YZoMUeHUU7XdiRvXx9QqmODbZghHjIk
         FzmA==
X-Gm-Message-State: AOAM531vfsZCiJ0QLTAC/J/dmiTPthbgrOXaCG5cQnmQWN9PZ3WGB9FX
        mlbNHw6Kt4KdMFVDx/fu7jgcZKE9
X-Google-Smtp-Source: ABdhPJxyZ3NKJqQ4cGl9aGGZXkS+m/XXZWLYmC8ClxCAZoxLQg8sSzUvIXhl8E/KxRDs85vX9sK7Pw==
X-Received: by 2002:a17:906:469a:: with SMTP id a26mr46852677ejr.198.1594166049386;
        Tue, 07 Jul 2020 16:54:09 -0700 (PDT)
Received: from [192.168.50.2] (178-164-237-246.pool.digikabel.hu. [178.164.237.246])
        by smtp.gmail.com with ESMTPSA id m2sm1066081ejg.7.2020.07.07.16.54.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2020 16:54:08 -0700 (PDT)
From:   Tibor Raschko <tibrasch@gmail.com>
Subject: Re: [Tech-board-discuss] [PATCH] CodingStyle: Inclusive Terminology
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        ksummit-discuss@lists.linuxfoundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        tech-board-discuss@lists.linuxfoundation.org
References: <20200706191555.GD6176@sirena.org.uk>
 <44713cf0-db41-bdd0-a41e-d710c346be12@gmail.com>
 <20200707212641.GA1575320@rani.riverdale.lan>
Message-ID: <cafbd1f4-b03b-077d-8a4e-d7b9bcaa070d@gmail.com>
Date:   Wed, 8 Jul 2020 01:54:07 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200707212641.GA1575320@rani.riverdale.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Blacklist most definitely has a negative connotation in technical use.
> You blacklist devices that don't work properly, you blacklist drivers
> that don't work for your hardware, you blacklist domains that are
> sending spam or trying to mount network attacks on your servers. Things
> on the blacklist are "bad" in one way or the other, that's the reason
> they're on it.
> 

Of course, we put "bad" things on a blacklist. But in computing, only technical
things, not black people. What I meant with "blacklist has no negative
connotation" was that when we use the word "blacklist", nobody actually thinks
about people or skin color. Blocking bad IP addresses or faulty devices is
surely non-offensive.

If you argue that instead of this, what we really care about is "black" things
generally meaning something "bad", then forbidding "blacklist" will not get us
any closer to our goal. This is because we have a hundred other "black" phrases
in our language: black economy, black sheep, black market, to blacken, a
blackleg, a blackguard, a black mark ... only a couple of examples from the top
of my head.

My point is we will never get rid of the bad connotations in "black". "Black" is
always going to assume and remain something "unwanted", even after 2020. This is
why I think this whole campaign of removing "blacklist" is utterly ridiculous
and ineffective.

The real problem is that a group of people have been marked and
labeled with such a negative word. If we want to remove the negative association
from black people, we should stop calling them black. That'd be productive in
the long run, since afro-americans then wouldn't be associated with something
"bad" anymore.

But all the supporters of the campaign keep calling them something ba" by
calling them black, and hope to make a difference by banning 2 or 3 totally
unrelated phrases out of probably 50. The whole campaign is pointless and rides
on emotion and media attention instead of rational thinking.

I support avoiding references to master, slave, and to slavery in general.
I oppose avoiding blacklist.

Raschko T.
