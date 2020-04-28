Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A70C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 21:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02DE4206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 21:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aws0RLC8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgD1VYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 17:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726282AbgD1VYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 17:24:51 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73701C03C1AC;
        Tue, 28 Apr 2020 14:24:51 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id y24so355021wma.4;
        Tue, 28 Apr 2020 14:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zb7LzoAznLFO4xh93OzPl5Gk/vjaZwZU1XohHV7MrJc=;
        b=aws0RLC8kF78hcBigDsWrLtx64615jTQ1kP286WBAk3gnucdA/dPcXz+5qx06ab28r
         8SMeiNTy31aTlWPYuknfa9DL/fzfcFyQDAtB7IV0y7YbqoKbZjI16PvsQ+fnR7vVoI04
         n8+IV7mwWcEFdkbT0tKImrTRJG26sn1nj0gKtD9yW0NzgqNlONzg9uNWd7XyKBi4oD6N
         u4k1ZEK1oYB4ofl1vnn4ayBhScEfxI9FlLldXh2KCySlQzNCgQHU8WMvG8LI+NVhxOrR
         Q2fDiFH9c5OSNN3QHql0rEbY6Iyo/Gv361QL8QFX8Ix3cGOxmr52YruscRmHt7mxn67F
         MqOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=zb7LzoAznLFO4xh93OzPl5Gk/vjaZwZU1XohHV7MrJc=;
        b=N6STyyTbZcoErgkJLmdDeO8/gxOJVBuHyhmWfWtymHYwNR8oFvPJNWhkiBYfBVdbmU
         yCru1oD0DvY8fR8NWCc2ta03T+Db/0Gs+i7A4Cj2RF+yp1OJByIOWSBgBySmgJMTwNeN
         Mpx2YaOFL0pn/k0akB1A5SE6lGr7bZJmdc4vS5r3s4jg0vY4oRIa3xsaT4he7/1q4HS4
         u+LkG4v7NBIOd//SB/yA5kcVb0heASbKFRXP2AhnPomtvvUn3rrKIsCy7IRLW5oH1nDB
         KTLP+/TbKN688HOew2eynjiFOnBicxS/4cGqfnEqyIfPIKRRL6eTYle1AA/yNsWZQ3rD
         dRIg==
X-Gm-Message-State: AGi0Puam1s+UnrI+UEt29DIyNH6v4MQ0Ye2qz0J63YxbYG9w720v73Kr
        Qg/xxi1UoV20nmyFnzcR7fc=
X-Google-Smtp-Source: APiQypIMBVANqX5mS1XhUTfaHLqCbfuUp9eJdnNb6wPSFjXp5rIT+MYNnUAD9kaUtKywbmW2zbvBiQ==
X-Received: by 2002:a1c:4e15:: with SMTP id g21mr6441082wmh.29.1588109090241;
        Tue, 28 Apr 2020 14:24:50 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id j13sm26876116wro.51.2020.04.28.14.24.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Apr 2020 14:24:49 -0700 (PDT)
Date:   Tue, 28 Apr 2020 21:24:49 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Wei Yang <richard.weiyang@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] XArray: entry in last level is not expected to be a
 node
Message-ID: <20200428212449.2ww7ftgvrkcn4c7n@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200330123643.17120-1-richard.weiyang@gmail.com>
 <20200330123643.17120-6-richard.weiyang@gmail.com>
 <20200330124842.GY22483@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330124842.GY22483@bombadil.infradead.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 05:48:42AM -0700, Matthew Wilcox wrote:
>On Mon, Mar 30, 2020 at 12:36:39PM +0000, Wei Yang wrote:
>> If an entry is at the last level, whose parent's shift is 0, it is not
>> expected to be a node. We can just leverage the xa_is_node() check to
>> break the loop instead of check shift additionally.
>
>I know you didn't run the test suite after making this change.

Hi, Matthew

Would you mind picking up this thread again? Or what other concern you have?

-- 
Wei Yang
Help you, Help me
