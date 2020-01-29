Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BFFEC35240
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 09:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CBDD20720
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 09:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="olH4saEQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgA2JdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 04:33:06 -0500
Received: from mail-qv1-f47.google.com ([209.85.219.47]:38616 "EHLO
        mail-qv1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgA2JdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 04:33:05 -0500
Received: by mail-qv1-f47.google.com with SMTP id g6so7390539qvy.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 01:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=SEko2ioVJG7Wf/SR20F5+TmAIOn8h9DiUwnnGGX+QBw=;
        b=olH4saEQKRC4us+ObIVZSyiSu7aHUI839iycJ+r3jkLa6Z3U87gj+D1ImHBBBPxPof
         xrQAfPVvbFwFSQQoh1mCM3p45kZoLnG3aSKhw3oBwNQf3YElb8t571NuEmxWh0AwCR+T
         qxNi6yOOh7DmXf0CCE0l+KPhQOJMwrx5N62ot5bTCbQVWhk7DUYk9StVtr0dEACFUfX3
         HJyikMTQZlh+yRkl66UPrzbwFg67KFoT69UAcNfndQXkIP87BBEYphzRM4MO+eSbVNxr
         OovdNeYk/lSiWjqvsktDZaj5Uf/XXV7ou9odZIkW8R7vPrsacLa9BhWgMgh+dKxmqFwD
         +Aew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=SEko2ioVJG7Wf/SR20F5+TmAIOn8h9DiUwnnGGX+QBw=;
        b=ElY4pC8yz5WTMY1QqsDH3der+eGQLEy9lTtn2/D2a1SJdrTZ/yCcSyVq1X2X56sUOD
         jRJoBXlMOpxWBENanGprR/JFz5zlRN93amTk+ilOLnRE1va6F67lTn2J2PDEcr8OS+JP
         dmZBxRQbSxr840g9zK/RVh0waDYQKbMJbpruCVvai4vf4UrW2xnBohovwzwpqfSlAVj4
         rIO8X2hGkGWjSeFTuPMVvpPt3PieelarHUXUNRYpOdLTJlRW4YlT3Wfh0oM3ZS/0n+Ax
         mfg6JbARu2mP5ex0O/0a56ycPEyaH4O7JQHZsQaUQx56L7HWjqHbAOhsadySKbBp0c8l
         6Ngw==
X-Gm-Message-State: APjAAAUyJQjSNjDK5iAvbnIFt2u+EjCbnqBjAj9ji/3OZ9T3AZMFffOi
        mlL6zEfQcTxSnLB0IRBxrZq0dw==
X-Google-Smtp-Source: APXvYqyyuXiowgda7LPWjEzsNpokPLRh9eTikkorKxtGWX2rQjILFLM81EY7tUahGOsz1O1Hx6ww7A==
X-Received: by 2002:a0c:ecc6:: with SMTP id o6mr26855704qvq.220.1580290384669;
        Wed, 29 Jan 2020 01:33:04 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id 64sm661206qkk.123.2020.01.29.01.33.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2020 01:33:04 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH -next] mm/page_counter: mark intentional data races
Date:   Wed, 29 Jan 2020 04:33:03 -0500
Message-Id: <DE8391CD-A9CF-4D16-A41B-F563F2AE8D57@lca.pw>
References: <CANpmjNNaCtL+vqpPKug9_DoFUue=PdoTyQFXLOx5H_BYCyDMzA@mail.gmail.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <CANpmjNNaCtL+vqpPKug9_DoFUue=PdoTyQFXLOx5H_BYCyDMzA@mail.gmail.com>
To:     Marco Elver <elver@google.com>
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 29, 2020, at 4:06 AM, Marco Elver <elver@google.com> wrote:
>=20
> Why are the line numbers for the remaining symbols missing?  Doesn't
> scripts/decode_stacktrace.sh give you all line numbers?

I used scripts/faddr2line and never used decode_stacktrace.sh before. I did n=
ot insert other line numbers because it can be easily determined by looking a=
t the function itself through an code browser.

>=20
> [ As an aside: if you want to use what syzbot uses to put line numbers
> on symbols, which is a bit faster:
> https://github.com/google/syzkaller/tree/master/tools/syz-symbolize
> https://github.com/google/syzkaller/blob/master/docs/linux/setup.md
> then 'go build tools/syz-symbolize'. ]

That is good to know.=
