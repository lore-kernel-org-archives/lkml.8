Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D88EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 05:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AFA820734
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 05:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ttMtVBuf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbgFJFd4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 01:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbgFJFdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 01:33:54 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87853C05BD1E;
        Tue,  9 Jun 2020 22:33:54 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id h5so732964wrc.7;
        Tue, 09 Jun 2020 22:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=T5+YAtcRgziqO5C2N6ia15+cgn+tR71qagnrzljPNOs=;
        b=ttMtVBufZEb4GP86ouNkVbgpx6OQWXQgsqEYjbatjSoiIybJXHEoQIqEJ9vq8yJDVu
         TrL+CNpV9RHEFWxbrJsN60j8/Qk55Q44C3201FxJ/7WDA/nB6mehgVVzj8yItZcaurJo
         IvrjWspMWYRAL7eeD4e8fj5a6Hl6mBNW7qfTOCyi3eIrSY7OiK3SaT1Ejy+/no1v35wX
         /sxtSLuf1coUxyojIaC170ui1Aw+h7J3xwsw7Ex2cIBtY2Eu+qUan8f3EG6Y6fidibkH
         u/ZyxNuZ6Tj5oHjp16y5h7SQKbBZo9Z8uL8SP1xLPpRrEveoQdTQs+9LOxZIXRb27UgL
         ntNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=T5+YAtcRgziqO5C2N6ia15+cgn+tR71qagnrzljPNOs=;
        b=gxRd/TCofXBSf2Wy7qWNowTq0e9FL3GqAfGH9BVXpf63TXDOkLlH5K7LhTBAXCag3G
         ScfmaW5wza0by5mEFbzjlATHHKZPGfL0wxa6UwOGAvY0pP/UjKKH4mrykbaknr1Vvk7f
         5a9/5iRfx/L1UX/JtLiK/sLNImWOzewHwVoc831UCrQ6YnTksqPkSeP7+TLWei6xXc4w
         8TH1InGEnG0R4azNmPctVohYKfeV8cCU/HnZYRYj78PIq+sYs6jZnDGQhdTKxPYXbP2h
         7Za5rj0J7sUwpMV4uQDBor7J5roQiUjj3uGwOctdKOxD+dg8u/pP9UZN/rzsXuWbLhMe
         A1Fw==
X-Gm-Message-State: AOAM532Xx5m35c81E3aLb0f4/Yv9jtaEP1yb8wFWPsNb9y+xQOURSzP1
        7Zcgcp27NDZVtOUB2NoiidFwRuDF
X-Google-Smtp-Source: ABdhPJzDaJLm3wmW3nYGhhj+Tlq7KEQxisVm3BiXyC3yISOKVqTilrpaLpgrhji+o239Lgl/FCi9bg==
X-Received: by 2002:a5d:4a04:: with SMTP id m4mr1685879wrq.153.1591767230649;
        Tue, 09 Jun 2020 22:33:50 -0700 (PDT)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:bdc8:ea26:f7b2:4ad5])
        by smtp.gmail.com with ESMTPSA id n23sm5238254wmc.0.2020.06.09.22.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 22:33:49 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     SeongJae Park <sjpark@amazon.com>, akpm@linux-foundation.org,
        colin.king@canonical.com, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, SeongJae Park <sjpark@amazon.de>
Subject: Re: Re: [PATCH v2] scripts/spelling: Recommend blocklist/allowlist instead of blacklist/whitelist
Date:   Wed, 10 Jun 2020 07:33:35 +0200
Message-Id: <20200610053335.14684-1-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <d086a1a412de3079cefbfb15f38c4dc9aae0045d.camel@perches.com> (raw)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 Jun 2020 18:35:46 -0700 Joe Perches <joe@perches.com> wrote:

> On Tue, 2020-06-09 at 14:25 +0200, SeongJae Park wrote:
> > From: SeongJae Park <sjpark@amazon.de>
> >
> > This commit recommends the patches to replace 'blacklist' and
> > 'whitelist' with the 'blocklist' and 'allowlist', because the new
> > suggestions are incontrovertible, doesn't make people hurt, and more
> > self-explanatory.
> 
> nack.  Spelling is for typos not for politics.

Agreed, I'm abusing the spell checking.  I personally believe the terms will
eventually removed from the dictionary and become typos, though.

I will update checkpatch to support deprecated terms checking, and set the
'blacklist' and 'whitelist' as the deprecated terms in the next spin.


Thanks,
SeongJae Park

> 
> > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> > ---
> >  scripts/spelling.txt | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/scripts/spelling.txt b/scripts/spelling.txt
> > index d9cd24cf0d40..ea785568d8b8 100644
> > --- a/scripts/spelling.txt
> > +++ b/scripts/spelling.txt
> > @@ -230,6 +230,7 @@ beter||better
> >  betweeen||between
> >  bianries||binaries
> >  bitmast||bitmask
> > +blacklist||blocklist
> >  boardcast||broadcast
> >  borad||board
> >  boundry||boundary
> > @@ -1495,6 +1496,7 @@ whcih||which
> >  whenver||whenever
> >  wheter||whether
> >  whe||when
> > +whitelist||allowlist
> >  wierd||weird
> >  wiil||will
> >  wirte||write
