Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EEE3C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 07:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FBF4207C3
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 07:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b="IYmxvA7X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbgIGHpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 03:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbgIGHpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 03:45:45 -0400
Received: from canardo.mork.no (canardo.mork.no [IPv6:2001:4641::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3701CC061573;
        Mon,  7 Sep 2020 00:45:44 -0700 (PDT)
Received: from miraculix.mork.no (miraculix.mork.no [IPv6:2001:4641:0:2:7627:374e:db74:e353])
        (authenticated bits=0)
        by canardo.mork.no (8.15.2/8.15.2) with ESMTPSA id 0877jMO6027725
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 7 Sep 2020 09:45:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
        t=1599464723; bh=F/cpKEbPOeBiiYDZm58dXUDkbQv3QMMupiIUIMsLI98=;
        h=From:To:Cc:Subject:References:Date:Message-ID:From;
        b=IYmxvA7XZxgTNjZdtiqqNQwmZylArahmbbj/z7bCvG82Axg//Sookx8SobMq9UqaI
         t6dAaNzoTauNcm4HbfjQ+zOFZSWARTUXFxLdiqWSut9ln1Ba7hQKhHX7xNPu8TPKLR
         RNXHnG56jYmVtDz9vSS6SL8QU5Ik98kxwQJytvQY=
Received: from bjorn by miraculix.mork.no with local (Exim 4.94)
        (envelope-from <bjorn@mork.no>)
        id 1kFBq5-000zls-55; Mon, 07 Sep 2020 09:45:21 +0200
From:   =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To:     Kristian Evensen <kristian.evensen@gmail.com>
Cc:     Daniele Palmas <dnlplm@gmail.com>,
        Paul Gildea <paul.gildea@gmail.com>,
        "davem\@davemloft.net" <davem@davemloft.net>,
        "netdev\@vger.kernel.org" <netdev@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: usb: qmi_wwan: Fix for packets being rejected in the ring buffer used by the xHCI controller.
Organization: m
References: <CA+4pmEueEiz0Act8X6t4y3+4LOaOh_-ZfzScH0CbOKT99x91NA@mail.gmail.com>
        <87wo7una02.fsf@miraculix.mork.no>
        <CAGRyCJE-VYRthco5=rZ_PX0hkzhXmQ45yGJe_Gm1UvYJBKYQvQ@mail.gmail.com>
        <CAKfDRXg2xRbLu=ZcQYdJUuYbfMQbav9pUDwcVMc-S+hwV3Johw@mail.gmail.com>
Date:   Mon, 07 Sep 2020 09:45:21 +0200
In-Reply-To: <CAKfDRXg2xRbLu=ZcQYdJUuYbfMQbav9pUDwcVMc-S+hwV3Johw@mail.gmail.com>
        (Kristian Evensen's message of "Mon, 7 Sep 2020 09:25:16 +0200")
Message-ID: <87v9gqghda.fsf@miraculix.mork.no>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.102.4 at canardo
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kristian Evensen <kristian.evensen@gmail.com> writes:

> Hi all,
>
> I was able to trigger the same issue as reported by Paul, and came
> across this patch (+ Daniele's other patch and thread on the libqmi
> mailing list). Applying Paul's fix solved the problem for me, changing
> the MTU of the QMI interface now works fine. Thanks a lot to everyone
> involved!
>
> I just have one question, is there a specific reason for the patch not
> being resubmitted or Daniele's work not resumed? I do not use any of
> the aggregation-stuff, so I don't know how that is affected by for
> example Paul's change. If there is anything I can do to help, please
> let me know.

Thanks for bringing this back into our collective memory.  The patch
never made it to patchwork, probably due to the formatting issues, and
was just forgotten.

There are no other reasons than Daniele's concerns in the email you are
replying to, AFAIK.  The issue pointed out by Paull should be fixed, but
the fix must not break aggregation..

This is a great opportunity for you to play with QMAP aggregation :-)
Wouldn't it be good to do some measurements to document why it is such a
bad idea?


Bj=C3=B8rn

