Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D01C3F2C6
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 01:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A7D320828
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 01:26:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Km+SgZv6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387462AbgCDB0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 20:26:18 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:38424 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728079AbgCDB0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 20:26:17 -0500
Received: by mail-pj1-f65.google.com with SMTP id a16so150020pju.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 17:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=gTBAmyoSju6V+iCObTAIv0pg/QQBxsssI2exHJW7aHo=;
        b=Km+SgZv6vmH4suVHHHRa6p38rIK68C91t5Y9K87WNgkBa2sgd2YuzMg1WCUdGQ+Ojb
         uVG8+WzmuXgmG25CLnimL4va2L6mPgBYqJdbP5Zvpnqyd9uACdDC0uRbgoo4WytiPXsY
         PF9QZOycFnpZ0S12q3ymDLOdYBjv/4On89jB41ZbfouzW/qqffsPfSkvRSLqTnQNp9Y9
         QWPh0KLRcfKRHICHOSCiHOj8ovtejWZMsCfPWGFeeZzZWA/IY/C69gNTC/ubbKY0GCqo
         OLIQdX0iUDeXuJhAXPCzUl1l8XPK56xjF380e0aXLfZLK0lgsTpXh3NS4/9Az9twhK44
         8Tfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=gTBAmyoSju6V+iCObTAIv0pg/QQBxsssI2exHJW7aHo=;
        b=DG7xW2taB9/ImGvuMdPeNFfI1i9Hl5G337vvfVusMoihcGJZ7jaagxPJQdnnsMnStK
         wJ1lhG2+UcUt3xcJW+hN667KlKNhJ4WfE31yPB6c0wcuuhdAN5RvqgHGzTkkZ3ohcZXF
         scoLn/MWhQ3hvFL+buGAlgag7S7noRe2iTboBBxdAlqmgxHqgnEkfvwdCEmrdVBJuIpe
         RFCtymlpwN+OOVy4pZG8EAVxmmmmAz58wlaANIv4D+5C2UJoMfvsT928GHpI9+gadzxk
         4Bj/E1ZxnQiOaLcpw/gT7d4rAMrQtnbPJt4kHiw9sAxlQlM4RUkDH2F7rAETOZvQiN4i
         Lymw==
X-Gm-Message-State: ANhLgQ2cuCBJCQ6B28M8YgWB0VoAXzEDfkP5YyvkTBXPCDnXE9K4CH0h
        shiKbMP0KyBbzsyTomxpd7+6CQ==
X-Google-Smtp-Source: ADFU+vs1XsFffIfIld6bH+IcbAim5YS3vCLeR46wMo7dLCksbHbqckbqlzD2uNS1Xd2aRqGYpG8XBw==
X-Received: by 2002:a17:90a:bd10:: with SMTP id y16mr413347pjr.138.1583285176369;
        Tue, 03 Mar 2020 17:26:16 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id 5sm13648268pfw.179.2020.03.03.17.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 17:26:15 -0800 (PST)
Date:   Tue, 3 Mar 2020 17:26:14 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Jann Horn <jannh@google.com>
cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Matthew Garrett <mjg59@google.com>
Subject: Re: SLUB: sysfs lets root force slab order below required minimum,
 causing memory corruption
In-Reply-To: <CAG48ez31PP--h6_FzVyfJ4H86QYczAFPdxtJHUEEan+7VJETAQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.2003031724400.77561@chino.kir.corp.google.com>
References: <CAG48ez31PP--h6_FzVyfJ4H86QYczAFPdxtJHUEEan+7VJETAQ@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Mar 2020, Jann Horn wrote:

> Hi!
> 
> FYI, I noticed that if you do something like the following as root,
> the system blows up pretty quickly with error messages about stuff
> like corrupt freelist pointers because SLUB actually allows root to
> force a page order that is smaller than what is required to store a
> single object:
> 
>     echo 0 > /sys/kernel/slab/task_struct/order
> 
> The other SLUB debugging options, like red_zone, also look kind of
> suspicious with regards to races (either racing with other writes to
> the SLUB debugging options, or with object allocations).
> 

Thanks for the report, Jann.  To address the most immediate issue, 
allowing a smaller order than allowed, I think we'd need something like 
this.

I can propose it as a formal patch if nobody has any alternate 
suggestions?
---
 mm/slub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3598,7 +3598,7 @@ static int calculate_sizes(struct kmem_cache *s, int forced_order)
 	 */
 	size = ALIGN(size, s->align);
 	s->size = size;
-	if (forced_order >= 0)
+	if (forced_order >= slab_order(size, 1, MAX_ORDER, 1))
 		order = forced_order;
 	else
 		order = calculate_order(size);
