Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F2E5C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 00:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8A2720825
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 00:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o77WcHHS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733267AbgGWAyn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 20:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728607AbgGWAyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 20:54:43 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF05C0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 17:54:42 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id n26so4569533ejx.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 17:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DexRFTZ526JKTDwRw2yRBmbNYYN7yzEGOYTfHkLd9mM=;
        b=o77WcHHSKrzKQBHGh+QWIWGjXb4OA+VaRiufZssaph4gUM8wrtjDbQQ6d40irNeiHP
         wK9ofKe+W3a0+IrloajIbysWJOvuzVFurAhIT+5lIOn+Hf9ALNywaZk8nGKzFrfe+xaw
         kqKy6MOmZnEn/oMzQKGQciz5lI5YLnKCqmRPzOOp2GeVqdSHwxnB5BPvR8+g9xkG/hjY
         p9nEh2g4mHAzssYHqVGBrmrfwaH2GVTeySQGmLJdViDOqbkkciRzxI70jJ0He8+Y+xHY
         uqGlX9dQoEDaUnzK7aUaPOE1hPagwItsmdaD4/mxNTkg/C5CYueAx5n5DEe/Jj/tIx9f
         2xXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DexRFTZ526JKTDwRw2yRBmbNYYN7yzEGOYTfHkLd9mM=;
        b=QSMIHOGxiIPw8noGu7J8Bs7+oIBbxi8RNdFa9ODU+BIsJqLg3ll9Bvr1QYCkpCTF9U
         qfddkDEnuJaL9TjHOXbFd73VCrF1b+sOiXLjzvnArTR7j+x8Scm4XWrTE0xEe1wsuBGD
         bcAfHEnEK9Tk1kt1rY2M2dxFzSMHbek5JWjb899WdNVJ0CxBk11sIxACjmkIi+xWVjd0
         6bhheax4dRldIYJpHa1x/h+SNAqH6DBndksLrRTmNJ5B2zIJyv53KnSvdjkW49ilX+k3
         JuId1bMXyAEODgNntscon0jdVBl2pUyHCIGunPjPfCxrBG9JdEFChx/Bj1s844kmgrA/
         W5bQ==
X-Gm-Message-State: AOAM5331stWkjcOSX2/pB/MnvsCO48owYxvjKQjSX+kikO4qf4NDEjER
        5RRufQrMCR67tvF7VwhnaPXJiRBBAJgRSvN33u4jPw==
X-Google-Smtp-Source: ABdhPJzFIHfA0DHg2RgxNQ0S/iTPsLq03TdY/Rjb+qnOHTv/wxhj76Yyj72ywJ3nswCbAkokW8LGmaHS3rTHF2OTHEs=
X-Received: by 2002:a17:906:3889:: with SMTP id q9mr2217431ejd.318.1595465681118;
 Wed, 22 Jul 2020 17:54:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200722015732.1720840-1-briannorris@chromium.org>
 <20200722015732.1720840-2-briannorris@chromium.org> <5ebf1534-8045-9894-9c1c-b92b9c6d8479@collabora.com>
 <CA+ASDXMk7Tg7Lwqt8Pv5BQT0J40dpJtqrL9TAn8y5Nj3TCkj6Q@mail.gmail.com>
 <CABXOdTfvNBuaEx-vTU2MqNF_EmULJu=506oUtd29kN=FAPswBQ@mail.gmail.com>
 <CA+ASDXNeTp0z7M6rR62rJEa3tF52BYjXdodFTQvuR4b43o0e-Q@mail.gmail.com> <CA+ASDXPbnqRbw9EpTQ5uWt1ALh6h9dqggrEusXXaAOp46dp+Ag@mail.gmail.com>
In-Reply-To: <CA+ASDXPbnqRbw9EpTQ5uWt1ALh6h9dqggrEusXXaAOp46dp+Ag@mail.gmail.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Wed, 22 Jul 2020 17:54:30 -0700
Message-ID: <CABXOdTedz9wRKo=3o4b6VYSi=G1-GJ7dVCv5ETdbqAa_K7yvkQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] platform/chrome: cros_ec_proto: check for missing EC_CMD_HOST_EVENT_GET_WAKE_MASK
To:     Brian Norris <briannorris@chromium.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 5:50 PM Brian Norris <briannorris@chromium.org> wrote:
>
> On Wed, Jul 22, 2020 at 5:43 PM Brian Norris <briannorris@chromium.org> wrote:
> > unless I got
> > refactor cros_ec_get_host_event_wake_mask() to use
> > cros_ec_cmd_xfer_status() instead of send_command(). I'm actually not
> > sure why we don't do that, now that I think about it...
>
> Ah, that would appear to be recursion (cros_ec_query_all() ->
> cros_ec_get_host_event_wake_mask() -> cros_ec_cmd_xfer_status() -> ...
> cros_ec_query_all()), although that could only happen if the first
> cros_ec_query_all() doesn't initialize 'proto_version' to something
> besides EC_PROTO_VERSION_UNKNOWN. That is only possible if the EC
> reports '0' back to us.
>
> I might skip out on that particular refactor for the moment.
>
Agreed, better not touch that. As for the order of changes, I agree
that they are independent. Best approach might be to submit yours, and
then we can clean up things a bit more later after my series is in the
tree.

Thanks,
Guenter

> Brian
