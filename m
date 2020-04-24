Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA33BC55196
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 17:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 967CD20774
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 17:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587749766;
	bh=Peyeh9R1RKW3zw7UW1YT91/pMaRcN7Ix0/Y0p+HkVQs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=RhpbCv1CrTE450GZhwCbsVgG63xPTmriU6zTk/iYFqJgiHL0ZA8X2QampvB6oqhvd
	 5Jl92kibffy8Hr6W7XT1lZyVYXSzlXGEgJZznDVSXY830nKd4TPOSAXnaKQ/BSOWN5
	 9mB4bBw5vuTxG7ePVuFO4p2r7+xNOuSm0eX+5gRs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729065AbgDXRgF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 13:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728855AbgDXRfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 13:35:47 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF93C09B04E
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 10:35:47 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id g4so10825524ljl.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 10:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=17Kg1dRas/M0sQXVRI4F1cdrQ//6hjmUk/mclI6heeY=;
        b=d+qcaZcbU1H0AzDGp+UTOcPWUOR9HjuA25jpYxyTWS0ttqCFnGFEDZb7W8gtA+8q7Q
         DUnPsJgjbJ8jo2hCYbfGpWCBX4F5xcNqH+cIGSxuDfBaMWgLONIW6hJ8WQHyGftwdtXB
         H8XP2ZEiiiYTC5NDB9zm0db/DQyW0/Ezlxt8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=17Kg1dRas/M0sQXVRI4F1cdrQ//6hjmUk/mclI6heeY=;
        b=MNQCpOPTNalc8iKge2tzSBkdOmb5fhkhQlZ5DsXIWYpd9UQkPn5WnXYw243sUBHr7U
         +CKQOCU3szp7wwVFwWkOlpigBO7fEp4yYmnGnwhI/ORo+/iIvCfAIsK6Wys5Dy5K1bAU
         yGSoArju+AqKc2zGuCMNIZKt1sZ1jUri9kwDbBrTGPTJ9ERlq7OHKEk/phGa3pQNK+bH
         bZhN9vlglavRQlFWrYCakS+tSquBXuslix+FQTY9+XWWGSTqRwVqQYQv/uxH1s0KMju5
         yRFtrRp48NBJ6CBouXbDJ+M1eUOTYbU1VWlVNxY4ZZmbEXUwW7Ozb3U6xzB5aPhK5zmg
         lkUA==
X-Gm-Message-State: AGi0PuY5K54ypaVeazn7qdo3mDDqQLR6qd3cB61+K7WwV41Z/8S+1D7A
        I/OEAXO+ARY+2XZbpqpOOB5ggYVt7pM=
X-Google-Smtp-Source: APiQypK0hlO1y4dSmvILzt1UMv+T7O5MAhuuvfa2gMSBticxtoE86pDdPm7Ip8joY5KAO0mlWj9CNw==
X-Received: by 2002:a2e:8199:: with SMTP id e25mr6634782ljg.87.1587749744805;
        Fri, 24 Apr 2020 10:35:44 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id j15sm5128392lji.18.2020.04.24.10.35.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2020 10:35:44 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id x23so8387811lfq.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 10:35:43 -0700 (PDT)
X-Received: by 2002:a19:240a:: with SMTP id k10mr7152809lfk.30.1587749743463;
 Fri, 24 Apr 2020 10:35:43 -0700 (PDT)
MIME-Version: 1.0
References: <3632016.1587744742@warthog.procyon.org.uk>
In-Reply-To: <3632016.1587744742@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 24 Apr 2020 10:35:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi_0Fye2U+AXjScpgd_hh=pFu3GJvgsUqCk-4=ckcHhhw@mail.gmail.com>
Message-ID: <CAHk-=wi_0Fye2U+AXjScpgd_hh=pFu3GJvgsUqCk-4=ckcHhhw@mail.gmail.com>
Subject: Re: [GIT PULL] afs: Miscellaneous fixes
To:     David Howells <dhowells@redhat.com>
Cc:     linux-afs@lists.infradead.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 24, 2020 at 9:12 AM David Howells <dhowells@redhat.com> wrote:
>
>  (3) Make a couple of waits uninterruptible if they're done for an
>      operation that isn't supposed to be interruptible.

Should they not even be killable?

Anyway, pulled.

             Linus
