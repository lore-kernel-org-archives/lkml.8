Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F857C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 08:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59EB22051A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 08:11:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2635656AbgDOILg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 04:11:36 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:40863 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2635647AbgDOILJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 04:11:09 -0400
Received: from mail-qv1-f43.google.com ([209.85.219.43]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1Mf0Jg-1imZYP3BAQ-00gWyZ; Wed, 15 Apr 2020 10:11:07 +0200
Received: by mail-qv1-f43.google.com with SMTP id 37so1233072qvc.8;
        Wed, 15 Apr 2020 01:11:07 -0700 (PDT)
X-Gm-Message-State: AGi0PuZ4DUDKc8jENFcGiCUoFwydTP6QkmgYFQ9tgtv+xF1bW1110Xth
        NTpdRO1nAGndDFzwbQtZXqltTdeqfSv8jkeX3kM=
X-Google-Smtp-Source: APiQypKbcr9mNZith4L1LqQGcBZRroQaZgRKQ5zyJLhw+epylMCiDLECTAHbnS4VN3DF3oujdEWN0Dl+LFcKSHTwNBs=
X-Received: by 2002:a0c:eb11:: with SMTP id j17mr318223qvp.197.1586938266531;
 Wed, 15 Apr 2020 01:11:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200414221222.23996-1-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20200414221222.23996-1-chris.packham@alliedtelesis.co.nz>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 15 Apr 2020 10:10:50 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1Ktqne6vB0kFR+CuRgFjsRDCoXsndo-G9JSRaCv_qHfQ@mail.gmail.com>
Message-ID: <CAK8P3a1Ktqne6vB0kFR+CuRgFjsRDCoXsndo-G9JSRaCv_qHfQ@mail.gmail.com>
Subject: Re: [PATCH] docs: timekeeping: Use correct prototype for deprecated functions
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:+j8ZxrtrwrE0HspVLQUwA9R6mb/wIIWYgWe/VnER3zNvDohVPlN
 lIUySd+nJz/tN8JnmEo85oLfNrlobTDPY1Igtb8wBar3Dg+csv8iyMERvtWPV2b3L6R1k9F
 fq3lMxquJ9TZHtSYmLTqtOtQRK/cJvVKCH+XAXuAqmtErtaHo5jdEnNowciaq1621wfXHRE
 8fjQ6YoimTok3x2Jy4YWg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RQNTkg/HTLs=:/7d7Ml3N60wGhARTFONyxb
 IvVDN/nQ15wzJlU3UKBewEDrDb+HIlukzCHen2mVkLmrBW5czEnqW23J+BVeI7A01kPEmp2Fj
 S0DDNeid9hVVaOV3Cmv5j2fJ/lDaEoDHcgLtpopR9Q/NHDvkI1M2zk3njSWYvFHm3xk9DXlGS
 mfqNZCAOcZt3sIu5dIOfSsiNdQZQKnzMAyIr/Ub+BiSC+TFqBgVwJ3t50PqS8aYTxqX720h+r
 tUg2n8d9aKdtW0IDpTE6EqgGJqUtXwBtv9FVtfQ5vavcgAO8t1O2n+RVVD9tBaHjYoYRg9bVb
 sOlHCofCVuTFdakSd9M7slnPt876jPhWqbFrr6b/ohkBtAUXtWgQaCA3Wbap8hBi3/n7wFUAz
 CivmxDOuI5TfBRBGTzUIn0SXJUGoQn2wrlxZXzl9CFOQh/JGqE9iESNzBe/wi3DfMTMWM9Fya
 Dst1PFlEeDxmobA0ZtK8IHRu76aRdvTnYZH/tru3MjIFhoxkdxrFb7Nux3QXB6v3NwEh9Rczc
 Ax89qy/reaw2yGdS2mT4e6it5BfF7eN6+8TUWro4fXrkN6F+3AjnqWECeGdHvYt5fl7ULIute
 PjLJhZwzyX2PcDQkySi7tYdbaDgn5re37rXOdZSjAlm5+ggauiCB9jv+P4WTVwi2R12EWIxqE
 maG9PfedrbamfZqPPqXkiNqSi/bA0EtS6EsOppDlQxJYG4fgEhDqb+putYt+2Sce0vDPbdgMW
 9ahR2dRCEn0BcafN4k1ihYGN/sEu2g+a+91FTbqUchG0mPnnn+iO4xsr75rAk0pjmPTG7QuvP
 5Nvl6x8vAwqsCez5GJas7r7wXkB7gKnY4XJcYHRweTtJvvDO4A=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 12:12 AM Chris Packham
<chris.packham@alliedtelesis.co.nz> wrote:
>
> Use the correct prototypes for do_gettimeofday(), getnstimeofday() and
> getnstimeofday64(). All of these returned void and passed the return
> value by reference. This should make the documentation of their
> deprecation and replacements easier to search for.
>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Acked-by: Arnd Bergmann <arnd@arndb.de>
