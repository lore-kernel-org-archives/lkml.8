Return-Path: <SRS0=5Fkd=6R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE728C4724C
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 11:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDFCD2084D
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 11:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NkQsAYes"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbgECLyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 May 2020 07:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727112AbgECLyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 07:54:24 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9288BC061A0C;
        Sun,  3 May 2020 04:54:24 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id z1so4133686pfn.3;
        Sun, 03 May 2020 04:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X2DurU4Vh0Yd3MU//DVV30ODVL3/CkrGhn4rgAtbVjE=;
        b=NkQsAYesfqyA/Kilc74lDwpDm7JKVpHRd8asuPMDpRP0knU1NwNs2txQDZh+ueON+A
         dJvKqVBG68tuvDKbMRNUbMKvhRxguZnf6vfJ9A2GFuxqZ0Gu/+BHqXt7ljTNj0xrwXao
         L1DVxfhZUF4yw+3pNRJ8T7d1BhbIc+EtnOVtIJYj4xPLcW7vjLtTi7YWxDQ5DY2TX47I
         EBHnKGPi1046iQyWj44U9QVTQb63L/978pGS+vLyAdGcRJk3T3NxThBNG9+SO8t9MG1k
         kTBgUfPlOFX2TgF/Qt9px1VJJ+xIHENTr4Z6pJzsB91ZWJ4UzoQM+FxjIiwiuZx5Cv0d
         QdiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=X2DurU4Vh0Yd3MU//DVV30ODVL3/CkrGhn4rgAtbVjE=;
        b=mtOGfVEOrUBLfVSPjgtQVB5xAYA6ddYHOoTydeyBCvINfX15OFoxCAsGjxLG1CGvcd
         qoSi2ZKKHlELcH18qCgrVJ85/opdt95bnH05UMZJJ4qZFzGKJVPu5lQ6kY9RJSiwQ5oX
         Fc6J1YLiGvE/NsFGs0/XkQlSAflW3amtdBPJU3AfsEUurPpS+epiJ2/vIh5F4Lk+e5CA
         OX3zTIlZ22qk0kn7xNBeueaYRnScd7tiuxL4C7Tv0cG13kJM/85X6VThc1fFhuc3HWM3
         yRWBUg2rmxbjFivuXgBsf9lTZ9bebymNZmoNmkNrkinLfESmuerhrDv+LufVzGCiVmWd
         7caQ==
X-Gm-Message-State: AGi0PubswmtM/W+5OlxWnfBMafEtVMaqTU1/2B3aqirKKmOBhK18jYgE
        AwFoRnSwXkFSlDHIgXNR11LLVSgt
X-Google-Smtp-Source: APiQypIfqOMNxsOZd7FeQ6jaM9tAwa6+SbN+r8AelILnZTQUuTePJtZm/AQAlDhdmD+J4DSbeFV0VA==
X-Received: by 2002:a63:d201:: with SMTP id a1mr11782889pgg.137.1588506863752;
        Sun, 03 May 2020 04:54:23 -0700 (PDT)
Received: from udknight.localhost ([59.57.158.27])
        by smtp.gmail.com with ESMTPSA id 140sm6465884pfw.96.2020.05.03.04.54.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 May 2020 04:54:22 -0700 (PDT)
Received: from udknight.localhost (localhost [127.0.0.1])
        by udknight.localhost (8.14.9/8.14.4) with ESMTP id 043Bk45j010346;
        Sun, 3 May 2020 19:46:04 +0800
Received: (from root@localhost)
        by udknight.localhost (8.14.9/8.14.9/Submit) id 043BjvpN010345;
        Sun, 3 May 2020 19:45:57 +0800
Date:   Sun, 3 May 2020 19:45:57 +0800
From:   Wang YanQing <udknight@gmail.com>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>,
        kernel-janitors@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matteo Croce <mcroce@redhat.com>
Subject: Re: [PATCH v4] checkpatch: add support to check 'Fixes:' tag format
Message-ID: <20200503114557.GA10332@udknight>
Mail-Followup-To: Wang YanQing <udknight@gmail.com>,
        Markus Elfring <Markus.Elfring@web.de>,
        Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>,
        kernel-janitors@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matteo Croce <mcroce@redhat.com>
References: <20200502185421.GB9082@udknight>
 <6a3a6f8d-e8be-0002-780d-1991f6152c8f@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a3a6f8d-e8be-0002-780d-1991f6152c8f@web.de>
User-Agent: Mutt/1.7.1 (2016-10-04)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 02, 2020 at 09:40:24PM +0200, Markus Elfring wrote:
> 
> 
> > +				$diagnostics .= "Missing a pair of parentheses '()' or a pair of double quotation marks (\"\").\n";
> 
> Can such a message trigger any more thoughts and development ideas?

No, I don't think so. '(" ... ")' is the minimum interface between analyser
(checkpatch) and commit id description (normal commit id and 'Fixes:' tag)
about the title, it is very difficult if not impossible to guess the title
boundary and whether it is the *REAL* title that folllow the SHA1 without
this precondition, and it is more difficult to do it when we need to support
title which across lines in the normal commit id description.

At last I really doubt the benefit it brings deserves the complexity and the
current diagnostics info is enough clear for most situation.

Thanks.
