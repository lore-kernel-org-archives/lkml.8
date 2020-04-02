Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB07C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 09:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B5272072E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 09:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AsedCKJm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387780AbgDBJOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 05:14:30 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41790 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387477AbgDBJOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 05:14:30 -0400
Received: by mail-wr1-f65.google.com with SMTP id h9so3252248wrc.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 02:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7oO5ojwsmMbiz9bV8lc0KuGAlbZ9cZsYY465AETTzhw=;
        b=AsedCKJmk3zh2162AWk03RYYnuwMu43SqSyMa22CuDwuKeBsqYZ/ZpnbkpH9ozYkzi
         UdXHImrAQuck55VmiVaUc2Nh40UFymzSnq12eRdEMV2fCGw5xg3RIKi87r7RIsrkhjOV
         FmI7Yf200tOGPV1eG5J30GDQiQTVsMJ4Bndl1DYtAe6hC17/LXNjtlyfa8UFMdkFToWZ
         hcc13K0AEdtmoH0CvI/oH7xvQVljRKJ4Zh1YV4BLdsVHZaG+zqt+GyJYnqB4Z/VJoLQP
         cF/eh3b7QZAbGi9mDpyj18Tjbz9WZdwsbY5+ih/eofyYe/IlJsptXWGbm/Ee+gYLYeEF
         VOZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7oO5ojwsmMbiz9bV8lc0KuGAlbZ9cZsYY465AETTzhw=;
        b=LPmiPyEjuHMkxEIetjGEusQPL+/nHuwlPg71DcngdByj6M3YCpstgYNAaKhOiG2Hnb
         tj8Pwk5jcYymhvjL8BOrbFhYRMM3/EZFYSnmAJDPE+YqkjpOGndUwLEvQ5W191SI3s14
         BxVBtlhQwwXfNUELOeZXqVBP6mnbkFXkc4Et5BZW6wcQ7UHgS7ilw2Keyo+ay29NmO21
         X4TgvFPTnRxUIlA146lOGtmfZP+uNlAna/nP+jFwjP5vavzuBtFCpWZ02X0FlwQRbLNw
         I4vEYC5IbPD7UbWb08e8pFIxpRiYh75jDklnCYfJckgNYjcY6CDZRZ9MRZNZHcvslWIv
         KG7Q==
X-Gm-Message-State: AGi0PuZbsp45b/UjpxAXiG6bXxABF7Waxx7OYBLi+NALUs04HJZDpVgR
        /zATdhLHFms2VLfjUSZA3ULafCXMRYvXKG2i1P8=
X-Google-Smtp-Source: APiQypKwMvEoXZrpaQ4HZtkwJZMlk/p+Ce1lVBXhTtTkZk8wqF0d2jH6KErb2sML3hZjLYmwCQ9w8019RNXG/6FVFXI=
X-Received: by 2002:adf:ff8b:: with SMTP id j11mr2592490wrr.117.1585818868271;
 Thu, 02 Apr 2020 02:14:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200305233231.174082-1-leonardo@linux.ibm.com> <33333c2ffe9fedbee252a1731d7c10cd3308252b.camel@linux.ibm.com>
In-Reply-To: <33333c2ffe9fedbee252a1731d7c10cd3308252b.camel@linux.ibm.com>
From:   Bharata B Rao <bharata.rao@gmail.com>
Date:   Thu, 2 Apr 2020 14:44:17 +0530
Message-ID: <CAGZKiBp7qjH1gMOzRuPgX=qcrJs4b7UgBbfxjgzAEpQPZ0nhHQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/1] powerpc/kernel: Enables memory hot-remove
 after reboot on pseries guests
To:     Leonardo Bras <leonardo@linux.ibm.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nathan Fontenot <nfont@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Anderson <andmike@linux.ibm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Bharata B Rao <bharata.rao@in.ibm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 1, 2020 at 8:38 PM Leonardo Bras <leonardo@linux.ibm.com> wrote:
>
> On Thu, 2020-03-05 at 20:32 -0300, Leonardo Bras wrote:
> > ---
> > The new flag was already proposed on Power Architecture documentation,
> > and it's waiting for approval.
> >
> > I would like to get your comments on this change, but it's still not
> > ready for being merged.
>
> New flag got approved on the documentation.
> Please review this patch.

Looks good to me, also tested with PowerKVM guests.

Reviewed-by: Bharata B Rao <bharata@linux.ibm.com>

Regards,
Bharata.
-- 
http://raobharata.wordpress.com/
