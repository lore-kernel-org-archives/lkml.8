Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA15C3F2CE
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 17:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4739C22B48
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 17:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="U6+qoKiO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730020AbgCDRnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 12:43:08 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34142 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728361AbgCDRnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 12:43:08 -0500
Received: by mail-ot1-f67.google.com with SMTP id j16so2890949otl.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 09:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wel1JEO/E9eVNEX7Tkf4Unp84Qyn6ST0gR4MiIt2Igc=;
        b=U6+qoKiOF0TyylLlrE1G6SritxaDt8X475He0dDCbOzHYLXrKZ6X6pSWgsmkgPpyLU
         ysN7a2JlmBcrPV5KhfRdiJN0YV7Gp0FD+FCE7CrAttaw43FRxeY1dFGY1midGDo+NYIe
         DNutxvlVKL/bxCM3EwFEiOGCqMfaFeuztVoYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wel1JEO/E9eVNEX7Tkf4Unp84Qyn6ST0gR4MiIt2Igc=;
        b=P6cG5w/PuuqpG+MqBhwZ5IiXc6wrb+c6eERAsg4gO20cXkGhsKz81fh/bKv3x9OHVx
         5wdOJ3xEBaCTFd/UOrM+wxpwGAcBZbgjK+9TYP+6iw4VYQ7VTa57QHYfgxF4QPcO2CVK
         adGBP6d4z7W9/9EYPSF5XI0tZlB+g0blybfMMO5hkLHadiYZoVszW/WhZmLS/b9i2jYH
         whgI0Z73VC+ewDXTe4SwpCyQ9nujgr6vlZ3OuITkwo9DeopPZ/jsKF6FkwwXHCrgCC6R
         4exQDKy1keK/7b2wCMxgGKQyX++VzE41C/lAjlkq5wnuJpCiq/PgzvLHeI3pX1hq1QnB
         AjCQ==
X-Gm-Message-State: ANhLgQ0PZuRToN32mzuxszQlT46RmEhu36w79VC5NCMyY1e2gNsfiiUv
        SHbVVBGd0n9u/q8Id+Y0Tjoh8ClBECUhweL+FdVhmg==
X-Google-Smtp-Source: ADFU+vsLQ7o1wHymKj4RDew/ck4Fo2ZijcSPVm+MdcWrw93paF9JmQcXBxW58Idr/UGXcvnUp3kzHpAeTrxOvaPyqjs=
X-Received: by 2002:a9d:64b:: with SMTP id 69mr3159164otn.237.1583343786118;
 Wed, 04 Mar 2020 09:43:06 -0800 (PST)
MIME-Version: 1.0
References: <cover.1583332764.git.vpillai@digitalocean.com> <e65d3cd4-9339-4586-7aff-07652cb1ae47@linux.intel.com>
In-Reply-To: <e65d3cd4-9339-4586-7aff-07652cb1ae47@linux.intel.com>
From:   Vineeth Remanan Pillai <vpillai@digitalocean.com>
Date:   Wed, 4 Mar 2020 12:42:55 -0500
Message-ID: <CANaguZAdK0HBqK80+8rs0X3afGkNZpzfK3OF17jiP=OM_n6qQg@mail.gmail.com>
Subject: Re: [RFC PATCH 00/13] Core scheduling v5
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joel Fernandes <joelaf@google.com>,
        Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Just to set the record straight, Aaron works at Alibaba.
>
Sorry about this. Thanks for the correction.

~Vineeth
