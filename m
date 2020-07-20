Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70BA6C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 19:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55A0720773
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 19:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729758AbgGTT1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 15:27:44 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:56067 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728947AbgGTT1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 15:27:44 -0400
Received: from mail-qv1-f53.google.com ([209.85.219.53]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1M1aQN-1k05cT1wTb-0033fn; Mon, 20 Jul 2020 21:27:42 +0200
Received: by mail-qv1-f53.google.com with SMTP id dm12so8106052qvb.9;
        Mon, 20 Jul 2020 12:27:42 -0700 (PDT)
X-Gm-Message-State: AOAM5326o2Kmv/oxnpZKng/ok6cRSR9F5b4asxIgIpHEUQvOLx90N6jV
        lck2dkpUFI+1Q2ItPYC8J73vaWYEJmidjJsqhHU=
X-Google-Smtp-Source: ABdhPJz4/GVi095uNagL1zwS7AisRzIt6vFPRcHiAqGZBWpvnfFu77t7jzve1fhi4YSFXXrmPSs1LFCvIBKpCGPSz7M=
X-Received: by 2002:ad4:4c09:: with SMTP id bz9mr21965168qvb.210.1595273261190;
 Mon, 20 Jul 2020 12:27:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200720191845.20115-1-trix@redhat.com>
In-Reply-To: <20200720191845.20115-1-trix@redhat.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 20 Jul 2020 21:27:25 +0200
X-Gmail-Original-Message-ID: <CAK8P3a15yTNgDrLWB4mhTJfjLjxjexbGg4Har4S1Q9uUfCBgFw@mail.gmail.com>
Message-ID: <CAK8P3a15yTNgDrLWB4mhTJfjLjxjexbGg4Har4S1Q9uUfCBgFw@mail.gmail.com>
Subject: Re: [PATCH] video: fbdev: pvr2fb: initialize variables
To:     trix@redhat.com
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Jani Nikula <jani.nikula@intel.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:nsRDEQzgnMxfu8R8icWTtUzZ7tQFJpe5cUoDit7hPxKKEHio1xg
 IWqG5/dXU+Fe0/9F9wwZBpSg8SSuWBUGECk5IHcyTs6KPT1HJjIPdHBx7/OpJVYEIUxfpLG
 drDSzse2c76cyspDPmJPV+B8E5/9Y5ojH2Rm/7BZL8QCiz1cAjhEtuzB3Xi2flM/Q7B2pKa
 TDjY9OFzF1e688gbbdKhw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PALBvoTVKtI=:NJONmpnhtkwGHlJO+DY+zZ
 FGcbDIq9tezIfthDFYSDNcH/9z4JgXviye4S3Nn52ExpxrRdQf8Bz4vt/npWbHDsjRHYARdqp
 lUEqLZSSKwepfA91vVg/mijXZoZRmrBzGbdLSAr9I1L+++C6HZtytPVMOHTQWsgdTlvKVOCBm
 fw980wm/6Bc12uvrSb9WTQLNvnG+uVyed2SngRWOKxnVBDI02nwTCl2no44motZb3s49tO++7
 z223WB5YFqnPR2IUbmXSDV6sW+snMOPPN0+KXPdKCJRAqSdP5kWRwdpqWWYikAzcUaHwOFAM9
 YZoA+jryCVzCj1NfAu+r9iKbVO3Sh2Y8JlAHSMrHJFQyBVjDAYJL0BFPdNdjqF1QrOdIKDn1r
 cUb9/G7LsgWX8cwCPYEfANXyZWNn86WyZKcvWV7M2xErrdTkVV8I+eyKVSHNDVV83J8Wi3f1Z
 Hm7HzgbMn9Z0QH2JSBZ3/EnJtPn/36CVQczdupZm8FOEID9uZkJ7PhGue0GqqcLJPIw65ph1x
 olkS/URmBhlWHkCAHD8YyO/uOwrcWVtybf8djGseBThV2Oa9wjQudce1UbDqLAerrzqKJzcnA
 8MI32NrX2IqDs+vehs1JLXaRgdC7s3g5H/K7HSPqSV8cRj+Y00fETonUhwH6+qFkGwgsul6Tn
 rdHhkS9FLm++VyRtslHinWRBEOlSbrACKUK58LK7+UDbkvIl700n377ZkGI1EvbAIQObSSHgJ
 LutXWGulIMZIknh3mqWSUq/TEsHg4A4adWRFhwIO6vq3TU01SvW75Dd5At2wGixCJpcjDHiHr
 AHxY2AkH7AbL04gF6IyKYZoLbNa+JLVzyIAfNQPn4lP2BE6/fi/kazxiyxRxvosSIP0mcOZ
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 20, 2020 at 9:19 PM <trix@redhat.com> wrote:
>
> From: Tom Rix <trix@redhat.com>
>
> clang static analysis reports this repesentative error
>
> pvr2fb.c:1049:2: warning: 1st function call argument
>   is an uninitialized value [core.CallAndMessage]
>         if (*cable_arg)
>         ^~~~~~~~~~~~~~~
>
> Problem is that cable_arg depends on the input loop to
> set the cable_arg[0].  If it does not, then some random
> value from the stack is used.
>
> A similar problem exists for output_arg.
>
> So initialize cable_arg and output_arg.

Adding a zero-initialization is almost never the correct way to
deal with these warnings, so one has to be careful doing this.

I checked this file, and your patch is absolutely correct here. ;-)

> Signed-off-by: Tom Rix <trix@redhat.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
